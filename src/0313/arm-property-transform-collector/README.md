# arm-property-transform-collector

https://docs.microsoft.com/en-us/azure/architecture/guide/azure-resource-manager/advanced-templates/collector

https://docs.microsoft.com/en-us/azure/architecture/guide/azure-resource-manager/advanced-templates/

[高度な Azure Resource Manager テンプレートの機能](https://docs.microsoft.com/ja-jp/azure/architecture/guide/azure-resource-manager/advanced-templates/)

[arm-property-transform-collector](https://github.com/jeffpatton1971/arm-property-transform-collector)

![collector-transformer](https://docs.microsoft.com/ja-jp/azure/architecture/guide/azure-resource-manager/images/collector-transformer.png)

```
git clone https://github.com/mspnp/template-examples.git
cd template-examples/example4-collector
az group create --location <location> --name <resource-group-name>
az deployment group create -g <resource-group-name> \
    --template-uri https://raw.githubusercontent.com/mspnp/template-examples/master/example4-collector/deploy.json \
    --parameters deploy.parameters.json
```
