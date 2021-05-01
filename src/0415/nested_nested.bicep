param endpoints object
param settingName string
param storageAccountName string
param storageSyncName string
param workspaceId string

var hasblob = contains(endpoints, 'blob')
var hastable = contains(endpoints, 'table')
var hasfile = contains(endpoints, 'file')
var hasqueue = contains(endpoints, 'queue')

resource storageAccountName_Microsoft_Insights_settingName 'Microsoft.Storage/storageAccounts/providers/diagnosticsettings@2017-05-01-preview' = {
  name: '${storageAccountName}/Microsoft.Insights/${settingName}'
  properties: {
    workspaceId: workspaceId
    storageAccountId: resourceId('Microsoft.Storage/storageAccounts', storageSyncName)
    metrics: [
      {
        category: 'Transaction'
        enabled: true
      }
    ]
  }
}

resource storageAccountName_default_Microsoft_Insights_settingName 'Microsoft.Storage/storageAccounts/blobServices/providers/diagnosticsettings@2017-05-01-preview' = if (hasblob) {
  name: '${storageAccountName}/default/Microsoft.Insights/${settingName}'
  properties: {
    workspaceId: workspaceId
    storageAccountId: resourceId('Microsoft.Storage/storageAccounts', storageSyncName)
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
    storageAccountId: resourceId('Microsoft.Storage/storageAccounts', storageSyncName)
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
    storageAccountId: resourceId('Microsoft.Storage/storageAccounts', storageSyncName)
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
    storageAccountId: resourceId('Microsoft.Storage/storageAccounts', storageSyncName)
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