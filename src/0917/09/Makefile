# required variables
# 	RESOURCE_GROUP
# 	LOCATION
LOCATION		?= eastus2

SERVER_NAME		?= omimysql01
LOGANALYTICS_NAME	?= omila01

ADMINISTRATOR_LOGIN 	?= mysqladmin
ADMINISTRATOR_LOGIN_PASSWORD = ./.secrets/$(RESOURCE_GROUP)/administratorLoginPassword

MY_IPADDRESS		= $(shell curl -s https://api.ipify.org)


help:           ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)


deploy:		## deploy web pubsub
deploy: setup
	az deployment group create -g $(RESOURCE_GROUP) \
		-f main.bicep \
		-p serverName=$(SERVER_NAME) \
		-p administratorLogin=$(ADMINISTRATOR_LOGIN) \
		-p administratorLoginPassword=@$(ADMINISTRATOR_LOGIN_PASSWORD) \
		-p logAnalyticsName=$(LOGANALYTICS_NAME) \
		-p myIpAddress=$(MY_IPADDRESS)

create-rg:	## create resource group
create-rg:
	[ "$$(az group exists -g $(RESOURCE_GROUP) -o tsv)" = "true" ] ||  \
	 az group create --location $(LOCATION) -n $(RESOURCE_GROUP)

clean:
	az group delete -n $(RESOURCE_GROUP)

setup: $(ADMINISTRATOR_LOGIN_PASSWORD) create-rg
ifndef RESOURCE_GROUP
	$(error RESOURCE_GROUP required)
endif

$(ADMINISTRATOR_LOGIN_PASSWORD):
	@mkdir -p ./.secrets
	@chmod 0700 ./.secrets
	@mkdir -p ./.secrets/$(RESOURCE_GROUP)
	@chmod 0700 ./.secrets/$(RESOURCE_GROUP)
	openssl rand -base64 64 > $(ADMINISTRATOR_LOGIN_PASSWORD)
	@chmod 0600 $(ADMINISTRATOR_LOGIN_PASSWORD)
