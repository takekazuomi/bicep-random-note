# VM deploy

Setp By Step で、VMを作成してみる。

Azureだと下記のようなリソース構成になる。これを順番にbicepで書いていってみよう。

1. public ip
2. nsg
3. vnet+subnet
4. nic
5. vm

ここでは、ファイルを上記の単位で分けて作成する。[^1]

## 1. public ip

`pip.bicep` というファイルを作成する。パラメーターとしては、location と nameを受け取る。

vscodeの操作画面を入れる

必須のものだけを指定している。その他の値はデフォルトが使われる。

// https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2020-07-01/publicipaddresses?tabs=json
// https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-public-ip-address#create-a-public-ip-address
resource pip 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: name
}

```yaml:pip.bicep
param location string = resourceGroup().location
param name string

resource pip 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: name
}

output pip_id string = pip.id
```

## 2. nsg

自動 dependOnを説明する。

```yaml:nsg.bicep
param location string = resourceGroup().location
param name string

resource nsg 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: name
}

resource nsgRule 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  name: '${name}-rule'
  properties: {
    access: 'Deny'
    direction:'Inbound'
    sourceAddressPrefix:'*'
    sourcePortRange:'*'
    protocol:'*'
  }
}
```


## 3. vnet+subnet

## 4. nic

## 5. vm

## 最後に

ここでは、チュートリアルなので、細かいことに拘らずに最小限で書いたが、プロダクションで使うならドキュメントを見て必要なオプションとデフォルト値を確認するべきだ。

## 脚注

[^1]: ファイル単位でモジュールとなり、モジュール単位で再利用することができる。モジュール
