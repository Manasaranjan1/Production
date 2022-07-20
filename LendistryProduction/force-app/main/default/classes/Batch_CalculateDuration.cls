global class Batch_CalculateDuration implements Database.Batchable<sObject>
{
    String query = 'SELECT Id FROM Opportunity where stageName != \'Funded\' AND stageName != \'Missed Opp\'';
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Opportunity> scope)
    {  
        OPP_CALCULATE_DURATION.calling_duration(scope);
    }  
    global void finish(Database.BatchableContext BC)
    {
    }
}