param namePrefix string
param administratorLogin string
@secure()
param administratorLoginPassword string

var location = resourceGroup().location
var name = '${namePrefix}-${uniqueString(resourceGroup().id)}'

resource mySQLdb 'Microsoft.DBforMySQL/servers@2017-12-01' = {
  name: name
  location: location
  sku:{
    name:
  }
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    createMode: 'Default'
  }
}
