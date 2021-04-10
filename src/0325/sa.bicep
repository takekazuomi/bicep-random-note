param name string = 'sa01'
param deploy bool = false

resource sa 'Microsoft.Storage/storageAccounts@2021-01-01' = if(deploy) {
  name: '${name}${uniqueString(resourceGroup().id)}'
  location: resourceGroup().location
  kind: 'Storage'
  sku: {
    name: 'Standard_LRS'
  }
}

output sa object = {
  id: sa.id
  name: sa.name
}
