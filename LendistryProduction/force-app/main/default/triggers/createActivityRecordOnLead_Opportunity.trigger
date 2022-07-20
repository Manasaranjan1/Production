trigger createActivityRecordOnLead_Opportunity on tdc_tsw__Message__c (after insert) {
    List<Task> listofTask = new List<Task>();
    for(tdc_tsw__Message__c objSMS : [select id,name,tdc_tsw__Message_Text_New__c,tdc_tsw__Lead__c,
                                        tdc_tsw__Lead__r.Id ,tdc_tsw__Opportunity__c,tdc_tsw__Opportunity__r.Id
                                        from tdc_tsw__Message__c 
                                        where id in : trigger.new]){
        Task tsk = new task();
        if(objSMS.tdc_tsw__Lead__c !=null)
            tsk.WhoId = objSMS.tdc_tsw__Lead__r.Id;
        if(objSMS.tdc_tsw__Opportunity__c!=null)
            tsk.Whatid = objSMS.tdc_tsw__Opportunity__r.Id;
        tsk.Subject = objSMS.Name+' '+ 'SMS';
        tsk.ActivityDate = date.today();
        tsk.status = 'Completed';
        tsk.description = objSMS.tdc_tsw__Message_Text_New__c;
        listofTask.add(tsk);
    }
    if(listofTask != null && listofTask.size()>0)
    insert listofTask;
}