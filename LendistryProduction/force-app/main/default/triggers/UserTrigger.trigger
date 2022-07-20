trigger UserTrigger on User (after insert, after update ) {
    
    UserTriggerHandler handler = new UserTriggerHandler(Trigger.isExecuting, Trigger.size);
    if(Trigger.New.size()>0 && Trigger.New[0].ContactId ==null )
    {
        if( Trigger.isInsert && Trigger.isAfter && UserTrigger__c.getValues('User Data').User_Trigger_Insert__c)
        {
            handler.OnAfterInsert(trigger.New);
        }
        if ( Trigger.isUpdate && Trigger.isAfter && UserTrigger__c.getValues('User Data').User_Trigger_Update__c)
        {
            handler.OnAfterUpdate(trigger.New ,Trigger.OldMap);
        }
    }
        
}