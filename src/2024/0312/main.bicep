param location string = resourceGroup().location
param name string

//resource pip 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
//resource pip 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
resource pip 'Microsoft.Network/publicIPAddresses@2019-12-01' = {
  name: name
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    dnsSettings: {
      domainNameLabel: 'pip-test-${name}-${uniqueString(resourceGroup().id)}'
    }
  }
}

output ipaddress object = pip.properties

