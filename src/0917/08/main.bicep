param myIpAddress string

var firewallrules = [for (item, index) in json(loadTextContent('mysql-firewall-rules.json')): {
  Name: item.Name
  StartIpAddress: item.Name == 'myaddress' ? myIpAddress : item.StartIpAddress
  EndIpAddress: item.Name == 'myaddress' ? myIpAddress : item.EndIpAddress
}]

output firewallrules array = firewallrules
