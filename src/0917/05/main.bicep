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
param skuCapacity int = 2

@description('Azure database for MySQL sku name ')
param skuName string = 'GP_Gen5_2'

@description('Azure database for MySQL Sku Size ')
param skuSizeMB int = 5120

@description('Azure database for MySQL pricing tier')
param skuTier string = 'GeneralPurpose'

@description('Azure database for MySQL sku family')
param skuFamily string = 'Gen5'

@description('MySQL version')
@allowed([
  '5.6'
  '5.7'
  '8.0'
])
param mysqlVersion string = '8.0'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('MySQL Server backup retention days')
param backupRetentionDays int = 7

@description('Geo-Redundant Backup setting')
param geoRedundantBackup string = 'Disabled'

@description('Virtual Network Name')
param virtualNetworkName string = 'azure_mysql_vnet'

@description('Subnet Name')
param subnetName string = 'azure_mysql_subnet'

@description('Virtual Network RuleName')
param virtualNetworkRuleName string = 'AllowSubnet'

@description('Virtual Network Address Prefix')
param vnetAddressPrefix string = '10.0.0.0/16'

@description('Subnet Address Prefix')
param subnetPrefix string = '10.0.0.0/16'

module virtualNetwork 'vnet.bicep' = {
  name: virtualNetworkName
  params: {
    location: location
    subnetName: subnetName
    subnetPrefix: subnetPrefix
    virtualNetworkName: virtualNetworkName
    vnetAddressPrefix: vnetAddressPrefix
  }
}

module mySQLServer 'mysql.bicep' = {
  name: serverName
  params: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    backupRetentionDays: backupRetentionDays
    geoRedundantBackup: geoRedundantBackup
    location: location
    serverName: serverName
    mysqlVersion: mysqlVersion
    skuCapacity: skuCapacity
    skuFamily: skuFamily
    skuName: skuName
    skuSizeMB: skuSizeMB
    skuTier: skuTier
    subnetName: subnetName
    virtualNetworkName: virtualNetworkName
    virtualNetworkRuleName: virtualNetworkRuleName
  }
  dependsOn: [
    virtualNetwork
  ]
}
