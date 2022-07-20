trigger AutopopulateSubject on Event (Before Insert, Before Update) {
    If(Trigger.IsInsert || Trigger.IsUpdate)
    {
        Set<id> Setid = new Set<id>();  
        For(Event EVT : Trigger.New)
        {
            Setid.add(EVT.WhoId); 
        }
        List<Lead> lstlead = [Select id, RecordType.Name from Lead where id=: Setid Limit 1];
        System.debug('lstlead-'+lstlead);
        Map<id,Lead> LstMap = new Map<id,Lead>(lstlead);
        For(Event EVT : Trigger.New)
        {
            //String id = EVT.whoid;
            //System.debug('id-'+id);   
            if(EVT.WhatId == null){         
            String STR =  LStMap.get(EVT.whoid).RecordType.Name;
            System.debug('STR-'+STR);
            
            If(STR == 'Lendistry Lending' && EVT.Event_Type__c != null)            
                EVT.Subject= EVT.Event_Type__c;
        }
        }
    }
}