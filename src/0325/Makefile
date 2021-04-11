RESOURCE_GROUP	?= omi-0325-rg
LOCATION	?= eastus2
DEPLOY		?= true

BICEP		:= bicep
AZ		:= az
DEPLOY_NAME	= $(shell date +'deploy-%d%H%M%S')

VPATH	= ./modules

AZURE_CORE_OUTPUT ?= json
export AZURE_CORE_OUTPUT
export AZURE_CORE_NO_COLOR = True

# keep intemidiate files usefull for debug
#.PRECIOUS: %.json

BICEP_FILES	:= $(wildcard *.bicep)
TARGETS		:= $(basename $(BICEP_FILES))

.DEFAULT_GOAL := help

help:           ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

%.json: %.bicep
	@$(BICEP) build $<

$(RESOURCE_GROUP):
	$(AZ) group create -n $(RESOURCE_GROUP) -l $(LOCATION)
	touch $(RESOURCE_GROUP)

.PHONY: sa-module
$(TARGETS): $(RESOURCE_GROUP)
	$(AZ) deployment group create -g $(RESOURCE_GROUP) -n $(DEPLOY_NAME) \
		-f $@.bicep -p deploy=$(DEPLOY)
