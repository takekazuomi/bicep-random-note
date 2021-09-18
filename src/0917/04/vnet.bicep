@description('Virtual Network Name')
param virtualNetworkName string

@description('Subnet Name')
param subnetName string

@description('Virtual Network Address Prefix')
param vnetAddressPrefix string

@description('Subnet Address Prefix')
param subnetPrefix string

@description('Location for all resources.')
param location string

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2020-06-01' = {
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

resource virtualNetworkSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-06-01' = {
  parent: virtualNetwork
  name: subnetName
  properties: {
    addressPrefix: subnetPrefix
  }
}
