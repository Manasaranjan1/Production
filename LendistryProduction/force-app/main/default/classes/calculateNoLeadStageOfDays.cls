public class calculateNoLeadStageOfDays{
    public static void updateNoOfDays(List<Lead> listOfLead){
        //query history
         List<Holiday> holidays=[Select h.StartTimeInMinutes, h.Name, h.ActivityDate From Holiday h];
        map<String,List<Lead_History__c>> mapOfStatusWithHistoryList = new map<String,List<Lead_History__c>>();
        List<Lead_History__c> listOfHistory=[select id,Name,Lead__c ,Lead_Status__c ,Status_Start_Date__c,Lead_End_Date__c  
                                                from Lead_History__c where Lead__c in : listOfLead ];
         if(listOfHistory !=null && listOfHistory.size()>0){
             for(Lead_History__c objHis : listOfHistory){
                 if(mapOfStatusWithHistoryList.containsKey(objHis.Lead_Status__c )){
                    mapOfStatusWithHistoryList.get(objHis.Lead_Status__c).add(objHis );
                }
                else{
                    mapOfStatusWithHistoryList.put(objHis.Lead_Status__c, new List<Lead_History__c>{objHis });
                }
             }
         } 
         system.debug('mapOfStatusWithHistoryList'+mapOfStatusWithHistoryList);
         for(Lead objLead : listOfLead){
             
             for(String  str : mapOfStatusWithHistoryList.keySet()){
              List<Lead_History__c> dummyHistory = mapOfStatusWithHistoryList.get(str);
              Integer dayCounter=0;
              for(Lead_History__c his : dummyHistory ){
                  if(his.Lead__c == objLead.Id){
                  Date endDate;
                 if(his.Lead_End_Date__c  ==null)
                    endDate = Date.today();
                 else
                    endDate = his.Lead_End_Date__c;
                    
                Date startDate = his.Status_Start_Date__c ;
                Integer daysValue = weekdaysCalculate(startDate,endDate ,holidays );
                dayCounter= dayCounter +daysValue;
                //update Lead 
               
                if(his.Lead_Status__c =='New')
                     objLead.of_Days_in_New__c = dayCounter;
                if(his.Lead_Status__c =='Pending Follow up')
                     objLead.of_Days_in_Pending_Follow_up__c = dayCounter;
                if(his.Lead_Status__c =='Nurturing')
                     objLead.of_Days_in_Nurturing__c = dayCounter;
                if(his.Lead_Status__c =='Qualified')
                     objLead.of_Days_in_Qualified__c = dayCounter;
                if(his.Lead_Status__c =='Unqualified')
                    objLead.of_Days_in_Unqualified__c  = dayCounter;
                if(his.Lead_Status__c =='Qualified (Center)')
                     objLead.of_Days_in_Qualified_Center__c= dayCounter;
                if(his.Lead_Status__c =='Identification')
                     objLead.of_Days_in_Identification__c = dayCounter;
                if(his.Lead_Status__c =='Qualification')
                     objLead.of_Days_in_Qualification__c = dayCounter;
                if(his.Lead_Status__c =='Cultivation')
                     objLead.of_Days_in_Cultivation__c = dayCounter;
                if(his.Lead_Status__c =='Solicitation')
                     objLead.of_Days_in_Solicitation__c= dayCounter;   
                if(his.Lead_Status__c =='Stewardship')
                     objLead.of_Days_in_Stewardship__c = dayCounter;
                if(his.Lead_Status__c =='Not A Prospect')
                     objLead.of_Days_in_Not_A_Prospect__c= dayCounter;
                system.debug('dayCounterdayCounter'+dayCounter);
                  }
              }
          }
         }
         
         // here calculate status no of days 
           
         update listOfLead;                                    
   }
    // calculate days
    public static Integer weekdaysCalculate(Date date1 , Date date2 ,List<Holiday> holidays){
       
        
        Integer allDaysBetween = date1.daysBetween(date2);
        Integer allWorkingDays=0;
        for(Integer k=0;k<allDaysBetween ;k++ ){
            if(checkifItisWorkingDay(date1.addDays(k),holidays)){
                allWorkingDays++;
            }
        }
        system.debug('>>>>>>>>>'+allWorkingDays);
        return allWorkingDays;
    
    }
    
    public static boolean checkifItisWorkingDay(Date currentDate,List<Holiday> holidays){
        Date weekStart  = currentDate.toStartofWeek();
        for(Holiday hDay:holidays){
            if(currentDate.daysBetween(hDay.ActivityDate) == 0){
                return false;
            }
        }
        if(weekStart.daysBetween(currentDate) ==0 || weekStart.daysBetween(currentDate) == 6){
            return false;
        } else
        return true;
}
}