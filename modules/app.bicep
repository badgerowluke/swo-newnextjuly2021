param location string
param appname string


resource appplan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: 'app-plan'
  location: location
  sku: {
    tier: 'Free'
    name: 'F1'
  }
}

resource app 'Microsoft.Web/sites@2021-01-15' = {
  name: appname
  location: location
  properties: {
    serverFarmId: appplan.id
  }

}
