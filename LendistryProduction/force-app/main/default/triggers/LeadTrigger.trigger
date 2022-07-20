trigger LeadTrigger on Lead( after insert, before update, after update , before insert)
{
    Trigger_ON_OFF_Setting__c triggerONOFF = Trigger_ON_OFF_Setting__c.getInstance('LeadTrigger_Switch');
    Id CenterLeadsRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Center Leads').getRecordTypeId();
    String GQRecordTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('General Questions Contact Form').getRecordTypeId();
    String PCRecordTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Partnership Contact Form').getRecordTypeId();

    system.debug('--1--CenterLeadsRecordTypeId--->>'+CenterLeadsRecordTypeId);
    
    if(triggerONOFF != null && triggerONOFF.LeadTrigger_ON_OFF__c && CenterLeadsRecordTypeId != Trigger.New[0].recordTypeId)
    {
        system.debug('--2--CenterLeadsRecordTypeId--->>'+CenterLeadsRecordTypeId);
        LeadTriggerHandler handler = new LeadTriggerHandler (Trigger.isExecuting, Trigger.size);
        if( Trigger.isInsert && GQRecordTypeID != Trigger.New[0].recordTypeId && PCRecordTypeID != Trigger.New[0].recordTypeId)
        {
           
            if(Trigger.isBefore)
            {
            //handler.OnBeforeInsert(trigger.New ,trigger.Old,Trigger.NewMap);  
            //Added by Cloud Maven, INC
                    
            }
          
            // Added by ushank Khanna
            if(Trigger.isAfter  ) {
                handler.OnAfterInsert(trigger.New ,Trigger.OldMap);
                //LeadConvert.OnAfterInsert(trigger.New ,Trigger.OldMap);
                
            }
        }
        
        if ( Trigger.isUpdate && GQRecordTypeID != Trigger.New[0].recordTypeId && PCRecordTypeID != Trigger.New[0].recordTypeId)
        {
            if(Trigger.isBefore)
            {
                handler.OnBeforeUpdate(trigger.New ,trigger.Old,Trigger.NewMap,Trigger.OldMap);
                //assignOwnerFromQueue.onBeforeUpdate(trigger.New);
                handler.runCriminalReport(trigger.New,trigger.oldMap);
            }
            else if(Trigger.isAfter)
            {
                handler.OnAfterUpdate(trigger.New ,trigger.Old,Trigger.NewMap,Trigger.OldMap);
            }
        }
        if (Trigger.isUpdate && Trigger.isAfter && (GQRecordTypeID == Trigger.New[0].recordTypeId || PCRecordTypeID == Trigger.New[0].recordTypeId)){
            LeadConvert sc = new LeadConvert(trigger.New ,Trigger.OldMap);
            Datetime dt = (Datetime.now()).addMinutes(5);
            String timeForScheduler = dt.format('s m H d M \'?\' yyyy');
            Id schedId = System.Schedule('Lead Convert '+timeForScheduler,timeForScheduler,sc);
        }
        
    }
}