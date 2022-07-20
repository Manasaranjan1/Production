@istest
public class JavaAPICallOutNoOfDays_Test {
    public static String commonMethod(String stage){
        Opportunity opp = new Opportunity();
        opp.Name = 'testname';
        opp.StageName = stage;
        opp.CloseDate = date.today();
        opp.Origination_Fee__c ='200';
        opp.BusinessId__c = 'jhvuvu';
        insert opp;
        return opp.Id;
    }
    static testmethod void method1(){
      JSON2ApexListOfOpportunityResponse  objRes =  new JSON2ApexListOfOpportunityResponse();
      objRes.businessId ='1234';
      objRes.opportunityId=commonMethod('Sales Review');
      objRes.isUpdated =true;
      List<JSON2ApexListOfOpportunityResponse> listJson = new List<JSON2ApexListOfOpportunityResponse>{objRes};
      JSON2ApexListOfOpportunityResponse.parse(JSON.serialize(listJson ));
          String query ='Select Id,BusinessId__c, StageName, of_Days_in_Sales_Review__c, of_Days_in_PreQual_Out__c, of_Days_in_Processing_Sub__c, of_Days_in_UW_Sub__c, of_days_in_CON_APP_OUT__c, of_Days_in_Packaging__c, of_Days_in_UW__c, of_days_in_Sub_for_Review__c, of_Days_in_Sub_for_Approval__c, of_Days_in_CL_Out__c, of_Days_in_Docs_Out__c, of_Days_in_Pending_for_Closing__c, of_days_in_Suspended__c, of_days_in_Missed_Opp__c  From Opportunity where  Stagename!=\'New\' and stageName !=\'Funded\''; 
        
        Set<String> setOfstring = new Set<String>();
        
       setOfstring.add(commonMethod('Sales Review'));
        Test.startTest();
          Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock()); 
           //System.enqueueJob(new sendNoOfDaysQueueable (setOfstring));     
            JavaAPICallOutNoOfDays.sendListOfOpportunity(setOfString);    
        Test.stopTest();
          
    }


}