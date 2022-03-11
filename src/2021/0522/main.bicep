param location string = resourceGroup().location
param name string

resource sshkey 'Microsoft.Compute/sshPublicKeys@2020-12-01' = {
  location: location
  name: name
  properties: {}
  tags: {}
}

output pair object = sshkey
