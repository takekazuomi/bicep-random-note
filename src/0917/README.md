# MySQL をbidepでデプロイする

元ネタ

[azure-quickstart-templates/Deploy Azure Database for MySQL with VNet](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.dbformysql/managed-mysql-with-vnet)

## 流れ

1. 01/デコンパイル
2. 02/linter 修正
3. 03/名前修正
4. 04/モジュール分割
5. 05/firewallrules.json の外出し
6. 06/微調整, OnDepends 外し、Subnet外出し、API Version変更、Makefile追加

