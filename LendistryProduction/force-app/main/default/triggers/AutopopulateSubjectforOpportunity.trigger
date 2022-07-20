trigger AutopopulateSubjectforOpportunity on Event (Before Insert, Before Update) {
  If(Trigger.IsInsert || Trigger.IsUpdate)
    {
        Set<id> Setid = new Set<id>();  
        For(Event EVT : Trigger.New)
        {
            Setid.add(EVT.whatId); 
        }
        List<Opportunity> lstOpportunity = [Select id, RecordType.Name from Opportunity where id=: Setid Limit 1];
        System.debug('lstOpportunity-'+lstOpportunity);
        Map<id,Opportunity> LstMap = new Map<id,Opportunity>(lstOpportunity);
        For(Event EVT : Trigger.New)
        {
            //String id = EVT.whatid;
            //System.debug('id-'+id);   
            if(EVT.WhoId == null || (EVT.WhoId != null && EVT.WhatId != null)){         
            String STR =  LStMap.get(EVT.whatid).RecordType.Name;
            System.debug('STR-'+STR);
            
            If(STR == 'Lendistry Lending' && EVT.Event_Type__c != null)            
                EVT.Subject= EVT.Event_Type__c;
        }
        }
    }
}