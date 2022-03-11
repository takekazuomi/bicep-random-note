param name string
@allowed([
  'BlobStorage'
])
param kind string

var saName = '${name}${uniqueString(resourceGroup().id)}'

resource sa 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name:
  location:
  sku: {
    name:
  }
  kind:

}
resource cosmosDbAccount 'Microsoft.DocumentDB/databaseAccounts@2021-03-15' = {
  name: 'name'
  location: resourceGroup().location
  kind: 'GlobalDocumentDB'
  properties: {
    consistencyPolicy: {
      defaultConsistencyLevel: 'Eventual'
      maxStalenessPrefix: 1
      maxIntervalInSeconds: 5
    }
    locations: [
      {
        locationName: 'location'
        failoverPriority: 0
      }
    ]
    databaseAccountOfferType: 'Standard'
    enableAutomaticFailover: true
    capabilities: [
      {
        name: 'EnableTable'
      }
    ]
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'name'
  location: resourceGroup().location
  sku: {
    name: 'F1'
    capacity: 1
  }
}

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'name'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
    tier: 'Premium'
  }
}

