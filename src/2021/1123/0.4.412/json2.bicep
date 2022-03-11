var jsonVar = json('{"hello":"world"}')
var foo = jsonVar.hello
var names = json(loadTextContent('./storage-name.json'))
resource sa 'Microsoft.Storage/storageAccounts@2021-06-01' = [for n in names: {
  kind: 'Storage'
  location: resourceGroup().location
  name: n.name
  sku: {
    name: n.sku
  }
}]
