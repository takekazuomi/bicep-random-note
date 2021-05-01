# required variables
# 	RESOURCE_GROUP
# 	LOCATION

help:           ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)


check-env:	## required variables, RESOURCE_GROUP and LOCATION
check-env:
ifndef RESOURCE_GROUP
	$(error RESOURCE_GROUP is undefined)
endif
ifndef LOCATION
	$(error LOCATION is undefined)
endif
	@echo > /dev/null

deploy:		## deploy web pubsub
deploy: check-env
	az deployment group create -g $(RESOURCE_GROUP) \
		-f main.bicep \
		-p \
		name=$(subst -rg,-webpubsub,$(RESOURCE_GROUP))

create-rg:	## create resource group
create-rg: check-env
	az group create --location $(LOCATION) -n $(RESOURCE_GROUP)

