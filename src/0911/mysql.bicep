param administratorLogin string

@secure()
param administratorLoginPassword string
param location string
param serverName string
param serverEdition string
param storageSizeMB int
param haEnabled string = 'Disabled'
param availabilityZone string
param version string
param tags object = {}
param firewallRules object = {}
param vnetData object = {}
param backupRetentionDays int

var firewallRules_var = firewallRules.rules
var publicNetworkAccess = (empty(vnetData) ? 'Enabled' : 'Disabled')
var vnetDataSet = (empty(vnetData) ? json('{ "subnetArmResourceId": "" }') : vnetData)
var finalVnetData = json('{ "subnetArmResourceId": "${vnetDataSet.subnetArmResourceId}"}')

// https://docs.microsoft.com/en-us/azure/templates/microsoft.dbformysql/2021-05-01-preview/flexibleservers?tabs=bicep
resource serverName_resource 'Microsoft.DBForMySql/flexibleServers@2020-07-01-preview' = {
  name: serverName
  location: location
  sku: {
    name: 'Standard_D4ds_v4'
    tier: serverEdition
  }
  tags: tags
  properties: {
    version: version
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    publicNetworkAccess: publicNetworkAccess
    DelegatedSubnetArguments: (empty(vnetData) ? json('null') : finalVnetData)
    haEnabled: haEnabled
    storageProfile: {
      storageMB: storageSizeMB
      backupRetentionDays: backupRetentionDays
    }
    availabilityZone: availabilityZone
  }
}

@batchSize(1)
module firewallRules_resource './nested_firewallRules_resource.bicep' = [for i in range(0, ((length(firewallRules_var) > 0) ? length(firewallRules_var) : 1)): {
  name: 'firewallRules-${i}'
  params: {
    variables_firewallRules_copyIndex_name: firewallRules_var
    variables_firewallRules_copyIndex_startIPAddress: firewallRules_var
    variables_firewallRules_copyIndex_endIPAddress: firewallRules_var
    serverName: serverName
  }
  dependsOn: [
    serverName_resource
  ]
}]
