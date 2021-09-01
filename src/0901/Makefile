# required variables
# 	RESOURCE_GROUP
# 	LOCATION
#	PREFIX

help:           ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)


deploy:		## deploy web pubsub
deploy:
	az deployment group create -g $(RESOURCE_GROUP) \
		-f main.bicep \
		-p prefix=$(PREFIX) \


create-rg:	## create resource group
create-rg:
	az group create --location $(LOCATION) -n $(RESOURCE_GROUP)

