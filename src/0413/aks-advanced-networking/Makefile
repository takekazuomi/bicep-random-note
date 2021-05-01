# required variables
# 	RESOURCE_GROUP
# 	LOCATION
BASE_NAME	=	$(subst -rg,,$(RESOURCE_GROUP))
AKS_CLUSTER_NAME=	$(BASE_NAME)-aks

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
		aksClusterName=$(AKS_CLUSTER_NAME) \
		aksClusterAdminUsername=azureuser \
		vmAdminUsername=azureuser \
		logAnalyticsWorkspaceName=$(subst -rg,-workspace,$(RESOURCE_GROUP)) \
		aksClusterSshPublicKey="$$(cat tmp/id_rsa.pub)" \
		authenticationType=sshPublicKey \
		vmAdminPasswordOrKey="$$(cat tmp/id_rsa.pub)" \
		diskStorageAccounType=Standard_LRS \
		vmSize=Standard_B1s \
		nodePoolVmSize=Standard_B2s \
		nodePoolScaleSetPriority=Regular

create-rg:	## create resource group
create-rg: check-env
	az group create --location $(LOCATION) -n $(RESOURCE_GROUP)

tmp/id_rsa:	## generate new key paire
	echo -e 'y' | ssh-keygen -t rsa -b 4094 -f tmp/id_rsa  -N ""


aks-versions:	## print aks version
	az aks get-versions --location $(LOCATION) --output table

start:
	az aks stop --resource-group $(RESOURCE_GROUP) --name $(AKS_CLUSTER_NAME)

stop:
	az aks stop --resource-group $(RESOURCE_GROUP) --name $(AKS_CLUSTER_NAME)

.secret/$(BASE_NAME).json:
	mkdir -p .secret
	az ad sp create-for-rbac -n omiapp01 --skip-assignment -o json > $@
	cat $@ | jp -u appId
	az ad sp show --id $$(cat $@ | jp -u appId) --query objectId

echo: .secret/$(BASE_NAME).json
	echo $(BASE_NAME)

