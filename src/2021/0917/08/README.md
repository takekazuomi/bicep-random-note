# README

ここでは、別のアイディアをためす。

`mysql-firewall-rules.json` が下記のような内容だった時。

```json
[
  {
    "Name": "myaddress",
    "StartIpAddress": "here is a placeholder",
    "EndIpAddress": "here is a placeholder"
  }
]
```

main.bicep でjsonにして書き出す。

```yaml
var firewallrules = json(loadTextContent('mysql-firewall-rules.json'))

output firewallrules array = firewallrules
```

するとこんな感じになる。

```json
az deployment group create -g omi02-rg \
        -f main.bicep
{
  "id": "/subscriptions/eb366cce-61a4-447f-b5d0-cf4a7a262b37/resourceGroups/omi02-rg/providers/Microsoft.Resources/deployments/main",
  "location": null,
  "name": "main",
  "properties": {
    "correlationId": "d7f3fe5f-90f3-4ffd-b3ef-b2e5660b7b42",
    "debugSetting": null,
    "dependencies": [],
    "duration": "PT3.295523S",
    "error": null,
    "mode": "Incremental",
    "onErrorDeployment": null,
    "outputResources": [],
    "outputs": {
      "firewallrules": {
        "type": "Array",
        "value": [
          {
            "EndIpAddress": "here is a placeholder",
            "Name": "myaddress",
            "StartIpAddress": "here is a placeholder"
          }
        ]
      }
    },
    "parameters": null,
    "parametersLink": null,
    "providers": [],
    "provisioningState": "Succeeded",
    "templateHash": "14151299432643776290",
    "templateLink": null,
    "timestamp": "2021-09-19T04:18:47.928261+00:00",
    "validatedResources": null
  },
  "resourceGroup": "omi02-rg",
  "tags": null,
  "type": "Microsoft.Resources/deployments"
}
```

ip address をパラメータでもらって、mysql-firewall-rules.json 読んで変数に展開するときに書き換えると、ファイル自体を書き換える必要は無くなる。

```yaml
param myIpAddress string

var firewallrules = [for (item, index) in json(loadTextContent('mysql-firewall-rules.json')): {
  Name: item.Name
  StartIpAddress: item.Name == 'myaddress' ? myIpAddress : item.StartIpAddress
  EndIpAddress: item.Name == 'myaddress' ? myIpAddress : item.EndIpAddress
}]

output firewallrules array = firewallrules
```

とりあえず、これで良いかな。
