param adminUsername string

resource vm 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: 'vm'
  location: resourceGroup().location
  properties: {
    osProfile: {
      adminUsername: adminUsername
    }
  }
}
