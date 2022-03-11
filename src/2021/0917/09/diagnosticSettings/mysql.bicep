param logAnalyticsName string
param mySQLName string

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2021-06-01' existing = {
  name: logAnalyticsName
}

resource mySQL 'Microsoft.DBforMySQL/servers@2017-12-01' existing = {
  name: mySQLName
}

// https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/resource-logs-categories#microsoftdbformysqlservers
resource mySQLDiagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: mySQL
  name: 'diagnosticSettings'
  properties: {
    workspaceId: logAnalytics.id
    logs: [
      {
        category: 'MySqlSlowLogs'
        enabled: true
      }
      {
        category: 'MySqlAuditLogs'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
  }
}
