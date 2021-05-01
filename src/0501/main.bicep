param location string = resourceGroup().location
param name string

// https://github.com/Azure/azure-rest-api-specs/blob/master/specification/webpubsub/resource-manager/Microsoft.SignalRService/preview/2021-04-01-preview/webpubsub.json#L1617
@allowed([
  'Free_F1'
  'Standard_S1'
])
@description('The name of the SKU. Required. Allowed values: Standard_S1, Free_F1')
param skuName string = 'Free_F1'

// https://github.com/Azure/azure-rest-api-specs/blob/master/specification/webpubsub/resource-manager/Microsoft.SignalRService/preview/2021-04-01-preview/webpubsub.json#L2119
@allowed([
  'Free'
  'Basic'
  'Standard'
  'Premium'
])
@description('Optional tier of this particular SKU. `Standard` or `Free`. `Basic` is deprecated, use `Standard` instead.')
param tier string = 'Free'

// https://github.com/Azure/azure-rest-api-specs/blob/master/specification/webpubsub/resource-manager/Microsoft.SignalRService/preview/2021-04-01-preview/webpubsub.json#L1635
@allowed([
  1
  2
  5
  10
  20
  50
  100
])
@description('Optional, integer. The unit count of the resource. 1 by default. If present, following values are allowed: Free: 1, Standard: 1,2,5,10,20,50,100')
param capacity int = 1

param tags object = {}

// https://github.com/Azure/azure-rest-api-specs/tree/master/specification/webpubsub
resource name_resource 'Microsoft.SignalRService/WebPubSub@2021-04-01-preview' = {
  name: name
  location: location
  properties: {}
  sku: {
    name: skuName
    tier: tier
    capacity: capacity
  }
  tags: tags
}
