RESOURCE_GROUP	?=
LOCATION	?= japaneast

.DEFAULT_GOAL := help

help:           ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

deploy: main.bicep
	az deployment group create -g $(RESOURCE_GROUP) -f $< --query 'properties.outputs.result' -o tsv

