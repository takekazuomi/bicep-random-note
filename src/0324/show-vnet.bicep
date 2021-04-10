param name string

resource vnet 'Microsoft.Network/virtualNetworks@2020-08-01' = {
  name: name
}

output vnet object = vnet
