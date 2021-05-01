@maxLength(10)
@minLength(3)
@description('storage accountのprefix')
param prefix string
@description('場所、デフォルトはリソースグループと同じ')
param location string = resourceGroup().location
@allowed([
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GRS'
  'Standard_GZRS'
  'Standard_LRS'
  'Standard_RAGRS'
  'Standard_RAGZRS'
  'Standard_ZRS'
])
@description('storage accountのSKU')
param sku string

@allowed([
  'BlobStorage'
  'BlockBlobStorage'
  'FileStorage'
  'Storage'
  'StorageV2'
])
@description('storage accountの種別')
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
