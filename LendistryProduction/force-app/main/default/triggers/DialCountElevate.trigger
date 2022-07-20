trigger DialCountElevate on Task (After insert,After Update) {
    Map<ID,lead> Newmap = new Map<ID,lead>();
    Map<ID,Contact> NewMapContact = new Map<ID,Contact>();
    Map<ID,Opportunity> NewMapOpportunity = new Map<ID,Opportunity>();
    Map<ID,Account> NewMapAccount = new Map<ID,Account>();
    set< string > setOfLeads = new set< string >();
    set< string > setOfOpps = new set< string >();
    String sObjName;
    string WhatIdsObjName;
    string ConvertedWhoId;
    string ConvertedWhatId;
    Id  WhoId;
    Id  WhatId;
    list<Task> lstTask = new list<Task>();
    Static Integer Count = 0;
    for( Task eachT : Trigger.new )
    {
        setOfLeads.add(eachT.whoid);
        setOfOpps.add(eachT.whatId);
    }
        
    //OR whatid IN:setOfOpps
    if( setOfLeads != null || setOfOpps != null )
    lstTask = [Select ID, whoid,TaskSubtype, whatId from Task where (whoid IN:setOfLeads AND WhatId IN:setOfOpps ) AND TaskSubtype= 'Call'];
    if(lstTask != null && lstTask.size()>0)
    {
        for(Task eachTask : lstTask )
        {
            System.debug('eachTask.WhoId: '+eachTask.WhoId);
           if( (string.valueof(eachTask.WhoId) != null && string.valueof(eachTask.WhoId) != '' ))
           {
               ConvertedWhoId = String.valueOf(eachTask.whoid).substring(0, 15);
               WhoId = Id.valueOf(ConvertedWhoId);
               sObjName = WhoId.getSObjectType().getDescribe().getName();
           }
            
            if( (string.valueof(eachTask.whatId) != null && string.valueof(eachTask.whatId) != '' ))
            {
                ConvertedwhatId = String.valueOf(eachTask.whatId).substring(0, 15);
            
                whatId = Id.valueOf(ConvertedwhatId);
                WhatIdsObjName = whatId.getSObjectType().getDescribe().getName();
            }
            
             
            
            If((eachTask.TaskSubtype == 'Call' && sObjName == 'Lead') ){
                lead objLead = new lead(id=WhoId);
                Count = Count+1;
                objLead.Elevate_Dials__c = Count;
                Newmap.put(WhoId, objLead);
            }
            
            If((eachTask.TaskSubtype == 'Call' && sObjName == 'Contact')){
                Contact objContact = new Contact(id=WhoId);
                Count = Count+1;
                objContact.Elevate_Dials__c = Count;
                NewMapContact.put(WhoId, objContact);
            }
            
            If((eachTask.TaskSubtype == 'Call' && WhatIdsObjName == 'Account')){
                Account objAccount = new Account(id=whatId);
                Count = Count+1;
                objAccount.Elevate_Dials__c = Count;
                NewMapAccount.put(whatId, objAccount);
            }
            
            If((eachTask.TaskSubtype == 'Call' && WhatIdsObjName == 'Opportunity')){
                Opportunity objOpportunity = new Opportunity(id=whatId);
                Count = Count+1;
                objOpportunity.Elevate_Dials__c = Count;
                NewMapOpportunity.put(whatId, objOpportunity);
            }
        }
    }
    if(Newmap != null && Newmap.size()>0)
    	update Newmap.values();
    if( NewMapContact != null && NewMapContact.size() > 0)
        Update NewMapContact.values();
    if(NewMapAccount != null && NewMapAccount.size() > 0)
        Update NewMapAccount.values();
    if(NewMapOpportunity != null && NewMapOpportunity.size() > 0)
        Update NewMapOpportunity.values();
}