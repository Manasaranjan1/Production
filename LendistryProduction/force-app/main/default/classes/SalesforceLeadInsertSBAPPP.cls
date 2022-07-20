@RestResource(urlMapping='/SalesforceLeadInsertSBAPPP/*')

global with sharing class SalesforceLeadInsertSBAPPP {

@HttpPost 
global static void insertLeadSBAPPP() {
    
    RestRequest request = RestContext.request;
    RestResponse res = RestContext.response;
    res.addHeader('Content-Type', 'application/json');
    JSON2ApexSBAPPP leadinfo = new JSON2ApexSBAPPP();
    leadinfo = JSON2ApexSBAPPP.parse(request.requestBody.toString());
    String jsonResponse = '';
    Portal_Integration_Response_Code__c objPortalExceptionHadling = new Portal_Integration_Response_Code__c();
    Lead objLead = new Lead();
    
    try
    {
    
    if(leadinfo !=null ){
        
        //objLead.RecordTypeId = leadinfo.RecordTypeID;
        Id devRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get(leadinfo.RecordTypeID).getRecordTypeId();
        objLead.RecordTypeId = devRecordTypeId;
        objLead.IsSyncWithPortal__c = true;
        objLead.Application_ID_SBAPPP__c = leadinfo.ApplicationID;
        objLead.Business_ID_SBAPPP__c = leadinfo.BusinessID;
        objLead.Referral_Partner1__c = leadinfo.ReferralPartner;
        objLead.Company = leadinfo.Company;
        objLead.DBA__c = leadinfo.DBA;
        objLead.Business_EIN__c = String.valueof(leadinfo.BusinessEIN);
        objLead.Business_Phone__c = leadinfo.BusinessPhone;
        objLead.Entity_Type__c = leadinfo.BusinessType;
        objLead.State_of_incopration__c = leadinfo.StateOfIncorporation;
        objLead.Street = leadinfo.BusinessStreet;
        objLead.City = leadinfo.BusinessCity;
        objLead.State = leadinfo.BusinessState;
        objLead.PostalCode = leadinfo.BusinessZipCode;
        //objLead.Country = leadinfo.BusinessCountry;
        if(leadinfo.BusinessCountry == 'United States' || leadinfo.BusinessCountry == 'USA' || leadinfo.BusinessCountry == 'US')
        {
            objLead.Country = leadinfo.BusinessCountry;
        }
        Else
        {
            objLead.Country = 'USA';
        }
        if(leadinfo.BusinessStartDate != null && leadinfo.BusinessStartDate != '')
        {
            objLead.Business_Start_Date__c = Date.valueOf(leadinfo.BusinessStartDate);
        }
        objLead.Website = leadinfo.BusinessWebsite;
        objLead.Do_you_rent_own_business_space__c = leadinfo.DoYouRentOwnBusinessSpace == true? 'Yes': 'No';
        if( leadinfo.MonthlyRentMtg != null )
        {
                objLead.Monthly_Rent_Mtg__c = leadinfo.MonthlyRentMtg;
        }
        objLead.Who_is_Your_Customer_Base1__c = leadinfo.WhoIsYourCustomerBase;
        if(leadinfo.WhatDoesYourBusinessDo != null && leadinfo.WhatDoesYourBusinessDo != '')
        {
            objLead.What_does_your_Business_do__c = leadinfo.WhatDoesYourBusinessDo;
        }
        if(leadinfo.WhatTypeOfBusinessIsIt != null && leadinfo.WhatTypeOfBusinessIsIt != '')
        {
            objLead.What_type_of_Business_is_it__c = leadinfo.WhatTypeOfBusinessIsIt;
        }
        if(leadinfo.TellUsMore != null && leadinfo.TellUsMore != '')
        {
            objLead.Tell_us_more__c = leadinfo.TellUsMore;
        }
        objLead.NAICS_CODE__c = leadinfo.NAICSCode;
        objLead.Purpose_of_the_loan__c = leadinfo.PurposeOfTheLoan;
        if(leadinfo.Other != null && leadinfo.Other != '')
        {
            objLead.Other__c = leadinfo.Other;
        }
        if(leadinfo.RequestedAmount != null)
        {
            objLead.Requested_Amount__c = leadinfo.RequestedAmount;
        }
        objLead.Will_this_loan_create_more_Jobs__c = leadinfo.WillThisLoanCreateMoreJobs == true? 'Yes': 'No';
        if(leadinfo.NoOfCurrentEmployees != null)
        {
            objLead.of_Current_Employees__c = leadinfo.NoOfCurrentEmployees;
        }
        if(leadinfo.NoOfJobsCreated != null)
        {
            objLead.of_Jobs_Created_30th_June__c = leadinfo.NoOfJobsCreated;
        }
        if(leadinfo.NoOfJobsRetained != null)
        {
            objLead.of_Jobs_Retained__c = leadinfo.NoOfJobsRetained;
        }
        if(leadinfo.AverageMonthlyPayroll != null)
        {
            objLead.Average_Monthly_Payroll__c = leadinfo.AverageMonthlyPayroll;
        }
        objLead.Women_Owned__c = leadinfo.WomenOwned == true? 'Yes': 'No';
        objLead.Veteran__c = leadinfo.Veteran == true? 'Yes': 'No';
        objLead.Disabled__c = leadinfo.Disabled == true? 'Yes': 'No';
        objLead.Race__c = leadinfo.Race;
        objLead.Ethnicity__c = leadinfo.Ethnicity;
        objLead.Franchise__c = leadinfo.Franchise == true? 'Yes': 'No';
        if(leadinfo.CurrentSBAEconomicDisasterInjuryLoanBalance != null)
        {
            objLead.Curr_SBA_Econ_Disaster_Injury_Loan_Bal__c = leadinfo.CurrentSBAEconomicDisasterInjuryLoanBalance;
        }
        
        objLead.Rural__c = leadinfo.Rural;
        objLead.X0KSB_Scholar_Alumni__c = leadinfo.ScholarAlumini;
        objLead.Do_50_of_empl_earn_less_than_51859__c = leadinfo.DoFiftyPercentEmployeeEarnLessThan;
        objLead.Have_you_ever_been_convicted_of_a_crime__c = leadinfo.HaveYouEverBeenConvictedOfCrime== true? 'Yes': 'No';
        objLead.Legal_action_pending_against_youspouse__c = leadinfo.AreThereAnyLegalActionPendingAgainstYou== true? 'Yes': 'No';
        objLead.Do_you_have_a_tax_lien_of_taxes_due__c = leadinfo.DoYouHaveTaxLien== true? 'Yes': 'No';
        objLead.exhausted_personal_nonSBA_financing__c = leadinfo.HaveYouExhausedAllPersonalFinancingOption== true? 'Yes': 'No';
        objLead.Have_you_ever_defaulted_on_a_govt_loan__c = leadinfo.HaveYouEverDefaultedOnGovernmentLoan== true? 'Yes': 'No';
        objLead.Is_the_US_Principal_place_of_residence__c = leadinfo.IsTheUSPrincipalPlaceOfResidenceOfAllEmployees== true? 'Yes': 'No';
        objLead.Does_the_Business_have_existing_SBA_Debt__c = leadinfo.DoesBusinessHaveExistingSBADebt== true? 'Yes': 'No';
        objLead.Submit_loan_req_SBAfinancial_COVID19__c = leadinfo.HaveYouSubmittedLoanRequestInConnectionWithCOVID19== true? 'Yes': 'No';
        
        if(leadinfo.OwnerInfoList != null && leadinfo.OwnerInfoList.size()> 0 )
        {
            
            for( JSON2ApexSBAPPP.OwnerInfoWrap eachOwner : leadinfo.OwnerInfoList)
            {
                if(eachOwner.OwnerNumber == '1')
                {
                    objLead.Owner_ID_Owner_1__c = eachOwner.OwnerID;
                    objLead.FirstName = eachOwner.OwnerFirstName;
                    objLead.LastName = eachOwner.OwnerLastName;
                    objLead.Email = eachOwner.OwnerEmail;
                    objLead.Phone = eachOwner.OwnerPhone;
                    objLead.Street_Owner_1__c = eachOwner.OwnerStreet;
                    objLead.City_Owner_1__c = eachOwner.OwnerCity;
                    objLead.State_Owner_1__c = eachOwner.OwnerState;
                    objLead.Zip_Code_Owner_1__c = eachOwner.OwnerZipcode;
                    //objLead.Country_Owner_1__c = eachOwner.OwnerCountry;
                    if(eachOwner.OwnerCountry == 'United States' || eachOwner.OwnerCountry == 'USA' || eachOwner.OwnerCountry == 'US')
                        {
                            objLead.Country_Owner_1__c = eachOwner.OwnerCountry;
                        }
                        Else
                        {
                            objLead.Country_Owner_1__c = 'USA';
                        }
                    objLead.SSN1__c = eachOwner.OwnerSSN;
                    
                }
            }
        }
        insert objLead;
        
        // Error Handling Object
        res.statusCode = 200;
                jsonResponse = '{"status": true, "id": "' + objLead.ID+ '", "errors":[]}';
                res.responseBody = blob.valueOf(jsonResponse);  
                objPortalExceptionHadling.Response__c = jsonResponse;
                objPortalExceptionHadling.Success_Error_Code__c = '200';
                objPortalExceptionHadling.Request__c = request.requestBody.toString();
                objPortalExceptionHadling.exception__c = null;
                 objPortalExceptionHadling.Business_Id__c = leadinfo.BusinessID;
                objPortalExceptionHadling.Application_Id__c = leadinfo.ApplicationID;
                objPortalExceptionHadling.Opportunity_Id__c = '';
                objPortalExceptionHadling.Lead_Id__c = objLead.Id;
        
    }
    } 
    Catch (Exception ex)
    {
        res.statusCode = 500;
            jsonResponse = '{"status": false, "errors": "[' + ex + ']"}';
            res.responseBody = blob.valueOf(jsonResponse); 
            objPortalExceptionHadling.Response__c = jsonResponse;
            objPortalExceptionHadling.Success_Error_Code__c = '500';
            objPortalExceptionHadling.Business_Id__c = leadinfo.BusinessID;
            objPortalExceptionHadling.Application_Id__c = leadinfo.ApplicationID;
            objPortalExceptionHadling.Opportunity_Id__c = '';
            objPortalExceptionHadling.Lead_Id__c = objLead.Id;
            objPortalExceptionHadling.Request__c = request.requestBody.toString();
            objPortalExceptionHadling.exception__c = string.valueof(ex);
    }
    insert objPortalExceptionHadling;
}

}