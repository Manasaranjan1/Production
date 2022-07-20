/**
 * @File Name          : UpdateLeadSyncFieldBatch.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 4/24/2020, 1:07:57 PM
 * @Modification Log   : 
 * Ver       Date            Author                 Modification
 * 1.0    4/24/2020   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
// batch class 
global class UpdateLeadSyncFieldBatch implements   Database.Batchable<sObject> ,Database.AllowsCallouts,DataBase.StateFul{
    
    // instance member to retain state across transactions
     global final String Query;
     global UpdateLeadSyncFieldBatch (String q){

      query=q;
   }
    // start method here to get all records
    global Database.QueryLocator start(Database.BatchableContext bc) {      
        return Database.getQueryLocator(query);
    }
    
    // execute method perform all processing..
    global void execute(Database.BatchableContext bc, List<Lead> listOfLead){   
    /****************************************************************************************************************************************************
    Method Name : execute
    Description :  This Batch execute method iterate all leads record and based on Tenant URL on Lead we set a different portal end point and add in their
                    respective lead set. After adding URL perform enqueueJob jobs.
    
    ********************************************************************************************************************************************************/
       Set<Lead> setOfLeadId = new Set<Lead>();
        
        // process each batch of records
       
        if(listOfLead!=null && listOfLead.size()>0){
            for(Lead objLead : listOfLead){ 
                setOfLeadId.add(objLead);   
                                                    
            }                      
        } 
        if(setOfLeadId !=null && setOfLeadId.size()>0)
             System.enqueueJob(new updateSyncLeadQueueable (setOfLeadId));    // server 1 endpoint     
    }    
    global void finish(Database.BatchableContext bc){
         // callout future method
         
        
    }    
}