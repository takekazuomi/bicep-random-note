param settingName string
param storageAccountName string
param workspaceId string

resource sa 'Microsoft.Storage/storageAccounts@2021-02-01' existing = {
  name:storageAccountName
}

//resource logAnalyticsWorkspaceDiagnostics 'Microsoft.Insights/diagnosticSettings@2017-05-01-preview' = {
//  scope: sa
//  name: 'diagnosticSettings'

resource storageAccountInsights 'microsoft.insights/diagnosticSettings@2017-05-01-preview' = {
  scope: sa
  name: settingName
  properties: {
    workspaceId: workspaceId
    metrics: [
      {
        category: 'Transaction'
        enabled: true
      }
    ]
  }
}

resource storageAccountInsightsBlob 'microsoft.insights/diagnosticSettings@2017-05-01-preview' = {
  scope: sa
  name: '${storageAccountName}/default/Microsoft.Insights/${settingName}'
  properties: {
    workspaceId: workspaceId
    logs: [
      {
        category: 'StorageRead'
        enabled: true
      }
      {
        category: 'StorageWrite'
        enabled: true
      }
      {
        category: 'StorageDelete'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'Transaction'
        enabled: true
      }
    ]
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_providers_diagnosticsettings_storageAccountName_default_Microsoft_Insights_settingName 'Microsoft.Storage/storageAccounts/tableServices/providers/diagnosticsettings@2017-05-01-preview' = if (hastable) {
  name: '${storageAccountName}/default/Microsoft.Insights/${settingName}'
  properties: {
    workspaceId: workspaceId
    logs: [
      {
        category: 'StorageRead'
        enabled: true
      }
      {
        category: 'StorageWrite'
        enabled: true
      }
      {
        category: 'StorageDelete'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'Transaction'
        enabled: true
      }
    ]
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_providers_diagnosticsettings_storageAccountName_default_Microsoft_Insights_settingName 'Microsoft.Storage/storageAccounts/fileServices/providers/diagnosticsettings@2017-05-01-preview' = if (hasfile) {
  name: '${storageAccountName}/default/Microsoft.Insights/${settingName}'
  properties: {
    workspaceId: workspaceId
    logs: [
      {
        category: 'StorageRead'
        enabled: true
      }
      {
        category: 'StorageWrite'
        enabled: true
      }
      {
        category: 'StorageDelete'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'Transaction'
        enabled: true
      }
    ]
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_providers_diagnosticsettings_storageAccountName_default_Microsoft_Insights_settingName 'Microsoft.Storage/storageAccounts/queueServices/providers/diagnosticsettings@2017-05-01-preview' = if (hasqueue) {
  name: '${storageAccountName}/default/Microsoft.Insights/${settingName}'
  properties: {
    workspaceId: workspaceId
    logs: [
      {
        category: 'StorageRead'
        enabled: true
      }
      {
        category: 'StorageWrite'
        enabled: true
      }
      {
        category: 'StorageDelete'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'Transaction'
        enabled: true
      }
    ]
  }
}
