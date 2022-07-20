public class IntegrationLogCls3 {
    public List<Portal_Integration_Response_Code__c> listOfLogs {get;set;}
        public String searchKey {get;set;}

    public IntegrationLogCls3(){
        listOfLogs = [SELECT  Opportunity_Id__c,Success_Error_Code__c,Request__c,Response__c, Application_ID__c,Lead_Id__c,CreatedDate,Business_Id__c from Portal_Integration_Response_Code__c order by CreatedDate DESC LIMIT 20000 ];
        if(listOfLogs == null){
            listOfLogs = new List<Portal_Integration_Response_Code__c>();
        }
    }
    public void search(){
        if( searchKey != null && searchKey != '')
        listOfLogs = [SELECT  Opportunity_Id__c,Success_Error_Code__c,Request__c,Response__c,Application_ID__c,Lead_Id__c,CreatedDate,Business_Id__c from Portal_Integration_Response_Code__c Where Application_ID__c=:searchKey LIMIT 20000];
        else
            listOfLogs = [SELECT  Opportunity_Id__c,Success_Error_Code__c,Request__c,Response__c,Application_ID__c,Lead_Id__c,CreatedDate,Business_Id__c from Portal_Integration_Response_Code__c LIMIT 20000];
    }
}