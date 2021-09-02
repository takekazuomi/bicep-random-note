// array of storage account names
param storageAccounts array

resource sa 'Microsoft.Storage/storageAccounts@2021-02-01' = [for name in storageAccounts:{
  name: name
  location: resourceGroup().location
  kind: 'Storage'
  sku: {
    name: 'Standard_LRS'
  }
}]

