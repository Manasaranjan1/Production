public class counselingSessionTriggerHandler {
 //@future  
    public static void updateCumulativeTimeOnLead(Set<Id> CSessionids, Boolean afterUpdate ) {                
        
        
        List<Counseling_Session__c> csessionList = [select id, Lead__c from Counseling_Session__c where id in:CSessionids];
        set<id> setOfIds = new set<id>();
        for (Counseling_Session__c cs: csessionList) {
            setOfIds.add(cs.Lead__c);  
        }
        
        
        List<Lead> listOfLeads = [select id, Cumulative_Time__c, (select id, CS_Hours__c, CS_Minutes__c from Counselling_Sessions__r ) from Lead where id in:setOfIds];
        List<Lead> updatedlistOfLeads = new List<Lead>(); 
        list<Group> lstOfPartnerQueue = [select Id from Group where Type = 'Queue' AND Name='Partner Queue' limit 1];
        
        decimal sumOfHours=0.0 ;
        decimal sumOfMinutes=0.0 ;
        /* For Update Event */     
        if(afterUpdate==True){    //Trigger.isUpdate = afterUpdate
            if(CumulativeTimeFlag.flag==false ) {                        
                if(listOfLeads  != null && listOfLeads.size()>0){       
                    for(Lead lead: listOfLeads) {    
                        if( lstOfPartnerQueue != null && lstOfPartnerQueue.size() > 0 && lstOfPartnerQueue[0].Id != null )
                        {
                            lead.OwnerId= lstOfPartnerQueue[0].Id;
                        }
                        integer childCount = lead.Counselling_Sessions__r.size();
                        //System.debug('No of Childs :'+childCount);    
                        if(childCount>0) {             
                            for(Counseling_Session__c cs: lead.Counselling_Sessions__r) {   
                                sumOfHours = sumOfHours + (cs.CS_Hours__c)*1.0;   
                                sumOfMinutes = sumOfMinutes + (cs.CS_Minutes__c)*1.0;                                   
                            }                  
                        }                        
                        
                        
                        double cumulatedTime = sumOfHours*1.0 + Integer.valueOf(sumOfMinutes/60)*1.0 + Double.valueOf(System.math.mod(Integer.valueOf(sumOfMinutes),60))/100;
                        
                        lead.Cumulative_Time__c = cumulatedTime;
                        updatedlistOfLeads.add(lead);   
                    }
                }
                CumulativeTimeFlag.flag=true;                 
            }        
        } 
        else {    
            
            /* For Non Update events */
            if(listOfLeads  != null && listOfLeads.size()>0){                
                for(Lead lead: listOfLeads) {         
                     if( lstOfPartnerQueue != null && lstOfPartnerQueue.size()>0 && lstOfPartnerQueue[0].Id != null )
                        {
                            lead.OwnerId= lstOfPartnerQueue[0].Id;
                        }
                    integer childCount = lead.Counselling_Sessions__r.size();    
                    System.debug('No of Childs :'+childCount); 
                    if(childCount>0) {             
                        for(Counseling_Session__c cs: lead.Counselling_Sessions__r) {          
                            sumOfHours = sumOfHours + (cs.CS_Hours__c)*1.0;               
                            sumOfMinutes = sumOfMinutes + (cs.CS_Minutes__c)*1.0;                                   
                        }                  
                    }
                    
                    
                    double cumulatedTime = sumOfHours*1.0 + Integer.valueOf(sumOfMinutes/60)*1.0 + Double.valueOf(System.Math.mod(Integer.valueOf(sumOfMinutes),60))/100;
                    
                    lead.Cumulative_Time__c = cumulatedTime;   //pbList ==> updatedcsessionList   //pr ==> cs
                    //cs.CummulativeTime03__c = d3;
                    System.debug(lead.Cumulative_Time__c);
                    updatedlistOfLeads.add(lead);
                }
            }
            /* ADD */  
        }
        
        system.debug('--------Testing Lead Update Call--------->>');
        if(!System.Test.isRunningTest())
            Update updatedlistOfLeads;   
        
    }
    
    public static void onBeforeInsert(list<Counseling_Session__c> newList)
    {
        for(Counseling_Session__c newSession : newList){
              if( newSession.Note__c!=null ){
                  
                  Timezone tz = Timezone.getTimeZone('America/Los_Angeles');
                  DateTime pst =  DateTime.newInstance(System.Now().getTime() + tz.getOffset(System.Now()));                
                  newSession.Note__c= newSession.Note__c +' '+ pst;
                  
                  //newSession.Note__c= newSession.Note__c +' '+ System.Now();
              }
         }
    }
     public static void onBeforeUpdate(list<Counseling_Session__c> newList, list<Counseling_Session__c> oldList, map<id,Counseling_Session__c> oldMap)
    {
        for(Counseling_Session__c newSession : newList){
              Counseling_Session__c  oldSession = oldMap.get(newSession.Id);
              if( oldSession.Note__c!= newSession.Note__c ){
                  /* Conversion of PDT to PST  */
                  Timezone tz = Timezone.getTimeZone('America/Los_Angeles');
                  DateTime pst =  DateTime.newInstance(System.Now().getTime() + tz.getOffset(System.Now()));                
                  newSession.Note__c= newSession.Note__c +' '+ pst;
                  
                  /* PDT Time Zone
                   *  newSession.Note__c= newSession.Note__c +' '+ System.Now();  */                  
              }
         }
    }
}