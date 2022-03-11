param prefix string
param location string = resourceGroup().location

var name = '${prefix}${uniqueString(resourceGroup().id)}'
resource acr 'Microsoft.ContainerRegistry/registries@2021-06-01-preview' = {
  name: name
  location: location
  sku: {
    name: 'Basic'
  }
}

output acr_fqdn string = acr.properties.loginServer
