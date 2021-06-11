@minLength(1)
@description('Database administrator login name')
param administratorLogin string

@minLength(8)
@maxLength(128)
@description('Database administrator password')
@secure()
param administratorLoginPassword string

@description('Azure database for MySQL sku name')
param databaseSkuName string

@description('Azure database for MySQL sku family')
param databaseSkuFamily string

@allowed([
  '102400'
  '51200'
])
@description('Azure database for MySQL Sku Size')
param databaseSkuSizeMB string

@description('Azure database for MySQL pricing tier')
param databaseSkuTier string

@allowed([
  '5.6'
  '5.7'
  '8.0'
])
@description('MySQL version')
param mysqlVersion string

@description('Location for all resources.')
param location string

param databaseName string
param mysqlName string

resource mysql 'Microsoft.DBForMySQL/servers@2017-12-01' = {
  location: location
  name: mysqlName
  properties: {
    createMode: 'Default'
    version: mysqlVersion
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
  sku: {
    name: databaseSkuName
    tier: databaseSkuTier
    size: databaseSkuSizeMB
    family: databaseSkuFamily
  }
}

resource mysqlFirewall 'Microsoft.DBForMySQL/servers/firewallRules@2017-12-01' = {
  parent: mysql
  name: '${mysqlName}firewall'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '255.255.255.255'
  }
}

resource mysqlDatabase 'Microsoft.DBForMySQL/servers/databases@2017-12-01' = {
  parent: mysql
  name: databaseName
  properties: {
    charset: 'utf8'
    collation: 'utf8_general_ci'
  }
}

output connectionString string = 'Database=${databaseName};Data Source=${mysql.properties.fullyQualifiedDomainName};User Id=${administratorLogin}@${mysqlName};Password=${administratorLoginPassword}'
