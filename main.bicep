/*
The Azure Team as already built a good number of basic snippets to use

az deployment sub create -f main.bicep -l northcentralus --parameters main.bicep.local.json
az deployment sub what-if -f main.bicep -l northcentralus --parameters main.bicep.local.json
*/


// targetScope = 'subscription'

@secure()
param serveradminpwd string

@secure()
param tenantId string 

/*
  will need to explain te scope here, and WHY we're going to modularize
  Why we modularize: 
  1. maintainability
  2. readability
  3. treat infrastrucuture config like your code
  4. complete deployments into a subscription

  the demos that the azure team provides will show you execution of creation/what-if based 
  on a `az deployment group create`, which assumes a pre-configured resource group 
*/


/*
  this function will pull and create a resource group "object" that you've 
  previously created (make-group.bicep).

  we're doing this because of the interesting permissions on our 
  VS Enterprise Azure Account
*/
param rg object = resourceGroup()

resource kvName_resource 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: 'kv-newnext2021'
  location: rg.location
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

resource dbserver 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: 'asqlserver-2021-newnext'
  location: rg.location

  properties: {
    administratorLogin:'SogetiSA'
    administratorLoginPassword: serveradminpwd
    version: '12.0'
  }
}

resource sqldb 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  parent: dbserver
  location: rg.location
  name: 'sqldb-2021-newnext'
  sku: {
    name: 'Basic'
  }

  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 1073741824
  }
}

resource appInsights 'Microsoft.Insights/components@2015-05-01' = {
  name: 'newnext-2021-app-insights'
  location: rg.location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Request_Source: 'rest'
  }
}

resource appplan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: 'app-plan'
  location: rg.location
  sku: {
    tier: 'Free'
    name: 'F1'
  }
}

resource app 'Microsoft.Web/sites@2021-01-15' = {
  name: 'newnext2021-app'
  location: rg.location
  properties: {
    serverFarmId: appplan.id
  }
}

/*
  so why not just use ARM?
  or Terraform?
  or Farmer?
  or Pulumni?

  -- per the Azure Team: "you absolutely can, not all environments/ecosystems/teams are the same
  -- readibility
  -- feature parody: there is no separately maintained "resource provider" (Terraform)

  can we use this for multi-cloud?
  -- strictly speaking, no.  This sits on top of the Azure Resource Manager templates,
     however, you can provision Azure Arc which would then  allow a level of control over multi-cloud
  
  how do you manage infrastructure "drift"?
  -- the cli reads directly from the resource group/sub/management-group/tenant that is targeted
     to generate the what-if comparisons
*/
