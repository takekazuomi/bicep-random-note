param name string
param location string


// https://docs.microsoft.com/en-us/azure/templates/microsoft.operationalinsights/2021-06-01/workspaces?tabs=bicep
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  location: location
  name: name
  properties: {
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
    workspaceCapping: {
      dailyQuotaGb: -1
    }
  }
}

output logAnalytics object = {
  id: logAnalytics.id
  name: logAnalytics.name
}
