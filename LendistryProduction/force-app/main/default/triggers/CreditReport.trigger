trigger CreditReport on creditchecker__Credit_Report__c (after update) {
    if(Trigger.isUpdate && Trigger.isAfter) {
        Map<Id, Lead> mapStrings = new Map<Id, Lead>();
        for(creditchecker__Credit_Report__c oCR : Trigger.new) {
            creditchecker__Credit_Report__c oOldCR = Trigger.oldMap.get(oCR.Id);
            if(oCR.creditchecker__Parent_Record_Id__c != null && oCR.creditchecker__Parent_Record_Id__c.startsWith('00Q') && oCR.creditchecker__Status__c == 'Completed' && oOldCR.creditchecker__Status__c != oCR.creditchecker__Status__c) {
                Lead oLead = new Lead();
                oLead.Id = oCR.creditchecker__Parent_Record_Id__c;
                
                if(mapStrings.containsKey(oCR.creditchecker__Parent_Record_Id__c)) {
                    oLead = mapStrings.get(oCR.creditchecker__Parent_Record_Id__c);
				}
                if(oCR.Owner_Type__c == 'Owner 1') {
                	oLead.Actual_Owner1_Credit_Score__c = oCR.creditchecker__Average_Score__c;
                }
                if(oCR.Owner_Type__c == 'Owner 2') {
                     oLead.Actual_Owner2_Credit_Score__c = oCR.creditchecker__Average_Score__c;    
                }
                if(oCR.Owner_Type__c == 'Owner 3') {
                     oLead.Actual_Owner3_Credit_Score__c = oCR.creditchecker__Average_Score__c;   
                }
                if(oCR.Owner_Type__c == 'Owner 4') {
                     oLead.Actual_Owner4_Credit_Score__c = oCR.creditchecker__Average_Score__c;   
                }
                if(oCR.Owner_Type__c == 'Owner 5') {
                     oLead.Actual_Owner5_Credit_Score__c = oCR.creditchecker__Average_Score__c;  
                }
                mapStrings.put(oCR.creditchecker__Parent_Record_Id__c, oLead);
            }
        }
        
        if(mapStrings != null && !mapStrings.isEmpty()) {
            update mapStrings.values();
        }
    }
}