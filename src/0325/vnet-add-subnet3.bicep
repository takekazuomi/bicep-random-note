param name string = 'vnet'
param deploy bool = true

var subnets = [
  {
    name: 'subnet001'
    properties: {
      addressPrefix: '10.0.1.0/24'
    }
  }
  {
    name: 'subnet002'
    properties: {
      addressPrefix: '10.0.2.0/24'
    }
  }
  {
    name: 'subnet003'
    properties: {
      addressPrefix: '10.0.3.0/24'
    }
  }
  {
    name: 'subnet004'
    properties: {
      addressPrefix: '10.0.4.0/24'
    }
  }
  {
    name: 'subnet005'
    properties: {
      addressPrefix: '10.0.5.0/24'
    }
  }
]

// var currentSubnets = vnetref.properties.subnets
// resource vnetref 'Microsoft.Network/virtualNetworks@2020-06-01'  existing = {
//   name: name
// }

var currentSubnets = vnetref.outputs.subnets
module vnetref 'vnet-add-subnet2-subnet.bicep' = {
  name:'vnet'
  params:{
    name: name
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
     subnets: union(currentSubnets, subnets)
   }
}

// output vnet object = vnet
