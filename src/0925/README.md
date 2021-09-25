# README

deploy

```sh
export l=eastus2
export g=<適当な名前>
az group create -l $l -g $g
az deployment group create -g ${g} -f mysql.bicep
```
