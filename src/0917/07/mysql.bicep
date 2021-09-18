@description('Server Name for Azure database for MySQL')
param serverName string

@description('Database administrator login name')
@minLength(1)
param administratorLogin string

@description('Database administrator password')
@minLength(8)
@secure()
param administratorLoginPassword string

@description('Azure database for MySQL compute capacity in vCores B (1,2), GP (2,4,8,16,32)')
param skuCapacity int

@description('Azure database for MySQL sku name ')
param skuName string

@description('Azure database for MySQL Sku Size ')
param skuSizeMB int

@description('Azure database for MySQL pricing tier')
@allowed([
  'Basic'
  'GeneralPurpose'
  'MemoryOptimized'
])
param skuTier string

@description('Azure database for MySQL sku family')
@allowed([
  'Gen5'
])
param skuFamily string

@description('MySQL version')
@allowed([
  '5.6'
  '5.7'
  '8.0'
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

// https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-functions-files
var firewallrules = json(loadTextContent('mysql-firewall-rules.json'))

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' existing = {
  name: virtualNetworkName
}

resource virtualNetworkSubnet 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' existing = {
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
    sslEnforcement: 'Enabled'
    minimalTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    storageProfile: {
      storageMB: skuSizeMB
      backupRetentionDays: backupRetentionDays
      geoRedundantBackup: geoRedundantBackup
      storageAutogrow: 'Enabled'
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
  name: firewallrules[i].Name
  properties: {
    startIpAddress: firewallrules[i].StartIpAddress
    endIpAddress: firewallrules[i].EndIpAddress
  }
}]

output mySQL object = {
  id: mySQLServer.id
  name: mySQLServer.name
}
