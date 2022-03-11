param source object
param state array = []

var instance = [
  {
    name: source.name
    properties: {
      description: source.description
      protocol: source.protocol
      sourcePortRange: source.sourcePortRange
      destinationPortRange: source.destinationPortRange
      sourceAddressPrefix: source.sourceAddressPrefix
      destinationAddressPrefix: source.destinationAddressPrefix
      access: source.access
      priority: source.priority
      direction: source.direction
    }
  }
]

output collection array = concat(state, instance)