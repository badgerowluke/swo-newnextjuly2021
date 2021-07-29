param location string
@secure()
param serveradminpwd string

resource dbserver 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: 'asqlserver-2021-newnext'
  location: location

  properties: {
    administratorLogin:'SogetiSA'
    administratorLoginPassword: serveradminpwd
    version: '12.0'
  }
}

resource sqldb 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  parent: dbserver
  location: location
  name: 'sqldb-2021-newnext'
  sku: {
    name: 'Basic'
  }

  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 1073741824
  }
}
