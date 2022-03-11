param storageAccountName string
param settingName string
param storageSyncName string
param workspaceId string

module nested './nested_nested.bicep' = {
  name: 'nested'
  params: {
    endpoints: reference(resourceId('Microsoft.Storage/storageAccounts', storageAccountName), '2019-06-01', 'Full').properties.primaryEndpoints
    settingName: settingName
    storageAccountName: storageAccountName
    storageSyncName: storageSyncName
    workspaceId: workspaceId
  }
}