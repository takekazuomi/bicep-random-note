# README

8/24 あたりにmainにマージされた、bicep registry を使ってみる。PRは、このへん。https://github.com/Azure/bicep/pull/4144

## 専用のリソースグループを作る

```sh
az group create --location eastus2 -n ${RESOURCE_GROUP} -o table
```

## ACRを作成する`acr.bicep`を書く

```bicep
var name = '${replace(resourceGroup().name, '-rg', '')}${uniqueString(resourceGroup().id)}'
var location = resourceGroup().location

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2021-06-01-preview' = {
  name: name
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

output name string = containerRegistry.name
```

## deployしてACR環境を作る。

```sh
az deployment group create -g ${RESOURCE_GROUP} -f acr.bicep
```

## コマンドでACR名を確認

```sh
% az acr list -o table

NAME                RESOURCE GROUP    LOCATION    SKU    LOGIN SERVER                   CREATION DATE         ADMIN ENABLED
------------------  ----------------  ----------  -----  -----------------------------  --------------------  ---------------
{place holder name}  ${RESOURCE_GROUP}          eastus2     Basic  {place holder name}.azurecr.io  2021-09-24T07:24:51Z  True
```

環境変数`ACR_NAME`にACR名をセット

```sh
export ACR_NAME=$(az acr list -g ${RESOURCE_GROUP} -o table --query '[*].name' -o tsv)
```

## 簡単な、hello worldを出力するだけの`hello.bicep`を書く

```bicep
var msg = 'hello world'

output msg string = msg
```

## ACRに登録する

まだ、お試し機能なので、環境変数に、`BICEP_REGISTRY_ENABLED_EXPERIMENTAL=true`が必要。

```sh
% export BICEP_REGISTRY_ENABLED_EXPERIMENTAL=true
% bicep publish hello.bicep --target br:${ACR_NAME}.azurecr.io/demo/hello:1.0
```

## レジストリのモジュールを使ってみる

モジュールを利用するテンプレートを書く。`remote.bicep`
**環境変数展開は出来ないので、${ACR_NAME}の部分は書き換える**

```bicep
module hello 'br:${ACR_NAME}.azurecr.io/demo/hello:1.0' = {
  name:'hello'
}
output hello string = hello.outputs.msg
```

## レジストリを参照したのをdeployしてみる

az ビルトインのbicepは更新されていないので、buildしてjsonをdeploy。

```sh
bicep build remote.bicep
az deployment group create -g ${RESOURCE_GROUP} -f remote.json

...json
"outputs": {
  "hello": {
    "type": "String",
    "value": "hello world"
  }
},
...

```

`outputs` に、`"hello world"` が出てた。

## モジュールはローカルにキャッシュされる

```json
% cat ~/.bicep/br/omi02ax6xi6fpkotik.azurecr.io/demo\$hello/1.0\$/main.json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "metadata": {
    "_generator": {
      "name": "bicep",
      "version": "0.4.884.13971",
      "templateHash": "8519799227580281418"
    }
  },
  "functions": [],
  "variables": {
    "msg": "hello world"
  },
  "resources": [],
  "outputs": {
    "msg": {
      "type": "string",
      "value": "[variables('msg')]"
    }
  }
}
```
