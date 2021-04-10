RESOURCE_GROUP	?= coreg-omi
LOCATION	?= japaneast

BICEP		:= bicep
AZ		:= az
DEPLOY_NAME	= $(shell date +'deploy-%d%H%M%S')

VPATH	= ./modules

AZURE_CORE_OUTPUT ?= json
export AZURE_CORE_OUTPUT
export AZURE_CORE_NO_COLOR = True

# keep intemidiate files usefull for debug
#.PRECIOUS: %.json

.DEFAULT_GOAL := help

help:           ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

%.json: %.bicep
	@$(BICEP) build $<

.PHONY: show-vnet
show-vnet: show-vnet.bicep
	$(AZ) deployment group create -g $(RESOURCE_GROUP) -n $(DEPLOY_NAME) \
		-f $< -p

.PHONY: show-nsg
show-nsg: show-nsg.bicep
	$(AZ) deployment group create -g $(RESOURCE_GROUP) -n $(DEPLOY_NAME) \
		-f $< -p name=networkSecurityGroup1

