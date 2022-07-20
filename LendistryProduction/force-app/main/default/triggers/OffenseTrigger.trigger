trigger OffenseTrigger on criminalreports__Offense__c (before insert, before update) {
    if(!OffenseTriggerHandler.isBeforeTriggerRan) {
        OffenseTriggerHandler.beforeTrigger(Trigger.New);
        OffenseTriggerHandler.isBeforeTriggerRan = true;
    }
}