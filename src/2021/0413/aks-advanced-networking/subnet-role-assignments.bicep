param existingVirtualNetworkName string
param existingSubnetName string
param builtInRoleType string
param existingServicePrincipalObjectId string
param builtInRole object
param vnetSubnetId string

resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  name: existingVirtualNetworkName
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' existing = {
  parent: vnet
  name: existingSubnetName
}

resource roleAssignments 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  scope: subnet
  name: '${guid(resourceGroup().id, deployment().name)}'
  properties: {
    roleDefinitionId: builtInRole[builtInRoleType]
    principalId: existingServicePrincipalObjectId
  }
}

