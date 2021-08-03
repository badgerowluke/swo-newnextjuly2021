/*
The Azure Team as already built a good number of basic snippets to use

az deployment sub create -f main.bicep -l northcentralus --parameters main.bicep.local.json
az deployment sub what-if -f main.bicep -l northcentralus --parameters main.bicep.local.json
az deployment group create -f main.bicep -g newnext2021 --parameters main.bicep.local.json
az deployment group what-if -f main.bicep -g newnext2021 --parameters main.bicep.local.json
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

module kv 'modules/vault.bicep' = {
  name: 'kv-newnext2021'
  params: {
    location: rg.location
    tenantId: tenantId
    
  }
}

module persistence 'modules/storage.bicep' = {
  name: 'db-deploy'
  params: {
    location: rg.location
    serveradminpwd: serveradminpwd
  }
}

module monitoring 'modules/monitoring.bicep' = {
  name: 'monitor-deploy'
  params: {
    appName:'monitor-newnext2021-app'
    location: rg.location
  }
}

module app 'modules/app.bicep' = {
  name: 'app-deploy'
  params: {
    location: rg.location
    appname: 'app-newnext2021'
    
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
