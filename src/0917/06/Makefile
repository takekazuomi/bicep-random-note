# required variables
# 	RESOURCE_GROUP
# 	LOCATION
LOCATION		?= eastus2

SERVER_NAME		?= omimysql01
ADMINISTRATOR_LOGIN 	?= mysqladmin
ADMINISTRATOR_LOGIN_PASSWORD = ./.secrets/$(RESOURCE_GROUP)/administratorLoginPassword

help:           ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)


deploy:		## deploy web pubsub
deploy: setup
	az deployment group create -g $(RESOURCE_GROUP) \
		-f main.bicep \
		-p serverName=$(SERVER_NAME) \
		-p administratorLogin=$(ADMINISTRATOR_LOGIN) \
		-p administratorLoginPassword=@$(ADMINISTRATOR_LOGIN_PASSWORD)


create-rg:	## create resource group
create-rg: setup
	az group exists -g $(RESOURCE_GROUP) > /dev/null 2>&1 || \
	 az group create --location $(LOCATION) -n $(RESOURCE_GROUP)

clean:
	az group delete -n $(RESOURCE_GROUP)

setup: $(administratorLoginPassword)
ifndef RESOURCE_GROUP
	$(error RESOURCE_GROUP required)
endif

$(administratorLoginPassword):
	@mkdir -p ./.secrets
	@chmod 0700 ./.secrets
	@mkdir -p ./.secrets/$(RESOURCE_GROUP)
	@chmod 0700 ./.secrets/$(RESOURCE_GROUP)
	openssl rand -base64 64 > $(administratorLoginPassword)
	@chmod 0600 $(administratorLoginPassword)

