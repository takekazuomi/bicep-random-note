@description('Server Name for Azure database for MySQL')
param serverName string

@description('Database administrator login name')
@minLength(1)
param administratorLogin string

@description('Database administrator password')
@minLength(8)
@secure()
param administratorLoginPassword string

@description('Azure database for MySQL compute capacity in vCores (2,4,8,16,32)')
param skuCapacity int

@description('Azure database for MySQL sku name ')
param skuName string

@description('Azure database for MySQL Sku Size ')
param skuSizeMB int

@description('Azure database for MySQL pricing tier')
param skuTier string

@description('Azure database for MySQL sku family')
param skuFamily string

@description('MySQL version')
@allowed([
  '5.6'
  '5.7'
])
param mysqlVersion string

@description('Location for all resources.')
param location string

@description('MySQL Server backup retention days')
param backupRetentionDays int

@description('Geo-Redundant Backup setting')
param geoRedundantBackup string

@description('Virtual Network Name')
param virtualNetworkName string

@description('Subnet Name')
param subnetName string

@description('Virtual Network RuleName')
param virtualNetworkRuleName string

var firewallrules = {
  batch: {
    rules: [
      {
        Name: 'rule1'
        StartIpAddress: '0.0.0.0'
        EndIpAddress: '255.255.255.255'
      }
      {
        Name: 'rule2'
        StartIpAddress: '0.0.0.0'
        EndIpAddress: '255.255.255.255'
      }
    ]
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2020-06-01' existing = {
  name: virtualNetworkName
}

resource virtualNetworkSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-06-01' existing = {
  parent: virtualNetwork
  name: subnetName
}

resource mySQLServer 'Microsoft.DBforMySQL/servers@2017-12-01' = {
  name: serverName
  location: location
  sku: {
    name: skuName
    tier: skuTier
    capacity: skuCapacity
    size: '${skuSizeMB}'
    family: skuFamily
  }
  properties: {
    createMode: 'Default'
    version: mysqlVersion
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    storageProfile: {
      storageMB: skuSizeMB
      backupRetentionDays: backupRetentionDays
      geoRedundantBackup: geoRedundantBackup
    }
  }
}

resource mySQLServerVirtualNetworkRule 'Microsoft.DBforMySQL/servers/virtualNetworkRules@2017-12-01' = {
  parent: mySQLServer
  name: virtualNetworkRuleName
  properties: {
    virtualNetworkSubnetId: virtualNetworkSubnet.id
    ignoreMissingVnetServiceEndpoint: true
  }
}

@batchSize(1)
resource mySQLServerFirewallRules 'Microsoft.DBforMySQL/servers/firewallRules@2017-12-01' = [for i in range(0, length(firewallrules.batch.rules)): {
  parent: mySQLServer
  name: firewallrules.batch.rules[i].Name
  properties: {
    startIpAddress: firewallrules.batch.rules[i].StartIpAddress
    endIpAddress: firewallrules.batch.rules[i].EndIpAddress
  }
  dependsOn: [
    mySQLServer
  ]
}]
