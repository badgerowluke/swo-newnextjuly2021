/*
The Azure Team as already built a good number of basic snippets to use

az deployment sub create -f main.bicep -l northcentralus --parameters main.bicep.local.json
*/


targetScope = 'subscription'

resource  newRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'newnext2021'
  location: deployment().location
}
