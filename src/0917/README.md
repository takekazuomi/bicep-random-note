# MySQL をbicepでデプロイする

元ネタ

- [Quickstart: Use an ARM template to create an Azure Database for MySQL server](https://docs.microsoft.com/en-us/azure/mysql/quickstart-create-mysql-server-database-using-arm-template?tabs=azure-portal)
- azure-quickstart-templatesの[Deploy Azure Database for MySQL with VNet](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.dbformysql/managed-mysql-with-vnet)

## 流れ

上記、ドキュメントで使っている、ARMテンプレートをbicepに変換してデプロイする。

1. 01/元ネタとデコンパイル後
2. 02/linterの警告を消す
3. 03/デコンパイルで付いた名前を直す
4. 04/モジュールに分割する
5. 05/firewallrulesを外出しのjsonにする
6. 06/微調整, OnDepends 外し、Subnet外出し、API Version変更、Makefile追加
7. 07/Log Analytics 追加、Firewallに自分のAIPを許可するルールをデプロイ時に追加
8. 08/Firewallに自分のAIPを許可する方法の改善実装の確認
