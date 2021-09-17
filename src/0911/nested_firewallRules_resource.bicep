param variables_firewallRules_copyIndex_name ? /* TODO: fill in correct type */
param variables_api ? /* TODO: fill in correct type */
param variables_firewallRules_copyIndex_startIPAddress ? /* TODO: fill in correct type */
param variables_firewallRules_copyIndex_endIPAddress ? /* TODO: fill in correct type */
param serverName string

resource serverName_variables_firewallRules_copyIndex_name_name 'Microsoft.DBforMySQL/flexibleServers/firewallRules@[parameters(\'variables_api\')]' = {
  name: '${serverName}/${variables_firewallRules_copyIndex_name[copyIndex()].name}'
  properties: {
    StartIpAddress: variables_firewallRules_copyIndex_startIPAddress[copyIndex()].startIPAddress
    EndIpAddress: variables_firewallRules_copyIndex_endIPAddress[copyIndex()].endIPAddress
  }
}