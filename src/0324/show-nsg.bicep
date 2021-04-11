param name string

resource nsg 'Microsoft.Network/networkSecurityGroups@2020-08-01' existing = {
  name: name
  scope: resourceGroup()
}

var rules = nsg.properties.securityRules

output vnet object = nsg
output roules array = rules
