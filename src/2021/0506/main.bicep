
param namePrefix string
param administratorLogin string

@secure()
param administratorLoginPassword string

param storageSizeMB int = 32 * 1024
param version string = '5.7'
param backupRetentionDays int = 7
param storageIops int = 100
param skuName string = 'Standard_B1ms'
param skuCapacity int = 1
param skuTier string = 'Burstable'

var name = '${namePrefix}-${uniqueString(resourceGroup().id)}'
var location = resourceGroup().location

resource mysql_resource 'Microsoft.DBForMySql/flexibleServers@2020-07-01-preview' = {
  name: name
  location: location
  sku: {
    name: skuName
    tier: skuTier
  }
  properties: {
    version: version
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    storageProfile: {
      storageMB: storageSizeMB
      backupRetentionDays: backupRetentionDays
      storageIops: storageIops
    }
  }
}
