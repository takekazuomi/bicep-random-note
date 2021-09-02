@description('Address prefix for the Virtual Network')
param addressPrefix string

@description('Location for all resources.')
param location string

param virtualNetworkName string

@description('Array of subnet object. https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2020-07-01/virtualnetworks?tabs=json#subnet-object')
param subnets array

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: subnets
  }
}

//output subnetId string = subnet.id
output subnets array = virtualNetwork.properties.subnets
