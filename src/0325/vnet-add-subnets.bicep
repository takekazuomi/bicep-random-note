param name string = 'vnet'
param addressPrefix string = '10.0.0.0/15'
param deploy bool = true

var subnets = union(vnet.outputs.subnets, [
  {
    name: 'subnet003'
    properties: {
      addressPrefix: '10.0.2.0/24'
    }
  }
  {
    name: 'subnet004'
    properties: {
      addressPrefix: '10.0.3.0/24'
    }
  }
])

module vnet 'vnet-subnet.bicep' = {
  name: 'vnet'
  params: {
    deploy: false
  }
}

resource vnet2 'Microsoft.Network/virtualNetworks@2020-06-01' = if (deploy) {
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
    subnets: [for s in subnets: {
      name: s.name
      properties: {
        addressPrefix: s.properties.addressPrefix
        privateEndpointNetworkPolicies: s.properties.privateEndpointNetworkPolicies
        privateLinkServiceNetworkPolicies: s.properties.privateLinkServiceNetworkPolicies
      }
    }]
  }
}

output vnet2 object = vnet2
