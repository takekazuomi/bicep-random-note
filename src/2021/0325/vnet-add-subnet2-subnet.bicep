param name string

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01'  existing = {
  name: name
}

output subnets array = vnet.properties.subnets

//output subnets array = [for s in vnet.properties.subnets: {
//  id: s.id
//  name: s.name
//  properties: {
//    addressPrefix: s.properties.addressPrefix
//    privateEndpointNetworkPolicies: s.properties.privateEndpointNetworkPolicies
//    privateLinkServiceNetworkPolicies: s.properties.privateLinkServiceNetworkPolicies
//  }
//}]
