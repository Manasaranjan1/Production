public class TimeTrackingTriggerHandler {
    set<id> setOfIds = new set<id>();
    
    public void updateCounselingSession(List<Time_Tracker__c> trackerList, Boolean afterUpdate) {
        List<Counseling_Session__c> updatedcsessionList = new List<Counseling_Session__c>();
        decimal sumOfHours=0.0 ;
        decimal sumOfMinutes=0.0 ;
        for (Time_Tracker__c tt: trackerList) {
            setOfIds.add(tt.Counseling_Session__c);
        }   
        List<Counseling_Session__c> csessionList = [select id, Cumulative_Time2__c, (select id, THours__c, TMinutes__c from Time_Trackers__r ) from Counseling_Session__c where id in:setOfIds];
        
        /* For Update Event */     
        if(afterUpdate==True){    //Trigger.isUpdate = afterUpdate
        system.debug('CumulativeTimeFlag.flag1111111'+CumulativeTimeFlag.flag);
            if(CumulativeTimeFlag.flag==False || System.test.isRunningTest()) {                       
                if(csessionList  != null && csessionList.size()>0){        
                    for(Counseling_Session__c cs: csessionList) {                            
                        integer childCount = cs.Time_Trackers__r.size();
                        System.debug('No of Childs :'+childCount); 
                        if(childCount>0) {             
                            for(Time_Tracker__c tt: cs.Time_Trackers__r) {    
                                sumOfHours = sumOfHours + (tt.THours__c)*1.0;   
                                sumOfMinutes = sumOfMinutes + (tt.TMinutes__c)*1.0;                                   
                            }                  
                        }           
                        double cumulatedTime = sumOfHours*1.0 + Integer.valueOf(sumOfMinutes/60)*1.0 + Double.valueOf(System.math.mod(Integer.valueOf(sumOfMinutes),60))/100;
                        
                        cs.Cumulative_Time2__c = cumulatedTime;
                        updatedcsessionList.add(cs);
                        System.debug('**** update ****');
                    }
                }
                CumulativeTimeFlag.flag=True;     
            }        
        } 
        else {
            
            /* For Non Update events */
            if(csessionList  != null && csessionList.size()>0){         
                for(Counseling_Session__c cs: csessionList) {        
                    
                    integer childCount = cs.Time_Trackers__r.size();    
                    System.debug('No of Childs :'+childCount); 
                    if(childCount>0) {             
                        for(Time_Tracker__c tt: cs.Time_Trackers__r) {    
                            sumOfHours = sumOfHours + (tt.THours__c)*1.0;   
                            sumOfMinutes = sumOfMinutes + (tt.TMinutes__c)*1.0;                                   
                        }                  
                    }
                    
                    double cumulatedTime = sumOfHours*1.0 + Integer.valueOf(sumOfMinutes/60)*1.0 + Double.valueOf(System.Math.mod(Integer.valueOf(sumOfMinutes),60))/100;
                    
                    cs.Cumulative_Time2__c = cumulatedTime;   
                    
                    System.debug('****insert delete undelete ****');
                    //System.debug(cs.Cumulative_Time2__c);
                    updatedcsessionList.add(cs);
                }
            }         
        }
        
        Update updatedcsessionList;   
    }
}