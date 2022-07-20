global class Batch_update_duration_on_Opp implements Database.Batchable<sObject>
{
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'Select Id,Opportunity__c, Name,Stage_Close_Date__c, Stage_Duration_Hidden__c,Stage_Duration__c,Stage_Previous__c,Stage_New__c,Stage_Start_Date__c, LastModifiedDate,LastModifiedBy.Name, Createddate from Opportunity_Field_History__c';
       
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Opportunity_Field_History__C> scope)
    {
        CalculateDuration_batch_cls.updateDuration(scope);
    }
    global void finish(Database.BatchableContext BC) {
    }
}