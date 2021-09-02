param prefix string

@description('SKU tier')
@allowed([
  'Free'
  'Shared'
  'Basic'
  'Standard'
  'Premium'
  'PremiumV2'
])
param skuTier string = 'Free'

@description('SKU Name')
@allowed([
  'F1'
  'D1'
  'B1'
  'B2'
  'B3'
  'S1'
  'S2'
  'S3'
  'P1'
  'P2'
  'P3'
  'P1V2'
  'P2V2'
  'P3V2'
])
param skuName string = 'F1'

var laName = 'la-${prefix}-${uniqueString(resourceGroup().id)}'
var aiName = 'ai-${prefix}-${uniqueString(resourceGroup().id)}'
var aspName = 'asp-${prefix}-${uniqueString(resourceGroup().id)}'
var asName = 'as-${prefix}-${uniqueString(resourceGroup().id)}'
var location = resourceGroup().location

var netFrameworkVersion = 'v4.0'
var alwaysOn = (!((skuName == 'F1') || (skuName == 'D1')))

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: laName
  location: location
  properties: {
    sku: {
      name: 'Free'
    }
  }
}

// https://github.com/Azure/bicep/issues/784#issuecomment-742516491
// https://github.com/Azure/bicep/issues/784#issuecomment-721339721
// https://docs.microsoft.com/en-us/azure/templates/microsoft.insights/2020-02-02-preview/components
// https://docs.microsoft.com/en-us/azure/azure-monitor/app/create-workspace-resource#azure-resource-manager-templates
resource applicationInsights 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: aiName
  location: location
  kind: 'web'
  properties: {
    WorkspaceResourceId: logAnalyticsWorkspace.id
    Application_Type: 'web'
  }
}

// https://docs.microsoft.com/en-us/azure/templates/microsoft.web/2020-06-01/serverfarms
resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: aspName
  location: location
  properties: {}
  sku: {
    tier: skuTier
    name: skuName
    capacity: 1
  }
}

// https://docs.microsoft.com/en-us/azure/templates/microsoft.web/2020-06-01/sites
resource appService 'Microsoft.Web/sites@2020-06-01' = {
  kind: 'app'
  name: asName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    siteConfig: {
      netFrameworkVersion: netFrameworkVersion
      alwaysOn: alwaysOn
    }
    clientAffinityEnabled: false
    serverFarmId: appServicePlan.id
  }
}

// https://docs.microsoft.com/en-us/azure/templates/microsoft.web/2020-06-01/sites/config-appsettings
// https://github.com/Azure/bicep/issues/784#issuecomment-725447850
// https://github.com/Azure/bicep/issues/657
resource appSettings 'Microsoft.Web/sites/config@2020-06-01' = {
  parent: appService
  name: 'appsettings'
  properties: {
    APPINSIGHTS_INSTRUMENTATIONKEY: applicationInsights.properties.InstrumentationKey
    APPLICATIONINSIGHTS_CONNECTION_STRING: applicationInsights.properties.ConnectionString
    ApplicationInsightsAgent_EXTENSION_VERSION: '~2'
    XDT_MicrosoftApplicationInsights_Mode: 'recommended'
    WEBSITE_TIME_ZONE: 'Tokyo Standard Time'
    WEBSITE_RUN_FROM_PACKAGE: '1'
  }
}
