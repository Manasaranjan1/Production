@isTest(SeeAllData=true)
public class IntegrationLogCls3_Test {
    public static testMethod void method1(){
        Portal_Integration_Response_Code__c pai = new Portal_Integration_Response_Code__c();        
        pai.API_Name__c = 'testapi';
        pai.Application_ID__c = 'testappl';
        pai.Business_Id__c = 'testbusi';
        pai.Credit_Report_ID__c = 'testcredit';
        pai.exception__c = 'testes';
        pai.IsSyncWithPortal__c = true;
        pai.Lead_Id__c = 'testles';
        pai.Method_Name__c = 'testmethod';
        pai.Opportunity_Id__c = 'testopp';
        pai.Primary_Owner_Id__c = 'testprim';
        pai.Request__c = 'testreq';
        pai.Response__c = 'testres';
        pai.Success_Error_Code__c = 'testsucc';             
        insert pai;
      
         ApexPages.CurrentPage().getparameters().put('id', pai.id); 
        ApexPages.StandardController sc = new ApexPages.StandardController(pai);
        
        IntegrationLogCls3 ext = new IntegrationLogCls3();
        ext.search();
               
    }
}