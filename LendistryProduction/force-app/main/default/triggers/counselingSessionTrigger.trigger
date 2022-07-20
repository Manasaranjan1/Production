trigger counselingSessionTrigger on Counseling_Session__c (before update, after insert, after update, after delete, after undelete) {
    
    if( Trigger.isAfter)
    {
        if(Trigger.isInsert || Trigger.isUndelete) {
            
            counselingSessionTriggerHandler.updateCumulativeTimeOnLead(Trigger.Newmap.keySet(), False);
        }
        if(Trigger.isUpdate){
            counselingSessionTriggerHandler.updateCumulativeTimeOnLead(Trigger.Newmap.keySet(), True);  
        }
        if(Trigger.isDelete){
            
            counselingSessionTriggerHandler.updateCumulativeTimeOnLead(Trigger.OldMap.keySet(), False);  
        }  
    }
    
   if(Trigger.isUpdate && Trigger.isBefore){
         counselingSessionTriggerHandler.onBeforeUpdate(trigger.new, trigger.old, trigger.oldMap);
    }
    if(Trigger.isInsert && Trigger.isBefore){
         counselingSessionTriggerHandler.onBeforeInsert(trigger.new);
    }
}