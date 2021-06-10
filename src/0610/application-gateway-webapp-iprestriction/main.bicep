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
  '102400'
  '51200'
])
@description('Azure database for MySQL Sku Size')
param databaseSkuSizeMB string = '51200'

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

var applicationGatewayName = '${siteName}-agw'
var publicIPAddressName = '${siteName}-pip'
var virtualNetworkName = 'virtualNetwork1'
var subnetName = 'appGatewaySubnet'
var subnetRef = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, subnetName)
var publicIPRef = publicIPAddress.id
var databaseName = '${siteName}db'
var mysqlName = '${siteName}mysqlserver'
var hostingPlanName = '${siteName}serviceplan'

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2020-05-01' = {
  name: publicIPAddressName
  location: location
  properties: {
    publicIPAllocationMethod: 'Static'
  }
  sku: {
    name: 'Standard'
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2020-05-01' = {
  name: virtualNetworkName
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

resource applicationGateway 'Microsoft.Network/applicationGateways@2020-05-01' = {
  name: applicationGatewayName
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
              ipAddress: site.properties.defaultHostName
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
            id: resourceId('Microsoft.Network/applicationGateways/probes/', applicationGatewayName, 'Probe1')
          }
        }
      }
    ]
    httpListeners: [
      {
        name: 'appGatewayHttpListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations/', applicationGatewayName, 'appGatewayFrontendIP')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts/', applicationGatewayName, 'appGatewayFrontendPort')
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
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners/', applicationGatewayName, 'appGatewayHttpListener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools/', applicationGatewayName, 'appGatewayBackendPool')
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection/', applicationGatewayName, 'appGatewayBackendHttpSettings')
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
    virtualNetwork
  ]
}

module fetchIpAddress 'fetchIpAddress.bicep' = {
  name: 'fetchIpAddress'
  params: {
    publicIPAddressId: publicIPAddress.id
  }
  dependsOn: [
    applicationGateway
  ]
}

resource hostingPlan 'Microsoft.Web/serverfarms@2019-08-01' = {
  name: hostingPlanName
  location: location
  tags: {
    displayName: 'HostingPlan'
  }
  sku: {
    name: 'S1'
    capacity: 1
  }
}

resource site 'Microsoft.Web/sites@2019-08-01' = {
  name: siteName
  location: location
  properties: {
    serverFarmId: hostingPlan.id
  }
}

resource siteConnectionStrings 'Microsoft.Web/sites/config@2019-08-01' = {
  parent: site
  name: 'connectionstrings'
  properties: {
    DefaultConnection: {
      value: 'Database=${databaseName};Data Source=${mysql.properties.fullyQualifiedDomainName};User Id=${administratorLogin}@${mysqlName};Password=${administratorLoginPassword}'
      type: 'MySql'
    }
  }
}

resource siteConfig 'Microsoft.Web/sites/config@2019-08-01' = {
  parent: site
  name: 'web'
  properties: {
    ipSecurityRestrictions: [
      {
        ipAddress: '${fetchIpAddress.outputs.ipAddress}/32'
      }
    ]
  }
}

resource mysql 'Microsoft.DBforMySQL/servers@2017-12-01' = {
  location: location
  name: mysqlName
  properties: {
    createMode: 'Default'
    version: mysqlVersion
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
  sku: {
    name: databaseSkuName
    tier: databaseSkuTier
    size: databaseSkuSizeMB
    family: databaseSkuFamily
  }
}

resource mysqlFirewall 'Microsoft.DBforMySQL/servers/firewallrules@2017-12-01' = {
  parent: mysql
  name: '${mysqlName}firewall'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '255.255.255.255'
  }
}

resource mysqlDatabase 'Microsoft.DBforMySQL/servers/databases@2017-12-01' = {
  parent: mysql
  name: databaseName
  properties: {
    charset: 'utf8'
    collation: 'utf8_general_ci'
  }
}
