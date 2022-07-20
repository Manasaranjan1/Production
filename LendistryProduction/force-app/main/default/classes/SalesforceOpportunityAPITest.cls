@isTest
public class SalesforceOpportunityAPITest {
    
    private static Opportunity getOpportunity(){
        Opportunity opp =  new Opportunity();
        opp.name = 'Test';
        opp.StageName = 'Packaging';
        opp.CloseDate = System.today();
        opp.Origination_Fee__c = '15';
        opp.Projected_Close_Date__c = System.today();
        opp.Referral_Partner_Fee__c = 10;
        opp.Partner_Referral_Fee__c = '2.00';
        return opp;
    }

    private static RestRequest setTestRestRequest(String requestBodyString, String url, String requestType) {
        RestRequest req = new RestRequest();
        req.requestURI = url; 
        req.httpMethod = requestType;
        req.requestBody = Blob.valueof(requestBodyString);
        return req;
        
    }

    @isTest
    public static void stageOpportunity(){
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity opp =  getOpportunity();
        opp.StageName = 'Docs Out';
        oppList.add(opp);
        Opportunity opp1 =  getOpportunity();
        opp1.StageName = 'Sales Review';
        oppList.add(opp1);
        insert oppList;

        String requestBodyString = '[{"stagename":"Docs Out","Sales_Business_Id":"1234567","Opportunity_Id":"'+oppList[0].Id+'","daysinStage":12},';
            requestBodyString = requestBodyString + '{"stagename":"Sales Review","Sales_Business_Id":"12345677","Opportunity_Id":"'+oppList[1].Id+'","daysinStage":10}';
            requestBodyString = requestBodyString + ']';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceOpportuntyAPI/*','POST');
        RestContext.response = new RestResponse();
       
        List<SalesforceOpportuntyAPI.wrapper> OppWrapperList = new List<SalesforceOpportuntyAPI.wrapper>();

        Test.startTest();
            OppWrapperList = SalesforceOpportuntyAPI.getStageDaysOnOpportunity();
        Test.stopTest();

        System.AssertEquals(true,OppWrapperList.size()>0, 'OppWrapperList must have some value');
        
    }
    
    @isTest
    public static void stageOpportunityForPreQualOut(){
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity opp =  getOpportunity();
        opp.StageName = 'UW Sub';
        oppList.add(opp);
        Opportunity opp21  = opp.clone(false);
        opp21.StageName = 'PreQual Out';
        oppList.add(opp21);
        insert oppList;     
        

        String requestBodyString = '[{"stagename":"UW Sub","Sales_Business_Id":"1234567","Opportunity_Id":"'+oppList[0].Id+'","daysinStage":12},';
        requestBodyString = requestBodyString + '{"stagename":"PreQual Out","Sales_Business_Id":"12345678","Opportunity_Id":"'+oppList[1].Id+'","daysinStage":11}';
        requestBodyString = requestBodyString + ']';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceOpportuntyAPI/*','POST');
        RestContext.response = new RestResponse(); 
        List<SalesforceOpportuntyAPI.wrapper> OppWrapperList = new List<SalesforceOpportuntyAPI.wrapper>();
        
        Test.startTest();
           
            OppWrapperList = SalesforceOpportuntyAPI.getStageDaysOnOpportunity();
        Test.stopTest();

        System.AssertEquals(true,OppWrapperList.size()>0, 'OppWrapperList must have some value');  
    }
    
    @isTest
    public static void stageOpportunityForProcessingSubAndCONAPP(){
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity opp =  getOpportunity();
        opp.StageName = 'Processing Sub';
        oppList.add(opp);
        Opportunity opp21  = opp.clone(false);
        opp21.StageName = 'CON APP OUT';
        oppList.add(opp21);
        insert oppList;     
        
        String requestBodyString = '[{"stagename":"Processing Sub","Sales_Business_Id":"1234567","Opportunity_Id":"'+oppList[0].Id+'","daysinStage":12},';
        requestBodyString = requestBodyString + '{"stagename":"CON APP OUT","Sales_Business_Id":"12345678","Opportunity_Id":"'+oppList[1].Id+'","daysinStage":11}';
        requestBodyString = requestBodyString + ']';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceOpportuntyAPI/*','POST');
        RestContext.response = new RestResponse();
        List<SalesforceOpportuntyAPI.wrapper> OppWrapperList = new List<SalesforceOpportuntyAPI.wrapper>();
        
        Test.startTest();
           
            OppWrapperList = SalesforceOpportuntyAPI.getStageDaysOnOpportunity();
        Test.stopTest();

        System.AssertEquals(true,OppWrapperList.size()>0, 'OppWrapperList must have some value');  
    }
    
    @isTest
    public static void stageOpportunityFoPackagingAndUW(){
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity opp = getOpportunity();
        opp.StageName = 'Packaging';
        oppList.add(opp);
        Opportunity opp21  = opp.clone(false);
        opp21.StageName = 'UW';
        oppList.add(opp21);
        insert oppList;     
        
        String requestBodyString = '[{"stagename":"Packaging","Sales_Business_Id":"1234567","Opportunity_Id":"'+oppList[0].Id+'","daysinStage":12},';
        requestBodyString = requestBodyString + '{"stagename":"UW","Sales_Business_Id":"12345678","Opportunity_Id":"'+oppList[1].Id+'","daysinStage":11}';
        requestBodyString = requestBodyString + ']';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceOpportuntyAPI/*','POST');
        RestContext.response = new RestResponse();
        List<SalesforceOpportuntyAPI.wrapper> OppWrapperList = new List<SalesforceOpportuntyAPI.wrapper>();
        
        Test.startTest();
           
            OppWrapperList = SalesforceOpportuntyAPI.getStageDaysOnOpportunity();
        Test.stopTest();

        System.AssertEquals(true,OppWrapperList.size()>0, 'OppWrapperList must have some value');  
    }
    
     @isTest
    public static void stageOpportunityFoSubforReviewAndSubforApproval(){
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity opp =  getOpportunity();
        opp.StageName = 'Sub for Review';
        oppList.add(opp);
        Opportunity opp21  = opp.clone(false);
        opp21.StageName = 'Sub for Approval';
        oppList.add(opp21);
        insert oppList;     
       
        String requestBodyString = '[{"stagename":"Sub for Review","Sales_Business_Id":"1234567","Opportunity_Id":"'+oppList[0].Id+'","daysinStage":12},';
        requestBodyString = requestBodyString + '{"stagename":"Sub for Approval","Sales_Business_Id":"12345678","Opportunity_Id":"'+oppList[1].Id+'","daysinStage":11}';
        requestBodyString = requestBodyString + ']';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceOpportuntyAPI/*','POST');
        RestContext.response = new RestResponse();
        List<SalesforceOpportuntyAPI.wrapper> OppWrapperList = new List<SalesforceOpportuntyAPI.wrapper>();
        
        Test.startTest();
           
            OppWrapperList = SalesforceOpportuntyAPI.getStageDaysOnOpportunity();
        Test.stopTest();

        System.AssertEquals(true,OppWrapperList.size()>0, 'OppWrapperList must have some value');  
    }
    
    @isTest
    public static void stageOpportunityForCLOutAndDocsOut(){
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity opp =  getOpportunity();
        opp.StageName = 'CL Out';
        oppList.add(opp);
        Opportunity opp21  = opp.clone(false);
        opp21.StageName = 'Docs Out';
        oppList.add(opp21);
        insert oppList;     
        
        String requestBodyString = '[{"stagename":"CL Out","Sales_Business_Id":"1234567","Opportunity_Id":"'+oppList[0].Id+'","daysinStage":12},';
        requestBodyString = requestBodyString + '{"stagename":"Docs Out","Sales_Business_Id":"12345678","Opportunity_Id":"'+oppList[1].Id+'","daysinStage":11}';
        requestBodyString = requestBodyString + ']';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceOpportuntyAPI/*','POST');
        RestContext.response = new RestResponse(); 
        List<SalesforceOpportuntyAPI.wrapper> OppWrapperList = new List<SalesforceOpportuntyAPI.wrapper>();
        
        Test.startTest();
           
            OppWrapperList = SalesforceOpportuntyAPI.getStageDaysOnOpportunity();
        Test.stopTest();

        System.AssertEquals(true,OppWrapperList.size()>0, 'OppWrapperList must have some value');  
    }
    
    @isTest
    public static void stageOpportunityFoPendingforClosingAndSuspended(){
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity opp =  getOpportunity();
        opp.StageName = 'Pending for Closing';
        oppList.add(opp);
        Opportunity opp21  = opp.clone(false);
        opp21.StageName = 'Suspended';
        oppList.add(opp21);
        insert oppList;     
        
        String requestBodyString = '[{"stagename":"Pending for Closing","Sales_Business_Id":"1234567","Opportunity_Id":"'+oppList[0].Id+'","daysinStage":12},';
        requestBodyString = requestBodyString + '{"stagename":"Suspended","Sales_Business_Id":"12345678","Opportunity_Id":"'+oppList[1].Id+'","daysinStage":11}';
        requestBodyString = requestBodyString + ']';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceOpportuntyAPI/*','POST');
        RestContext.response = new RestResponse();
        List<SalesforceOpportuntyAPI.wrapper> OppWrapperList = new List<SalesforceOpportuntyAPI.wrapper>();
        
        Test.startTest();
           
            OppWrapperList = SalesforceOpportuntyAPI.getStageDaysOnOpportunity();
        Test.stopTest();

        System.AssertEquals(true,OppWrapperList.size()>0, 'OppWrapperList must have some value');  
    }
    
     @isTest
    public static void stageOpportunityFoMissedOppAndSubforApproval(){
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity opp =  getOpportunity();
        opp.StageName = 'Missed Opp';
        opp.Decline_Withdrawn_Reason__c = 'Changed My Mind';
        opp.Status__c = 'Closing Withdrawn';
        opp.What_does_your_Business_do__c = 'Manufacturer';
        opp.What_type_of_Business_is_it__c = 'Food Products';
        opp.Tell_us_more__c = 'Meat and Dairy';
        oppList.add(opp);
        Opportunity opp1  = opp.clone(false);
        opp1.StageName = 'Funded';
        opp1.Decline_Withdrawn_Reason__c = '';
        opp1.Status__c = '';
        opp1.What_does_your_Business_do__c = 'Construction Business ';
        opp1.What_type_of_Business_is_it__c = 'Special Trade Contractor';
        opp1.Tell_us_more__c = 'Masonary, Stonework, Tile and plastering';
        oppList.add(opp1);
        insert oppList;     
        
        String requestBodyString = '[{"stagename":"Missed Opp","Sales_Business_Id":"1234567","Opportunity_Id":"'+oppList[0].Id+'","daysinStage":12}';
        requestBodyString = requestBodyString + ',{"stagename":"Funded","Sales_Business_Id":"12345678","Opportunity_Id":"'+oppList[1].Id+'","daysinStage":11}';
        requestBodyString = requestBodyString + ']';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceOpportuntyAPI/*','POST');
        RestContext.response = new RestResponse();
        List<SalesforceOpportuntyAPI.wrapper> OppWrapperList = new List<SalesforceOpportuntyAPI.wrapper>();
        
        Test.startTest();
           
            OppWrapperList = SalesforceOpportuntyAPI.getStageDaysOnOpportunity();
        Test.stopTest();

        System.AssertEquals(true,OppWrapperList.size()>0, 'OppWrapperList must have some value');  
    }
    
    @isTest
    public static void stageOpportunityFoMException(){
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity opp =  getOpportunity();
        opp.StageName = 'Missed Opp';
        opp.Decline_Withdrawn_Reason__c = 'Changed My Mind';
        opp.Status__c = 'Closing Withdrawn';
        opp.What_does_your_Business_do__c = 'Manufacturer';
        opp.What_type_of_Business_is_it__c = 'Food Products';
        opp.Tell_us_more__c = 'Meat and Dairy';
        oppList.add(opp);
        Opportunity opp1  = opp.clone(false);
        opp1.StageName = 'Funded';
        opp1.Decline_Withdrawn_Reason__c = '';
        opp1.Status__c = '';
        opp1.What_does_your_Business_do__c = 'Construction Business ';
        opp1.What_type_of_Business_is_it__c = 'Special Trade Contractor';
        opp1.Tell_us_more__c = 'Masonary, Stonework, Tile and plastering';
        oppList.add(opp1);
        insert oppList;     
        
        String requestBodyString = '[{"stagename":"Missed Opp","Sales_Business_Id":"1234567","Opportunity_Id":"'+oppList[0].Id+'","daysinStage":12}';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceOpportuntyAPI/*','POST');
        RestContext.response = new RestResponse();
        List<SalesforceOpportuntyAPI.wrapper> OppWrapperList = new List<SalesforceOpportuntyAPI.wrapper>();
        Test.startTest();
             OppWrapperList = SalesforceOpportuntyAPI.getStageDaysOnOpportunity();   
        Test.stopTest();

        System.AssertEquals(true,OppWrapperList.size()==0, 'OppWrapperList should be empty, due to bad request');  
    }

    @isTest
    public static void updateSalesScreenDatatoSFForException(){
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity opp =  getOpportunity();
        opp.StageName = 'UW Sub';
        oppList.add(opp);
        insert oppList;     
        
        String requestBodyString = '[{"stagename":"UW Sub","Sales_Business_Id":"1234567","Opportunity_Id":"'+oppList[0].Id+'","daysinStage":12}';
        requestBodyString = requestBodyString + ']';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceOpportuntyAPI/*','POST');
        RestContext.response = new RestResponse();
        List<SalesforceOpportuntyAPI.wrapper> OppWrapperList = new List<SalesforceOpportuntyAPI.wrapper>();
        
        Test.startTest();
           
            String response = SalesforceOpportuntyAPI.updateSalesScreenDatatoSF();
        Test.stopTest();

        System.AssertEquals(true,String.isNotEmpty(response), 'response must have some value');  
    }

    @isTest
    public static void updateSalesScreenDatatoSF(){
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity opp =  getOpportunity();
        opp.StageName = 'UW Sub';
        opp.BusinessId__c = '1234567';
        oppList.add(opp);
        Opportunity opp21  = opp.clone(false);
        opp21.StageName = 'PreQual Out';
        oppList.add(opp21);
        insert oppList;     
        
        String requestBodyString = '{"stagename":"Missed Opp","Sales_Business_Id":"1234567","Opportunity_Id":"'+oppList[0].Id+'","daysinStage":12,"processing_fee":"10.0","referral_part_fee":"10.0","sales_decline_reason":"Credit","loan_type":"Bridge Loan"}';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceOpportuntyAPI/*','POST');
        RestContext.response = new RestResponse();
        List<SalesforceOpportuntyAPI.wrapper> OppWrapperList = new List<SalesforceOpportuntyAPI.wrapper>();
        
        Test.startTest();
           
            String response = SalesforceOpportuntyAPI.updateSalesScreenDatatoSF();
        Test.stopTest();

        System.AssertEquals(true,String.isNotEmpty(response), 'response must have some value');  
    }
}