param location string = resourceGroup().location
param name string
@description('Address space for the VNet.')
param vnetAddressPrefix string = '192.168.100.0/24'

@description('The prefix for the GatewaySubnet where the VirtualNetworkGateway will be deployed. This must be at least /29.')
param gatewaySubnetPrefix string = '192.168.100.16/28'

resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: gatewaySubnetPrefix
        }
      }
    ]
  }
}

resource gatewayPublicIPName_resource 'Microsoft.Network/publicIPAddresses@2020-05-01' = {
  name: gatewayPublicIPName
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}
