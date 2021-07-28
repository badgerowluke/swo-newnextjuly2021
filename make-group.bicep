targetScope = 'subscription'
resource newRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'newnext2021'
  location: 'northcentralus'
}
