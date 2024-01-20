param location string

resource redisCache 'Microsoft.Cache/redis@2021-06-01' = {
  name: 'name'
  location: location
  identity: {
    type: 'string'
    userAssignedIdentities: {}
  }
  properties: {
    sku: {
      name: 'Basic'
      family: 'C'
      capacity: 0
    }
  }
}
