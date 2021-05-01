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

deploy:		## deploy aks
deploy: check-env tmp/id_rsa
	az deployment group create -g $(RESOURCE_GROUP) \
		-f main.bicep \
		-p \
		vmAdminUsername=azureuser \
		logAnalyticsWorkspaceName=$(subst -rg,-workspace,$(RESOURCE_GROUP)) \
		authenticationType=sshPublicKey \
		vmAdminPasswordOrKey="$$(cat tmp/id_rsa.pub)" \
		diskStorageAccounType=Standard_LRS \
		vmSize=Standard_B1s

create-rg:	## create resource group
create-rg: check-env
	az group create --location $(LOCATION) -n $(RESOURCE_GROUP)

tmp/id_rsa:	## generate new key paire
	echo -e 'y' | ssh-keygen -t rsa -b 4094 -f tmp/id_rsa  -N ""

start:
	az aks stop --resource-group $(RESOURCE_GROUP) --name $(AKS_CLUSTER_NAME)

stop:
	az aks stop --resource-group $(RESOURCE_GROUP) --name $(AKS_CLUSTER_NAME)
