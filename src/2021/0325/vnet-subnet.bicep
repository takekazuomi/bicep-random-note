param name string = 'vnet'
param addressPrefix string = '10.0.0.0/15'
param deploy bool = true

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = if(deploy) {
  name: '${name}${uniqueString(resourceGroup().id)}'
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    enableVmProtection: false
    enableDdosProtection: false
    subnets: [
      {
        name: 'subnet001'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: 'subnet002'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}

output subnets array = [for s in vnet.properties.subnets: {
  id: s.id
  name: s.name
  properties: {
    addressPrefix: s.properties.addressPrefix
    privateEndpointNetworkPolicies: s.properties.privateEndpointNetworkPolicies
    privateLinkServiceNetworkPolicies: s.properties.privateLinkServiceNetworkPolicies
  }
}]
