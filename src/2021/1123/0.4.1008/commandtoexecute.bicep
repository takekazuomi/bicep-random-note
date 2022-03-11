param vmName string
param location string
param fileUris string

@secure()
param arguments string

var UriFileNamePieces = split(fileUris, '/')
var firstFileNameString = UriFileNamePieces[(length(UriFileNamePieces) - 1)]
var firstFileNameBreakString = split(firstFileNameString, '?')
var firstFileName = firstFileNameBreakString[0]

resource customScriptExtension 'Microsoft.Compute/virtualMachines/extensions@2021-04-01' = {
  name: '${vmName}/CustomScriptExtension'
  location: location
  properties: {
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    autoUpgradeMinorVersion: true
    settings: {
      fileUris: split(fileUris, ' ')
    }
    protectedSettings:{
      commandToExecute: 'powershell -ExecutionPolicy Unrestricted -File ${firstFileName} ${arguments}'
    }
  }
}
