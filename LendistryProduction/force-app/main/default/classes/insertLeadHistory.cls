public class insertLeadHistory{
    public static void createHistory(List<Lead> listOfLead){
        //query history
         List<Lead_History__c> listOfHistoryInserted = new List<Lead_History__c>(); 
        for(Lead objLead : listOfLead){
            Lead_History__c objHistory = new Lead_History__c();
            //objHistory.Name = objLead.Name;
            objHistory.Lead__c = objLead.Id;
            objHistory.Lead_Status__c = objLead.Status;
            objHistory.Status_Start_Date__c =Date.today();
            //objHistory.Name = objLead.Name;
            listOfHistoryInserted.add(objHistory);
        }
        if(listOfHistoryInserted !=null && listOfHistoryInserted.size()>0)
            insert listOfHistoryInserted;      
    }
    
    // update history
    public static void updateAndInsertHistory(List<Lead> listOfLead ){
         List<Lead_History__c> listOfHistory = [select id,Lead__c ,Lead_End_Date__c from 
                                                 Lead_History__c where Lead__c  in : listOfLead and 
                                                 Lead_End_Date__c  =null order by createdDate];
         if(listOfHistory !=null && listOfHistory.size()>0){                                        
             for(Lead_History__c oldHistory : listOfHistory ){
                 oldHistory.Lead_End_Date__c = Date.today();
             }
         }
         update listOfHistory; 
         createHistory(listOfLead );                                       
         
    }
}