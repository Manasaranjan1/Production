trigger ContactTrigger on Contact (After update) {
    
    if(Trigger.isAfter){
        if(Trigger.isUpdate) {
            ContactTriggerHandler.onAfterUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}