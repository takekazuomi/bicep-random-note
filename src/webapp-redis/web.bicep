@description('DNS of the WebApp')
param siteName string

@description('Location for all resources.')
param location string

@description('Array of ipSecurityRestriction object. https://docs.microsoft.com/en-us/azure/templates/microsoft.web/2020-12-01/sites/config-web?tabs=json#ipsecurityrestriction-object')
param ipSecurityRestrictions array

param subnetId string

@allowed([
  'Free'
  'Standard'
  'Premium'
  'PremiumV2'
])
@description('Tier for Service Plan')
param tier string = 'Free'

@allowed([
  'F1'
  'S1'
  'S2'
  'S3'
  'P1'
  'P2'
  'P3'
  'P1V2'
  'P2V2'
  'P3V3'
])
@description('Size for Service Plan')
param sku string = 'F1'

param alwaysOn bool
param linuxFxVersion string
param dockerRegistryUrl string
param dockerRegistryUsername string

@secure()
param dockerRegistryPassword string

param dockerRegistryStartupCommand string

var hostingPlanName = '${siteName}-plan'

resource hostingPlan 'Microsoft.Web/serverfarms@2021-01-01' = {
  name: hostingPlanName
  location: location
  kind: 'linux'
  sku: {
    name: sku
    tier: tier
    capacity: 1
  }
}

resource site 'Microsoft.Web/sites@2021-01-01' = {
  name: siteName
  location: location
  properties: {
    siteConfig: {
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: dockerRegistryUrl
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: dockerRegistryUsername
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: dockerRegistryPassword
        }
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
      ]
      linuxFxVersion: linuxFxVersion
      appCommandLine: dockerRegistryStartupCommand
      alwaysOn: alwaysOn
    }
    serverFarmId: hostingPlan.id
    clientAffinityEnabled: false
  }
}

resource sitevnet 'Microsoft.Web/sites/networkConfig@2021-01-01' = {
  parent: site
  name: 'virtualNetwork'
  properties: {
    subnetResourceId: subnetId
    swiftSupported: true
  }
}

resource siteConfig 'Microsoft.Web/sites/config@2021-01-01' = {
  parent: site
  name: 'web'
  properties: {
    ipSecurityRestrictions: ipSecurityRestrictions
  }
}

resource symbolicname 'Microsoft.Web/sites/config@2018-11-01' = {
  parent:site
  name: 'appsettings'
  properties: {
    {
      name: 'DOCKER_REGISTRY_SERVER_URL'
      value: dockerRegistryUrl
    }
    {
      name: 'DOCKER_REGISTRY_SERVER_USERNAME'
      value: dockerRegistryUsername
    }
    {
      name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
      value: dockerRegistryPassword
    }
    {
      name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
      value: 'false'
    }

    name: 'value'
    name: 'value'
    name: 'value'
  }
}

output defaultHostName string = site.properties.defaultHostName
