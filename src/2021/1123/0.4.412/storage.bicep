param name string
param location string = resourceGroup().location

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: name
  location: location
  kind: 'Storage'
  sku: {
    name: 'Standard_LRS'
  }
}
