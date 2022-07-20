trigger timeTrackingTrigger on Time_Tracker__c (after insert, after update, after delete, after undelete)  {
    TimeTrackingTriggerHandler handler = new TimeTrackingTriggerHandler(); 
    
    if( trigger.isAfter)
    {
        if(Trigger.isInsert || Trigger.isUndelete) {
        handler.updateCounselingSession(Trigger.New, False);
    }
    if(Trigger.isUpdate) {
        handler.updateCounselingSession(Trigger.New, True);
    }
    if (Trigger.isDelete) {
        handler.updateCounselingSession(Trigger.old, False);    
    }
    }
}