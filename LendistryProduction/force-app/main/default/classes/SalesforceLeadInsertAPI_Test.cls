@isTest(seeAlldata=true)
public class SalesforceLeadInsertAPI_Test{
    //Insert User
   
    public static user userObj = new User();
    
    Public static testmethod  void CreateLead(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
      //  Tenant_Details__c TDC = [Select ID,Tenant_Name__c from Tenant_Details__c LIMIT 1];
        //  userObj =  ;
        userObj.Alias = 'standt';
        userObj.Email='standarduser@testorg.com'; 
        userObj.EmailEncodingKey='UTF-8';
        userObj.LastName='Testing';
        userObj.LanguageLocaleKey='en_US';
        userObj.LocaleSidKey='en_US';
        userObj.ProfileId = p.Id;
        userObj.TimeZoneSidKey='America/Los_Angeles';
        userObj.UserName='betaCharlie@aaCharlie.com';
        insert userObj;
        
         Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());
        
        Lead objLead = new Lead();
        objLead.Title = 'Mr.';
        objLead.FirstName = 'FirstName';
        objLead.LastName = 'test';
        objLead.Company = 'Test';
        objlead.Base64_Encoded_Pardot_Url_Parameter__c = 'MDBRMmEwMDAwMDVPbkxGRUEwfHwwMi4wMi4yMDIwIDE5OjAw';
        objLead.Entity_Type__c = 'Corporation';
        objlead.DoNotCall = false;
        objlead.HasOptedOutOfFax = false;
        objlead.Phone = '999-999-9999';
        objlead.pi__Needs_Score_Synced__c = false;
        objlead.pi__pardot_hard_bounced__c = false;
        objlead.Run_Credit_Report__c = false;
        objlead.Run_Owner2_Credit_Report__c = false;
        objlead.Run_Owner3_Credit_Report__c = false;
        objlead.Run_Owner4_Credit_Report__c = false;
        objlead.Run_Owner5_Credit_Report__c = false;
        objLead.Status = 'New';
        objLead.Status_Detail__c = 'New';
        //objLead.Tenant_Details__c = TDC.id;
        
        objlead.SSN1__c = '000-00-0001';
        objLead.Street_Owner_1__c='220 Locust Ave';
        objLead.City_Owner_1__c = 'Anthill';
        objLead.State_Owner_1__c='MO';
        objLead.Zip_Code_Owner_1__c='65488';
        objLead.Country_Owner_1__c='US';
        objLead.Email = 'first@gmail.com';
        objLead.Was_Your_Business_Profitable_In_2019__c = 'Yes';
        
        objLead.of_Ownership_Owner__c = 20;
        objLead.Credit_Score__c = 'under 600'; 
        objLead.Run_Credit_Report__c= true;
        objlead.Owner_ID_Owner_1__c = '123';
        objlead.Credit_Score_5th_Owner_from_Webform__c = 'Over 700';
        
        //Second Owner Details
        objLead.Title_2nd_Owner__c = 'Ms';
        objLead.First_Name_2nd_Owner__c = 'SecondName';
        objLead.Last_Name_2nd_Owner__c = 'LastName';
        objLead.SSN2__c = '000-00-0001';
        objLead.Street_Owner_2__c = '220 Locust Ave';
        objLead.State_Owner_2__c = 'MO';
        objLead.Zip_Code_Owner_2__c = '65488';
        objLead.Country_Owner_2__c = 'US';
        objLead.Email_2nd_Owner__c = 'second@gmail.com';
        ObjLead.Phone_2nd_Owner__c = '999-999-9999';
        objLead.of_Ownership_Second_Owner__c = 20;
        objLead.City_Owner_2__c = 'Anthill';
        ObjLead.Credit_Score_2nd_Owner__c = '600 to 650';
        objLead.Run_Owner2_Credit_Report__c =true;
        objLead.Owner_ID_Owner_2__c = '124';
        
        //Third Owner Details
        objLead.First_Name_3rd_Owner__c = 'ThirdName';
        objLead.Last_Name_3rd_Owner__c = 'LastName';
        objLead.SSN_3rd_Owner__c = '000-00-0001';
        objLead.of_Ownership_3rd_Owner__c = 20;
        objLead.City_Owner_3__c = 'Anthill';
        objLead.Email_3rd_Owner__c = 'third@gmail.com';
        objLead.Street_Owner_3__c = '220 Locust Ave';
        objLead.State_Owner_3__c = 'MO';
        objLead.Title_3rd_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_3__c ='65488';
        objLead.Country_Owner_3__c = 'US';
        ObjLead.Credit_Score_3rd_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_3rd_Owner__c = '999-999-9999';
        objLead.Run_Owner3_Credit_Report__c =true;
        objLead.Owner_ID_Owner_3__c = '125';
        
        //Fourth Owner details
        objLead.First_Name_4th_Owner__c = 'FourthName';
        objLead.Last_Name_4th_Owner__c = 'LastName';
        objLead.SSN_4th_Owner__c = '000-00-0001';
        objLead.of_Ownership_4th_Owner__c = 5;
        objLead.City_Owner_4__c = 'Anthill';
        objLead.Email_4th_Owner__c = 'fourth@gmail.com';
        objLead.Street_Owner_4__c = '220 Locust Ave';
        objLead.State_Owner_4__c = 'MO';
        objLead.Title_4th_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_4__c = '65488';
        objLead.Country_Owner_4__c = 'US';
        ObjLead.Credit_Score_4th_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_4th_Owner__c = '999-999-9999';
        objLead.Run_Owner4_Credit_Report__c=true;
        objLead.Owner_ID_Owner_4__c = '126';
        
        //Fifth Owner Details
        objLead.First_Name_5th_Owner__c = 'FifthName';
        objLead.Last_Name_5th_Owner__c = 'LastName';
        objLead.SSN_5th_Owner__c = '000-00-0001';
        objLead.of_Ownership_5th_Owner__c = 16;
        objLead.City_Owner_5__c = 'Anthill';
        objLead.Email_5th_Owner__c   = 'fifth@gmail.com';
        objLead.Street_Owner_5__c = '220 Locust Ave';
        objLead.State_Owner_5__c = 'MO';
        objLead.Title_5th_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_5__c = '65488';
        objLead.Country_Owner_5__c = 'US';
        ObjLead.Credit_Score_5th_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_5th_Owner__c = '999-999-9999';
        ObjLead.Run_Owner5_Credit_Report__c =true;
        objLead.Owner_ID_Owner_5__c = '127';
        
        objLead.Are_you_COD_30_60_90__c = ' Yes';
        objLead.AnnualRevenue = 2313;
        objLead.Brief_History_on_the_business__c = 'Testing';
        objLead.What_exactly_does_the_business_do__c = 'Test';
        objLead.Who_is_your_customer_base__c = 'test';
        objLead.Do_You_Carry_Life_Insurance__c = 'test';
        objLead.Planned_Changes_In_Next_6_Months__c = 'test';
        objLead.Brief_History_on_the_owner_manager__c = 'test';
        objLead.What_are_the_terms_of_your_current_lease__c = 'test';
        objLead.Who_is_your_customer_base__c = 'test';
        objLead.Who_is_Your_Customer_Base1__c = 'B2B';
        objLead.Do_you_pay_child_support_or_alimony__c = 'yes';
        objLead.Explanation_of_any_BKs_defaults_etc__c = 'Test';
        objLead.Industry = 'Banking';
        objLead.Profitable_Last_2_Years__c = 'Yes';
        objLead.Requested_Amount__c = 50000 ;
        objLead.TIB_Months__c = '21';
        objLead.Use_of_Funds__c = 'Working Capital';
        objLead.What_are_the_terms_of_your_current_lease__c ='Testing';
        objLead.Are_you_COD_30_60_90__c = 'Testing';
        objLead.Brief_History_on_the_business__c = 'Testing'; 
        objLead.Brief_History_on_the_owner_manager__c = 'Testing';
        objLead.Who_is_your_customer_base__c = 'Testing';
        objLead.What_is_the_purpose_of_loan__c =  'Testing';
        objLead.What_are_the_terms_of_your_current_lease__c =  'Testing';
        objLead.Referral_type__c = 'BANK';
        objLead.What_does_your_Business_do__c = 'Service Business';
        objLead.What_type_of_Business_is_it__c = 'Entertainment';
        objLead.Tell_us_more__c = 'Full Service Restaurant';
        objLead.BusinessId__c = '1156';
      //  insert objLead;
        
    }
    
    private static user getuserByEmail(String LastName) {
        user use = [select ID from User where LastName = 'Testing'];
        return use;
    } 
    private static RestRequest setTestRestRequest(String requestBodyString, String url, String requestType) {
        RestRequest req = new RestRequest();
        req.requestURI = url; 
        req.httpMethod = requestType;
        req.requestBody = Blob.valueof(requestBodyString);
        return req;
        
    }
    
    @isTest
    public static void InserLeadForException(){
        String requestBodyString = '[{"FirstName":"Marisol L","LastName":"Testcase","Title":"","Description":"Java salesforce integration and creation lead call","Email":"a@gmail.com","Company":"test","ZipCode":"65488","LoanType":"PA CARES","RecordTypeId":"PA CARES","Status":"New","LeadSource":"Portal","Referral_Id":"'+userinfo.getUserId()+'"}]';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceLeadInsertAPI/*','POST');
        RestContext.response = new RestResponse();
        
        System.test.startTest();
        SalesforceLeadInsertAPI.insertLeadData();
        System.test.stopTest();
        
        //System.AssertEquals(true,OppWrapperList.size()>0, 'OppWrapperList must have some value');
       
    }
    
    @isTest
    public static void InserLead(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        String requestBodyString = '{"FirstName":"Marisol L","LastName":"Testcase","Title":"","Description":"Java salesforce integration and creation lead call","Email":"a@gmail.com","Business_Phone":"9817259860","Company":"test","Loan_Type__c":"PA CARES","ZipCode":"65488","Status":"New","RecordTypeId":"recTypeId","X0KSB_Scholar_Alumni__c":"Yes","LeadSource":"Portal","Referral_Id":"'+userinfo.getUserId()+'"}';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceLeadInsertAPI/*','POST');
        RestContext.response = new RestResponse();
        
       System.test.startTest();
        SalesforceLeadInsertAPI.insertLeadData();
        SalesforceLeadInsertAPI.deleteOwners();
        salesforceLeadInsertAPI.getLeadData();
        System.test.stopTest();
        
        // System.AssertEquals(true,OppWrapperList.size()>0, 'OppWrapperList must have some value');
        
    }
    
    @isTest
    public static void PatchLeadDataForException(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Lead objLead = new Lead();
        
        objLead.FirstName = 'Marisol L11';
        objLead.LastName = 'Testcase11';
        objlead.Title = 'Test1111';
        objlead.Description ='Java sal11esforce integration and creation lead call';
        objlead.Email = 'a@gmail.com';
        objlead.Company = 'tes11t';
        objlead.PostalCode = '65411';
        objlead.Status = 'New';
        objlead.LeadSource = 'Portal';
        objLead.Industry  = 'Agriculture';
        objLead.X0KSB_Scholar_Alumni__c = 'Yes';
        objLead.Was_Your_Business_Profitable_In_2019__c = 'Yes';
        objlead.OwnerId = userinfo.getUserId();
        try{
        Insert objlead;
        }Catch(Exception ex){}
        String requestBodyString = '{"LeadId":"objlead.Id","FirstName":"Marisol L","LastName":"Testcase","Title":"Test","Description":"Java salesforce integration and creation lead call","Email":"a@gmail.com","Company":"test","ZipCode":"65488","Status":"New","LeadSource":"Portal","WillThisLoanCreateMoreJobs":true,"Referral_Id":"'+userinfo.getUserId()+'"}';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceLeadInsertAPI/*','PATCH');
        RestContext.response = new RestResponse();
        
        System.test.startTest();
        SalesforceLeadInsertAPI.PatchLeadData();
        System.test.stopTest();
        
        // System.AssertEquals(true,OppWrapperList.size()>0, 'OppWrapperList must have some value');
        //System.assertEquals('Lead.Industry',Agriculture);
    }
    
    @isTest
    public static void getLeadDataTest(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Lead objLead = new Lead();
        
        objLead.Title = 'Mr.';
        objLead.FirstName = 'FirstName';
        objLead.LastName = 'test';
        objLead.Company = 'Test';
        objlead.Base64_Encoded_Pardot_Url_Parameter__c = 'MDBRMmEwMDAwMDVPbkxGRUEwfHwwMi4wMi4yMDIwIDE5OjAw';
        objLead.Entity_Type__c = 'Corporation';
        objlead.DoNotCall = false;
        objlead.HasOptedOutOfFax = false;
        objlead.Phone = '999-999-9999';
        objlead.pi__Needs_Score_Synced__c = false;
        objlead.pi__pardot_hard_bounced__c = false;
        objlead.Run_Credit_Report__c = false;
        objlead.Run_Owner2_Credit_Report__c = false;
        objlead.Run_Owner3_Credit_Report__c = false;
        objlead.Run_Owner4_Credit_Report__c = false;
        objlead.Run_Owner5_Credit_Report__c = false;
        objLead.Status = 'New';
        objLead.Status_Detail__c = 'New';
        objlead.SSN1__c = '000-00-0001';
        objLead.Street_Owner_1__c='220 Locust Ave';
        objLead.City_Owner_1__c = 'Anthill';
        objLead.State_Owner_1__c='MO';
        objLead.Zip_Code_Owner_1__c='65488';
        objLead.X0KSB_Scholar_Alumni__c = 'yes';
        objLead.Country_Owner_1__c='US';
        objLead.Email = 'first@gmail.com';
        objLead.of_Ownership_Owner__c = 20;
        objLead.Credit_Score__c = 'under 600'; 
        objLead.Run_Credit_Report__c= true;
        objlead.Owner_ID_Owner_1__c = '123';
        objlead.Credit_Score_5th_Owner_from_Webform__c = 'Over 700';
        objLead.DOB_Owner_1__c = Date.newInstance(1974,12,9);
        
        //Second Owner Details
        objLead.Title_2nd_Owner__c = 'Ms';
        objLead.First_Name_2nd_Owner__c = 'SecondName';
        objLead.Last_Name_2nd_Owner__c = 'LastName';
        objLead.SSN2__c = '000-00-0001';
        objLead.Street_Owner_2__c = '220 Locust Ave';
        objLead.State_Owner_2__c = 'MO';
        objLead.Zip_Code_Owner_2__c = '65488';
        objLead.Country_Owner_2__c = 'US';
        objLead.Email_2nd_Owner__c = 'second@gmail.com';
        ObjLead.Phone_2nd_Owner__c = '999-999-9999';
        objLead.of_Ownership_Second_Owner__c = 10;
        objLead.City_Owner_2__c = 'Anthill';
        ObjLead.Credit_Score_2nd_Owner__c = '600 to 650';
        objLead.Run_Owner2_Credit_Report__c =true;
        objLead.Owner_ID_Owner_2__c = '124';
        objLead.DOB_Owner_2__c = Date.newInstance(1974,12,9);
        
        //Third Owner Details
        objLead.First_Name_3rd_Owner__c = 'ThirdName';
        objLead.Last_Name_3rd_Owner__c = 'LastName';
        objLead.SSN_3rd_Owner__c = '000-00-0001';
        objLead.of_Ownership_3rd_Owner__c = 30;
        objLead.City_Owner_3__c = 'Anthill';
        objLead.Email_3rd_Owner__c = 'third@gmail.com';
        objLead.Street_Owner_3__c = '220 Locust Ave';
        objLead.State_Owner_3__c = 'MO';
        objLead.Title_3rd_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_3__c ='65488';
        objLead.Country_Owner_3__c = 'US';
        ObjLead.Credit_Score_3rd_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_3rd_Owner__c = '999-999-9999';
        objLead.Run_Owner3_Credit_Report__c =true;
        objLead.Owner_ID_Owner_3__c = '125';
        objLead.DOB_Owner_3__c =Date.newInstance(1974,12,9);
        
        //Fourth Owner details
        objLead.First_Name_4th_Owner__c = 'FourthName';
        objLead.Last_Name_4th_Owner__c = 'LastName';
        objLead.SSN_4th_Owner__c = '000-00-0001';
        objLead.of_Ownership_4th_Owner__c = 5;
        objLead.City_Owner_4__c = 'Anthill';
        objLead.Email_4th_Owner__c = 'fourth@gmail.com';
        objLead.Street_Owner_4__c = '220 Locust Ave';
        objLead.State_Owner_4__c = 'MO';
        objLead.Title_4th_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_4__c = '65488';
        objLead.Country_Owner_4__c = 'US';
        ObjLead.Credit_Score_4th_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_4th_Owner__c = '999-999-9999';
        objLead.Run_Owner4_Credit_Report__c=true;
        objLead.Owner_ID_Owner_4__c = '126';
        objLead.DOB_Owner_4__c = Date.newInstance(1974,12,9);
        
        //Fifth Owner Details
        objLead.First_Name_5th_Owner__c = 'FifthName';
        objLead.Last_Name_5th_Owner__c = 'LastName';
        objLead.SSN_5th_Owner__c = '000-00-0001';
        objLead.of_Ownership_5th_Owner__c = 6;
        objLead.City_Owner_5__c = 'Anthill';
        objLead.Email_5th_Owner__c   = 'fifth@gmail.com';
        objLead.Street_Owner_5__c = '220 Locust Ave';
        objLead.State_Owner_5__c = 'MO';
        objLead.Title_5th_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_5__c = '65488';
        objLead.Country_Owner_5__c = 'US';
        ObjLead.Credit_Score_5th_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_5th_Owner__c = '999-999-9999';
        ObjLead.Run_Owner5_Credit_Report__c =true;
        objLead.Owner_ID_Owner_5__c = '127';
        objLead.DOB_Owner_5__c = Date.newInstance(1974,12,9);
        
        
        objLead.Are_you_COD_30_60_90__c = ' Yes';
        objLead.AnnualRevenue = 2313;
        objLead.Brief_History_on_the_business__c = 'Testing';
        objLead.What_exactly_does_the_business_do__c = 'Test';
        objLead.Who_is_your_customer_base__c = 'test';
        objLead.Do_You_Carry_Life_Insurance__c = 'test';
        objLead.Planned_Changes_In_Next_6_Months__c = 'test';
        objLead.Brief_History_on_the_owner_manager__c = 'test';
        objLead.What_are_the_terms_of_your_current_lease__c = 'test';
        objLead.Who_is_your_customer_base__c = 'test';
        objLead.Do_you_pay_child_support_or_alimony__c = 'yes';
        objLead.Explanation_of_any_BKs_defaults_etc__c = 'Test';
        objLead.Industry = 'Banking';
        objLead.Profitable_Last_2_Years__c = 'Yes';
        objLead.Requested_Amount__c = 50000 ;
        objLead.TIB_Months__c = '21';
        objLead.Use_of_Funds__c = 'Working Capital';
        objLead.What_are_the_terms_of_your_current_lease__c ='Testing';
        objLead.Are_you_COD_30_60_90__c = 'Testing';
        objLead.Brief_History_on_the_business__c = 'Testing'; 
        objLead.Brief_History_on_the_owner_manager__c = 'Testing';
        objLead.Who_is_your_customer_base__c = 'Testing';
        objLead.What_is_the_purpose_of_loan__c =  'Testing';
        objLead.What_are_the_terms_of_your_current_lease__c =  'Testing';
        objLead.Referral_type__c = 'BANK';
        objLead.What_does_your_Business_do__c = 'Service Business';
        objLead.What_type_of_Business_is_it__c = 'Entertainment';
        objLead.Tell_us_more__c = 'Full Service Restaurant';
        objLead.BusinessId__c = '1156';
        objLead.OwnerId = userinfo.getUserId();
        objLead.LeadSource = 'Portal';
        //objLead.Business_Start_Date__c = Date.today();
        insert objLead;
        
      
        String requestBodyString = '{"LeadId":"'+objLead.Id+'","FirstName":"Marisol L","LastName":"Testcase","Title":"","Description":"Java salesforce","Email":"","Company":"test","ZipCode":"65488","Status":"New","LeadSource":"Portal","Referral_Id":"'+objLead.OwnerId+'"}';
        RestContext.request = setTestRestRequest(JSON.serialize(requestBodyString),'/services/apexrest/SalesforceLeadInsertAPI/*','Get');
        
        //RestContext.request.addParameter('id',objLead.Id);
        RestContext.response = new RestResponse();
        RestContext.request.requestURI = 'https://yourInstance.salesforce.com/services/apexrest/SalesforceLeadInsertAPI/'+objLead.Id;
        System.test.startTest();
        SalesforceLeadInsertAPI.getLeadData();
       
        System.test.stopTest();
       /*
        Id recordId = objLead.id;
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri ='https://yourInstance.salesforce.com/services/apexrest/SalesforceLeadInsertAPI/*'+ recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        SalesforceLeadInsertAPI.getLeadData();
        */
    }
    
    @isTest
    public static void getLeadDataTestForException(){
        Lead objLead = new Lead();
        String requestBodyString = '{"LeadId":"objLead.Id","FirstName":"Marisol L","LastName":"Testcase","Title":"","Description":"Java salesforce","Email":"","Company":"test","ZipCode":"65488","Status":"New","LeadSource":"Portal","Referral_Id":"'+objLead.OwnerId+'"}';
        //  requestBodyString = requestBodyString + ownerList;
        
        
        
        RestContext.request = setTestRestRequest(JSON.serialize(requestBodyString),'/services/apexrest/SalesforceLeadInsertAPI/*','Get');
        RestContext.request.addParameter('id','objLead.Id');
        RestContext.response = new RestResponse();
        
        System.test.startTest();
        //SalesforceLeadInsertAPI.getLeadData();
        System.test.stopTest();
        
        // System.AssertEquals(true,OppWrapperList.size()>0, 'OppWrapperList must have some value');
        
    }
    
    @isTest
    public static void PatchLeadData(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Lead objLead = new Lead();
        
        objLead.Title = 'Mr.';
        objLead.FirstName = 'FirstName';
        objLead.LastName = 'test';
        objLead.Company = 'Test';
        objlead.Base64_Encoded_Pardot_Url_Parameter__c = 'MDBRMmEwMDAwMDVPbkxGRUEwfHwwMi4wMi4yMDIwIDE5OjAw';
        objLead.Entity_Type__c = 'Corporation';
        objlead.DoNotCall = false;
        objlead.HasOptedOutOfFax = false;
        objlead.Phone = '999-999-9999';
        objlead.pi__Needs_Score_Synced__c = false;
        objlead.pi__pardot_hard_bounced__c = false;
        objlead.Run_Credit_Report__c = false;
        objlead.Run_Owner2_Credit_Report__c = false;
        objlead.Run_Owner3_Credit_Report__c = false;
        objlead.Run_Owner4_Credit_Report__c = false;
        objlead.Run_Owner5_Credit_Report__c = false;
        objLead.Status = 'New';
        objLead.Status_Detail__c = 'New';
        objLead.X0KSB_Scholar_Alumni__c = 'yes';
        objlead.SSN1__c = '000-00-0001';
        objLead.Street_Owner_1__c='220 Locust Ave';
        objLead.City_Owner_1__c = 'Anthill';
        objLead.State_Owner_1__c='MO';
        objLead.Zip_Code_Owner_1__c='65488';
        objLead.Country_Owner_1__c='US';
        objLead.Email = 'first@gmail.com';
        objLead.of_Ownership_Owner__c = 10;
        objLead.Credit_Score__c = 'under 600'; 
        objLead.Run_Credit_Report__c= true;
        objlead.Owner_ID_Owner_1__c = '2290';
        objlead.Credit_Score_5th_Owner_from_Webform__c = 'Over 700';
        objlead.Ethnicity__c = 'Hispanic or Latino';
        objlead.Portal_Application_Status__c = 'UnFinished';
        System.assertNotEquals('Disabled__c', null);
        
        //Second Owner Details
        objLead.Title_2nd_Owner__c = 'Ms';
        objLead.First_Name_2nd_Owner__c = 'SecondName';
        objLead.Last_Name_2nd_Owner__c = 'LastName';
        objLead.SSN2__c = '000-00-0001';
        objLead.Street_Owner_2__c = '220 Locust Ave';
        objLead.State_Owner_2__c = 'MO';
        objLead.Zip_Code_Owner_2__c = '65488';
        objLead.Country_Owner_2__c = 'US';
        objLead.Email_2nd_Owner__c = 'second@gmail.com';
        ObjLead.Phone_2nd_Owner__c = '999-999-9999';
        objLead.of_Ownership_Second_Owner__c = 10;
        objLead.City_Owner_2__c = 'Anthill';
        ObjLead.Credit_Score_2nd_Owner__c = '600 to 650';
        objLead.Run_Owner2_Credit_Report__c =true;
        objLead.Owner_ID_Owner_2__c = '2290';
        
        
        //Third Owner Details
        objLead.First_Name_3rd_Owner__c = 'ThirdName';
        objLead.Last_Name_3rd_Owner__c = 'LastName';
        objLead.SSN_3rd_Owner__c = '000-00-0001';
        objLead.of_Ownership_3rd_Owner__c = 20;
        objLead.City_Owner_3__c = 'Anthill';
        objLead.Email_3rd_Owner__c = 'third@gmail.com';
        objLead.Street_Owner_3__c = '220 Locust Ave';
        objLead.State_Owner_3__c = 'MO';
        objLead.Title_3rd_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_3__c ='65488';
        objLead.Country_Owner_3__c = 'US';
        ObjLead.Credit_Score_3rd_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_3rd_Owner__c = '999-999-9999';
        objLead.Run_Owner3_Credit_Report__c =true;
        objLead.Owner_ID_Owner_3__c = '2290';
        
        //Fourth Owner details
        objLead.First_Name_4th_Owner__c = 'FourthName';
        objLead.Last_Name_4th_Owner__c = 'LastName';
        objLead.SSN_4th_Owner__c = '000-00-0001';
        objLead.of_Ownership_4th_Owner__c = 20;
        objLead.City_Owner_4__c = 'Anthill';
        objLead.Email_4th_Owner__c = 'fourth@gmail.com';
        objLead.Street_Owner_4__c = '220 Locust Ave';
        objLead.State_Owner_4__c = 'MO';
        objLead.Title_4th_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_4__c = '65488';
        objLead.Country_Owner_4__c = 'US';
        ObjLead.Credit_Score_4th_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_4th_Owner__c = '999-999-9999';
        objLead.Run_Owner4_Credit_Report__c=true;
        objLead.Owner_ID_Owner_4__c = '2290';
        
        
        //Fifth Owner Details
        objLead.First_Name_5th_Owner__c = 'FifthName';
        objLead.Last_Name_5th_Owner__c = 'LastName';
        objLead.SSN_5th_Owner__c = '000-00-0001';
        objLead.of_Ownership_5th_Owner__c = 10;
        objLead.City_Owner_5__c = 'Anthill';
        objLead.Email_5th_Owner__c   = 'fifth@gmail.com';
        objLead.Street_Owner_5__c = '220 Locust Ave';
        objLead.State_Owner_5__c = 'MO';
        objLead.Title_5th_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_5__c = '65488';
        objLead.Country_Owner_5__c = 'US';
        ObjLead.Credit_Score_5th_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_5th_Owner__c = '999-999-9999';
        ObjLead.Run_Owner5_Credit_Report__c =true;
        objLead.Owner_ID_Owner_5__c = '2290';
        
        
        objLead.Are_you_COD_30_60_90__c = ' Yes';
        objLead.AnnualRevenue = 2313;
        objLead.Brief_History_on_the_business__c = 'Testing';
        objLead.What_exactly_does_the_business_do__c = 'Test';
        objLead.Who_is_your_customer_base__c = 'test';
        objLead.Do_You_Carry_Life_Insurance__c = 'test';
        objLead.Planned_Changes_In_Next_6_Months__c = 'test';
        objLead.Brief_History_on_the_owner_manager__c = 'test';
        objLead.What_are_the_terms_of_your_current_lease__c = 'test';
        objLead.Who_is_your_customer_base__c = 'test';
        objLead.Do_you_pay_child_support_or_alimony__c = 'yes';
        objLead.Explanation_of_any_BKs_defaults_etc__c = 'Test';
        objLead.Industry = 'Banking';
        objLead.Profitable_Last_2_Years__c = 'Yes';
        objLead.Requested_Amount__c = 50000 ;
        objLead.TIB_Months__c = '21';
        objLead.Use_of_Funds__c = 'Working Capital';
        objLead.What_are_the_terms_of_your_current_lease__c ='Testing';
        objLead.Are_you_COD_30_60_90__c = 'Testing';
        objLead.Brief_History_on_the_business__c = 'Testing'; 
        objLead.Brief_History_on_the_owner_manager__c = 'Testing';
        objLead.Who_is_your_customer_base__c = 'Testing';
        objLead.What_is_the_purpose_of_loan__c =  'Testing';
        objLead.What_are_the_terms_of_your_current_lease__c =  'Testing';
        objLead.Referral_type__c = 'BANK';
        objLead.What_does_your_Business_do__c = 'Service Business';
        objLead.What_type_of_Business_is_it__c = 'Entertainment';
        objLead.Tell_us_more__c = 'Full Service Restaurant';
        objLead.BusinessId__c = '1156';
        objLead.OwnerId = userinfo.getUserId();
        objLead.LeadSource = 'Portal';
        objLead.Industry = 'Agriculture';
        insert objLead;
        
        String requestBodyString = '{"LeadId":"'+objLead.id+'","Email":"fullcopytest20210609@yopmail.com","Company":"Testcase R Systems","BusinessId":"27044","ZipCode":"63534","UseofFunds":"","What_does_your_Business_do":"Manufacturer","State":"AK","Website":"testuat.com","Street":"220, L","City":"ant","Phone":"342-342-4243","Requested_Amount":49998,"Homeowner":false,"BriefHistoryontheowner":"Manufacturer","TIBMonths":"","Country":"US","NumberOfEmployees":0,"ownerInfoList":[{"owner_id":"18017","owner_home_address":"220, Locust Ave Anthill-65488, Missouri Unite","ownerCity":"anithill","owner_percentage":"3","ownerCellChone_no":"826-723-7867","owner_first_name":"Marisol L","owner_last_name":" Testcase","PrimaryContact":"Marisol L, Testcase","owner_email":"fullcopytest20210609@yopmail.com","Owner_zipcode":"65488","owner_SSN":"000-00-0001","owner_state_id":"MO","owner_dob":"1992-06-02","RunCreditReport":"True","owner_home_phone_no":"826-723-7867","owner_Address2":"220, Locust Ave Anthill-65488, Missouri Unite","owner_County":"Knox County"}],"LeadSource":"Portal","CampaignSource":"Finished","federal_taxId":"111111111","application_id":"DIR20020188","business_start_date":"2016-06-01","Disabled":false,"Ethnicity":"Not Disclosed","Race":"African-American","Veteran":true,"What_type_of_Business_is_it":"Apparel","Tell_us_more":"Hats and Caps","Women_Owned":true,"of_employees_added_in_next_12_months":"","of_customer_served_monthly":"","What_your_customer_base":"B2B;B2C","Address2":"220, L","County":"Aleutians East Borough","NumberofFullTimeEmployees":23,"AnnualGrossRevenue":1,"NumberofPartTimeEmployees":12,"NumberofJobsRetained":9,"LoanType":"NYR","PortalApplicationStatus":"Finished","SMSOptIn":true,"NaicsCode":"213123","BusinessType":"Corporation","PurposeOfTheLoan":"Insurance Costs","Other":"","StateOfIncorporation":"AK","WillThisLoanCreateMoreJobs":false,"NumberOfJobsCreated":34,"Rural":false,"Franchise":false,"DBA":"rope","doYouownaRealeState":false,"businesstaxliensfromIRSorState":false,"areYouDelinquentOnChildSupport":false,"Haveyoueverbeenconvictedofacrime":false,"HaveYouEverDefaultedOnGovernmentLoan":false,"DoYouHaveTaxLien":false,"AreThereAnyLegalActionPendingAgainstYou":false,"Owner1RentAmount":0,"Owner2RentAmount":0,"Owner3RentAmount":0,"Owner4RentAmount":0,"Owner5RentAmount":0,"ExhaustedPersonalAndNonSBAFinancing":false,"TenantReferralPartnerName":"ACCORD Corporation","PreferredLanguage":"English"}}';
         RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceLeadInsertAPI/*','PATCH');
        RestContext.response = new RestResponse();
        
        System.test.startTest();
        //objLead.Referral_type__c = 'BANK';
         SalesforceLeadInsertAPI.PatchLeadData();
        SalesforceLeadInsertAPI.deleteOwners();
        System.test.stopTest();
        
        // System.AssertEquals(true,OppWrapperList.size()>0, 'OppWrapperList must have some value');
        
    } 
    
    @isTest
    public static void PatchLeadData2(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Lead objLead = new Lead();
        
        objLead.Title = 'Mr.';
        objLead.FirstName = 'FirstName';
        objLead.LastName = 'test';
        objLead.Company = 'Test';
        objlead.Base64_Encoded_Pardot_Url_Parameter__c = 'MDBRMmEwMDAwMDVPbkxGRUEwfHwwMi4wMi4yMDIwIDE5OjAw';
        objLead.Entity_Type__c = 'Corporation';
        objlead.DoNotCall = false;
        objlead.HasOptedOutOfFax = false;
        objlead.Phone = '999-999-9999';
        objlead.pi__Needs_Score_Synced__c = false;
        objlead.pi__pardot_hard_bounced__c = false;
        objlead.Run_Credit_Report__c = false;
        objlead.Run_Owner2_Credit_Report__c = false;
        objlead.Run_Owner3_Credit_Report__c = false;
        objlead.Run_Owner4_Credit_Report__c = false;
        objlead.Run_Owner5_Credit_Report__c = false;
        objLead.Status = 'New';
        objLead.Status_Detail__c = 'New';
        objLead.X0KSB_Scholar_Alumni__c = 'yes';
        objlead.SSN1__c = '000-00-0001';
        objLead.Street_Owner_1__c='220 Locust Ave';
        objLead.City_Owner_1__c = 'Anthill';
        objLead.State_Owner_1__c='MO';
        objLead.Zip_Code_Owner_1__c='65488';
        objLead.Country_Owner_1__c='US';
        objLead.Email = 'first@gmail.com';
        objLead.of_Ownership_Owner__c = 30;
        objLead.Credit_Score__c = 'under 600'; 
        objLead.Run_Credit_Report__c= true;
        objlead.Owner_ID_Owner_1__c = '';
        objlead.Credit_Score_5th_Owner_from_Webform__c = 'Over 700';
        objlead.Ethnicity__c = 'Hispanic or Latino';
        objlead.Portal_Application_Status__c = 'UnFinished';
        System.assertNotEquals('Disabled__c', null);
        
        //Second Owner Details
        objLead.Title_2nd_Owner__c = 'Ms';
        objLead.First_Name_2nd_Owner__c = 'SecondName';
        objLead.Last_Name_2nd_Owner__c = 'LastName';
        objLead.SSN2__c = '000-00-0001';
        objLead.Street_Owner_2__c = '220 Locust Ave';
        objLead.State_Owner_2__c = 'MO';
        objLead.Zip_Code_Owner_2__c = '65488';
        objLead.Country_Owner_2__c = 'US';
        objLead.Email_2nd_Owner__c = 'second@gmail.com';
        ObjLead.Phone_2nd_Owner__c = '999-999-9999';
        objLead.of_Ownership_Second_Owner__c = 30;
        objLead.City_Owner_2__c = 'Anthill';
        ObjLead.Credit_Score_2nd_Owner__c = '600 to 650';
        objLead.Run_Owner2_Credit_Report__c =true;
        objLead.Owner_ID_Owner_2__c = '2290';
        
        
        //Third Owner Details
        objLead.First_Name_3rd_Owner__c = 'ThirdName';
        objLead.Last_Name_3rd_Owner__c = 'LastName';
        objLead.SSN_3rd_Owner__c = '000-00-0001';
        objLead.of_Ownership_3rd_Owner__c = 4;
        objLead.City_Owner_3__c = 'Anthill';
        objLead.Email_3rd_Owner__c = 'third@gmail.com';
        objLead.Street_Owner_3__c = '220 Locust Ave';
        objLead.State_Owner_3__c = 'MO';
        objLead.Title_3rd_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_3__c ='65488';
        objLead.Country_Owner_3__c = 'US';
        ObjLead.Credit_Score_3rd_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_3rd_Owner__c = '999-999-9999';
        objLead.Run_Owner3_Credit_Report__c =true;
        objLead.Owner_ID_Owner_3__c = '2290';
        
        //Fourth Owner details
        objLead.First_Name_4th_Owner__c = 'FourthName';
        objLead.Last_Name_4th_Owner__c = 'LastName';
        objLead.SSN_4th_Owner__c = '000-00-0001';
        objLead.of_Ownership_4th_Owner__c = 5;
        objLead.City_Owner_4__c = 'Anthill';
        objLead.Email_4th_Owner__c = 'fourth@gmail.com';
        objLead.Street_Owner_4__c = '220 Locust Ave';
        objLead.State_Owner_4__c = 'MO';
        objLead.Title_4th_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_4__c = '65488';
        objLead.Country_Owner_4__c = 'US';
        ObjLead.Credit_Score_4th_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_4th_Owner__c = '999-999-9999';
        objLead.Run_Owner4_Credit_Report__c=true;
        objLead.Owner_ID_Owner_4__c = '2290';
        
        
        //Fifth Owner Details
        objLead.First_Name_5th_Owner__c = 'FifthName';
        objLead.Last_Name_5th_Owner__c = 'LastName';
        objLead.SSN_5th_Owner__c = '000-00-0001';
        objLead.of_Ownership_5th_Owner__c = 6;
        objLead.City_Owner_5__c = 'Anthill';
        objLead.Email_5th_Owner__c   = 'fifth@gmail.com';
        objLead.Street_Owner_5__c = '220 Locust Ave';
        objLead.State_Owner_5__c = 'MO';
        objLead.Title_5th_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_5__c = '65488';
        objLead.Country_Owner_5__c = 'US';
        ObjLead.Credit_Score_5th_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_5th_Owner__c = '999-999-9999';
        ObjLead.Run_Owner5_Credit_Report__c =true;
        objLead.Owner_ID_Owner_5__c = '2290';
        
        
        objLead.Are_you_COD_30_60_90__c = ' Yes';
        objLead.AnnualRevenue = 2313;
        objLead.Brief_History_on_the_business__c = 'Testing';
        objLead.What_exactly_does_the_business_do__c = 'Test';
        objLead.Who_is_your_customer_base__c = 'test';
        objLead.Do_You_Carry_Life_Insurance__c = 'test';
        objLead.Planned_Changes_In_Next_6_Months__c = 'test';
        objLead.Brief_History_on_the_owner_manager__c = 'test';
        objLead.What_are_the_terms_of_your_current_lease__c = 'test';
        objLead.Who_is_your_customer_base__c = 'test';
        objLead.Do_you_pay_child_support_or_alimony__c = 'yes';
        objLead.Explanation_of_any_BKs_defaults_etc__c = 'Test';
        objLead.Industry = 'Banking';
        objLead.Profitable_Last_2_Years__c = 'Yes';
        objLead.Requested_Amount__c = 50000 ;
        objLead.TIB_Months__c = '21';
        objLead.Use_of_Funds__c = 'Working Capital';
        objLead.What_are_the_terms_of_your_current_lease__c ='Testing';
        objLead.Are_you_COD_30_60_90__c = 'Testing';
        objLead.Brief_History_on_the_business__c = 'Testing'; 
        objLead.Brief_History_on_the_owner_manager__c = 'Testing';
        objLead.Who_is_your_customer_base__c = 'Testing';
        objLead.What_is_the_purpose_of_loan__c =  'Testing';
        objLead.What_are_the_terms_of_your_current_lease__c =  'Testing';
        objLead.Referral_type__c = 'BANK';
        objLead.What_does_your_Business_do__c = 'Service Business';
        objLead.What_type_of_Business_is_it__c = 'Entertainment';
        objLead.Tell_us_more__c = 'Full Service Restaurant';
        objLead.BusinessId__c = '1156';
        objLead.OwnerId = userinfo.getUserId();
        objLead.LeadSource = 'Portal';
        objLead.Industry = 'Agriculture';
        insert objLead;
        
        String requestBodyString = '{"SMSOptIn":true,"NaicsCode":"1234","DBA":"abcc","StateOfIncorporation":"ANTHIL","Other":"hjjhjh","NumberOfJobsCreated":"30","Address2":"Anthil","County":"ANTHIL","Number_of_Full_Time_Employees__c":"5","NumberofPartTimeEmployees":"4","AnnualGrossRevenue":"200","NumberofJobsRetained":"3","PortalApplicationStatus" : "Finished","LeadId":"'+objLead.Id+'","Email":"primaryownertest@yomail.com","Company":"Primary Owner Test","BusinessId":"1228","ZipCode":"65499","UseofFunds":"Acquire Another Business","What_does_your_Business_do":"Manufacturer","State":"NY","Business_Phone":9876543210,"Title":"testtitle","Who_is_Your_Customer_Base1":"B2B","Website":"www.singh.com","Street":"123 Main St","City":"New York","Requested_Amount":1525000,"Homeowner":false,"BriefHistoryontheowner":"Manufacturer","TIBMonths":"< 1 Year","Country":"US","NumberOfEmployees":12,"ownerInfoList":[{"owner_id":"2290","owner_home_address":"220 Locust Ave","ownerCity":"Anthill","owner_percentage":"100","ownerCellChone_no":"123-456-7890","owner_first_name":"Marisol L","owner_last_name":"Testcase","PrimaryContact":"Marisol L, Testcase","owner_email":"primaryownertest@yomail.com","Owner_zipcode":"65488","owner_SSN":"000-00-0001","owner_state_id":"MO","owner_title":"PMO","owner_dob":"1992-01-05","RunCreditReport":"True","owner_home_phone_no":"123-456-7890","guarantor_owner_worth":1000000,"owner_rent":100000}],"LeadSource":"Portal","CampaignSource":"Unfinished","federal_taxId":"11-1111111","application_id":"DIR1896748","business_start_date":"2009-10-20","Disabled":true,"Ethnicity":"Hispanic or Latino","Race":"Black or African American","Veteran":true,"What_type_of_Business_is_it":"Textile","Tell_us_more":"Dyeing and Finishing","Women_Owned":false,"of_employees_added_in_next_12_months":"12","of_customer_served_monthly":"12"}';
         RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceLeadInsertAPI/*','PATCH');
        RestContext.response = new RestResponse();
        
        System.test.startTest();
        SalesforceLeadInsertAPI.PatchLeadData();
         SalesforceLeadInsertAPI.deleteOwners();
        System.test.stopTest();
        
        // System.AssertEquals(true,OppWrapperList.size()>0, 'OppWrapperList must have some value');
        
    }
    
    @isTest
    public static void PatchLeadData3(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Lead objLead = new Lead();
        
        objLead.Title = 'Mr.';
        objLead.FirstName = 'FirstName';
        objLead.LastName = 'test';
        objLead.Company = 'Test';
        objlead.Base64_Encoded_Pardot_Url_Parameter__c = 'MDBRMmEwMDAwMDVPbkxGRUEwfHwwMi4wMi4yMDIwIDE5OjAw';
        objLead.Entity_Type__c = 'Corporation';
        objlead.DoNotCall = false;
        objlead.HasOptedOutOfFax = false;
        objlead.Phone = '999-999-9999';
        objlead.pi__Needs_Score_Synced__c = false;
        objlead.pi__pardot_hard_bounced__c = false;
        objlead.Run_Credit_Report__c = false;
        objlead.Run_Owner2_Credit_Report__c = false;
        objlead.Run_Owner3_Credit_Report__c = false;
        objlead.Run_Owner4_Credit_Report__c = false;
        objlead.Run_Owner5_Credit_Report__c = false;
        objLead.Status = 'New';
        objLead.Status_Detail__c = 'New';
        objLead.X0KSB_Scholar_Alumni__c = 'yes';
        objlead.SSN1__c = '000-00-0001';
        objLead.Street_Owner_1__c='220 Locust Ave';
        objLead.City_Owner_1__c = 'Anthill';
        objLead.State_Owner_1__c='MO';
        objLead.Zip_Code_Owner_1__c='65488';
        objLead.Country_Owner_1__c='US';
        objLead.Email = 'first@gmail.com';
        objLead.of_Ownership_Owner__c = 30;
        objLead.Credit_Score__c = 'under 600'; 
        objLead.Run_Credit_Report__c= true;
        objlead.Owner_ID_Owner_1__c = '2290';
        objlead.Credit_Score_5th_Owner_from_Webform__c = 'Over 700';
        objlead.Ethnicity__c = 'Hispanic or Latino';
        objlead.Portal_Application_Status__c = 'UnFinished';
        System.assertNotEquals('Disabled__c', null);
        
        //Second Owner Details
        objLead.Title_2nd_Owner__c = 'Ms';
        objLead.First_Name_2nd_Owner__c = 'SecondName';
        objLead.Last_Name_2nd_Owner__c = 'LastName';
        objLead.SSN2__c = '000-00-0001';
        objLead.Street_Owner_2__c = '220 Locust Ave';
        objLead.State_Owner_2__c = 'MO';
        objLead.Zip_Code_Owner_2__c = '65488';
        objLead.Country_Owner_2__c = 'US';
        objLead.Email_2nd_Owner__c = 'second@gmail.com';
        ObjLead.Phone_2nd_Owner__c = '999-999-9999';
        objLead.of_Ownership_Second_Owner__c = 30;
        objLead.City_Owner_2__c = 'Anthill';
        ObjLead.Credit_Score_2nd_Owner__c = '600 to 650';
        objLead.Run_Owner2_Credit_Report__c =true;
        objLead.Owner_ID_Owner_2__c = '';
        
        
        //Third Owner Details
        objLead.First_Name_3rd_Owner__c = 'ThirdName';
        objLead.Last_Name_3rd_Owner__c = 'LastName';
        objLead.SSN_3rd_Owner__c = '000-00-0001';
        objLead.of_Ownership_3rd_Owner__c = 4;
        objLead.City_Owner_3__c = 'Anthill';
        objLead.Email_3rd_Owner__c = 'third@gmail.com';
        objLead.Street_Owner_3__c = '220 Locust Ave';
        objLead.State_Owner_3__c = 'MO';
        objLead.Title_3rd_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_3__c ='65488';
        objLead.Country_Owner_3__c = 'US';
        ObjLead.Credit_Score_3rd_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_3rd_Owner__c = '999-999-9999';
        objLead.Run_Owner3_Credit_Report__c =true;
        objLead.Owner_ID_Owner_3__c = '2290';
        
        //Fourth Owner details
        objLead.First_Name_4th_Owner__c = 'FourthName';
        objLead.Last_Name_4th_Owner__c = 'LastName';
        objLead.SSN_4th_Owner__c = '000-00-0001';
        objLead.of_Ownership_4th_Owner__c = 5;
        objLead.City_Owner_4__c = 'Anthill';
        objLead.Email_4th_Owner__c = 'fourth@gmail.com';
        objLead.Street_Owner_4__c = '220 Locust Ave';
        objLead.State_Owner_4__c = 'MO';
        objLead.Title_4th_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_4__c = '65488';
        objLead.Country_Owner_4__c = 'US';
        ObjLead.Credit_Score_4th_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_4th_Owner__c = '999-999-9999';
        objLead.Run_Owner4_Credit_Report__c=true;
        objLead.Owner_ID_Owner_4__c = '2290';
        
        
        //Fifth Owner Details
        objLead.First_Name_5th_Owner__c = 'FifthName';
        objLead.Last_Name_5th_Owner__c = 'LastName';
        objLead.SSN_5th_Owner__c = '000-00-0001';
        objLead.of_Ownership_5th_Owner__c = 6;
        objLead.City_Owner_5__c = 'Anthill';
        objLead.Email_5th_Owner__c   = 'fifth@gmail.com';
        objLead.Street_Owner_5__c = '220 Locust Ave';
        objLead.State_Owner_5__c = 'MO';
        objLead.Title_5th_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_5__c = '65488';
        objLead.Country_Owner_5__c = 'US';
        ObjLead.Credit_Score_5th_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_5th_Owner__c = '999-999-9999';
        ObjLead.Run_Owner5_Credit_Report__c =true;
        objLead.Owner_ID_Owner_5__c = '2290';
        
        
        objLead.Are_you_COD_30_60_90__c = ' Yes';
        objLead.AnnualRevenue = 2313;
        objLead.Brief_History_on_the_business__c = 'Testing';
        objLead.What_exactly_does_the_business_do__c = 'Test';
        objLead.Who_is_your_customer_base__c = 'test';
        objLead.Do_You_Carry_Life_Insurance__c = 'test';
        objLead.Planned_Changes_In_Next_6_Months__c = 'test';
        objLead.Brief_History_on_the_owner_manager__c = 'test';
        objLead.What_are_the_terms_of_your_current_lease__c = 'test';
        objLead.Who_is_your_customer_base__c = 'test';
        objLead.Do_you_pay_child_support_or_alimony__c = 'yes';
        objLead.Explanation_of_any_BKs_defaults_etc__c = 'Test';
        objLead.Industry = 'Banking';
        objLead.Profitable_Last_2_Years__c = 'Yes';
        objLead.Requested_Amount__c = 50000 ;
        objLead.TIB_Months__c = '21';
        objLead.Use_of_Funds__c = 'Working Capital';
        objLead.What_are_the_terms_of_your_current_lease__c ='Testing';
        objLead.Are_you_COD_30_60_90__c = 'Testing';
        objLead.Brief_History_on_the_business__c = 'Testing'; 
        objLead.Brief_History_on_the_owner_manager__c = 'Testing';
        objLead.Who_is_your_customer_base__c = 'Testing';
        objLead.What_is_the_purpose_of_loan__c =  'Testing';
        objLead.What_are_the_terms_of_your_current_lease__c =  'Testing';
        objLead.Referral_type__c = 'BANK';
        objLead.What_does_your_Business_do__c = 'Service Business';
        objLead.What_type_of_Business_is_it__c = 'Entertainment';
        objLead.Tell_us_more__c = 'Full Service Restaurant';
        objLead.BusinessId__c = '1156';
        objLead.OwnerId = userinfo.getUserId();
        objLead.LeadSource = 'Portal';
        objLead.Industry = 'Agriculture';
        insert objLead;
        
        String requestBodyString = '{"SMSOptIn":true,"NaicsCode":"1234","DBA":"abcc","StateOfIncorporation":"ANTHIL","Other":"hjjhjh","NumberOfJobsCreated":"30","Address2":"Anthil","County":"ANTHIL","Number_of_Full_Time_Employees__c":"5","NumberofPartTimeEmployees":"4","AnnualGrossRevenue":"200","NumberofJobsRetained":"3","PortalApplicationStatus" : "Finished","LeadId":"'+objLead.Id+'","Email":"primaryownertest@yomail.com","Company":"Primary Owner Test","BusinessId":"1228","ZipCode":"65499","UseofFunds":"Acquire Another Business","What_does_your_Business_do":"Manufacturer","State":"NY","Business_Phone":9876543210,"Title":"testtitle","Who_is_Your_Customer_Base1":"B2B","Website":"www.singh.com","Street":"123 Main St","City":"New York","Requested_Amount":1525000,"Homeowner":false,"BriefHistoryontheowner":"Manufacturer","TIBMonths":"< 1 Year","Country":"US","NumberOfEmployees":12,"ownerInfoList":[{"owner_id":"2290","owner_home_address":"220 Locust Ave","ownerCity":"Anthill","owner_percentage":"100","ownerCellChone_no":"123-456-7890","owner_first_name":"Marisol L","owner_last_name":"Testcase","PrimaryContact":"Marisol L, Testcase","owner_email":"primaryownertest@yomail.com","Owner_zipcode":"65488","owner_SSN":"000-00-0001","owner_state_id":"MO","owner_title":"PMO","owner_dob":"1992-01-05","RunCreditReport":"True","owner_home_phone_no":"123-456-7890","guarantor_owner_worth":1000000,"owner_rent":100000}],"LeadSource":"Portal","CampaignSource":"Unfinished","federal_taxId":"11-1111111","application_id":"DIR1896748","business_start_date":"2009-10-20","Disabled":true,"Ethnicity":"Hispanic or Latino","Race":"Black or African American","Veteran":true,"What_type_of_Business_is_it":"Textile","Tell_us_more":"Dyeing and Finishing","Women_Owned":false,"of_employees_added_in_next_12_months":"12","of_customer_served_monthly":"12"}';
         RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceLeadInsertAPI/*','PATCH');
        RestContext.response = new RestResponse();
        SalesforceLeadInsertAPI.i = 1;
        System.test.startTest();
        SalesforceLeadInsertAPI.PatchLeadData();
         SalesforceLeadInsertAPI.deleteOwners();
        System.test.stopTest();
        
        // System.AssertEquals(true,OppWrapperList.size()>0, 'OppWrapperList must have some value');
        
    } 
    
    
    @isTest
    public static void PatchLeadDataForBlankOwner(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Lead objLead = new Lead();
        
        objLead.Title = 'Mr.';
        objLead.FirstName = 'FirstName';
        objLead.LastName = 'test';
        objLead.Company = 'Test';
        objlead.Base64_Encoded_Pardot_Url_Parameter__c = 'MDBRMmEwMDAwMDVPbkxGRUEwfHwwMi4wMi4yMDIwIDE5OjAw';
        objlead.X0KSB_Scholar_Alumni__c = 'yes';
        objLead.Entity_Type__c = 'Corporation';
        objlead.DoNotCall = false;
        objlead.Net_Worth__c = 789654;
        objlead.HasOptedOutOfFax = false;
        objlead.Phone = '999-999-9999';
        objlead.pi__Needs_Score_Synced__c = false;
        objlead.pi__pardot_hard_bounced__c = false;
        objlead.Run_Credit_Report__c = false;
        objlead.Run_Owner2_Credit_Report__c = false;
        objlead.Run_Owner3_Credit_Report__c = false;
        objlead.Run_Owner4_Credit_Report__c = false;
        objlead.Run_Owner5_Credit_Report__c = false;
        objLead.Status = 'New';
        objLead.Status_Detail__c = 'New';
        objlead.SSN1__c = '000-00-0001';
        objLead.Street_Owner_1__c='220 Locust Ave';
        objLead.City_Owner_1__c = 'Anthill';
        objLead.State_Owner_1__c='MO';
        objLead.Zip_Code_Owner_1__c='65488';
        objLead.Country_Owner_1__c='US';
        objLead.Email = 'first@gmail.com';
        objLead.of_Ownership_Owner__c = 30;
        objLead.Credit_Score__c = 'under 600'; 
        objLead.Run_Credit_Report__c= true;
        objlead.Owner_ID_Owner_1__c = '';
       objLead.Annual_Gross_Revenue__c = 7896;
        
        //Second Owner Details
        objLead.Title_2nd_Owner__c = 'Ms';
        objLead.First_Name_2nd_Owner__c = 'SecondName';
        objLead.Last_Name_2nd_Owner__c = 'LastName';
        objLead.SSN2__c = '000-00-0001';
        objLead.Street_Owner_2__c = '220 Locust Ave';
        objLead.State_Owner_2__c = 'MO';
        objLead.Zip_Code_Owner_2__c = '65488';
        objLead.Country_Owner_2__c = 'US';
        objLead.Email_2nd_Owner__c = 'second@gmail.com';
        ObjLead.Phone_2nd_Owner__c = '999-999-9999';
        objLead.of_Ownership_Second_Owner__c = 30;
        objLead.City_Owner_2__c = 'Anthill';
        ObjLead.Credit_Score_2nd_Owner__c = 'Over 700';
        objLead.Run_Owner2_Credit_Report__c =true;
        objLead.Owner_ID_Owner_2__c = '';
        objLead.Address2_Owner_2__c = 'NewYork';
        //objLead.Credit_Score_2nd_Owner__c = 'Under 600';
        
        //Third Owner Details
        objLead.First_Name_3rd_Owner__c = 'ThirdName';
        objLead.Last_Name_3rd_Owner__c = 'LastName';
        objLead.SSN_3rd_Owner__c = '000-00-0001';
        objLead.of_Ownership_3rd_Owner__c = 4;
        objLead.City_Owner_3__c = 'Anthill';
        objLead.Email_3rd_Owner__c = 'third@gmail.com';
        objLead.Street_Owner_3__c = '220 Locust Ave';
        objLead.State_Owner_3__c = 'MO';
        objLead.Title_3rd_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_3__c ='65488';
        objLead.Country_Owner_3__c = 'US';
        ObjLead.Credit_Score_3rd_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_3rd_Owner__c = '999-999-9999';
        objLead.Run_Owner3_Credit_Report__c =true;
        objLead.Owner_ID_Owner_3__c = '';
        
        //Fourth Owner details
        objLead.First_Name_4th_Owner__c = 'FourthName';
        objLead.Last_Name_4th_Owner__c = 'LastName';
        objLead.SSN_4th_Owner__c = '000-00-0001';
        objLead.of_Ownership_4th_Owner__c = 5;
        objLead.City_Owner_4__c = 'Anthill';
        objLead.Email_4th_Owner__c = 'fourth@gmail.com';
        objLead.Street_Owner_4__c = '220 Locust Ave';
        objLead.State_Owner_4__c = 'MO';
        objLead.Title_4th_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_4__c = '65488';
        objLead.Country_Owner_4__c = 'US';
        ObjLead.Credit_Score_4th_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_4th_Owner__c = '999-999-9999';
        objLead.Run_Owner4_Credit_Report__c=true;
        objLead.Owner_ID_Owner_4__c = '';
        
        
        //Fifth Owner Details
        objLead.First_Name_5th_Owner__c = 'FifthName';
        objLead.Last_Name_5th_Owner__c = 'LastName';
        objLead.SSN_5th_Owner__c = '000-00-0001';
        objLead.of_Ownership_5th_Owner__c = 6;
        objLead.City_Owner_5__c = 'Anthill';
        objLead.Email_5th_Owner__c   = 'fifth@gmail.com';
        objLead.Street_Owner_5__c = '220 Locust Ave';
        objLead.State_Owner_5__c = 'MO';
        objLead.Title_5th_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_5__c = '65488';
        objLead.Country_Owner_5__c = 'US';
       // ObjLead.Credit_Score_5th_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_5th_Owner__c = '999-999-9999';
        ObjLead.Run_Owner5_Credit_Report__c =true;
        objLead.Owner_ID_Owner_5__c = '';
        objlead.Credit_Score_5th_Owner_from_Webform__c = 'Over 700';
        
        objLead.Are_you_COD_30_60_90__c = ' Yes';
        objLead.AnnualRevenue = 2313;
        objLead.Brief_History_on_the_business__c = 'Testing';
        objLead.What_exactly_does_the_business_do__c = 'Test';
        objLead.Who_is_your_customer_base__c = 'test';
        objLead.Do_You_Carry_Life_Insurance__c = 'test';
        objLead.Planned_Changes_In_Next_6_Months__c = 'test';
        objLead.Brief_History_on_the_owner_manager__c = 'test';
        objLead.What_are_the_terms_of_your_current_lease__c = 'test';
        objLead.Who_is_your_customer_base__c = 'test';
        objLead.Do_you_pay_child_support_or_alimony__c = 'yes';
        objLead.Explanation_of_any_BKs_defaults_etc__c = 'Test';
        objLead.Industry = 'Banking';
        objLead.Profitable_Last_2_Years__c = 'Yes';
        objLead.Requested_Amount__c = 50000 ;
        objLead.TIB_Months__c = '21';
        objLead.Use_of_Funds__c = 'Working Capital';
        objLead.What_are_the_terms_of_your_current_lease__c ='Testing';
        objLead.Are_you_COD_30_60_90__c = 'Testing';
        objLead.Brief_History_on_the_business__c = 'Testing'; 
        objLead.Brief_History_on_the_owner_manager__c = 'Testing';
        objLead.Who_is_your_customer_base__c = 'Testing';
        objLead.What_is_the_purpose_of_loan__c =  'Testing';
        objLead.What_are_the_terms_of_your_current_lease__c =  'Testing';
        objLead.Referral_type__c = 'BANK';
        objLead.What_does_your_Business_do__c = 'Service Business';
        objLead.What_type_of_Business_is_it__c = 'Entertainment';
        objLead.Tell_us_more__c = 'Full Service Restaurant';
        objLead.BusinessId__c = '1156';
        objLead.Number_of_Full_Time_Employees__c = 1187;
        objLead.OwnerId = userinfo.getUserId();
        objLead.CountyId_Owner__c = 'absc';
        objLead.LeadSource = 'Portal';
        insert objLead;
        String requestBodyString = '{"LeadId":"'+objLead.Id+'","Email":"primaryownertest@yomail.com","Company":"Primary Owner Test","BusinessId":"1228","ZipCode":"65499","UseofFunds":"Acquire Another Business","What_does_your_Business_do":"Manufacturer","State":"NY","Website":"www.singh.com","Street":"123 Main St","City":"New York","Requested_Amount":1525000,"Homeowner":false,"BriefHistoryontheowner":"Manufacturer","TIBMonths":"< 1 Year","Country":"US","NumberOfEmployees":12,"ownerInfoList":[{"owner_id":"2290","owner_home_address":"220 Locust Ave","ownerCity":"Anthill","owner_percentage":"100","ownerCellChone_no":"123-456-7890","owner_first_name":"Marisol L","owner_last_name":"Testcase","PrimaryContact":"Marisol L, Testcase","owner_email":"primaryownertest@yomail.com","Owner_zipcode":"65488","owner_SSN":"000-00-0001","owner_state_id":"MO","owner_title":"PMO","owner_dob":"1992-01-05","RunCreditReport":"True","owner_home_phone_no":"123-456-7890","guarantor_owner_worth":1000000,"owner_rent":100000},{"owner_id":"2290","owner_home_address":"220 Locust Ave","ownerCity":"Anthill","owner_percentage":"100","ownerCellChone_no":"123-456-7890","owner_first_name":"Marisol L","owner_last_name":"Testcase","PrimaryContact":"Marisol L, Testcase","owner_email":"primaryownertest@yomail.com","Owner_zipcode":"65488","owner_SSN":"000-00-0001","owner_state_id":"MO","owner_title":"PMO","owner_dob":"1992-01-05","RunCreditReport":"True","owner_home_phone_no":"123-456-7890","guarantor_owner_worth":1000000,"owner_rent":100000},{"owner_id":"2290","owner_home_address":"220 Locust Ave","ownerCity":"Anthill","owner_percentage":"100","ownerCellChone_no":"123-456-7890","owner_first_name":"Marisol L","owner_last_name":"Testcase","PrimaryContact":"Marisol L, Testcase","owner_email":"primaryownertest@yomail.com","Owner_zipcode":"65488","owner_SSN":"000-00-0001","owner_state_id":"MO","owner_title":"PMO","owner_dob":"1992-01-05","RunCreditReport":"True","owner_home_phone_no":"123-456-7890","guarantor_owner_worth":1000000,"owner_rent":100000},{"owner_id":"2290","owner_home_address":"220 Locust Ave","ownerCity":"Anthill","owner_percentage":"100","ownerCellChone_no":"123-456-7890","owner_first_name":"Marisol L","owner_last_name":"Testcase","PrimaryContact":"Marisol L, Testcase","owner_email":"primaryownertest@yomail.com","Owner_zipcode":"65488","owner_SSN":"000-00-0001","owner_state_id":"MO","owner_title":"PMO","owner_dob":"1992-01-05","RunCreditReport":"True","owner_home_phone_no":"123-456-7890","guarantor_owner_worth":1000000,"owner_rent":100000},{"owner_id":"2290","owner_home_address":"220 Locust Ave","ownerCity":"Anthill","owner_percentage":"100","ownerCellChone_no":"123-456-7890","owner_first_name":"Marisol L","owner_last_name":"Testcase","PrimaryContact":"Marisol L, Testcase","owner_email":"primaryownertest@yomail.com","Owner_zipcode":"65488","owner_SSN":"000-00-0001","owner_state_id":"MO","owner_title":"PMO","owner_dob":"1992-01-05","RunCreditReport":"True","owner_home_phone_no":"123-456-7890","guarantor_owner_worth":1000000,"owner_rent":100000}],"LeadSource":"Portal","CampaignSource":"Unfinished","federal_taxId":"11-1111111","application_id":"DIR1896748","business_start_date":"2009-10-20","Disabled":true,"Ethnicity":"Hispanic or Latino","Race":"Black or African American","Veteran":true,"What_type_of_Business_is_it":"Textile","Tell_us_more":"Dyeing and Finishing","Women_Owned":false,"of_employees_added_in_next_12_months":"12","of_customer_served_monthly":"12","WillThisLoanCreateMoreJobs:"Yes"}';
         RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceLeadInsertAPI/*','POST');
        RestContext.response = new RestResponse();
        
        System.test.startTest();
        SalesforceLeadInsertAPI.insertLeadData();
        System.test.stopTest();
        
        // System.AssertEquals(true,OppWrapperList.size()>0, 'OppWrapperList must have some value');
        
    }
    
    

    
    
  

}