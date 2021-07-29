param location string
param appName string


resource appInsights 'Microsoft.Insights/components@2015-05-01' = {
  name: appName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Request_Source: 'rest'
  }
}

output instrumentationkey string = appInsights.properties.InstrumentationKey
