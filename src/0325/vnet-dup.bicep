param name string = 'vnet'
param deploy bool = true

module vnet_mod 'vnet-dup-mod.bicep' = {
  name:'vnet'
  params: {
    deploy: false
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = if(deploy) {
  name: '${name}${uniqueString(resourceGroup().id)}'
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/15'
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
  dependsOn:[
    vnet_mod
  ]
}

output vnet object = vnet
