  param name string

  resource sa 'Microsoft.Storage/storageAccounts@2021-01-01' = {
  name: 'sa'
  location: resourceGroup().location
  kind: 'Storage'
  sku: {
    name: 'Standard_LRS'
  }
}
