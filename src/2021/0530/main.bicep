param name string
param location string = resourceGroup().location
param sku string = 'Dev(No SLA)_Standard_E2a_v4'
param tier string = 'Basic'
param capacity int = 1
param databaseName string

resource dx 'Microsoft.Kusto/clusters@2020-09-18' = {
  name: name
  location: location
  sku: {
    name: sku
    tier: tier
    capacity: capacity
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    trustedExternalTenants: [
      {
        value: '*'
      }
    ]
    enableDiskEncryption: false
    enableStreamingIngest: false
    enablePurge: false
    enableDoubleEncryption: false
    engineType: 'V3'
  }
}

resource database 'Microsoft.Kusto/clusters/databases@2020-09-18' = {
  parent: dx
  name: databaseName
  location: location
  kind:'ReadWrite'
  properties:{
    softDeletePeriodInDays: 365
    hotCachePeriodInDays: 31
  }
}

// https://github.com/Azure/bicep/issues/784#issuecomment-850962035
/*
main.bicep(39,5) : Warning BCP037: The property "softDeletePeriodInDays" is not allowed on objects of type "ReadWriteDatabaseProperties". Permissible properties include "hotCachePeriod", "provisioningState", "softDeletePeriod", "statistics".
main.bicep(40,5) : Warning BCP037: The property "hotCachePeriodInDays" is not allowed on objects of type "ReadWriteDatabaseProperties". Permissible properties include "hotCachePeriod", "provisioningState", "softDeletePeriod", "statistics".
*/

