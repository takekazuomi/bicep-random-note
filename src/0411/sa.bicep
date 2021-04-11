@description('Specifies the location of AKS cluster.')
param location string = resourceGroup().location

var name = 'sa01${replace(replace(resourceGroup().name, '-rg', ''), '-','')}'

// https://docs.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts?tabs=bicep
// https://docs.microsoft.com/ja-jp/rest/api/storagerp/storageaccounts/listkeys
resource sa 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: name
  location: location
  kind:'Storage'
  sku:{
    name:'Standard_LRS'
  }
}

output id string = sa.id
output keys string = listKey(sa.id, sa.apiVersion).keys[0].value
