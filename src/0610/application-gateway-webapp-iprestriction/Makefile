# required variables
# 	RESOURCE_GROUP
# 	LOCATION
#	SITE_NAME
#	ADMINISTRATOR_LOGIN
#    	ADMINISTRATOR_LOGIN_PASSWORD

help:           ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)


deploy:		## deploy web pubsub
deploy:
	az deployment group create -g $(RESOURCE_GROUP) \
		-f main.bicep \
		-p \
		siteName=$(subst -rg,-webpubsub,$(RESOURCE_GROUP)) \
		administratorLogin=$(ADMINISTRATOR_LOGIN) \
    		administratorLoginPassword=$(ADMINISTRATOR_LOGIN_PASSWORD)


create-rg:	## create resource group
create-rg:
	az group create --location $(LOCATION) -n $(RESOURCE_GROUP)
