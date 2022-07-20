@isTest(seeAlldata=true)
public class JavaAPICallOut2_Test{
    static testMethod void LeadConversion_UnitTest1() {
        Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());
        
        Lead objLead = Testutility.createdeaultLead();        
        insert objLead;
        String requestBodyString = '{"listOfLeadData":[{"WomenOwnedBusiness":false,"Willthisloancreatemorejobs":true,"Whoisyourcustomerbase":null,"WhattypeofBusinessisit":"00","Whatdoesyourbusinessdo":"00","Veteran":false,"useOfFunding":null,"TellusMore":"00","Stateofincopration":"NY","SBALoanNumber":888999,"SBAApplicationNumber":232222,"salesforceUserId":"0051V000006zXYSQA2","referredBySalesUserId":null,"referredBy":null,"ReferralPartner":"ourfairshare","rangeValue":null,"Race":"00","Purposeofloan":"Payroll","PhonrNumber":"(917) 453-1528","personalCashBalance":null,"ownerEmailAddress":"dev10may20@yopmail.com","Other":null,"ofemployeesasof2_15_2020":null,"ofemployeesasof12_31_19":null,"of_Jobs_Retained":1.00,"of_Jobs_Created_30th_June":"0.00","netWorth":null,"listOfOwnersData":[{"RunCreditReport":null,"PrimaryOwnerId":null,"ownerCity":"BROOKLYN","ownerCellChone_no":null,"Owner_zipcode":"65488","owner_title":null,"owner_state":"NY","owner_SSN":"050-44-4534","Owner_Rent":null,"Owner_Phone":null,"owner_percentage":null,"owner_last_name":"Blacksmith","Owner_Id":null,"owner_home_address":"154 WEIRFIELD ST","owner_first_name":"L A","owner_email":"dev10may20@yopmail.com","owner_dob":null,"Owner_Country":"USA","LeadId":"00Q3K000001EnrCUAS","isPrimaryContact":true,"CreditScorefromWebform":null}],"LeadStatus":"New","LeadId":"00Q3K000001EnrCUAS","LastName":"Blacksmith","IsTheUnitedStatesThePrincipalPlaceOfResidenceForAllEmployees":true,"isBusinessDebtSettled":null,"HaveyousubmittedaloanrequersttoSBAoranyotheragencyorfinancialinstutiontinconnectionwithCovid_19":false,"Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins":true,"Haveyoueverdefaultedonagovernmentloan_includedSBAloan_Studentloan_etc":false,"Haveyoueverbeenconvictedofacrime":false,"Franchise":false,"FirstName":"L A","federalTaxId":null,"Ethnicity":"00","Email":"dev10may20@yopmail.com","DoyourentORownbusinessspace":true,"Doyouhaveataxlienoftaxesdue":false,"DoestheBusinesshaveexistingSBADebt":false,"Disabled":false,"dbaName":"JAZZ-PLUS","CurrentSBAEconomicDisasterInjuryLoanBalance":0,"County":null,"corporateName":"Test Lead Sysnc API from Salesforce itself","contactPosition":"Position","contactPhone":null,"contactLastName":null,"contactFirstName":null,"contactEmail":"dev10may20@yopmail.com","BusinessWebAdress":null,"BusinessType":"Sole Proprietor (With Employees)","BusinessState":"NY","BusinessStartDate":null,"BusinessName":"Test Lead Sysnc API from Salesforce itself","BusinessEIN":"50444534","Business_Id":"2022","BuinessZip":"65488","BuinessState":"NY","BuinessCity":"BROOKLYN","BuinessAddress":"154 WEIRFIELD ST","Average_Monthly_Payroll":"2165.00","Arethereanylegalactionspendingagainstyou_oryourspouse":false,"arethemajorityownesofthebusinessUSCitizensorLegalPermanentResidents":false,"Application_Id":"DIR16406418","AnnualPayrollCost":2165,"AnnualGrossRevenue":1,"AmountRequested":10000.0,"AmountofrentORmtg":0}]}';
        RestContext.request = setTestRestRequest(requestBodyString,'/salesforce/applicationData/update/*','POST');
        RestContext.response = new RestResponse();
        Set<Id> setOfId = new Set<Id>();
        setOfId.add(objLead.id);
        
        // question
        Set<String> setOfQst = new Set<String>();
        
        Lead_Questions__c  objqst = Testutility.createLeadQuestion(objLead.id);           
        insert objqst;
        String requestBodySQsttring = '{"TenantId":14,"Questionnaire":[{"questionType":"text","questionId":1,"questionDesc":"1) Test Please provide the total combined household taxable income as reported on your most recently filed federal tax returns (for 2019, Line 11b, for 2018, Line 10) for all individuals in the household.","options":null,"isRequired":null,"isCustomized":null,"answer":"10000"}],"OpportunityId":null,"LeadId":"00Q3J000001cBpQUAU","businessId":17407}';
        RestContext.request = setTestRestRequest(requestBodyString,'/salesforce/applicationData/update/*','POST');
        RestContext.response = new RestResponse();
        setOfQst.add(objqst.id);
        Test.startTest();
        JavaAPICallOut2.updateLeadSFToPortal(setOfId, 'profeb');
        JavaAPICallOut2.updateLeadQuestions(setOfQst, 'test');
        
        
        Test.stopTest();
        JSON2ApexQuestions   qsr = new JSON2ApexQuestions();
        JSON2ApexQuestions.Questionnaire  oQst = new  JSON2ApexQuestions.Questionnaire();
        oQst.questionId =1;
        oQst.questionDesc ='';
        oQst.questionType='';
        oQst.isRequired = true;
        oQst.answer ='';
        oQst.options ='';
        oQst.isCustomized = true;
        List<JSON2ApexQuestions.Questionnaire> listQ = new List<JSON2ApexQuestions.Questionnaire>();
        listQ.add(oQst);
        
        qsr.TenantId =1;
        qsr.LeadId='';
        qsr.OpportunityId='';
        qsr.BusinessId=9;
        qsr.Questionnaire = listQ;
        String strJSON = JSON.serialize(qsr);
        JSON2ApexQuestions.parse(strJSON );
        
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
    
    static testMethod void LeadConversion_UnitTest2() {
        Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());
        Id recTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Lendistry Lending').getRecordTypeId();
        Lead objLead = TestUtility.CreateLeadrecordType(recTypeId);       
        String requestBodyString = '{"listOfLeadData":[{"WomenOwnedBusiness":false,"Willthisloancreatemorejobs":true,"Whoisyourcustomerbase":null,"WhattypeofBusinessisit":"00","Whatdoesyourbusinessdo":"00","Veteran":false,"useOfFunding":null,"TellusMore":"00","Stateofincopration":"NY","SBALoanNumber":888999,"SBAApplicationNumber":232222,"salesforceUserId":"0051V000006zXYSQA2","referredBySalesUserId":null,"referredBy":null,"ReferralPartner":"ourfairshare","rangeValue":null,"Race":"00","Purposeofloan":"Payroll","PhonrNumber":"(917) 453-1528","personalCashBalance":null,"ownerEmailAddress":"dev10may20@yopmail.com","Other":null,"ofemployeesasof2_15_2020":null,"ofemployeesasof12_31_19":null,"of_Jobs_Retained":1.00,"of_Jobs_Created_30th_June":"0.00","netWorth":null,"listOfOwnersData":[{"RunCreditReport":null,"PrimaryOwnerId":null,"ownerCity":"BROOKLYN","ownerCellChone_no":null,"Owner_zipcode":"65488","owner_title":null,"owner_state":"NY","owner_SSN":"050-44-4534","Owner_Rent":null,"Owner_Phone":null,"owner_percentage":null,"owner_last_name":"Blacksmith","Owner_Id":null,"owner_home_address":"154 WEIRFIELD ST","owner_first_name":"L A","owner_email":"dev10may20@yopmail.com","owner_dob":null,"Owner_Country":"USA","LeadId":"00Q3K000001EnrCUAS","isPrimaryContact":true,"CreditScorefromWebform":null}],"LeadStatus":"New","LeadId":"00Q3K000001EnrCUAS","LastName":"Blacksmith","IsTheUnitedStatesThePrincipalPlaceOfResidenceForAllEmployees":true,"isBusinessDebtSettled":null,"HaveyousubmittedaloanrequersttoSBAoranyotheragencyorfinancialinstutiontinconnectionwithCovid_19":false,"Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins":true,"Haveyoueverdefaultedonagovernmentloan_includedSBAloan_Studentloan_etc":false,"Haveyoueverbeenconvictedofacrime":false,"Franchise":false,"FirstName":"L A","federalTaxId":null,"Ethnicity":"00","Email":"dev10may20@yopmail.com","DoyourentORownbusinessspace":true,"Doyouhaveataxlienoftaxesdue":false,"DoestheBusinesshaveexistingSBADebt":false,"Disabled":false,"dbaName":"JAZZ-PLUS","CurrentSBAEconomicDisasterInjuryLoanBalance":0,"County":null,"corporateName":"Test Lead Sysnc API from Salesforce itself","contactPosition":"Position","contactPhone":null,"contactLastName":null,"contactFirstName":null,"contactEmail":"dev10may20@yopmail.com","BusinessWebAdress":null,"BusinessType":"Sole Proprietor (With Employees)","BusinessState":"NY","BusinessStartDate":null,"BusinessName":"Test Lead Sysnc API from Salesforce itself","BusinessEIN":"50444534","Business_Id":"2022","BuinessZip":"65488","BuinessState":"NY","BuinessCity":"BROOKLYN","BuinessAddress":"154 WEIRFIELD ST","Average_Monthly_Payroll":"2165.00","Arethereanylegalactionspendingagainstyou_oryourspouse":false,"arethemajorityownesofthebusinessUSCitizensorLegalPermanentResidents":false,"Application_Id":"DIR16406418","AnnualPayrollCost":2165,"AnnualGrossRevenue":1,"AmountRequested":10000.0,"AmountofrentORmtg":0}]}';
        RestContext.request = setTestRestRequest(requestBodyString,'/salesforce/applicationData/update/*','POST');
        RestContext.response = new RestResponse();
        Set<Id> setOfId = new Set<Id>();
        setOfId.add(objLead.id);
        
        // question
        Set<String> setOfQst = new Set<String>();
        
        Lead_Questions__c  objqst = Testutility.createLeadQuestion(objLead.id);           
        insert objqst;
        String requestBodySQsttring = '{"TenantId":14,"Questionnaire":[{"questionType":"text","questionId":1,"questionDesc":"1) Test Please provide the total combined household taxable income as reported on your most recently filed federal tax returns (for 2019, Line 11b, for 2018, Line 10) for all individuals in the household.","options":null,"isRequired":null,"isCustomized":null,"answer":"10000"}],"OpportunityId":null,"LeadId":"00Q3J000001cBpQUAU","businessId":17407}';
        RestContext.request = setTestRestRequest(requestBodyString,'/salesforce/applicationData/update/*','POST');
        RestContext.response = new RestResponse();
        setOfQst.add(objqst.id);
        Test.startTest();
        JavaAPICallOut2.updateLeadSFToPortal(setOfId, 'profeb');
        JavaAPICallOut2.updateLeadQuestions(setOfQst, 'test');
        
        
        Test.stopTest();
        JSON2ApexQuestions   qsr = new JSON2ApexQuestions();
        JSON2ApexQuestions.Questionnaire  oQst = new  JSON2ApexQuestions.Questionnaire();
        oQst.questionId =1;
        oQst.questionDesc ='';
        oQst.questionType='';
        oQst.isRequired = true;
        oQst.answer ='';
        oQst.options ='';
        oQst.isCustomized = true;
        List<JSON2ApexQuestions.Questionnaire> listQ = new List<JSON2ApexQuestions.Questionnaire>();
        listQ.add(oQst);
        
        qsr.TenantId =1;
        qsr.LeadId='';
        qsr.OpportunityId='';
        qsr.BusinessId=9;
        qsr.Questionnaire = listQ;
        String strJSON = JSON.serialize(qsr);
        JSON2ApexQuestions.parse(strJSON );
    }
    
    static testMethod void LeadConversion_UnitTest3() {
        Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());
        
        Id recTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Lendistry Lending').getRecordTypeId();
        Lead objLead = TestUtility.CreateLeadrecordType(recTypeId);  
        insert objLead;
        String requestBodyString = '{"listOfLeadData":[{"WomenOwnedBusiness":false,"Willthisloancreatemorejobs":true,"Whoisyourcustomerbase":null,"WhattypeofBusinessisit":"00","Whatdoesyourbusinessdo":"00","Veteran":false,"useOfFunding":null,"TellusMore":"00","Stateofincopration":"NY","SBALoanNumber":888999,"SBAApplicationNumber":232222,"salesforceUserId":"0051V000006zXYSQA2","referredBySalesUserId":null,"referredBy":null,"ReferralPartner":"ourfairshare","rangeValue":null,"Race":"00","Purposeofloan":"Payroll","PhonrNumber":"(917) 453-1528","personalCashBalance":null,"ownerEmailAddress":"dev10may20@yopmail.com","Other":null,"ofemployeesasof2_15_2020":null,"ofemployeesasof12_31_19":null,"of_Jobs_Retained":1.00,"of_Jobs_Created_30th_June":"0.00","netWorth":null,"listOfOwnersData":[{"RunCreditReport":null,"PrimaryOwnerId":null,"ownerCity":"BROOKLYN","ownerCellChone_no":null,"Owner_zipcode":"65488","owner_title":null,"owner_state":"NY","owner_SSN":"050-44-4534","Owner_Rent":null,"Owner_Phone":null,"owner_percentage":null,"owner_last_name":"Blacksmith","Owner_Id":null,"owner_home_address":"154 WEIRFIELD ST","owner_first_name":"L A","owner_email":"dev10may20@yopmail.com","owner_dob":null,"Owner_Country":"USA","LeadId":"00Q3K000001EnrCUAS","isPrimaryContact":true,"CreditScorefromWebform":null}],"LeadStatus":"New","LeadId":"00Q3K000001EnrCUAS","LastName":"Blacksmith","IsTheUnitedStatesThePrincipalPlaceOfResidenceForAllEmployees":true,"isBusinessDebtSettled":null,"HaveyousubmittedaloanrequersttoSBAoranyotheragencyorfinancialinstutiontinconnectionwithCovid_19":false,"Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins":true,"Haveyoueverdefaultedonagovernmentloan_includedSBAloan_Studentloan_etc":false,"Haveyoueverbeenconvictedofacrime":false,"Franchise":false,"FirstName":"L A","federalTaxId":null,"Ethnicity":"00","Email":"dev10may20@yopmail.com","DoyourentORownbusinessspace":true,"Doyouhaveataxlienoftaxesdue":false,"DoestheBusinesshaveexistingSBADebt":false,"Disabled":false,"dbaName":"JAZZ-PLUS","CurrentSBAEconomicDisasterInjuryLoanBalance":0,"County":null,"corporateName":"Test Lead Sysnc API from Salesforce itself","contactPosition":"Position","contactPhone":null,"contactLastName":null,"contactFirstName":null,"contactEmail":"dev10may20@yopmail.com","BusinessWebAdress":null,"BusinessType":"Sole Proprietor (With Employees)","BusinessState":"NY","BusinessStartDate":null,"BusinessName":"Test Lead Sysnc API from Salesforce itself","BusinessEIN":"50444534","Business_Id":"2022","BuinessZip":"65488","BuinessState":"NY","BuinessCity":"BROOKLYN","BuinessAddress":"154 WEIRFIELD ST","Average_Monthly_Payroll":"2165.00","Arethereanylegalactionspendingagainstyou_oryourspouse":false,"arethemajorityownesofthebusinessUSCitizensorLegalPermanentResidents":false,"Application_Id":"DIR16406418","AnnualPayrollCost":2165,"AnnualGrossRevenue":1,"AmountRequested":10000.0,"AmountofrentORmtg":0}]}';
        RestContext.request = setTestRestRequest(requestBodyString,'/salesforce/applicationData/update/*','POST');
        RestContext.response = new RestResponse();
        Set<Id> setOfId = new Set<Id>();
        setOfId.add(objLead.id);
        
        // question
        Set<String> setOfQst = new Set<String>();
        
        Lead_Questions__c  objqst = Testutility.createLeadQuestion(objLead.id);           
        insert objqst;
        String requestBodySQsttring = '{"TenantId":14,"Questionnaire":[{"questionType":"text","questionId":1,"questionDesc":"1) Test Please provide the total combined household taxable income as reported on your most recently filed federal tax returns (for 2019, Line 11b, for 2018, Line 10) for all individuals in the household.","options":null,"isRequired":null,"isCustomized":null,"answer":"10000"}],"OpportunityId":null,"LeadId":"00Q3J000001cBpQUAU","businessId":17407}';
        RestContext.request = setTestRestRequest(requestBodyString,'/salesforce/applicationData/update/*','POST');
        RestContext.response = new RestResponse();
        setOfQst.add(objqst.id);
        Test.startTest();
        JavaAPICallOut2.updateLeadSFToPortal(setOfId, 'profeb');
        JavaAPICallOut2.updateLeadQuestions(setOfQst, 'test');
        
        
        Test.stopTest();
        JSON2ApexQuestions   qsr = new JSON2ApexQuestions();
        JSON2ApexQuestions.Questionnaire  oQst = new  JSON2ApexQuestions.Questionnaire();
        oQst.questionId =1;
        oQst.questionDesc ='';
        oQst.questionType='';
        oQst.isRequired = true;
        oQst.answer ='';
        oQst.options ='';
        oQst.isCustomized = true;
        List<JSON2ApexQuestions.Questionnaire> listQ = new List<JSON2ApexQuestions.Questionnaire>();
        listQ.add(oQst);
        
        qsr.TenantId =1;
        qsr.LeadId='';
        qsr.OpportunityId='';
        qsr.BusinessId=9;
        qsr.Questionnaire = listQ;
        String strJSON = JSON.serialize(qsr);
        JSON2ApexQuestions.parse(strJSON );
    }
}