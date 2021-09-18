MySQLをデプロイして
FlexServer

https://docs.microsoft.com/ja-jp/azure/mysql/

フレキシブル サーバー (プレビュー) は、データベース管理機能と構成設定のよりきめ細かな制御と柔軟性を提供するために設計された、フル マネージド データベース サービスです。 一般に、このサービスでは、ユーザーの要件に基づいて、シングル サーバー デプロイよりも高度な柔軟性とサーバー構成のカスタマイズが提供されます。 フレキシブル サーバー アーキテクチャの採用により、ユーザーは単一の可用性ゾーン内での可用性と、複数の可用性ゾーンにまたがる高可用性を選択できます。 また、フレキシブル サーバーでは、サーバーを開始および停止する機能と、バースト可能な SKU によって優れたコスト最適化制御が提供されるため、最大限のコンピューティング容量が継続的には必要とされないワークロードに最適です。

https://docs.microsoft.com/ja-jp/azure/mysql/flexible-server/overview#network-isolation

プライベート アクセス (VNet 統合)

VNetにデプロイできて、パブリック エンドポイントがない。これはイイね。

価格

https://azure.microsoft.com/ja-jp/pricing/details/mysql/server/

Single
WUS2    1 vCore   2 GiB  ¥3.808/時間
JE      1	vCore  2 GiB	¥5.824/時間

WUS2    GB/月	¥11.200
JE      GB/月	¥13.44

## クイック スタート:ARM テンプレートを使用して Azure Database for MySQL - フレキシブル サーバー (プレビュー) を作成する

https://docs.microsoft.com/ja-jp/azure/mysql/flexible-server/quickstart-create-arm-template

[mysql-flexible-server-template.json](https://docs.microsoft.com/ja-jp/azure/mysql/flexible-server/quickstart-create-arm-template#review-the-template)

decompile するとこんなエラー

```sh
$ bicep decompile mysql-flexible-server-template.json

mysql-flexible-server-template.json
WARNING: Decompilation is a best-effort process, as there is no guaranteed mapping from ARM JSON to Bicep.
You may need to fix warnings and errors in the generated bicep file(s), or decompilation may fail entirely if an accurate conversion is not possible.
If you would like to report any issues or inaccurate conversions, please see https://github.com/Azure/bicep/issues.
WARNING: Decompilation is a best-effort process, as there is no guaranteed mapping from ARM JSON to Bicep.
You may need to fix warnings and errors in the generated bicep file(s), or decompilation may fail entirely if an accurate conversion is not possible.
If you would like to report any issues or inaccurate conversions, please see https://github.com/Azure/bicep/issues.
/bicep-random-note/src/0911/tmp/mysql-flexible-server-template.bicep(23,30) : Error BCP029: The resource type is not valid. Specify a valid resource type of format "<provider>/<types>@<apiVersion>".
/bicep-random-note/src/0911/tmp/mysql-flexible-server-template.bicep(23,30) : Error BCP029: The resource type is not valid. Specify a valid resource type of format "<provider>/<types>@<apiVersion>".
/bicep-random-note/src/0911/tmp/mysql-flexible-server-template.bicep(47,31) : Error BCP104: The referenced module has errors.
/bicep-random-note/src/0911/tmp/mysql-flexible-server-template.bicep(47,31) : Error BCP104: The referenced module has errors.
/bicep-random-note/src/0911/tmp/mysql-flexible-server-template.bicep(57,5) : Error BCP062: The referenced declaration with name "serverName_resource" is not valid.
/bicep-random-note/src/0911/tmp/mysql-flexible-server-template.bicep(57,5) : Error BCP062: The referenced declaration with name "serverName_resource" is not valid.
/bicep-random-note/src/0911/tmp/nested_firewallRules_resource.bicep(1,46) : Error BCP014: Expected a parameter type at this location. Please specify one of the following types: "array", "bool", "int", "object", "string".
/bicep-random-note/src/0911/tmp/nested_firewallRules_resource.bicep(1,46) : Error BCP014: Expected a parameter type at this location. Please specify one of the following types: "array", "bool", "int", "object", "string".
/bicep-random-note/src/0911/tmp/nested_firewallRules_resource.bicep(2,7) : Warning no-unused-params: Parameter "variables_api" is declared but never used. [https://aka.ms/bicep/linter/no-unused-params]
/bicep-random-note/src/0911/tmp/nested_firewallRules_resource.bicep(2,7) : Warning no-unused-params: Parameter "variables_api" is declared but never used. [https://aka.ms/bicep/linter/no-unused-params]
/bicep-random-note/src/0911/tmp/nested_firewallRules_resource.bicep(2,21) : Error BCP014: Expected a parameter type at this location. Please specify one of the following types: "array", "bool", "int", "object", "string".
/bicep-random-note/src/0911/tmp/nested_firewallRules_resource.bicep(2,21) : Error BCP014: Expected a parameter type at this location. Please specify one of the following types: "array", "bool", "int", "object", "string".
/bicep-random-note/src/0911/tmp/nested_firewallRules_resource.bicep(3,56) : Error BCP014: Expected a parameter type at this location. Please specify one of the following types: "array", "bool", "int", "object", "string".
/bicep-random-note/src/0911/tmp/nested_firewallRules_resource.bicep(3,56) : Error BCP014: Expected a parameter type at this location. Please specify one of the following types: "array", "bool", "int", "object", "string".
/bicep-random-note/src/0911/tmp/nested_firewallRules_resource.bicep(4,54) : Error BCP014: Expected a parameter type at this location. Please specify one of the following types: "array", "bool", "int", "object", "string".
/bicep-random-note/src/0911/tmp/nested_firewallRules_resource.bicep(4,54) : Error BCP014: Expected a parameter type at this location. Please specify one of the following types: "array", "bool", "int", "object", "string".
/bicep-random-note/src/0911/tmp/nested_firewallRules_resource.bicep(7,65) : Error BCP029: The resource type is not valid. Specify a valid resource type of format "<provider>/<types>@<apiVersion>".
/bicep-random-note/src/0911/tmp/nested_firewallRules_resource.bicep(7,65) : Error BCP029: The resource type is not valid. Specify a valid resource type of format "<provider>/<types>@<apiVersion>".

```
