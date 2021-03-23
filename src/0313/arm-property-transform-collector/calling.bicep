param networkSecurityGroupsSettings object
param url string
param path string
param version string

var collectorTemplateUri = '${url}/${path}/${version}/collector.json'

module collector '?' /*TODO: replace with correct path to [variables('collectorTemplateUri')]*/ = {
  name: 'collector'
  params: {
    source: networkSecurityGroupsSettings.securityRules
    transformTemplateUri: '${url}/${path}/${version}/transform.json'
    url: url
    path: path
    version: version
  }
}

module BuildNetworkSecurityGroup '?' /*TODO: replace with correct path to [concat(parameters('url'),'/',parameters('path'),'/',parameters('version'),'/networkSecurityGroups.json')]*/ = {
  name: 'BuildNetworkSecurityGroup'
  params: {
    Name: '${networkSecurityGroupsSettings.name}-nsg'
    SecurityRules: reference('collector').outputs.result.value
    DependsOn: []
  }
  dependsOn: []
}

output armTemplate object = {
  '$schema': 'https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#'
  contentVersion: '1.0.0.0'
  parameters: {}
  variables: {}
  resources: createArray(reference('BuildNetworkSecurityGroup').outputs.networkSecurityGroups.value)
  outputs: {}
}