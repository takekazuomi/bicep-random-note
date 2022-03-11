# sshkey resource の挙動確認

## az cli

```sh
% az sshkey create -n test01 -g omi02-rg
{
  "id": "/subscriptions/eb366cce-61a4-447f-b5d0-cf4a7a262b37/resourceGroups/OMI02-RG/providers/Microsoft.Compute/sshPublicKeys/test01",
  "location": "eastus2",
  "name": "test01",
  "publicKey": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCz80G8KOtfF/wmTzv1SIX2pnpH\r\nWXjkoF534TrYrqNOzrXoik7VD6dlslnIXJn/ySKH7/VRGRNXpu4lr5LcXkfSOa7q\r\n09t0OVhX9ivFpoR/TZa48df+uSbLEb+5+qwhS6MvA9ftpjNAQs3tDHvkYFX7sJRq\r\n68fNDDJR1/JtQZmUXNsS7OOW30BgLBac6XJ44ua+rio/tG15Br8k2ZMrcPwmhXTB\r\nj04Rmzc69DoxO6yzgQcB7IJ/piBWfc7NQXK9TOl6EYXpzg2P46xOdarNkW9dFC1J\r\nBjerZUmQ5uZtwMm8Cm4/QHyVUd5OfEAVwCZVjtLn4uCcBXM/m4uQktFRWBxzhRaP\r\njFAOY9YdxIcsiz0qUzGZv55U2Tblf3TFcYuWYqvfldUhPJ1kL+3mKxl0gIL8ucZi\r\ngIuTofCSVFnRqA5u38bP7cthRydzd2y9UOTjDbNh3rzedNypLCD6iMYZ8mmhqjyZ\r\nD/xV539B0QV0KVo6RJ6ewJIY1PyWiGbPiUq7Eys= generated-by-azure\r\n",
  "resourceGroup": "OMI02-RG",
  "tags": null,
  "type": null
}
```

portal で arm template としてexport する。

```sh
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "sshPublicKeys_test01_name": {
            "defaultValue": "test01",
            "type": "String"
        }
    },
    "variables": {},
    "resources": [
        {
            "type": "Microsoft.Compute/sshPublicKeys",
            "apiVersion": "2020-12-01",
            "name": "[parameters('sshPublicKeys_test01_name')]",
            "location": "eastus2",
            "properties": {
                "publicKey": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCz80G8KOtfF/wmTzv1SIX2pnpH\r\nWXjkoF534TrYrqNOzrXoik7VD6dlslnIXJn/ySKH7/VRGRNXpu4lr5LcXkfSOa7q\r\n09t0OVhX9ivFpoR/TZa48df+uSbLEb+5+qwhS6MvA9ftpjNAQs3tDHvkYFX7sJRq\r\n68fNDDJR1/JtQZmUXNsS7OOW30BgLBac6XJ44ua+rio/tG15Br8k2ZMrcPwmhXTB\r\nj04Rmzc69DoxO6yzgQcB7IJ/piBWfc7NQXK9TOl6EYXpzg2P46xOdarNkW9dFC1J\r\nBjerZUmQ5uZtwMm8Cm4/QHyVUd5OfEAVwCZVjtLn4uCcBXM/m4uQktFRWBxzhRaP\r\njFAOY9YdxIcsiz0qUzGZv55U2Tblf3TFcYuWYqvfldUhPJ1kL+3mKxl0gIL8ucZi\r\ngIuTofCSVFnRqA5u38bP7cthRydzd2y9UOTjDbNh3rzedNypLCD6iMYZ8mmhqjyZ\r\nD/xV539B0QV0KVo6RJ6ewJIY1PyWiGbPiUq7Eys= generated-by-azure\r\n"
            }
        }
    ]
}
```

`properties.publicKey` が入ってる。なんだコレ？

portal で作って見る

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "location": {
            "type": "string"
        },
        "name": {
            "type": "string"
        }
    },
    "resources": [
        {
            "location": "[parameters('location')]",
            "name": "[parameters('name')]",
            "type": "Microsoft.Compute/sshPublicKeys",
            "apiVersion": "2019-12-01",
            "properties": {},
            "tags": {}
        }
    ]
}
```

妥当な内容になった。bicp版

```yaml
param location string
param name string

resource name_resource 'Microsoft.Compute/sshPublicKeys@2019-12-01' = {
  location: location
  name: name
  properties: {}
  tags: {}
}
```

ドキュメントは、この辺

[Microsoft.Compute sshPublicKeys](https://docs.microsoft.com/en-us/azure/templates/microsoft.compute/sshpublickeys?tabs=json)

[publicKey プロパティの説明](https://docs.microsoft.com/en-us/azure/templates/microsoft.compute/sshpublickeys?tabs=json#sshpublickeyresourceproperties-object)

> sshを介して仮想マシンへの認証に使用されるSSH公開鍵。リソースの作成時にこのプロパティが最初に提供されていない場合、generateKeyPairが呼び出されたときにpublicKeyプロパティにデータが入力されます。リソースの作成時に公開鍵が提供される場合、提供される公開鍵は少なくとも2048ビットでssh-rsa形式である必要があります。

generateKeyPair ってなんだ？

SDKのドキュメントを読む。ここ、[Ssh Public Keys](https://docs.microsoft.com/en-us/rest/api/compute/sshpublickeys)

[Generate Key Pair](https://docs.microsoft.com/en-us/rest/api/compute/sshpublickeys/generatekeypair#sshpublickeygeneratekeypairresult) ってメソッドの戻りでprivate keyが拾える。

秘密鍵が失われると使えないので、az cliが修正される模様
https://github.com/Azure/azure-cli/pull/18022

元実装だと、create 呼んだ後に、public_key が空だったら、generate_key_pair して終わりだったところを、generate_key_pair  で生成されたペアを.sshに書くような修正が入っている。

ARM Template で、generateKeyPair を使う方法は不明



