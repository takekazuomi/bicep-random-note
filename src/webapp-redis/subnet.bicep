param virtualNetworkName string

resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' existing = {
  name: virtualNetworkName
}

resource subnets 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' = {
  parent:vnet
  name: 'websubnet'
  properties: {
    addressPrefix:  '10.0.0.0/24'
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
