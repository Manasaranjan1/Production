global class BatchLeadUpdateInPortal implements Database.Batchable<sObject>,Database.AllowsCallouts {
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute
        String type = 'NYR';
        String query = 'SELECT Id,PortalAPIEndPoint__c FROM Lead WHERE Loan_Type__c =:type AND IsConverted = False AND Custom_Last_Modified_Date__c >= 2021-09-21T16:48:34.000Z';
        if(Test.isRunningTest())
            query = 'SELECT Id,PortalAPIEndPoint__c FROM Lead WHERE Loan_Type__c =:type AND IsConverted = False AND Custom_Last_Modified_Date__c >= 2021-09-21T16:48:34.000Z limit 1';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Lead> leadList) {
       JavaAPICallOut2.updateLeadSFToPortalBatch(new Set<Id>{leadList[0].Id},'https://api10.mylendistry.com');
       //JavaAPICallOut2.updateLeadSFToPortalBatch(new Set<Id>{leadList[0].Id},'https://legacyhotfixapi.mylendistry.com');
    }   
    global void finish(Database.BatchableContext BC) {
        // execute any post-processing operations
  }
}