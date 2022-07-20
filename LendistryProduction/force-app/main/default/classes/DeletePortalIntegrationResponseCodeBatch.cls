public class DeletePortalIntegrationResponseCodeBatch implements Database.Batchable<sObject>,Schedulable{

     public void execute(SchedulableContext sc){
         DeletePortalIntegrationResponseCodeBatch batch = new DeletePortalIntegrationResponseCodeBatch();
         database.executeBatch(batch);
     }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        Date threemonthsbefore = Date.today().addMonths(-3);
        String isBlank = null;
        return Database.getQueryLocator('Select id from Portal_Integration_Response_Code__c where createddate<:threemonthsbefore OR Application_ID__c =:isBlank limit 100000');
        //return Database.getQueryLocator('Select id from Portal_Integration_Response_Code__c');
    }
    public void execute(Database.BatchableContext bc, List<Portal_Integration_Response_Code__c> records){
       
       System.debug('&&&&records&&&&&& '+records);
        Delete records;
        //Database.emptyRecycleBin(records);
    }    
    public void finish(Database.BatchableContext bc){
       
    } 
}