@description('Address prefix for the Virtual Network')
param addressPrefix string

@description('Location for all resources.')
param location string

param virtualNetworkName string

param subnetName string

@description('Subnet prefix')
param subnetPrefix string

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' existing = {
  parent:virtualNetwork
  name: subnetName
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
        }
      }
    ]
  }
}

output subnetId string = subnet.id
output subnets array = virtualNetwork.properties.subnets
