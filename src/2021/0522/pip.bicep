param location string = resourceGroup().location
param name string

resource pip 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: name
}
