param location string = resourceGroup().location
param name string

resource nsg 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: name
  location:location
}

resource nsgRule 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  name: '${name}-rule'
  properties: {
    access: 'Deny'
    direction:'Inbound'
    sourceAddressPrefix:'*'
    sourcePortRange:'*'
    protocol:'*'
  }
}
