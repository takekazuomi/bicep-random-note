param networkSecurityGroupsSettings object

var collectorTemplateUri = uri(deployment().properties.templateLink.uri, 'collector.template.json')

resource networkSecurityGroup1 'Microsoft.Network/networkSecurityGroups@2015-06-15' = {
  name: 'networkSecurityGroup1'
  location: resourceGroup().location
  properties: {
    securityRules: networkSecurityGroupsSettings
  }
}