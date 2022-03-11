# required variables
# 	RESOURCE_GROUP
# 	LOCATION
#	SITE_NAME
#	ADMINISTRATOR_LOGIN

ADMINISTRATOR_LOGIN_PASSWORD	:= tmp/dbpassword


help:           ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)


deploy:		## deploy web pubsub
deploy: $(ADMINISTRATOR_LOGIN_PASSWORD)
	az deployment group create -g $(RESOURCE_GROUP) \
		-f main.bicep \
		-p \
		siteName=$(subst -rg,-webpubsub,$(RESOURCE_GROUP)) \
		administratorLogin=$(ADMINISTRATOR_LOGIN) \
    		administratorLoginPassword=@$(ADMINISTRATOR_LOGIN_PASSWORD)


create-rg:	## create resource group
create-rg:
	az group create --location $(LOCATION) -n $(RESOURCE_GROUP)

$(ADMINISTRATOR_LOGIN_PASSWORD):
	cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1 > $@
