var name = '${replace(resourceGroup().name, '-rg', '')}${uniqueString(resourceGroup().id)}'
var location = resourceGroup().location

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2021-06-01-preview' = {
  name: name
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

output name string = containerRegistry.name
