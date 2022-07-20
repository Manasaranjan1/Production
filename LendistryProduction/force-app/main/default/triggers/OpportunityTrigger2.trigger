trigger OpportunityTrigger2 on Opportunity (before insert, before update, after insert, after update) {
public static boolean isRecursive =false;
    if(Trigger.isBefore){

        if(Trigger.isInsert){
            OpportunityTriggerHandler1.onBeforeInsert(Trigger.new);
        }

        if(Trigger.isUpdate && OpportunityTriggerHandler1.isRecursive ){
            OpportunityTriggerHandler1.onBeforeUpdate(Trigger.new, Trigger.oldMap);
            //isRecursive = true;
        }
    }
    
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            OpportunityTriggerHandler1.onAfterInsert(Trigger.new, Trigger.oldMap);
        }
        if(Trigger.isUpdate) {
            OpportunityTriggerHandler1.onAfterUpdate(Trigger.new, Trigger.oldMap);
        }
    }
    
}