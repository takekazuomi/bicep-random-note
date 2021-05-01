param prefix string
param location string
param sku string
param kind string

var name = '${prefix}${uniqueString(resourceGroup().id)}'

resource sa 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: name
  location: location
  kind: kind
  sku: {
    name: sku
  }
}
