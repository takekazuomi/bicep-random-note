@description('Specifies the location of AKS cluster.')
param location string = resourceGroup().location

// Log Analytics Workspace
@description('Specifies the name of the Log Analytics Workspace.')
param logAnalyticsWorkspaceName string

@allowed([
  'PerGB2018'
])
@description('Specifies the service tier of the workspace: Free, Standalone, PerNode, Per-GB.')
param logAnalyticsSku string = 'PerGB2018'

@description('Specifies the workspace data retention in days. -1 means Unlimited retention for the Unlimited Sku. 730 days is the maximum allowed for all other Skus.')
param logAnalyticsRetentionInDays int = 60

// Virtual Network
@description('Specifies the name of the virtual network.')
param virtualNetworkName string = 'Vnet'

@description('Specifies the address prefixes of the virtual network.')
param virtualNetworkAddressPrefixes string = '10.0.0.0/8'

@description('Specifies the name of the subnet which contains the virtual machine.')
param vmSubnetName string = 'VmSubnet'

@description('Specifies the address prefix of the subnet which contains the virtual machine.')
param vmSubnetAddressPrefix string = '10.1.0.0/24'

// Virtual Machine
@description('Specifies the name of the virtual machine.')
param vmName string = 'TestVm'

@description('Specifies the size of the virtual machine.')
param vmSize string = 'Standard_DS3_v2'

@description('Specifies the image publisher of the disk image used to create the virtual machine.')
param imagePublisher string = 'Canonical'

@description('Specifies the offer of the platform image or marketplace image used to create the virtual machine.')
param imageOffer string = 'UbuntuServer'

@description('Specifies the Ubuntu version for the VM. This will pick a fully patched image of this given Ubuntu version.')
param imageSku string = '18.04-LTS'

@allowed([
  'sshPublicKey'
  'password'
])
@description('Specifies the type of authentication when accessing the Virtual Machine. SSH key is recommended.')
param authenticationType string = 'sshPublicKey'

@description('Specifies the name of the administrator account of the virtual machine.')
param vmAdminUsername string

@description('Specifies the SSH Key or password for the virtual machine. SSH key is recommended.')
@secure()
param vmAdminPasswordOrKey string

@allowed([
  'Premium_LRS'
  'StandardSSD_LRS'
  'Standard_LRS'
  'UltraSSD_LRS'
])
@description('Specifies the storage account type for OS and data disk.')
param diskStorageAccounType string = 'Standard_LRS'

@minValue(0)
@maxValue(64)
@description('Specifies the number of data disks of the virtual machine.')
param numDataDisks int = 0

@description('Specifies the size in GB of the OS disk of the VM.')
param osDiskSize int = 32

@description('Specifies the size in GB of the OS disk of the virtual machine.')
param dataDiskSize int = 32

@description('Specifies the caching requirements for the data disks.')
param dataDiskCaching string = 'ReadWrite'

@description('Specifies the globally unique name for the storage account used to store the boot diagnostics logs of the virtual machine.')
param blobStorageAccountName string = 'blob${uniqueString(resourceGroup().id)}'

@description('Specifies the name of the private link to the boot diagnostics storage account.')
param blobStorageAccountPrivateEndpointName string = 'BlobStorageAccountPrivateEndpoint'

@description('Specifies the rules of the vm subnet nsg.')
param vmSubnetNsgSecurityRules array = [
  {
    name: 'AllowSshInbound'
    properties: {
      priority: 100
      access: 'Allow'
      direction: 'Inbound'
      destinationPortRange: '22'
      protocol: 'Tcp'
      sourceAddressPrefix: '*'
      sourcePortRange: '*'
      destinationAddressPrefix: '*'
    }
  }
]

module vnet 'vnet.bicep' = {
  name: 'vnet'
  params: {
    location: location
    virtualNetworkName: virtualNetworkName
    virtualNetworkAddressPrefixes: virtualNetworkAddressPrefixes
    vmSubnetName: vmSubnetName
    vmSubnetAddressPrefix: vmSubnetAddressPrefix
    vmSubnetNsgSecurityRules: vmSubnetNsgSecurityRules
  }
}

module logAnalytics 'log-analytics.bicep' = {
  name: 'log-analytics.bicep'
  params: {
    location: location
    logAnalyticsWorkspaceName: logAnalyticsWorkspaceName
    logAnalyticsSku: logAnalyticsSku
    logAnalyticsRetentionInDays: logAnalyticsRetentionInDays
  }
}

module jumpbox 'jumpbox.bicep' = {
  name: 'jumpbox'
  params: {
    location: location

    vmName: vmName
    vmAdminUsername: vmAdminUsername
    vmAdminPasswordOrKey: vmAdminPasswordOrKey

    vmSize: vmSize
    authenticationType: authenticationType

    diskStorageAccounType: diskStorageAccounType
    osDiskSize: osDiskSize
    dataDiskCaching: dataDiskCaching
    dataDiskSize: dataDiskSize
    numDataDisks: numDataDisks

    imageOffer: imageOffer
    imagePublisher: imagePublisher
    imageSku: imageSku

    blobStorageAccountName: blobStorageAccountName
    blobStorageAccountPrivateEndpointName: blobStorageAccountPrivateEndpointName

    logAnalyticsWorkspaceId: logAnalytics.outputs.logAnalyticsWorkspaceId
    virtualNetworkId: vnet.outputs.virtualNetworkResourceId
    vmSubnetId: vnet.outputs.vmSubnetId
  }
}
