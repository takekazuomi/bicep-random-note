# required variables
# 	RESOURCE_GROUP
# 	LOCATION

AKS_CLUSTER_NAME=$(subst -rg,-aks01,$(RESOURCE_GROUP))

help:           ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

check-env:
ifndef RESOURCE_GROUP
	$(error RESOURCE_GROUP is undefined)
endif
ifndef LOCATION
	$(error LOCATION is undefined)
endif
	@echo > /dev/null

la:		## deploy aks
la: log-analytics.bicep create-rg check-env
	az deployment group create -g $(RESOURCE_GROUP) \
		-f $<

sa:		## deploy aks
sa: sa.bicep create-rg check-env
	az deployment group create -g $(RESOURCE_GROUP) \
		-f $<


create-rg:	## create resource group
create-rg: check-env
	az group create --location $(LOCATION) -n $(RESOURCE_GROUP) -o table

