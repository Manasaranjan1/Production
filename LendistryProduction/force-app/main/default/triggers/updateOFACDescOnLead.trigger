trigger updateOFACDescOnLead on creditchecker__Alert__c (after insert, after update, before delete) {
    AlertHandler objHandler = new AlertHandler();
    if(Trigger.isInsert){        
        objHandler.onAfterInsert(Trigger.new);
    }
    
    // for update 
    if(Trigger.isUpdate){
        objHandler.onAfterUpdate(Trigger.new, Trigger.OldMap);
    }
    // for delete
    
    if(Trigger.isDelete){
        objHandler.onBeforeDelete(Trigger.old);
    }
}