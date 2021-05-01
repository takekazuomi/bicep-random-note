@description('Name of the virtual Network')
param vnetName string = 'vnet'

@description('Address prefix')
param vnetAddressPrefix string = '10.10.0.0/16'

@description('Subnet Prefix')
param subnetPrefix string = '10.10.0.0/24'
param subnetName string = 'Subnet'

@description('Location for the virtual network.')
param location string = resourceGroup().location

resource virtualNetworks 'Microsoft.Network/virtualNetworks@2020-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
  }
}

resource subnets 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks
  name: subnetName
  properties: {
    addressPrefix: subnetPrefix
  }
}

output vnetName string = vnetName
output vnetResourceGroupName string = resourceGroup().name
output subnetName string = subnetName
