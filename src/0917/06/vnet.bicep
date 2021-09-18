@description('Virtual Network Name')
param virtualNetworkName string

@description('Virtual Network Address Prefix')
param vnetAddressPrefix string

@description('Location for all resources.')
param location string

// https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-functions-files
var subnets = json(loadTextContent('virtual-network-subnets.json'))

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
  }
}

resource virtualNetworkSubnet 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' = [for i in range(0, length(subnets)): {
  parent: virtualNetwork
  name: subnets[i].name
  properties: {
    addressPrefix: subnets[i].prefix
  }
}]

output virtualNetwork object = {
  id: virtualNetwork.id
  name: virtualNetwork.name
}

output subnets array =  [for i in range(0, length(subnets)): {
  id: virtualNetworkSubnet[i].id
  name: virtualNetworkSubnet[i].name
}]
