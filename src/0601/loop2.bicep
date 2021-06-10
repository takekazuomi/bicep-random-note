param storagePrefix array
param storageCount int

resource sa 'Microsoft.Storage/storageAccounts@2021-02-01' = [for i in range(0, storageCount):{
  name: '${storagePrefix}${i}'
  location: resourceGroup().location
  kind: 'Storage'
  sku: {
    name: 'Standard_LRS'
  }
}]

