param name string = 'vnet'
param deploy bool = true
param skip bool = false

var subnets = [
  {
    name: 'subnet004'
    properties: {
      addressPrefix: '10.0.4.0/24'
    }
  }
]

module vnet_mod 'vnet-add-subnet2-subnet.bicep' = if(!skip) {
  name:'vnet'
  params:{
    name: name
  }
}

module union_mod 'vnet-add-subnet2-union.bicep' = {
  name:'vnet-union'
  params:{
    subnets1: skip ? []: vnet_mod.outputs.subnets
    subnets2: subnets
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
   name: name
   location: resourceGroup().location
   properties: {
     addressSpace: {
       addressPrefixes: [
         '10.0.0.0/15'
       ]
     }
     enableVmProtection: false
     enableDdosProtection: false
     subnets: union_mod.outputs.subnets
   }
}

// output vnet object = vnet
