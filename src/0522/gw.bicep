param location string = resourceGroup().location
param name string

@description('The Sku of the Gateway. This must be one of Basic, Standard or HighPerformance.')
param gatewaySku string

@description('The IP address range from which VPN clients will receive an IP address when connected. Range specified must not overlap with on-premise network.')
param vpnClientAddressPoolPrefix string

@description('The name of the client root certificate used to authenticate VPN clients. This is a common name used to identify the root cert.')
param clientRootCertName string

@description('Client root certificate data used to authenticate VPN clients.')
param clientRootCertData string

@description('The name of revoked certificate, if any. This is a common name used to identify a given revoked certificate.')
param revokedCertName string

@description('Thumbprint of the revoked certificate. This would revoke VPN client certificates matching this thumbprint from connecting to the VNet.')
param revokedCertThumbprint string

@description('Thumbprint of the revoked certificate. This would revoke VPN client certificates matching this thumbprint from connecting to the VNet.')
param gwSubnetRef string

resource pip 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: '${name}-pip'
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource gw 'Microsoft.Network/virtualNetworkGateways@2020-11-01' = {
  name: name
  location: location
  properties: {
    ipConfigurations: [
      {
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: gwSubnetRef
          }
          publicIPAddress: {
            id: pip.id
          }
        }
        name: 'vnetGatewayConfig'
      }
    ]
    sku: {
      name: gatewaySku
      tier: gatewaySku
    }
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    enableBgp: false
    vpnClientConfiguration: {
      vpnClientAddressPool: {
        addressPrefixes: [
          vpnClientAddressPoolPrefix
        ]
      }
      vpnClientRootCertificates: [
        {
          name: clientRootCertName
          properties: {
            publicCertData: clientRootCertData
          }
        }
      ]
      vpnClientRevokedCertificates: [
        {
          name: revokedCertName
          properties: {
            thumbprint: revokedCertThumbprint
          }
        }
      ]
    }
  }
}
