RESOURCE_GROUP	?= omipip01-rg
LOCATION	?= japaneast
NAME		?= pip01
AZ		= docker run --it -rm -v mcr.microsoft.com/azure-cli

.DEFAULT_GOAL 	:= help

help:           ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

deploy: main.bicep
	az deployment group create -g $(RESOURCE_GROUP) -p name=$(NAME) -f $<

create-rg:	## create resource group
	az group create -l $(LOCATION) -g $(RESOURCE_GROUP)

