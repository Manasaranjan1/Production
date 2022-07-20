@isTest(seeAlldata=true)
public class QuestionsTriggerHandler_Test{
    static testMethod void LeadConversion_UnitTest1() {
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
        objlead.Phone = '(963) 258-7410';
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
        objlead.Owner_ID_Owner_1__c = '123';
        objlead.Credit_Score_5th_Owner_from_Webform__c = 'Over 700';
        objlead.DOB_Owner_1__c = Date.valueof(System.now());
        //objlead.DOB_Owner_1__c = Date.today();
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
        ObjLead.Phone_2nd_Owner__c = '8947523713';
        objLead.of_Ownership_Second_Owner__c = 30;
        objLead.City_Owner_2__c = 'Anthill';
        ObjLead.Credit_Score_2nd_Owner__c = '600 to 650';
        objLead.Run_Owner2_Credit_Report__c =true;
        objLead.Owner_ID_Owner_2__c = '124';
        objlead.DOB_Owner_2__c = Date.valueof(System.now());
        //Third Owner Details
        objLead.First_Name_3rd_Owner__c = 'ThirdName';
        objLead.Last_Name_3rd_Owner__c = 'LastName';
        objLead.SSN_3rd_Owner__c = '000-00-0001';
        objLead.of_Ownership_3rd_Owner__c = 40;
        objLead.City_Owner_3__c = 'Anthill';
        objLead.Email_3rd_Owner__c = 'third@gmail.com';
        objLead.Street_Owner_3__c = '220 Locust Ave';
        objLead.State_Owner_3__c = 'MO';
        objLead.Title_3rd_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_3__c ='65488';
        objLead.Country_Owner_3__c = 'US';
        ObjLead.Credit_Score_3rd_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_3rd_Owner__c = '8947523713';
        objLead.Run_Owner3_Credit_Report__c =true;
        objLead.Owner_ID_Owner_3__c = '125';
        objlead.DOB_Owner_3__c = Date.valueof(System.now());
        //Fourth Owner details
        objLead.First_Name_4th_Owner__c = 'FourthName';
        objLead.Last_Name_4th_Owner__c = 'LastName';
        objLead.SSN_4th_Owner__c = '000-00-0001';
        objLead.of_Ownership_4th_Owner__c = 50;
        objLead.City_Owner_4__c = 'Anthill';
        objLead.Email_4th_Owner__c = 'fourth@gmail.com';
        objLead.Street_Owner_4__c = '220 Locust Ave';
        objLead.State_Owner_4__c = 'MO';
        objLead.Title_4th_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_4__c = '65488';
        objLead.Country_Owner_4__c = 'US';
        ObjLead.Credit_Score_4th_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_4th_Owner__c = '8947523713';
        objLead.Run_Owner4_Credit_Report__c=true;
        objLead.Owner_ID_Owner_4__c = '126';
        objlead.DOB_Owner_4__c = Date.valueof(System.now());
        //Fifth Owner Details
        objLead.First_Name_5th_Owner__c = 'FifthName';
        objLead.Last_Name_5th_Owner__c = 'LastName';
        objLead.SSN_5th_Owner__c = '000-00-0001';
        objLead.of_Ownership_5th_Owner__c = 60;
        objLead.City_Owner_5__c = 'Anthill';
        objLead.Email_5th_Owner__c   = 'fifth@gmail.com';
        objLead.Street_Owner_5__c = '220 Locust Ave';
        objLead.State_Owner_5__c = 'MO';
        objLead.Title_5th_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_5__c = '65488';
        objLead.Country_Owner_5__c = 'US';
        ObjLead.Credit_Score_5th_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_5th_Owner__c = '8947523713';
        ObjLead.Run_Owner5_Credit_Report__c =true;
        objLead.Owner_ID_Owner_5__c = '127';
        objlead.DOB_Owner_5__c = Date.valueof(System.now());
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
        objLead.Requested_Amount__c = 150000;
        objLead.Homeowner__c = 'Yes';
        objLead.Monthly_Rent_Mtg__c = 500;
        objLead.Net_Worth__c = 51000;        
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
        objLead.BusinessId__c = '1156';
        objLead.Adddress2_Owner__c ='US';
        objLead.Number_of_Full_Time_Employees__c = 20;
        objLead.Number_of_Full_Time_Employees__c= 10;
        objLead.NAICS_CODE__c = String.valueoF(1234);
        objLead.Veteran__c = 'Yes';
        objLead.Race__c ='Yes';
        objLead.Loan_Type__c  ='SBA-PPP';
        objLead.LeadSource = 'Portal';
        objLead.Campaign_Source__c = 'Finished';
        objLead.Portal_Application_Status__c= 'Finished';
        insert objLead;
        String requestBodyString = '{"listOfLeadData":[{"WomenOwnedBusiness":false,"Willthisloancreatemorejobs":true,"Whoisyourcustomerbase":null,"WhattypeofBusinessisit":"00","Whatdoesyourbusinessdo":"00","Veteran":false,"useOfFunding":null,"TellusMore":"00","Stateofincopration":"NY","SBALoanNumber":888999,"SBAApplicationNumber":232222,"salesforceUserId":"0051V000006zXYSQA2","referredBySalesUserId":null,"referredBy":null,"ReferralPartner":"ourfairshare","rangeValue":null,"Race":"00","Purposeofloan":"Payroll","PhonrNumber":"(917) 453-1528","personalCashBalance":null,"ownerEmailAddress":"dev10may20@yopmail.com","Other":null,"ofemployeesasof2_15_2020":null,"ofemployeesasof12_31_19":null,"of_Jobs_Retained":1.00,"of_Jobs_Created_30th_June":"0.00","netWorth":null,"listOfOwnersData":[{"RunCreditReport":null,"PrimaryOwnerId":null,"ownerCity":"BROOKLYN","ownerCellChone_no":null,"Owner_zipcode":"11221","owner_title":null,"owner_state":"NY","owner_SSN":"050-44-4534","Owner_Rent":null,"Owner_Phone":null,"owner_percentage":null,"owner_last_name":"Blacksmith","Owner_Id":null,"owner_home_address":"154 WEIRFIELD ST","owner_first_name":"L A","owner_email":"dev10may20@yopmail.com","owner_dob":null,"Owner_Country":"USA","LeadId":"00Q3K000001EnrCUAS","isPrimaryContact":true,"CreditScorefromWebform":null}],"LeadStatus":"New","LeadId":"00Q3K000001EnrCUAS","LastName":"Blacksmith","IsTheUnitedStatesThePrincipalPlaceOfResidenceForAllEmployees":true,"isBusinessDebtSettled":null,"HaveyousubmittedaloanrequersttoSBAoranyotheragencyorfinancialinstutiontinconnectionwithCovid_19":false,"Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins":true,"Haveyoueverdefaultedonagovernmentloan_includedSBAloan_Studentloan_etc":false,"Haveyoueverbeenconvictedofacrime":false,"Franchise":false,"FirstName":"L A","federalTaxId":null,"Ethnicity":"00","Email":"dev10may20@yopmail.com","DoyourentORownbusinessspace":true,"Doyouhaveataxlienoftaxesdue":false,"DoestheBusinesshaveexistingSBADebt":false,"Disabled":false,"dbaName":"JAZZ-PLUS","CurrentSBAEconomicDisasterInjuryLoanBalance":0,"County":null,"corporateName":"Test Lead Sysnc API from Salesforce itself","contactPosition":"Position","contactPhone":null,"contactLastName":null,"contactFirstName":null,"contactEmail":"dev10may20@yopmail.com","BusinessWebAdress":null,"BusinessType":"Sole Proprietor (With Employees)","BusinessState":"NY","BusinessStartDate":null,"BusinessName":"Test Lead Sysnc API from Salesforce itself","BusinessEIN":"50444534","Business_Id":"2022","BuinessZip":"11221","BuinessState":"NY","BuinessCity":"BROOKLYN","BuinessAddress":"154 WEIRFIELD ST","Average_Monthly_Payroll":"2165.00","Arethereanylegalactionspendingagainstyou_oryourspouse":false,"arethemajorityownesofthebusinessUSCitizensorLegalPermanentResidents":false,"Application_Id":"DIR16406418","AnnualPayrollCost":2165,"AnnualGrossRevenue":1,"AmountRequested":10000.0,"AmountofrentORmtg":0}]}';
        RestContext.request = setTestRestRequest(requestBodyString,'/salesforce/applicationData/update/*','POST');
        RestContext.response = new RestResponse();
          Set<Id> setOfId = new Set<Id>();
          setOfId.add(objLead.id);
       
        // question
         Set<String> setOfQst = new Set<String>();
          
        Lead_Questions__c  objqst = new Lead_Questions__c();
        objqst.Question_Type__c = 'what ir ur name';
        objqst.Answer__c ='test';
        objqst.Question__c  = 'tet';
        objqst.Question_Id__c ='2';
        //objqst.Business_Id__c = '1156';
        objqst.Lead__c = objLead.Id;
        objqst.Tenant_Id__c =  '123';
        insert objqst;
        objqst.Answer__c=  '1233';
        update objqst;
        
        Sub_Question__c sub = new Sub_Question__c();
        sub.Question_Type__c = 'what ir ur name';
        sub.Answer__c ='test';
        sub.Question__c  = 'tet';
        sub.Lead_Question__c = objqst.id;
        sub.Sub_Question_Id__c = '66';
        sub.Parent_Question_Id__c ='2';
        insert sub;
        sub.Answer__c=  '1233';
        update sub;
        String requestBodySQsttring = '{"TenantId":14,"Questionnaire":[{"questionType":"text","questionId":1,"questionDesc":"1) Test Please provide the total combined household taxable income as reported on your most recently filed federal tax returns (for 2019, Line 11b, for 2018, Line 10) for all individuals in the household.","options":null,"isRequired":null,"isCustomized":null,"answer":"10000"}],"OpportunityId":null,"LeadId":"00Q3J000001cBpQUAU","businessId":17407}';
        RestContext.request = setTestRestRequest(requestBodyString,'/salesforce/applicationData/update/*','POST');
        RestContext.response = new RestResponse();
           setOfQst.add(objqst.id);
        Test.startTest();
            JavaAPICallOut2.updateLeadSFToPortal(setOfId,'');
            JavaAPICallOut2.updateLeadQuestions(setOfQst,'');
        Test.stopTest();
            
       
       
       
    }
    
    private static RestRequest setTestRestRequest(String requestBodyString, String url, String requestType) {
        RestRequest req = new RestRequest();
        req.requestURI = url; 
        req.httpMethod = requestType;
        req.requestBody = Blob.valueof(requestBodyString);
        return req;
        
    }
    private static RestResponse setTestRestResponse(String responseBodyString, String url, String responseType) {
        RestResponse res = new RestResponse();
        res.statusCode = 500;
        //res.responseURI = url; 
        //res.httpMethod = responseType;
        res.responseBody = Blob.valueof(responseBodyString);
        return res;
    }
    }