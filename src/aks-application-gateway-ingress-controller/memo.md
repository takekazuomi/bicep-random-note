# bicep への変換作業

## decompile する

`bicep decompile` して azuredeploy.bicep から、main.bicepに名前を変更

```sh
% bicep decompile azuredeploy.json
WARNING: Decompilation is a best-effort process, as there is no guaranteed mapping from ARM JSON to Bicep.
You may need to fix warnings and errors in the generated bicep file(s), or decompilation may fail entirely if an accurate conversion is not possible.
If you would like to report any issues or inaccurate conversions, please see https://github.com/Azure/bicep/issues.
azuredeploy.bicep(490,49) : Warning prefer-interpolation: Use string interpolation instead of the concat function. [https://aka.ms/bicep/linter/prefer-interpolation]
azuredeploy.bicep(492,51) : Warning prefer-interpolation: Use string interpolation instead of the concat function. [https://aka.ms/bicep/linter/prefer-interpolation]
azuredeploy.bicep(697,58) : Warning BCP174: Type validation is not available for resource types declared containing a "/providers/" segment. Please instead use the "scope" property. [https://aka.ms/BicepScopes]
azuredeploy.bicep(722,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(723,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(746,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(747,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(751,53) : Warning BCP174: Type validation is not available for resource types declared containing a "/providers/" segment. Please instead use the "scope" property. [https://aka.ms/BicepScopes]
azuredeploy.bicep(764,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(765,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(795,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(825,31) : Warning BCP036: The property "storageAccountType" expected a value of type "'Premium_LRS' | 'StandardSSD_LRS' | 'Standard_LRS' | 'UltraSSD_LRS' | null" but the provided value is of type "'Premium_LRS' | 'Premium_ZRS' | 'StandardSSD_LRS' | 'StandardSSD_ZRS' | 'Standard_LRS'".
azuredeploy.bicep(835,31) : Warning BCP036: The property "storageAccountType" expected a value of type "'Premium_LRS' | 'StandardSSD_LRS' | 'Standard_LRS' | 'UltraSSD_LRS' | null" but the provided value is of type "'Premium_LRS' | 'Premium_ZRS' | 'StandardSSD_LRS' | 'StandardSSD_ZRS' | 'Standard_LRS'".
azuredeploy.bicep(854,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(860,9) : Warning simplify-interpolation: Remove unnecessary string interpolation. [https://aka.ms/bicep/linter/simplify-interpolation]
azuredeploy.bicep(875,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(876,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(882,9) : Warning simplify-interpolation: Remove unnecessary string interpolation. [https://aka.ms/bicep/linter/simplify-interpolation]
azuredeploy.bicep(891,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(892,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(893,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(919,53) : Warning BCP174: Type validation is not available for resource types declared containing a "/providers/" segment. Please instead use the "scope" property. [https://aka.ms/BicepScopes]
azuredeploy.bicep(944,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(945,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1000,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1001,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1027,5) : Warning BCP073: The property "scope" is read-only. Expressions cannot be assigned to read-only properties.
azuredeploy.bicep(1030,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1031,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1082,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1083,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1087,50) : Warning BCP174: Type validation is not available for resource types declared containing a "/providers/" segment. Please instead use the "scope" property. [https://aka.ms/BicepScopes]
azuredeploy.bicep(1105,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1106,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1110,63) : Warning BCP174: Type validation is not available for resource types declared containing a "/providers/" segment. Please instead use the "scope" property. [https://aka.ms/BicepScopes]
azuredeploy.bicep(1118,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1119,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1132,5) : Warning BCP073: The property "tier" is read-only. Expressions cannot be assigned to read-only properties.
azuredeploy.bicep(1160,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1164,44) : Warning BCP174: Type validation is not available for resource types declared containing a "/providers/" segment. Please instead use the "scope" property. [https://aka.ms/BicepScopes]
azuredeploy.bicep(1172,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1173,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1177,45) : Warning BCP174: Type validation is not available for resource types declared containing a "/providers/" segment. Please instead use the "scope" property. [https://aka.ms/BicepScopes]
azuredeploy.bicep(1200,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1201,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1218,5) : Warning BCP037: The property "sku" is not allowed on objects of type "ManagedClusterProperties". Permissible properties include "autoUpgradeProfile", "diskEncryptionSetID", "enablePodSecurityPolicy", "identityProfile", "nodeResourceGroup", "servicePrincipalProfile", "windowsProfile". If this is an inaccuracy in the documentation, please report it to the Bicep Team. [https://aka.ms/bicep-type-issues]
azuredeploy.bicep(1299,9) : Warning BCP073: The property "identity" is read-only. Expressions cannot be assigned to read-only properties.
azuredeploy.bicep(1337,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1338,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1339,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1340,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1341,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1342,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1346,52) : Warning BCP174: Type validation is not available for resource types declared containing a "/providers/" segment. Please instead use the "scope" property. [https://aka.ms/BicepScopes]
azuredeploy.bicep(1388,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1389,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1422,5) : Warning BCP073: The property "maxNumberOfRecordSets" is read-only. Expressions cannot be assigned to read-only properties.
azuredeploy.bicep(1423,5) : Warning BCP073: The property "maxNumberOfVirtualNetworkLinks" is read-only. Expressions cannot be assigned to read-only properties.
azuredeploy.bicep(1424,5) : Warning BCP073: The property "maxNumberOfVirtualNetworkLinksWithRegistration" is read-only. Expressions cannot be assigned to read-only properties.
azuredeploy.bicep(1432,5) : Warning BCP073: The property "maxNumberOfRecordSets" is read-only. Expressions cannot be assigned to read-only properties.
azuredeploy.bicep(1433,5) : Warning BCP073: The property "maxNumberOfVirtualNetworkLinks" is read-only. Expressions cannot be assigned to read-only properties.
azuredeploy.bicep(1434,5) : Warning BCP073: The property "maxNumberOfVirtualNetworkLinksWithRegistration" is read-only. Expressions cannot be assigned to read-only properties.
azuredeploy.bicep(1442,5) : Warning BCP073: The property "maxNumberOfRecordSets" is read-only. Expressions cannot be assigned to read-only properties.
azuredeploy.bicep(1443,5) : Warning BCP073: The property "maxNumberOfVirtualNetworkLinks" is read-only. Expressions cannot be assigned to read-only properties.
azuredeploy.bicep(1444,5) : Warning BCP073: The property "maxNumberOfVirtualNetworkLinksWithRegistration" is read-only. Expressions cannot be assigned to read-only properties.
azuredeploy.bicep(1459,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1460,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1475,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1476,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1491,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1492,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1516,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1517,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1523,9) : Warning simplify-interpolation: Remove unnecessary string interpolation. [https://aka.ms/bicep/linter/simplify-interpolation]
azuredeploy.bicep(1524,3) : Warning BCP187: The property "location" does not exist in the resource definition, although it might still be valid. If this is an inaccuracy in the documentation, please report it to the Bicep Team. [https://aka.ms/bicep-type-issues]
azuredeploy.bicep(1536,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1537,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1538,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1562,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1563,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1569,9) : Warning simplify-interpolation: Remove unnecessary string interpolation. [https://aka.ms/bicep/linter/simplify-interpolation]
azuredeploy.bicep(1570,3) : Warning BCP187: The property "location" does not exist in the resource definition, although it might still be valid. If this is an inaccuracy in the documentation, please report it to the Bicep Team. [https://aka.ms/bicep-type-issues]
azuredeploy.bicep(1582,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1583,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1584,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1608,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1609,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1615,9) : Warning simplify-interpolation: Remove unnecessary string interpolation. [https://aka.ms/bicep/linter/simplify-interpolation]
azuredeploy.bicep(1616,3) : Warning BCP187: The property "location" does not exist in the resource definition, although it might still be valid. If this is an inaccuracy in the documentation, please report it to the Bicep Team. [https://aka.ms/bicep-type-issues]
azuredeploy.bicep(1628,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1629,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1630,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1637,3) : Warning BCP035: The specified "object" declaration is missing the following required properties: "actions".
azuredeploy.bicep(1724,14) : Warning BCP036: The property "state" expected a value of type "'Disabled' | 'Enabled' | null" but the provided value is of type "'Disabled ' | 'Enabled'".
azuredeploy.bicep(1874,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1875,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1876,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1877,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1881,60) : Warning BCP174: Type validation is not available for resource types declared containing a "/providers/" segment. Please instead use the "scope" property. [https://aka.ms/BicepScopes]
azuredeploy.bicep(1907,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1908,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1918,5) : Warning BCP073: The property "scope" is read-only. Expressions cannot be assigned to read-only properties.
azuredeploy.bicep(1921,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
azuredeploy.bicep(1922,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
% mv azuredeploy.bicep main.bicep
```

## ErrorとWarning をざっとみる

エラーと警告が多いので、どんなメッセージが出てるのかをざっと見る。

```sh
% bicep decompile azuredeploy.json 2>&1 | grep -e Error -e Warning | cut -d : -f 2 | sort | uniq -c | sort -n -r
     67  Error BCP034
     13  Warning BCP073
      9  Warning BCP174
      5  Warning simplify-interpolation
      3  Warning BCP187
      3  Warning BCP036
      2  Warning prefer-interpolation
      1  Warning BCP037
      1  Warning BCP035
```

## Error BCP034

一番多いのが、`Error BCP034` で、

```log
Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
```

ARM Templateでは、下記のようになってた部分が、

```json
{
  "type": "providers/diagnosticSettings",
  "apiVersion": "2017-05-01-preview",
  "name": "Microsoft.Insights/default",
  "location": "[parameters('location')]",
  "dependsOn": [
    "[variables('bastionSubnetNsgId')]",
    "[variables('workspaceId')]"
  ],
  "properties": {
    "workspaceId": "[variables('workspaceId')]",
    "logs": [
      {
        "category": "NetworkSecurityGroupEvent",
        "enabled": true,
        "retentionPolicy": {
          "enabled": false,
          "days": 0
        }
      },
      {
        "category": "NetworkSecurityGroupRuleCounter",
        "enabled": true,
        "retentionPolicy": {
          "enabled": false,
          "days": 0
        }
      }
    ]
  }
}
```

下記のようにデコンパイルされています。

```bicep
resource bastionSubnetNsgName_Microsoft_Insights_default 'Microsoft.Network/networkSecurityGroups/providers/diagnosticSettings@2017-05-01-preview' = {
  name: '${bastionSubnetNsgName_var}/Microsoft.Insights/default'
  location: location
  properties: {
    workspaceId: workspaceId
    logs: [
      {
        category: 'NetworkSecurityGroupEvent'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
      {
        category: 'NetworkSecurityGroupRuleCounter'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
    ]
  }
  dependsOn: [
    bastionSubnetNsgId
    workspaceId
  ]
}
```

問題は、dependsOn で変数でリソースIDを書いている部分でした。

```json
 "dependsOn": [
    "[variables('bastionSubnetNsgId')]",
    "[variables('workspaceId')]"
  ],```
```

bicepでこのようになっていますが、ここには、リソースかモジュールが必要です。

```bicep
  dependsOn: [
    bastionSubnetNsgId
    workspaceId
  ]
```

関連: https://github.com/Azure/bicep/issues/2477

暗黙のdependOnを使いたいのですが、まずは、Idでは無くリソースを使うように直します。

テンプレートを見ると、下記のようなパターンでコーディングされていました。最終的には、この変数は不要なので削除することにして、まずは暫定的に直してエラーを消します。

```bicep
var bastionSubnetNsgId = bastionSubnetNsgName.id
```

暫定修正、

```bicep
var bastionSubnetNsgId = bastionSubnetNsgName
```

機械的にIDを変数定義していた部分を全部直しました。

```sh
% bicep build main.bicep 2>&1  | grep -e Error | cut -d : -f 2 | sort | uniq -c | sort -n -r

     12  Error BCP181
     12  Error BCP070
      2  Error BCP120
%
```

数は減って、BCP034は無くなり3つのエラーに別れました。多分IDが要求されるところがあるのだと思います。

## Error BCP181

こんなエラーでした。BCP034の修正が強引だったので仕方がないです、直します。

![BCP181](./images/decompile01.png)

デコンパイル結果は下記のようになっていますが、

```bicep
storageUri: reference(blobStorageAccountId).primaryEndpoints.blob
```

blobStorageAccountIdをリソースのシンボルにしてしまったので、これは使えず。下記のように直します。

```bicep
storageUri: blobStorageAccountId.properties.primaryEndpoints.blob
```

他にも、`list<Action>` のパターンがありました。下記のように直します。

修正前

```bicep
workspaceKey:  listKeys(workspaceId, '2020-03-01-preview').primarySharedKey
```

修正後

```bicep
workspaceKey:  workspaceId.listKeys().primarySharedKey
```

このパターンを全部修正した

```sh
% bicep build main.bicep 2>&1  | grep -e Error | cut -d : -f 2 | sort | uniq -c | sort -n -r
      2  Error BCP120
      2  Error BCP034
```

4つになったので、個別に確認

```log
main.bicep(1211,10) : Error BCP120: This expression is being used in an assignment to the "identity" property of the "Microsoft.ContainerService/managedClusters" type, which requires a value that can be calculated at the start of the deployment. You are referencing a variable which cannot be calculated at the start ("aksClusterUserDefinedManagedIdentityId" -> "aksClusterUserDefinedManagedIdentityName"). Properties of aksClusterUserDefinedManagedIdentityName which can be calculated at the start include "apiVersion", "id", "name", "type".
main.bicep(1339,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
main.bicep(1340,5) : Error BCP034: The enclosing array expected an item of type "module[] | (resource | module) | resource[]", but the provided item was of type "string".
main.bicep(1743,10) : Error BCP120: This expression is being used in an assignment to the "identity" property of the "Microsoft.Network/applicationGateways" type, which requires a value that can be calculated at the start of the deployment. You are referencing a variable which cannot be calculated at the start ("applicationGatewayUserDefinedManagedIdentityId" -> "applicationGatewayUserDefinedManagedIdentityName"). Properties of applicationGatewayUserDefinedManagedIdentityName which can be calculated at the start include "apiVersion", "id", "name", "type".
```

簡単そうなので、BCP034 から直す。

## Error BCP034 再び

下記２つが、dependsOnに書いてあって、リソースでもモジュールでも無いのが問題。

- keyVaultPrivateDnsZoneGroupId
- acrPrivateDnsZoneGroupId

![BCP034 再び](./images/decompile02.png)

resourceIdを使っているのを、existing に変更する。循環参照になってしまうかもしれないが、まずは気にしない。

```json
var keyVaultPrivateDnsZoneGroupId = resourceId('Microsoft.Network/privateEndpoints/privateDnsZoneGroups', keyVaultPrivateEndpointName, '${keyVaultPrivateEndpointGroupName}PrivateDnsZoneGroup')

var acrPrivateDnsZoneGroupId = resourceId('Microsoft.Network/privateEndpoints/privateDnsZoneGroups', acrPrivateEndpointName, '${acrPrivateEndpointGroupName}PrivateDnsZoneGroup')

```

```bicep
resource keyVaultPrivateDnsZoneGroupId 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2021-02-01' existing = {
  name:keyVaultPrivateEndpointGroupName
}

resource acrPrivateDnsZoneGroupId 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2021-02-01' existing = {
  name:acrPrivateEndpointGroupName
}
```

## Error BCP120

下記のような、エラーになる。

> This expression is being used in an assignment to the "identity" property of the "Microsoft.ContainerService/managedClusters" type, which requires a value that can be calculated at the start of the deployment. You are referencing a variable which cannot be calculated at the start ("aksClusterUserDefinedManagedIdentityId" -> "aksClusterUserDefinedManagedIdentityName"). Properties of aksClusterUserDefinedManagedIdentityName which can be calculated at the start include "apiVersion", "id", "name", "type".bicep(BCP120)

これは、`'${aksClusterUserDefinedManagedIdentityId}'`の部分には、展開の開始時に計算できる値が必要ということ。
変数、aksClusterUserDefinedManagedIdentityId では無くて、aksClusterUserDefinedManagedIdentityName を使う必要がある。

修正前

```bicep
var aksClusterUserDefinedManagedIdentityId = aksClusterUserDefinedManagedIdentityName
.... snip ....
identity: {
  type: 'UserAssigned'
  userAssignedIdentities: {
    '${aksClusterUserDefinedManagedIdentityId}': {}
  }
}
```

修正後

```bicep
var aksClusterUserDefinedManagedIdentityId = aksClusterUserDefinedManagedIdentityName
.... snip ....
identity: {
  type: 'UserAssigned'
  userAssignedIdentities: {
    '${aksClusterUserDefinedManagedIdentityName.id}': {}
  }
}
```

`aksClusterUserDefinedManagedIdentityId` を使っているところは別にもあるので、変数としては残して置く。
`applicationGatewayUserDefinedManagedIdentityId` も同様に直す。

ここまでで、Errorは全部無くなった。
