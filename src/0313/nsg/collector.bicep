param networkSecurityGroupsSettings array = []

resource networkSecurityGroup1 'Microsoft.Network/networkSecurityGroups@2015-06-15' = {
  name: 'networkSecurityGroup1'
  location: resourceGroup().location
  properties: {
    securityRules: networkSecurityGroupsSettings
  }
}

output networkSecurityGroup object = networkSecurityGroup1