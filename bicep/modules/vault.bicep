param location string

@secure()
param tenantId string

resource kvName_resource 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: 'kv-newnext2021'
  location: location
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: tenantId
    accessPolicies: [
    ]
  }
}
