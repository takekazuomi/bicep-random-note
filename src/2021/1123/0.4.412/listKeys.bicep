resource sa 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: 'demosa${uniqueString(resourceGroup().id)}'
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind:'Storage'
}

output key string = sa.listKeys().keys[0].value
//output key2 string = listKeys(sa.id, sa.apiVersion)
