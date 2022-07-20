@isTest(SeeAllData=true)
public class SalesforceLeadInsertSBAPPP_Test {
    
    private static RestRequest setTestRestRequest(String requestBodyString, String url, String requestType) 
    {
        RestRequest req = new RestRequest();
        req.requestURI = url; 
        req.httpMethod = requestType;
        req.requestBody = Blob.valueof(requestBodyString);
        return req;
        
    }
    
    @isTest
    public static void InserLead()
    {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String requestBodyString = '{  "RecordTypeID" : "SBA - PPP",  "ApplicationID" : "DIR12345",  "BusinessID" : "9821",  "ReferralPartner" : "ICICI Bank",  "Company" : "Test Company",  "DBA" : "DBA",  "BusinessEIN" : 123456,  "BusinessPhone" : "9876543210",  "BusinessType" : "Corporation",  "StateOfIncorporation" : "MO",  "BusinessStreet" : "220 Locust Ave",  "BusinessCity" : "Anthill",  "BusinessState" : "MO",  "BusinessZipCode" : "65488",  "BusinessCountry" : "USA",  "BusinessStartDate" : "",  "BusinessWebsite" : "www.test.com",  "DoYouRentOwnBusinessSpace" : true,  "MonthlyRentMtg" : 15000,  "WhoIsYourCustomerBase" : "B2B",  "WhatDoesYourBusinessDo" : "Service Business",  "WhatTypeOfBusinessIsIt" : "Insurance/Real Estate",  "TellUsMore" : "Independent Insurance Carriers",  "NAICSCode" : "123456",  "PurposeOfTheLoan" : "Other",  "Other" : "Test Other",  "RequestedAmount" : 50000,  "WillThisLoanCreateMoreJobs" : true,  "NoOfCurrentEmployees" : 10,  "NoOfJobsCreated" : 20,  "NoOfJobsRetained" : 30,  "AverageMonthlyPayroll" : 40,  "WomenOwned" : true,  "Veteran" : true,  "Disabled" : true,  "Race" : "American Indian",  "Ethnicity" : "Hispanic or Latino",  "Franchise" : false,  "CurrentSBAEconomicDisasterInjuryLoanBalance" : 22000,  "Rural" : true,  "ScholarAlumini" : true,  "DoFiftyPercentEmployeeEarnLessThan" : true,  "HaveYouEverBeenConvictedOfCrime" : true,  "AreThereAnyLegalActionPendingAgainstYou" : false,  "DoYouHaveTaxLien" : true,  "HaveYouExhausedAllPersonalFinancingOption" : false,  "HaveYouEverDefaultedOnGovernmentLoan" : true,  "IsTheUSPrincipalPlaceOfResidenceOfAllEmployees" : false,  "DoesBusinessHaveExistingSBADebt" : true,  "HaveYouSubmittedLoanRequestInConnectionWithCOVID19" : false,   "OwnerInfoList" : [  {  "OwnerNumber" : "1",  "OwnerID" : "123",  "OwnerFirstName" : "Marisol",  "OwnerLastName" : "Testcase",  "OwnerEmail" : "Marisol@Yopmail.com",  "OwnerPhone" : "9999999999",  "OwnerStreet" : "220 Locust Ave",  "OwnerCity" : "Anthill",  "OwnerState" : "MO",  "OwnerZipcode" : "65488",  "OwnerCountry" : "USA",  "OwnerSSN" : "000000001"  }  ]  }';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceLeadInsertSBAPPP/*','POST');
        RestContext.response = new RestResponse();
        
        Test.startTest();
        SalesforceLeadInsertSBAPPP.insertLeadSBAPPP();
        Test.stopTest();
        
    }
    
    @isTest
    public static void InserLeadforException()
    {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String requestBodyString = '{  "RecordTypeID" : "123",  "ApplicationID" : "DIR12345",  "BusinessID" : "9821",  "ReferralPartner" : "ICICI Bank",  "Company" : "Test Company",  "DBA" : "DBA",  "BusinessEIN" : 123456,  "BusinessPhone" : "9876543210",  "BusinessType" : "Corporation",  "StateOfIncorporation" : "MO",  "BusinessStreet" : "220 Locust Ave",  "BusinessCity" : "Anthill",  "BusinessState" : "MO",  "BusinessZipCode" : "65488",  "BusinessCountry" : "USA",  "BusinessStartDate" : "",  "BusinessWebsite" : "www.test.com",  "DoYouRentOwnBusinessSpace" : true,  "MonthlyRentMtg" : 15000,  "WhoIsYourCustomerBase" : "B2B",  "WhatDoesYourBusinessDo" : "Service Business",  "WhatTypeOfBusinessIsIt" : "Insurance/Real Estate",  "TellUsMore" : "Independent Insurance Carriers",  "NAICSCode" : "123456",  "PurposeOfTheLoan" : "Other",  "Other" : "Test Other",  "RequestedAmount" : 50000,  "WillThisLoanCreateMoreJobs" : true,  "NoOfCurrentEmployees" : 10,  "NoOfJobsCreated" : 20,  "NoOfJobsRetained" : 30,  "AverageMonthlyPayroll" : 40,  "WomenOwned" : true,  "Veteran" : true,  "Disabled" : true,  "Race" : "American Indian",  "Ethnicity" : "Hispanic or Latino",  "Franchise" : false,  "CurrentSBAEconomicDisasterInjuryLoanBalance" : 22000,  "Rural" : true,  "ScholarAlumini" : true,  "DoFiftyPercentEmployeeEarnLessThan" : true,  "HaveYouEverBeenConvictedOfCrime" : true,  "AreThereAnyLegalActionPendingAgainstYou" : false,  "DoYouHaveTaxLien" : true,  "HaveYouExhausedAllPersonalFinancingOption" : false,  "HaveYouEverDefaultedOnGovernmentLoan" : true,  "IsTheUSPrincipalPlaceOfResidenceOfAllEmployees" : false,  "DoesBusinessHaveExistingSBADebt" : true,  "HaveYouSubmittedLoanRequestInConnectionWithCOVID19" : false,   "OwnerInfoList" : [  {  "OwnerNumber" : "1",  "OwnerID" : "123",  "OwnerFirstName" : "Marisol",  "OwnerLastName" : "Testcase",  "OwnerEmail" : "Marisol@Yopmail.com",  "OwnerPhone" : "9999999999",  "OwnerStreet" : "220 Locust Ave",  "OwnerCity" : "Anthill",  "OwnerState" : "MO",  "OwnerZipcode" : "65488",  "OwnerCountry" : "USA",  "OwnerSSN" : "000000001"  }  ]  }';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceLeadInsertSBAPPP/*','POST');
        RestContext.response = new RestResponse();
        
        Test.startTest();
        SalesforceLeadInsertSBAPPP.insertLeadSBAPPP();
        Test.stopTest();
        
    }
}