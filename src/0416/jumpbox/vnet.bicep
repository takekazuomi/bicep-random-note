@description('Specifies the location of AKS cluster.')
param location string

@description('Specifies the name of the subnet which contains the virtual machine.')
param vmSubnetName string = 'VmSubnet'

@description('Specifies the address prefix of the subnet which contains the virtual machine.')
param vmSubnetAddressPrefix string = '10.1.0.0/24'

@description('Specifies the name of the virtual network.')
param virtualNetworkName string

@description('Specifies the address prefixes of the virtual network.')
param virtualNetworkAddressPrefixes string = '10.0.0.0/8'

@description('Specifies the rules of the vm subnet nsg.')
param vmSubnetNsgSecurityRules array = []

var vmSubnetNsgName = '${vmSubnetName}Nsg'
var vmSubnetId = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetwork.name, vmSubnetName)


resource vmSubnetNsg 'Microsoft.Network/networkSecurityGroups@2020-08-01' = {
  name: vmSubnetNsgName
  location: location
  properties: {
    securityRules: vmSubnetNsgSecurityRules
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2020-08-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        virtualNetworkAddressPrefixes
      ]
    }
    subnets: [
      {
        name: vmSubnetName
        properties: {
          addressPrefix: vmSubnetAddressPrefix
          networkSecurityGroup: {
            id: vmSubnetNsg.id
          }
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    enableDdosProtection: false
    enableVmProtection: false
  }
}

resource vmSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-08-01' existing = {
  parent: virtualNetwork
  name: vmSubnetName
}

output virtualNetworkResourceId string = virtualNetwork.id

// if I can use associative array then I can write match better code.
output vmSubnetId string = vmSubnet.id
