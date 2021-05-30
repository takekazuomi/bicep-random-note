param name string
param location string
param sku string
param tags object
param repositoryUrl string
param appLocation string
param appArtifactLocation string

@secure()
param repositoryToken string

resource sw 'Microsoft.Web/staticSites@2020-12-01' = {
  location: location
  name: name
  tags: tags
  sku: {
    tier: sku
    name: sku
  }
  properties: {
    repositoryUrl: repositoryUrl
    repositoryToken: repositoryToken
    buildProperties: {
      appLocation: appLocation
      appArtifactLocation: appArtifactLocation
    }
  }
}
