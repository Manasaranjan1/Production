trigger QuestionsTrigger on Lead_Questions__c (after update) {
    
    QuestionsTriggerHandler handler = new QuestionsTriggerHandler(Trigger.isExecuting, Trigger.size);
       
        if ( Trigger.isUpdate && Trigger.isAfter)
        {
            handler.OnAfterUpdate(trigger.New ,Trigger.OldMap);
        }
}