@description('DNS of the WebApp')
param siteName string

@description('Address prefix for the Virtual Network')
param addressPrefix string = '10.0.0.0/16'

@description('Subnet prefix')
param subnetPrefix array = [
  '10.0.0.0/28'
]

@description('Subnet names')
param subnetNames array = [
  'appGatewaySubnet'
]

@minLength(1)
@description('Database administrator login name')
param administratorLogin string

@minLength(8)
@maxLength(128)
@description('Database administrator password')
@secure()
param administratorLoginPassword string

@description('Azure database for MySQL sku name')
param databaseSkuName string = 'GP_Gen5_8'

@description('Azure database for MySQL sku family')
param databaseSkuFamily string = 'Gen5'

@allowed([
  '102400'
  '51200'
])
@description('Azure database for MySQL Sku Size')
param databaseSkuSizeMB string = '51200'

@description('Azure database for MySQL pricing tier')
param databaseSkuTier string = 'GeneralPurpose'

@allowed([
  '5.6'
  '5.7'
  '8.0'
])
@description('MySQL version')
param mysqlVersion string = '5.6'

@description('Location for all resources.')
param location string = resourceGroup().location

var applicationGatewayName = '${siteName}-agw'
var publicIPAddressName = '${siteName}-pip'
var virtualNetworkName = 'virtualNetwork1'
var databaseName = '${siteName}db'
var mysqlName = '${siteName}mysqlserver'

var subnets = [for (s, i) in subnetPrefix: {
  name: subnetNames[i]
  properties: {
    addressPrefix: s
  }
}]

module vnet 'vnet.bicep' = {
  name: 'vnet'
  params: {
    location: location
    virtualNetworkName: virtualNetworkName
    addressPrefix: addressPrefix
    subnets: subnets
  }
}

module pip 'pip.bicep' = {
  name: 'pip'
  params: {
    location: location
    publicIPAddressName: publicIPAddressName
  }
}

module mysql 'mysql.bicep' = {
  name: 'mysql'
  params: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    databaseName: databaseName
    databaseSkuFamily: databaseSkuFamily
    databaseSkuName: databaseSkuName
    databaseSkuSizeMB: databaseSkuSizeMB
    databaseSkuTier: databaseSkuTier
    location: location
    mysqlName: mysqlName
    mysqlVersion: mysqlVersion
  }
}

module web 'web.bicep' = {
  name: 'web'
  params: {
    connectionString: mysql.outputs.connectionString
    location: location
    ipSecurityRestrictions: [
      {
        ipAddress: '${pip.outputs.publicIPAddress}/32'
      }
    ]
    siteName: siteName
  }
}

module agw 'agw.bicep' = {
  name: 'agw'
  params: {
    applicationGatewayName: applicationGatewayName
    location: location
    publicIPAddressId: pip.outputs.publicIPAddressId
    siteHostName: web.outputs.defaultHostName
    agwSubnetId: vnet.outputs.subnets[0].id // use first subnet for agw
  }
}
