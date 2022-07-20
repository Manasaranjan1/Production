trigger UpdateSMSSendDateonLead on tdc_tsw__Message__c (after insert) {
    SMSHistoryHandler objHandler = new SMSHistoryHandler();
    if(Trigger.isInsert){        
        objHandler.onAfterInsert(Trigger.new);
    }
}