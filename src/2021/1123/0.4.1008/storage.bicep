param prefix string
param location string = resourceGroup().location

var name = '${prefix}${uniqueString(resourceGroup().id)}'

resource sa 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: name
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
}

output blob_fqdn string = sa.properties.primaryEndpoints.blob
