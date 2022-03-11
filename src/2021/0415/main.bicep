@description('Specifies the location of AKS cluster.')
param location string = resourceGroup().location

var name = 'sa${replace(replace(resourceGroup().name, '-rg', ''), '-', '')}01'
var logAnalyticsWorkspaceName ='law-${replace(replace(resourceGroup().name, '-rg', ''), '-', '')}-01'

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-03-01-preview' = {
  name: logAnalyticsWorkspaceName
  location: location
  properties: any({
    retentionInDays: 30
    features: {
      searchVersion: 1
    }
    sku: {
      name: 'PerGB2018'
    }
  })
}

// https://docs.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts?tabs=bicep
// https://docs.microsoft.com/ja-jp/rest/api/storagerp/storageaccounts/listkeys
resource sa 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: name
  location: location
  kind: 'Storage'
  sku: {
    name: 'Standard_LRS'
  }
}

output id string = sa.id
output keys string = listKeys(sa.id, sa.apiVersion).keys[0].value


resource logAnalyticsWorkspaceDiagnostics 'microsoft.insights/diagnosticSettings@2017-05-01-preview' = {
  scope: sa
  name: 'diagnosticSettings'
  properties: {
    workspaceId: logAnalyticsWorkspace.id
    logs: [
      {
        category: 'Audit'
        enabled: true
        retentionPolicy: {
          days: 7
          enabled: true
        }
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
        retentionPolicy: {
          days: 7
          enabled: true
        }
      }
    ]
  }
}

