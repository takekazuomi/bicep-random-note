@description('DNS of the WebApp')
param siteName string

@description('Address prefix for the Virtual Network')
param addressPrefix string = '10.0.0.0/16'

@description('Subnet prefix')
param subnetPrefix string = '10.0.0.0/28'

@minLength(1)
@description('Database administrator login name')
param administratorLogin string

@minLength(8)
@maxLength(128)
@description('Database administrator password')
@secure()
param administratorLoginPassword string

@description('Azure database for MySQL sku name')
param databaseSkuName string = 'GP_Gen5_8'

@description('Azure database for MySQL sku family')
param databaseSkuFamily string = 'Gen5'

@allowed([
  102400
  51200
])
@description('Azure database for MySQL Sku Size')
param databaseSkuSizeMB int = 51200

@description('Azure database for MySQL pricing tier')
param databaseSkuTier string = 'GeneralPurpose'

@allowed([
  '5.6'
  '5.7'
])
@description('MySQL version')
param mysqlVersion string = '5.6'

@description('Location for all resources.')
param location string = resourceGroup().location

var applicationGatewayName_var = '${siteName}-agw'
var publicIPAddressName_var = '${siteName}-pip'
var virtualNetworkName_var = 'virtualNetwork1'
var subnetName = 'appGatewaySubnet'
var subnetRef = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName_var, subnetName)
var publicIPRef = publicIPAddressName.id
var databaseName = '${siteName}db'
var serverName_var = '${siteName}mysqlserver'
var hostingPlanName_var = '${siteName}serviceplan'

resource publicIPAddressName 'Microsoft.Network/publicIPAddresses@2020-05-01' = {
  name: publicIPAddressName_var
  location: location
  properties: {
    publicIPAllocationMethod: 'Static'
  }
  sku: {
    name: 'Standard'
  }
}

resource virtualNetworkName 'Microsoft.Network/virtualNetworks@2020-05-01' = {
  name: virtualNetworkName_var
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
        }
      }
    ]
  }
}

resource applicationGatewayName 'Microsoft.Network/applicationGateways@2020-05-01' = {
  name: applicationGatewayName_var
  location: location
  properties: {
    sku: {
      name: 'Standard_v2'
      tier: 'Standard_v2'
      capacity: 2
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: subnetRef
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGatewayFrontendIP'
        properties: {
          publicIPAddress: {
            id: publicIPRef
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'appGatewayFrontendPort'
        properties: {
          port: 80
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'appGatewayBackendPool'
        properties: {
          backendAddresses: [
            {
              ipAddress: siteName_resource.properties.defaultHostName
            }
          ]
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'appGatewayBackendHttpSettings'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: true
          probeEnabled: true
          probe: {
            id: resourceId('Microsoft.Network/applicationGateways/probes/', applicationGatewayName_var, 'Probe1')
          }
        }
      }
    ]
    httpListeners: [
      {
        name: 'appGatewayHttpListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations/', applicationGatewayName_var, 'appGatewayFrontendIP')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts/', applicationGatewayName_var, 'appGatewayFrontendPort')
          }
          protocol: 'Http'
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'rule1'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners/', applicationGatewayName_var, 'appGatewayHttpListener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools/', applicationGatewayName_var, 'appGatewayBackendPool')
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection/', applicationGatewayName_var, 'appGatewayBackendHttpSettings')
          }
        }
      }
    ]
    probes: [
      {
        name: 'Probe1'
        properties: {
          protocol: 'Http'
          path: '/'
          interval: 30
          timeout: 10
          unhealthyThreshold: 3
          minServers: 0
          pickHostNameFromBackendHttpSettings: true
        }
      }
    ]
  }
  dependsOn: [
    virtualNetworkName
  ]
}

module fetchIpAddress 'fetchIpAddress.bicep' = {
  name: 'fetchIpAddress'
  params: {
    publicIPAddressId: publicIPAddressName.id
  }
  dependsOn: [
    applicationGatewayName
  ]
}

resource hostingPlanName 'Microsoft.Web/serverfarms@2019-08-01' = {
  name: hostingPlanName_var
  location: location
  tags: {
    displayName: 'HostingPlan'
  }
  sku: {
    name: 'S1'
    capacity: 1
  }
}

resource siteName_resource 'Microsoft.Web/sites@2019-08-01' = {
  name: siteName
  location: location
  properties: {
    name: siteName
    serverFarmId: hostingPlanName.id
  }
}

resource siteName_connectionstrings 'Microsoft.Web/sites/config@2019-08-01' = {
  parent: siteName_resource
  name: 'connectionstrings'
  properties: {
    DefaultConnection: {
      value: 'Database=${databaseName};Data Source=${serverName.properties.fullyQualifiedDomainName};User Id=${administratorLogin}@${serverName_var};Password=${administratorLoginPassword}'
      type: 'MySql'
    }
  }
}

resource siteName_web 'Microsoft.Web/sites/config@2019-08-01' = {
  parent: siteName_resource
  name: 'web'
  properties: {
    ipSecurityRestrictions: [
      {
        ipAddress: '${fetchIpAddress.outputs.ipAddress}/32'
      }
    ]
  }
}

resource serverName 'Microsoft.DBforMySQL/servers@2017-12-01' = {
  location: location
  name: serverName_var
  properties: {
    createMode: 'Default'
    version: mysqlVersion
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    storageMB: databaseSkuSizeMB
  }
  sku: {
    name: databaseSkuName
    tier: databaseSkuTier
    size: databaseSkuSizeMB
    family: databaseSkuFamily
  }
}

resource serverName_serverName_firewall 'Microsoft.DBforMySQL/servers/firewallrules@2017-12-01' = {
  parent: serverName
  name: '${serverName_var}firewall'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '255.255.255.255'
  }
}

resource serverName_databaseName 'Microsoft.DBforMySQL/servers/databases@2017-12-01' = {
  parent: serverName
  name: '${databaseName}'
  properties: {
    charset: 'utf8'
    collation: 'utf8_general_ci'
  }
}
