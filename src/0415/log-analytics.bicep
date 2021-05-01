@description('Specifies the location of AKS cluster.')
param location string = resourceGroup().location

var logAnalyticsWorkspaceName = replace(resourceGroup().name, '-rg', '-workspace')
var logAnalyticsSku = 'PerGB2018'

// https://docs.microsoft.com/en-us/azure/templates/microsoft.operationalinsights/2020-08-01/workspaces?tabs=json
// The documentation is only up to 2020-08-01.
// schema
// https://github.com/Azure/azure-resource-manager-schemas/blob/master/schemas/2020-10-01/Microsoft.OperationalInsights.json
// Where is definition of list* operation
// https://docs.microsoft.com/ja-jp/azure/azure-resource-manager/templates/template-functions-resource?tabs=json#implementations
// rest API spec is here
// https://github.com/Azure/azure-rest-api-specs
// https://github.com/Azure/azure-rest-api-specs/blob/master/specification/operationalinsights/resource-manager/Microsoft.OperationalInsights/stable/2020-08-01/SharedKeys.json
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-10-01' = {
  name: logAnalyticsWorkspaceName
  location: location
  properties: {
    sku: {
      name: logAnalyticsSku
    }
  }
}

output logAnalyticsWorkspaceId string = logAnalyticsWorkspace.id
output logAnalyticsWorkspaceKey string = listKey(logAnalyticsWorkspace.id, logAnalyticsWorkspace.apiVersion).primarySharedKey
