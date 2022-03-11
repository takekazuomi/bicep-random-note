module networkSecurityGroupsSettings './collector.bicep' = {
  name: 'nsg'

}

module o 'dummy.bicep' = {
  name: 'd'
}

resource networkSecurityGroup1 'Microsoft.Network/networkSecurityGroups@2015-06-15' = {
  name: 'networkSecurityGroup1'
  location: resourceGroup().location
  properties: {
    securityRules: [
      networkSecurityGroupsSettings.outputs.networkSecurityGroup
    ]
  }
}