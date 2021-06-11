@description('DNS of the WebApp')
param siteName string

@description('Location for all resources.')
param location string

param ipSecurityRestrictionAddress string

@secure()
param connectionString string

var hostingPlanName = '${siteName}serviceplan'

resource hostingPlan 'Microsoft.Web/serverfarms@2021-01-01' = {
  name: hostingPlanName
  location: location
  tags: {
    displayName: 'HostingPlan'
  }
  sku: {
    name: 'S1'
    capacity: 1
  }
}

resource site 'Microsoft.Web/sites@2021-01-01' = {
  name: siteName
  location: location
  properties: {
    serverFarmId: hostingPlan.id
  }
}

resource siteConnectionStrings 'Microsoft.Web/sites/config@2021-01-01' = {
  parent: site
  name: 'connectionstrings'
  properties: {
    DefaultConnection: {
      value: connectionString
      type: 'MySql'
    }
  }
}

resource siteConfig 'Microsoft.Web/sites/config@2021-01-01' = {
  parent: site
  name: 'web'
  properties: {
    ipSecurityRestrictions: [
      {
        ipAddress: '${ipSecurityRestrictionAddress}/32'
      }
    ]
  }
}

output defaultHostName string = site.properties.defaultHostName
