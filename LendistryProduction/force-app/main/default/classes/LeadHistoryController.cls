public without sharing class LeadHistoryController{
    @AuraEnabled
    public static List<HistoryWrapper > getLeadHistory(String leadId){
        List<Holiday> holidays=[Select h.StartTimeInMinutes, h.Name, h.ActivityDate From Holiday h];
        List<HistoryWrapper> listOfWrapper = new List<HistoryWrapper>();
        map<String,List<Lead_History__c>> mapOfStatusWithHistoryList = new map<String,List<Lead_History__c>>();
        List<Lead_History__c> listOfHistory =[select id,Lead__c,Lead_End_Date__c,Lead_Status__c,Stage_Duration__c,Status_Start_Date__c from 
                                                 Lead_History__c where    Lead__c=:leadId and Lead_End_Date__c !=null
        
                                                ];
         if(listOfHistory !=null && listOfHistory.size()>0){
             for(Lead_History__c objHis : listOfHistory){
                 Date endDate;
                 if(objHis.Lead_End_Date__c  ==null)
                    endDate = Date.today();
                 else
                    endDate = objHis.Lead_End_Date__c;
                    
                Date startDate = objHis.Status_Start_Date__c ;
                Integer daysValue = calculateNoLeadStageOfDays.weekdaysCalculate(startDate,endDate ,holidays );
                HistoryWrapper objWrap = new HistoryWrapper();
                objWrap.status= objHis.Lead_Status__c;
                objWrap.endDate= String.valueOf(objHis.Lead_End_Date__c);
                objWrap.startDate = String.valueOf(objHis.Status_Start_Date__c) ;
                objWrap.noOfDays = daysValue;
                listOfWrapper.add(objWrap);
             }
         } 
         
                                      
        return listOfWrapper;
    }
    
    // wrapper
    public class HistoryWrapper{
        @AuraEnabled
        public String status;
        @AuraEnabled
        public String startDate;
        @AuraEnabled
        public String endDate;
        @AuraEnabled
        public Integer noOfDays;        
    }
    
}