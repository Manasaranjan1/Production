public class AlertHandler{
    public void onAfterInsert(List<creditchecker__Alert__c> listOfAlert){
        List<Lead> updateLeadlist = new List<Lead>();
        map<Id,String> mapOfLeadIdWithStatus = new map<Id,String>();
        Id devRecordTypeId = Schema.SObjectType.creditchecker__Alert__c.getRecordTypeInfosByName().get('Regulatory').getRecordTypeId();
       
        if(listOfAlert !=null && listOfAlert.size()>0){
            for(creditchecker__Alert__c objAlert : [SELECT creditchecker__Credit_Report__r.creditchecker__Lead__c ,recordTypeId  
                                                     ,creditchecker__Status__c,creditchecker__Regulatory_Product_Type__c,
                                                     creditchecker__Status_Description__c
                                                     FROM creditchecker__Alert__c 
                                                     Where creditchecker__Credit_Report__r.creditchecker__Lead__c != null
                                                     AND id in : listOfAlert AND creditchecker__Regulatory_Product_Type__c='OFAC' 
                                                     AND creditchecker__Status__c='Clear' AND recordTypeId=:devRecordTypeId  AND creditchecker__Status_Description__c !=null
                                                     ]){
                   mapOfLeadIdWithStatus.put(objAlert.creditchecker__Credit_Report__r.creditchecker__Lead__c,objAlert.creditchecker__Status_Description__c); 
            }
        }
        if(mapOfLeadIdWithStatus!=null && mapOfLeadIdWithStatus.size()>0){
            for(String str : mapOfLeadIdWithStatus.keySet()){
                Lead objLead = new Lead(id=str);
                objLead.OFAC_Status_Description__c = mapOfLeadIdWithStatus.get(str);
                updateLeadlist.add(objLead);
            }
        }
        if(updateLeadlist !=null && updateLeadlist.size()>0)
            update updateLeadlist;
    }
    
    // aftr update operation
    public void onAfterUpdate(List<creditchecker__Alert__c> listOfAlert,Map<Id,creditchecker__Alert__c> oldMap){
        List<Lead> updateLeadlist = new List<Lead>();
        map<Id,String> mapOfLeadIdWithStatus = new map<Id,String>();
        Id devRecordTypeId = Schema.SObjectType.creditchecker__Alert__c.getRecordTypeInfosByName().get('Regulatory').getRecordTypeId();
       
        if(listOfAlert !=null && listOfAlert.size()>0){
            for(creditchecker__Alert__c objAlert : [SELECT creditchecker__Credit_Report__r.creditchecker__Lead__c ,recordTypeId  
                                                     ,creditchecker__Status__c,creditchecker__Regulatory_Product_Type__c,
                                                     creditchecker__Status_Description__c
                                                     FROM creditchecker__Alert__c 
                                                     Where creditchecker__Credit_Report__r.creditchecker__Lead__c != null
                                                     AND id in : listOfAlert  AND recordTypeId=:devRecordTypeId  AND creditchecker__Status_Description__c !=null
                                                     ]){
                                                     
                   creditchecker__Alert__c oldAlert = oldMap.get(objAlert.ID);// get old value
                   // check for description changes
                   if(oldAlert.creditchecker__Status_Description__c !=objAlert.creditchecker__Status_Description__c &&  objAlert.creditchecker__Regulatory_Product_Type__c=='OFAC' 
                                                     && objAlert.creditchecker__Status__c=='Clear')
                       mapOfLeadIdWithStatus.put(objAlert.creditchecker__Credit_Report__r.creditchecker__Lead__c,objAlert.creditchecker__Status_Description__c); 
                   // check for Product type changes
                  if(oldAlert.creditchecker__Regulatory_Product_Type__c!=objAlert.creditchecker__Regulatory_Product_Type__c && objAlert.creditchecker__Regulatory_Product_Type__c=='OFAC')
                        mapOfLeadIdWithStatus.put(objAlert.creditchecker__Credit_Report__r.creditchecker__Lead__c,objAlert.creditchecker__Status_Description__c); 
                   // check for Status changes
                  if(oldAlert.creditchecker__Status__c!=objAlert.creditchecker__Status__c && objAlert.creditchecker__Status__c=='Clear')
                        mapOfLeadIdWithStatus.put(objAlert.creditchecker__Credit_Report__r.creditchecker__Lead__c,objAlert.creditchecker__Status_Description__c); 
                  if((oldAlert.creditchecker__Regulatory_Product_Type__c!=objAlert.creditchecker__Regulatory_Product_Type__c && 
                  objAlert.creditchecker__Regulatory_Product_Type__c!='OFAC')|| (oldAlert.creditchecker__Status__c!=objAlert.creditchecker__Status__c  && objAlert.creditchecker__Status__c!='Clear'))
                       mapOfLeadIdWithStatus.put(objAlert.creditchecker__Credit_Report__r.creditchecker__Lead__c,'');
                       
            }
        }
       
        if(mapOfLeadIdWithStatus!=null && mapOfLeadIdWithStatus.size()>0){
            for(String str : mapOfLeadIdWithStatus.keySet()){
                Lead objLead = new Lead(id=str);
                objLead.OFAC_Status_Description__c = mapOfLeadIdWithStatus.get(str);
                updateLeadlist.add(objLead);
            }
        }
        if(updateLeadlist !=null && updateLeadlist.size()>0)
            update updateLeadlist;
    }
    
    // for delete
    
    public void onBeforeDelete(List<creditchecker__Alert__c> listOfAlert){
        List<Lead> updateLeadlist = new List<Lead>();
        map<Id,String> mapOfLeadIdWithStatus = new map<Id,String>();
        Id devRecordTypeId = Schema.SObjectType.creditchecker__Alert__c.getRecordTypeInfosByName().get('Regulatory').getRecordTypeId();
       
        if(listOfAlert !=null && listOfAlert.size()>0){
            for(creditchecker__Alert__c objAlert : [SELECT creditchecker__Credit_Report__r.creditchecker__Lead__c ,recordTypeId  
                                                     ,creditchecker__Status__c,creditchecker__Regulatory_Product_Type__c,
                                                     creditchecker__Status_Description__c
                                                     FROM creditchecker__Alert__c 
                                                     Where creditchecker__Credit_Report__r.creditchecker__Lead__c != null
                                                     AND id in : listOfAlert
                                                     ]){
                                                     
                  
                   // check for description changes
                   if(objAlert.creditchecker__Regulatory_Product_Type__c=='OFAC' && objAlert.creditchecker__Status__c=='Clear' &&  objAlert.recordTypeId==devRecordTypeId)
                       mapOfLeadIdWithStatus.put(objAlert.creditchecker__Credit_Report__r.creditchecker__Lead__c,''); 
            }
        }
       
        if(mapOfLeadIdWithStatus!=null && mapOfLeadIdWithStatus.size()>0){
            for(String str : mapOfLeadIdWithStatus.keySet()){
                Lead objLead = new Lead(id=str);
                objLead.OFAC_Status_Description__c = mapOfLeadIdWithStatus.get(str);
                updateLeadlist.add(objLead);
            }
        }
        if(updateLeadlist !=null && updateLeadlist.size()>0)
            update updateLeadlist;
    }
}