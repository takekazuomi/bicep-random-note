@description('Location for all resources.')
param location string

@description('Public IP Address name.')
param publicIPAddressName string

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: publicIPAddressName
  location: location
  properties: {
    publicIPAllocationMethod: 'Static'
  }
  sku: {
    name: 'Standard'
  }
}

output publicIPAddress string = publicIPAddress.properties.ipAddress
output publicIPAddressId string = publicIPAddress.id
