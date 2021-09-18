param variables_firewallRules_copyIndex_name string /* TODO: fill in correct type */
param variables_firewallRules_copyIndex_startIPAddress string /* TODO: fill in correct type */
param variables_firewallRules_copyIndex_endIPAddress string /* TODO: fill in correct type */
param serverName string

resource serverName_variables_firewallRules_copyIndex_name_name 'Microsoft.DBforMySQL/flexibleServers/firewallRules@2021-05-01-preview' = {
  name: '${serverName}/${variables_firewallRules_copyIndex_name}'
  properties: {
    StartIpAddress: variables_firewallRules_copyIndex_startIPAddress
    EndIpAddress: variables_firewallRules_copyIndex_endIPAddress
  }
}
