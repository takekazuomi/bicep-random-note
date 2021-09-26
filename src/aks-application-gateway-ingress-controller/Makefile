# required variables
# 	RESOURCE_GROUP
# 	LOCATION
LOCATION		?= eastus2

PREFIX				=
AKS_CLUSTER_ADMINUSER_NAME	= aksadmin
AKS_CLUSTER_SSH_PUBLIC_KEY	= $(HOME)/.ssh/id_rsa.pub
VM_ADMINUSER_NAME		= azureuser
VM_ADMIN_PASSWORD_OR_KEY	= $(HOME)/.ssh/id_rsa.pub
LOGANALYTICS_NAME		?= $(PREFIX)la01


help:           ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)


deploy:		## deploy
deploy: setup
	az deployment group create -g $(RESOURCE_GROUP) \
		-f main.bicep \
      		-p aksClusterAdminUsername=$(AKS_CLUSTER_ADMINUSER_NAME) \
		-p aksClusterSshPublicKey=@$(AKS_CLUSTER_SSH_PUBLIC_KEY) \
		-p vmAdminUsername=$(VM_ADMINUSER_NAME) \
		-p authenticationType=sshPublicKey \
		-p vmAdminPasswordOrKey=@$(VM_ADMIN_PASSWORD_OR_KEY) \
		-p logAnalyticsWorkspaceName=$(LOGANALYTICS_NAME)

create-rg:	## create resource group
create-rg:
ifndef RESOURCE_GROUP
	$(error RESOURCE_GROUP required)
endif
	[ "$$(az group exists -g $(RESOURCE_GROUP) -o tsv)" = "true" ] ||  \
	 az group create --location $(LOCATION) -n $(RESOURCE_GROUP)

clean:
	az group delete -n $(RESOURCE_GROUP)

setup: create-rg

