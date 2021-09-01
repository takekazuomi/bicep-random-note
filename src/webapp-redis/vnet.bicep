@description('Location for all resources.')
param location string

param appName string

param virtualNetworkName string

var vnetAddressPrefix = '10.0.0.0/16'
var subnetName = '${appName}sn'
var subnetAddressPrefix = '10.0.0.0/24'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetAddressPrefix
          delegations: [
            {
              name: 'delegation'
              properties: {
                serviceName: 'Microsoft.Web/serverFarms'
              }
            }
          ]
        }
      }
    ]
  }
}

//output subnetId string = subnet.id
output subnets array = virtualNetwork.properties.subnets
