@RestResource(urlMapping='/SalesforceLeadInsertAPI/*')

global with sharing class SalesforceLeadInsertAPI {
    public static integer i=1;
    @HttpPost 
    global static void insertLeadData() {
        
        RestRequest request = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String jsonResponse = '';
        List<Integer> lstOfOwners = new List<Integer>();
        JSON2Apex leadinfo = new JSON2Apex();
        Lead objLead = new Lead();
        list<product__c> lstOfProducts = new list<product__c>();
        system.debug('+++Request body+++'+request.requestBody.toString());
        Portal_Integration_Response_Code__c objPortalExceptionHadling = new Portal_Integration_Response_Code__c();
        try
        {
            system.debug('++Enter try++');
            //Id recCRGTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('CRG').getRecordTypeId();
            Id recTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('GRANT').getRecordTypeId();
            Id GrantNyrrecTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('GRANT-NYR').getRecordTypeId();
            Id CarlrecTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('SBA-CARL').getRecordTypeId();
            Id GrantNYCTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Grant-NYC').getRecordTypeId();
            leadinfo = JSON2Apex.parse(request.requestBody.toString());
            if(leadinfo !=null ){
                
                /* if( leadinfo.LoanType != null && leadinfo.LoanType != '' && 
                ( leadinfo.LoanType == 'LUZERNE CARES'  || leadinfo.LoanType == 'LUZERNE NPO CARES'  || 
                leadinfo.LoanType == 'PA CARES'  ||  leadinfo.LoanType=='YoCo STRONG' ||  
                leadinfo.LoanType=='YoCo STRONG NPO' || leadinfo.LoanType == 'BERKS COUNTY' ||  
                leadinfo.LoanType=='LackawannaCARES' ||  leadinfo.LoanType=='PhiladelphiaCARES' ||  
                leadinfo.LoanType=='AlleghenyCARES' || leadinfo.LoanType=='CRG')&& recTypeId != null )
                {*/
                
                if( leadinfo.TenantId != null  && leadinfo.LoanType != null && leadinfo.LoanType !='' )
                {   
                    lstOfProducts = [select id,Is_Grant__c from product__c where Tenant__r.Tenant_ID__c =:leadinfo.TenantId AND name =:leadinfo.LoanType LIMIT 1];
                    system.debug('----lstOfProducts.size()---->>'+lstOfProducts.size());
                    // Insert Lead with Record type of 'GRANT'
                    if(lstOfProducts!=null && lstOfProducts.size() > 0 && lstOfProducts[0].Is_Grant__c == true && leadinfo.LoanType != 'NYR'){
                        objLead.RecordTypeId = recTypeId;  
                    }
                   else if(lstOfProducts!=null && lstOfProducts.size() > 0 && lstOfProducts[0].Is_Grant__c == true && leadinfo.LoanType == 'NYR'){
                        objLead.RecordTypeId = GrantNyrrecTypeId;  
                    }
                }
                // }    
                if( leadinfo.LoanType != null && leadinfo.LoanType != '' && ( leadinfo.LoanType == 'CARL') && recTypeId != null )
                {
                    // Insert Lead with Record type of 'CARL'
                    objLead.RecordTypeId = CarlrecTypeId;
                } 
                if( leadinfo.application_id != null && leadinfo.application_id != '')
                    objLead.Application_ID__c = leadinfo.application_id;
                if( leadinfo.BusinessId != null && leadinfo.BusinessId != '')
                    objLead.BusinessId__c = leadinfo.BusinessId;
                 
                 if( leadinfo.LoanType != null && leadinfo.LoanType != '' && ( leadinfo.LoanType == 'NYC') && GrantNYCTypeId != null ){
                    objLead.RecordTypeId = GrantNYCTypeId;
                    /*objLead.How_did_you_hear_about_us__c = leadinfo.howDidYouHearAboutUs;
                    objLead.Business_Stage__c = leadinfo.businessStageName;
                    objLead.Location_Type__c = leadinfo.locationTypeName;
                    objLead.of_Employees_Temporary_Full_Time_2020__c = Decimal.valueOf(leadinfo.numberOfTempFullTimeEmployees);
                    objLead.of_Employees_Temporary_Part_Time_2020__c = Decimal.valueOf(leadinfo.numberOfTempPartTimeEmployees);*/
                }
                objLead.Tenant_Referral_Partner_Name__c = leadinfo.TenantReferralPartnerName;
                objLead.Preferred_Language__c = leadinfo.PreferredLanguage;
                objLead.Loan_Type__c = leadinfo.LoanType;
                objLead.FirstName = leadinfo.Firstname;
                objLead.LastName = leadinfo.LastName;
                objLead.company  = leadinfo.company;
                objLead.BusinessId__c = leadinfo.BusinessId;
                objLead.LeadSource = leadinfo.LeadSource;
                objLead.Email = leadinfo.Email;
                objLead.Portal_Application_Status__c = 'Unfinished';
                if(String.isNotBlank(String.valueOf(leadinfo.Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins))){
                    objLead.Have_you_exhausted_all_personal_non_SB__c = leadinfo.Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins == true? 'Yes':'No';
                } 
                
                if(String.isNotBlank(String.valueOf(leadinfo.DoestheBusinesshaveexistingSBADebt))){
                    objLead.Does_the_Business_have_existing_SBA_Debt__c = leadinfo.DoestheBusinesshaveexistingSBADebt == true? 'Yes':'No';
                }
                if(leadinfo.Referral_Id != null && leadinfo.Referral_Id != '')
                    objLead.Ownerid = leadinfo.Referral_Id;
                // objLead.SMS_Opt_In__c = leadinfo.SMS_Opt_In;
                objLead.Tenant_Id__c = leadinfo.TenantId;
                if(leadinfo.TenantId != null){
                    Tenant_Details__c TenantDetails = [Select ID,Tenant_Name__c from Tenant_Details__c 
                                                       where Tenant_ID__c = :leadinfo.TenantId LIMIT 1];
                    if(TenantDetails != null){
                        objLead.Tenant_Name__c = TenantDetails.Tenant_Name__c;
                        objLead.Tenant_Details__c = TenantDetails.id;
                    }  
                }
                system.debug('*****objLead*******>>'+objLead);
                insert objLead;
                res.statusCode = 200;
                jsonResponse = '{"status": true, "id": "' + objLead.ID+ '", "errors":[]}';
                res.responseBody = blob.valueOf(jsonResponse);  
                objPortalExceptionHadling.Response__c = jsonResponse;
                objPortalExceptionHadling.Success_Error_Code__c = '200';
                objPortalExceptionHadling.Request__c = request.requestBody.toString();
                objPortalExceptionHadling.exception__c = null;
                objPortalExceptionHadling.Business_Id__c = leadinfo.BusinessId;
                objPortalExceptionHadling.Application_Id__c = leadinfo.application_id;
                objPortalExceptionHadling.Opportunity_Id__c = '';
                objPortalExceptionHadling.Lead_Id__c = objLead.Id;
                
            }  
        }
        Catch(Exception ex)   
        {
            res.statusCode = 500;
            jsonResponse = '{"status": false, "errors": "[' + ex + ']"}';
            res.responseBody = blob.valueOf(jsonResponse); 
            //system.debug('*****Exception *******>>'+ex);
            objPortalExceptionHadling.Response__c = jsonResponse;
            objPortalExceptionHadling.Success_Error_Code__c = '500';
            objPortalExceptionHadling.Request__c = request.requestBody.toString();
            objPortalExceptionHadling.exception__c = string.valueof(ex);
            objPortalExceptionHadling.Business_Id__c = leadinfo.BusinessId;
            objPortalExceptionHadling.Application_Id__c = leadinfo.application_id;
            objPortalExceptionHadling.Opportunity_Id__c = '';
            objPortalExceptionHadling.Lead_Id__c = objLead.Id;
        } 
        insert objPortalExceptionHadling;
        return;
    } 
    
    @HttpPatch 
    global static void PatchLeadData() {
        RestRequest request = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String jsonResponse = '';
        String RecordId = '';
        List<Integer> lstOfOwners = new List<Integer>();
        List<criminalreports__Criminal_Report__c > ListOfCriminalReports = new List<criminalreports__Criminal_Report__c >();
        JSON2Apex leadinfo = new JSON2Apex();
        Lead objLead = new Lead();
        system.debug('+++Request body+++'+request.requestBody.toString());
        Portal_Integration_Response_Code__c objPortalExceptionHadling = new Portal_Integration_Response_Code__c();
        leadinfo = JSON2Apex.parse(request.requestBody.toString());
        try
        {
            system.debug('(request.requestBody.toString()--->'+request.requestBody.toString());
            
            
            RecordId = leadinfo.LeadId;
            system.debug('***********RecordId ***************>>'+ RecordId);
            if(leadinfo.LeadId !=null && leadinfo.LeadId != '' ){
                objLead = [ Select Business_Borough__c,How_did_you_hear_about_us__c,Business_Stage__c,Location_Type__c,of_Employees_Temporary_Full_Time_2020__c,of_Employees_Temporary_Part_Time_2020__c,Did_you_take_out_PPP_or_a_EIDL_loan__c, Has_your_PPP_loan_been_forgiven__c, 
                            Do_you_have_any_other_outstanding_liens__c, Have_you_filed_for_bankruptcy__c, PPP_AMOUNT_RECEIVED__c,Run_Owner1_Criminal_Report__c , recordtype.name,Was_Your_Business_Profitable_In_2019__c,Minority_Business_Owned__c,Tenant_Referral_Partner_Name__c, Preferred_Language__c, SMS_Opt_In__c,Please_confirm_that_your_organization_se__c,Please_confirm_your_non_profit_status__c ,
                            Portal_Application_Status__c,Loan_Type__c,Purpose_of_Grant__c,Will_this_grant_create_new_jobs__c,Business_EIN__c,County__c,
                            DBA__c,State_of_incopration__c,Purpose_of_the_loan__c,Other__c,Will_this_loan_create_more_Jobs__c,of_Jobs_Created__c,Rural__c,
                            Franchise__c,Address2_Business__c,CountyId_Business__c,Number_of_Full_Time_Employees__c,Number_of_Part_Time_Employees__c,
                            Annual_Gross_Revenue__c,of_jobs_retained__c,Adddress2_Owner__c,CountyId_Owner__c,Address2_Owner_2__c,Address2_Owner_3__c,
                            Address2_Owner_4__c,Address2_Owner_5__c,County_Owner_2__c,County_Owner_3__c,County_Owner_4__c,County_Owner_5__c,NAICS_CODE__c,
                            Net_Worth__c,Who_is_Your_Customer_Base1__c,Business_Phone__c,Disabled__c,Veteran__c,Ethnicity__c,What_does_your_Business_do__c ,
                            What_type_of_Business_is_it__c ,Tell_us_more__c ,of_Dials__c,Application_ID__c,Business_Start_Date__c,Owner_ID_Owner_1__c,
                            Owner_ID_Owner_2__c,Owner_ID_Owner_3__c,Owner_ID_Owner_4__c,Owner_ID_Owner_5__c,of_Ownership_Owner__c,
                            creditchecker__Adverse_Alert__c,Are_you_COD_30_60_90__c,creditchecker__Average_Score__c,creditchecker__Bankruptcy_Count__c,
                            Brief_History_on_the_business__c,Brief_History_on_the_owner_manager__c,Campaign_Source__c,creditchecker__Charge_Offs_Count__c,
                            creditchecker__Collections_Count__c,creditchecker__Current_Adverse_Count__c,creditchecker__Derogatory_Count__c,
                            creditchecker__Disputes_Count__c,Do_You_Carry_Life_Insurance__c,Do_you_pay_child_support_or_alimony__c,Entity_Type__c,
                            Explanation_of_any_BKs_defaults_etc__c,First_Name_2nd_Owner__c,Homeowner__c,Last_Name_2nd_Owner__c,Monthly_Rent_Mtg__c,
                            Owner__c,Planned_Changes_In_Next_6_Months__c,creditchecker__Previous_Adverse_Count__c,Profitable_Last_2_Years__c,
                            creditchecker__Public_Record_Count__c,Referral_Partner__c,Referral_type__c,Requested_Amount__c,
                            creditchecker__Revolving_Credit_Utilization__c,Second_Owner__c,TIB_Months__c,creditchecker__Total_High_Credit__c,
                            creditchecker__Total_Inquiry_Count__c,creditchecker__Total_Liability_Balance__c,creditchecker__Total_Liability_PastDue__c,
                            creditchecker__Total_Liability_Payment__c,Use_of_Funds__c,What_are_the_terms_of_your_current_lease__c,
                            What_exactly_does_the_business_do__c,What_is_the_purpose_of_loan__c,Who_is_your_customer_base__c,of_Ownership_Second_Owner__c
                            ,Address,Address_3rd_Owner__c,Address_4th_Owner__c,Address_5th_Owner__c,Address_Owner_1__c,Address_Owner_2__c,AnnualRevenue,City,
                            City_2nd_Owner__c,City_Owner_1__c,City_Owner_2__c,City_Owner_3__c,City_Owner_4__c,City_Owner_5__c,Company,IsConverted,
                            ConvertedAccountId,ConvertedContactId,ConvertedDate,ConvertedOpportunityId,Country,Country_2nd_Owner__c,Country_Owner_1__c,
                            Country_Owner_2__c,Country_Owner_3__c,Country_Owner_4__c,Country_Owner_5__c,CreatedById,CreatedDate,Credit_Report_Type__c,
                            Credit_Score_2nd_Owner__c,Credit_Score_3rd_Owner_from_Webform__c,Credit_Score_4th_Owner_from_Webform__c,
                            Credit_Score_5th_Owner_from_Webform__c,Credit_Score__c,Jigsaw,IsDeleted,Description,DoNotCall,Email,Email_2nd_Owner__c,
                            Email_3rd_Owner__c,Email_4th_Owner__c,Email_5th_Owner__c,NumberOfEmployees,FirstName,First_Name_3rd_Owner__c,
                            First_Name_4th_Owner__c,First_Name_5th_Owner__c,Name,GeocodeAccuracy,Industry,JigsawContactId,LastActivityDate,LastModifiedById,
                            LastModifiedDate,LastName,Last_Name_3rd_Owner__c,Last_Name_4th_Owner__c,Last_Name_5th_Owner__c,LastReferencedDate,LastViewedDate,
                            Latitude,Id,LeadSource,Longitude,MasterRecordId,MiddleName,Mobile_2nd_Owner__c,Mobile_3rd_Owner__c,Mobile_4th_Owner__c,
                            Mobile_5th_Owner__c,MobilePhone,Not_Interested__c,of_Ownership_3rd_Owner__c,of_Ownership_4th_Owner__c,of_Ownership_5th_Owner__c,
                            OwnerId,Phone,Phone_2nd_Owner__c,Phone_3rd_Owner__c,Phone_4th_Owner__c,Phone_5th_Owner__c,PhotoUrl,Postal_Code_2nd_Owner__c,
                            Rating,Referral_Partner_Email__c,Sales_Decline__c,Salutation,Source_Web_Form__c,SSN1__c,SSN2__c,SSN_3rd_Owner__c,SSN_4th_Owner__c,
                            SSN_5th_Owner__c,State_2nd_Owner__c,State_Owner_1__c,State_Owner_2__c,State_Owner_3__c,State_Owner_4__c,State_Owner_5__c,State,
                            Status,Status_Detail__c,Street,Street_2nd_Owner__c,Street_Owner_1__c,Street_Owner_2__c,Street_Owner_3__c,Street_Owner_4__c,
                            Street_Owner_5__c,Suffix,SystemModstamp,Title,Title_2nd_Owner__c,Title_3rd_Owner__c,Title_4th_Owner__c,Title_5th_Owner__c,
                            IsUnreadByOwner,UTM_Campaign__c,UTM_Medium__c,UTM_Source__c,Website,Zip_Code_Owner_1__c,Zip_Code_Owner_2__c,Zip_Code_Owner_3__c,
                            Zip_Code_Owner_4__c,Zip_Code_Owner_5__c,PostalCode,Have_you_had_a_25_revenue_drop_between__c ,Who_originated_your_PPP_loan__c,
                            Did_you_obtain_a_PPP_loan_in_2020__c,Network_Selection__c,Did_you_receive_a_Shuttered_Venue_Operat__c,Does_the_Business_have_existing_SBA_Debt__c,Have_you_exhausted_all_personal_non_SB__c
                            From Lead Where Id=:leadinfo.LeadId];
                ListOfCriminalReports = [SELECT criminalreports__Lead__r.Id,id, Name, criminalreports__DOB__c,  CreatedBy.Name ,criminalreports__Lead__r.Name, criminalreports__Lead__r.Loan_Type__c from criminalreports__Criminal_Report__c where (criminalreports__Lead__r.Loan_Type__c ='NYR' OR criminalreports__Lead__r.Loan_Type__c ='NYC') AND criminalreports__Lead__r.Id=:leadinfo.LeadId ];          
                String LoanType = objLead.Loan_Type__c;
                String RecordTypeName = objLead.recordtype.name;
                
                // Changed on 09/20/2021 - NYC - LPR-1061
                if( LoanType == 'NYC'){
                    if(String.isNotBlank(leadinfo.howDidYouHearAboutUs))
                    objLead.How_did_you_hear_about_us__c = leadinfo.howDidYouHearAboutUs;
                    if(String.isNotBlank(leadinfo.businessStageName))
                    objLead.Business_Stage__c = leadinfo.businessStageName;
                    if(String.isNotBlank(leadinfo.businessBoroughName))
                    objLead.Business_Borough__c = leadinfo.businessBoroughName;
                    if(String.isNotBlank(leadinfo.locationTypeName))
                    objLead.Location_Type__c = leadinfo.locationTypeName;
                    if(String.isNotBlank(String.valueOf(leadinfo.numberOfTempFullTimeEmployees)))
                    objLead.of_Employees_Temporary_Full_Time_2020__c = Decimal.valueOf(leadinfo.numberOfTempFullTimeEmployees);
                    if(String.isNotBlank(String.valueOf(leadinfo.numberOfTempPartTimeEmployees)))
                    objLead.of_Employees_Temporary_Part_Time_2020__c = Decimal.valueOf(leadinfo.numberOfTempPartTimeEmployees);
                }
                
                if( (LoanType == 'NYR' || LoanType == 'NYC') && objLead.Run_Owner1_Criminal_Report__c ==false && ListOfCriminalReports != null && ListOfCriminalReports.size() <= 0)
                    objLead.Run_Owner1_Criminal_Report__c = true;
                 
                 objLead.Annual_Gross_Revenue__c = leadinfo.AnnualGrossRevenue;
                 
                 //========================Lendistry Lending Mapping Added=======================
                    if( leadinfo.isPPPLoanForgiven != null )
                    objLead.Has_your_PPP_loan_been_forgiven__c = leadinfo.isPPPLoanForgiven;
                    if( leadinfo.isOutstandingLiens != null )
                    objLead.Do_you_have_any_other_outstanding_liens__c=leadinfo.isOutstandingLiens ; 
                    if( leadinfo.isBankruptsyFiled != null )
                    objLead.Have_you_filed_for_bankruptcy__c= leadinfo.isBankruptsyFiled ;
                    if(leadinfo.pppAmountRcvd != null )
                    objLead.PPP_AMOUNT_RECEIVED__c= leadinfo.pppAmountRcvd;
                    if(leadinfo.eidlAmountRcvd != null )
                    objLead.EIDL_AMOUNT_RECEIVED__c= leadinfo.eidlAmountRcvd;
                 //========================Lendistry Lending Mapping End Block===================
                if( leadinfo.WillThisLoanCreateMoreJobs != null && RecordTypeName == 'GRANT-NYR') 
                objLead.Was_Your_Business_Profitable_In_2019__c = leadinfo.WillThisLoanCreateMoreJobs == true? 'Yes':'No';
                if( leadinfo.TenantReferralPartnerName !=null && leadinfo.TenantReferralPartnerName != '')
                objLead.Tenant_Referral_Partner_Name__c = leadinfo.TenantReferralPartnerName;
                if( leadinfo.PreferredLanguage !=null && leadinfo.PreferredLanguage != '')
                    objLead.Preferred_Language__c = leadinfo.PreferredLanguage;
                if(leadinfo.BusinessNonProfitStatus !=null && leadinfo.BusinessNonProfitStatus !='')
                    objLead.Please_confirm_your_non_profit_status__c = leadinfo.BusinessNonProfitStatus;
                
                if(leadinfo.BusinessTopFourPriorities !=null && leadinfo.BusinessTopFourPriorities!='')
                    objLead.Please_confirm_that_your_organization_se__c = leadinfo.BusinessTopFourPriorities;
                /****************************   END  **********************************************************************/ 
                if(leadinfo.ScholarAlumini!= null )
                    objLead.X0KSB_Scholar_Alumni__c = leadinfo.ScholarAlumini;
                if(leadinfo.DoYouHaveTaxLien!= null )
                    objLead.Do_you_have_a_tax_lien_of_taxes_due__c = leadinfo.DoYouHaveTaxLien== true? 'Yes': 'No';
                if(leadinfo.HaveYouEverDefaultedOnGovernmentLoan!= null )
                    objLead.Have_you_ever_defaulted_on_a_govt_loan__c = leadinfo.HaveYouEverDefaultedOnGovernmentLoan== true? 'Yes': 'No';
                if(leadinfo.AreThereAnyLegalActionPendingAgainstYou!= null )
                    objLead.Legal_action_pending_against_youspouse__c = leadinfo.AreThereAnyLegalActionPendingAgainstYou== true? 'Yes': 'No';
                
                if(leadinfo.areYouDelinquentOnChildSupport != null )
                    objLead.Are_you_delinquent_on_child_support__c = leadinfo.areYouDelinquentOnChildSupport ==true? 'Yes': 'No';
                if(leadinfo.businesstaxliensfromIRSorState!=null )
                    objLead.Business_tax_liens_from_the_IRS_or_State__c = leadinfo.businesstaxliensfromIRSorState == true? 'Yes': 'No';
                if(leadinfo.convictedOfacrimeinPast6months !=null )
                    objLead.Convicted_of_a_crime_in_past_6_months__c = leadinfo.convictedOfacrimeinPast6months == true? 'Yes': 'No';
                if(leadinfo.didYouTakeoutPPPoraEIDLLoan !=null && leadinfo.didYouTakeoutPPPoraEIDLLoan !='')
                    objLead.Did_you_take_out_PPP_or_a_EIDL_loan__c = leadinfo.didYouTakeoutPPPoraEIDLLoan;
                if(leadinfo.doYouownaRealeState !=null )
                    objLead.Do_you_own_a_real_estate__c = leadinfo.doYouownaRealeState == true? 'Yes': 'No';
                if(leadinfo.crimeConvictionRange !=null && leadinfo.crimeConvictionRange!='')
                    objLead.crime_Conviction_Range__c = leadinfo.crimeConvictionRange;
                if(leadinfo.whatIsTheValueOfYourPersonalAsset !=null )
                    objLead.What_is_the_value_of_your_personal_asset__c = leadinfo.whatIsTheValueOfYourPersonalAsset;
                if(leadinfo.timeAtAddress !=null && leadinfo.timeAtAddress!='')
                    objLead.Time_At_Address__c = leadinfo.timeAtAddress;
                if(leadinfo.Owner1RentAmount !=null )
                    objLead.Owner_Rent_1__c = leadinfo.Owner1RentAmount;
                if(leadinfo.Owner2RentAmount !=null )
                    objLead.Owner_Rent_2__c = leadinfo.Owner2RentAmount;
                if(leadinfo.Owner3RentAmount !=null )
                    objLead.Owner_Rent_3__c = leadinfo.Owner3RentAmount;
                if(leadinfo.Owner4RentAmount !=null )
                    objLead.Owner_Rent_4__c = leadinfo.Owner4RentAmount;
                if(leadinfo.Owner5RentAmount !=null )
                    objLead.Owner_Rent_5__c = leadinfo.Owner5RentAmount;
                if(leadinfo.ExhaustedPersonalAndNonSBAFinancing !=null )
                    objLead.exhausted_personal_nonSBA_financing__c = leadinfo.ExhaustedPersonalAndNonSBAFinancing == true? 'Yes': 'No';
                if(leadinfo.DoestheBusinesshaveexistingSBADebt !=null )
                    objLead.Does_the_Business_have_existing_SBA_Debt__c = leadinfo.DoestheBusinesshaveexistingSBADebt == true? 'Yes': 'No';
                if(leadinfo.Haveyoueverbeenconvictedofacrime !=null )
                    objLead.Have_you_ever_been_convicted_of_a_crime__c = leadinfo.Haveyoueverbeenconvictedofacrime == true? 'Yes': 'No';
                  // added by saurabh Kumar onn 22 Jan 2021  
                if(leadinfo.Have_you_had_a_25_revenue_drop_between!=null )
                    objLead.Have_you_had_a_25_revenue_drop_between__c = leadinfo.Have_you_had_a_25_revenue_drop_between== true? 'Yes': 'No'; 
                    
                if(leadinfo.Who_originated_your_PPP_loan!=null )
                    objLead.Who_originated_your_PPP_loan__c = leadinfo.Who_originated_your_PPP_loan; 
                
                if(leadinfo.Did_you_obtain_a_PPP_loan_in_2020!=null )
                    objLead.Did_you_obtain_a_PPP_loan_in_2020__c = leadinfo.Did_you_obtain_a_PPP_loan_in_2020== true? 'Yes': 'No'; 
                
                if(leadinfo.Did_you_receive_a_Shuttered_Venue_Operat!=null )
                    objLead.Did_you_receive_a_Shuttered_Venue_Operat__c = leadinfo.Did_you_receive_a_Shuttered_Venue_Operat== true? 'Yes': 'No'; 
                
                //END//
                
                  // added by saurabh Kumar onn 25 Jan 2021  
                if(leadinfo.Period_2_Revenue!=null )
                    objLead.Period_2_Revenue__c= leadinfo.Period_2_Revenue; 
                if(leadinfo.networkSelection!=null)
                    objLead.Network_Selection__c = leadinfo.networkSelection;
                    
                if(leadinfo.Last_Years_Period!=null )
                    objLead.Last_Year_s_Period__c  = leadinfo.Last_Years_Period; 
                
                if(leadinfo.Proof_of_25_revenue_drop_2020!=null )
                    objLead.Proof_of_25_revenue_drop_2020__c = leadinfo.Proof_of_25_revenue_drop_2020; 
                
                if(leadinfo.Period_1_Revenue!=null )
                    objLead.Period_1_Revenue__c= leadinfo.Period_1_Revenue; 
               
               if(leadinfo.Refinance_of_Eligible_Economic_Injury_Di!=null )
                    objLead.Refinance_of_Eligible_Economic_Injury_Di__c= leadinfo.Refinance_of_Eligible_Economic_Injury_Di; 
                
                if(leadinfo.Economic_Injury_Disaster_Loan_Number!=null )
                    objLead.Economic_Injury_Disaster_Loan_Number__c = leadinfo.Economic_Injury_Disaster_Loan_Number; 
                
                //END//    
                       
                if(leadinfo.CurrentOutstandingBalanceForTaxLienOrTaxesDue !=null )
                    objLead.Current_outstanding_for_tax_lientax_due__c = leadinfo.CurrentOutstandingBalanceForTaxLienOrTaxesDue;
                if(leadinfo.MonthlyPaymentForTaxLienOrTaxesDue !=null )
                    objLead.Monthly_payment_for_tax_lien_or_tax_due__c = leadinfo.MonthlyPaymentForTaxLienOrTaxesDue;
                if(leadinfo.CurrentOutstandingBalanceForBusinessTaxLienOrTaxesDue !=null )
                    objLead.Current_Outstand_Bal_Busi_TaxLienTaxDue__c = leadinfo.CurrentOutstandingBalanceForBusinessTaxLienOrTaxesDue;
                if(leadinfo.MonthlyPaymentForBusinessTaxLienOrTaxesDue !=null )
                    objLead.Monthly_Payment_Business_TaxLienTaxDue__c = leadinfo.MonthlyPaymentForBusinessTaxLienOrTaxesDue;
                
                
                if( leadinfo.email != null && leadinfo.email != '')  
                    objLead.Email = leadinfo.email;
                // objLead.company  = leadinfo.company;
                if( leadinfo.LeadSource != null )
                    objLead.LeadSource = leadinfo.LeadSource;
                if( leadinfo.BusinessId != null )
                    objLead.BusinessId__c = leadinfo.BusinessId;
                if( objLead.recordType.Name == 'Lendistry Lending' &&  leadinfo.NumberOfEmployees != null && leadinfo.NumberOfEmployees != '')  
                    objLead.of_Current_Employees__c = Decimal.valueof(leadinfo.NumberOfEmployees);
                if( objLead.recordType.Name != 'Lendistry Lending' &&  leadinfo.NumberOfEmployees != null && leadinfo.NumberOfEmployees != '')  
                    objLead.NumberOfEmployees = Integer.valueOf(leadinfo.NumberOfEmployees);
                    
                if( leadinfo.Industry != null && leadinfo.Industry != '')
                    objLead.Industry = leadinfo.Industry;
                if( leadinfo.website != null )
                    objLead.Website = leadinfo.website;
                if( leadinfo.City != null )
                    objLead.City = leadinfo.City;
                if( leadinfo.Country != null )
                    objLead.Country = leadinfo.Country;
                if( leadinfo.ZipCode != null )
                    objLead.PostalCode = leadinfo.ZipCode;
                if( leadinfo.Email != null )
                    objLead.Email = leadinfo.Email;
                if( leadinfo.Street != null )
                    objLead.Street = leadinfo.Street;
                if( leadinfo.State != null )
                    objLead.State = leadinfo.State;
                if( leadinfo.Title != null )
                    objLead.Title = leadinfo.Title;
                if( leadinfo.What_your_customer_base != null )
                    objLead.Who_is_Your_Customer_Base1__c = leadinfo.What_your_customer_base;
                if( leadinfo.business_start_date != null && leadinfo.business_start_date != '')
                    objLead.Business_Start_Date__c = Date.valueof(leadinfo.business_start_date);
                if( leadinfo.application_id != null && leadinfo.application_id != '')
                    objLead.Application_ID__c = leadinfo.application_id;
                if( leadinfo.Phone != null )
                    objLead.Business_Phone__c = string.valueof(leadinfo.Phone);
                //objLead.LastName = leadinfo.LastName;
                
                if( leadinfo.AnnualRevenue != null && leadinfo.AnnualRevenue != '')
                    objLead.AnnualRevenue = Decimal.valueof(leadinfo.AnnualRevenue);
                if( leadinfo.Website != null )
                    objLead.Website = leadinfo.Website;
                
                if( leadinfo.Requested_Amount != null )
                    objLead.Requested_Amount__c = Decimal.valueOf(leadinfo.Requested_Amount);
                if( leadinfo.is_home_owner != null )
                    objLead.Homeowner__c = leadinfo.is_home_owner;
                if( leadinfo.What_does_your_Business_do != null )
                    objLead.What_does_your_Business_do__c = leadinfo.What_does_your_Business_do;
                
                if(leadinfo.What_type_of_Business_is_it != null && leadinfo.What_type_of_Business_is_it != ''){
                    objLead.What_type_of_Business_is_it__c  = leadinfo.What_type_of_Business_is_it;
                }
                if( leadinfo.Tell_us_more != null )
                    objLead.Tell_us_more__c = leadinfo.Tell_us_more;
                if( leadinfo.net_worth != null)
                    objLead.Net_Worth__c = Decimal.valueof(leadinfo.net_worth);
                if( leadinfo.UseofFunds != null )
                    objLead.Use_of_Funds__c = leadinfo.UseofFunds;
                //objLead.Profitable_Last_2_Years__c = leadinfo.ProfitableLast2Years;
                if( leadinfo.TIBMonths != null )
                    objLead.TIB_Months__c = leadinfo.TIBMonths;
                //objLead.Sales_Decline__c = leadinfo.SalesDecline;
                //objLead.Not_Interested__c = leadinfo.NotInterested;
                if( leadinfo.Homeowner != null )
                    objLead.Homeowner__c = leadinfo.Homeowner;
                if( leadinfo.MonthlyRentMtg != null && leadinfo.MonthlyRentMtg != '' )
                    objLead.Monthly_Rent_Mtg__c = Decimal.valueOf(leadinfo.MonthlyRentMtg);
                if( leadinfo.of_employees_added_in_next_12_months != null )
                    objLead.of_employees_added_in_next_12_months__c = leadinfo.of_employees_added_in_next_12_months;
                if( leadinfo.of_customer_served_monthly != null )
                    objLead.of_customer_served_monthly__c = leadinfo.of_customer_served_monthly;
                /*objLead.What_exactly_does_the_business_do__c = leadinfo.Whatexactlydoesthebusinessdo;
objLead.Do_You_Carry_Life_Insurance__c = leadinfo.DoYouCarryLifeInsurance;
objLead.Planned_Changes_In_Next_6_Months__c = leadinfo.PlannedChangesInNext6Months;
objLead.Brief_History_on_the_business__c = leadinfo.BriefHistoryonthebusiness;
objLead.What_are_the_terms_of_your_current_lease__c = leadinfo.Whatarethetermsofyourcurrentlease;
objLead.What_is_the_purpose_of_loan__c = leadinfo.Whatisthepurposeofloan;
objLead.Are_you_COD_30_60_90__c = leadinfo.AreyouCOD306090;
objLead.Do_you_pay_child_support_or_alimony__c = leadinfo.Doyoupaychildsupportoralimony;
objLead.Explanation_of_any_BKs_defaults_etc__c = leadinfo.ExplanationofanyBKsdefaultsetc;
*/
                if( leadinfo.PortalApplicationStatus != null )
                {
                    if( leadinfo.PortalApplicationStatus == 'Finished')
                        objLead.Portal_Application_Status__c = leadinfo.PortalApplicationStatus;
                    else if( objLead.Portal_Application_Status__c == 'Finished')
                        objLead.Portal_Application_Status__c = 'Finished';
                    else
                        objLead.Portal_Application_Status__c = 'Unfinished';
                }
                if( leadinfo.Ethnicity != null )
                    objLead.Ethnicity__c = leadinfo.Ethnicity;
                if( leadinfo.Race != null )
                    objLead.Race__c = leadinfo.Race;
                if( leadinfo.Veteran != null )
                    objLead.Veteran__c = leadinfo.Veteran == true? 'Yes': 'No';
                if( leadinfo.Disabled != null )
                    objLead.Disabled__c = leadinfo.Disabled == true? 'Yes':'No';
                if( leadinfo.Women_Owned != null )
                    objLead.Women_Owned__c = leadinfo.Women_Owned == true? 'Yes':'No';
                
                //Addition for Multi-Tenant
                if( leadinfo.Address2 != null )
                    objLead.Address2_Business__c = leadinfo.Address2;
                if( leadinfo.County != null )
                    objLead.CountyId_Business__c = leadinfo.County;
                if( leadinfo.NumberofFullTimeEmployees != null )
                    objLead.Number_of_Full_Time_Employees__c = leadinfo.NumberofFullTimeEmployees;
                if( leadinfo.NumberofPartTimeEmployees != null )
                    objLead.Number_of_Part_Time_Employees__c = leadinfo.NumberofPartTimeEmployees;
                
                if( leadinfo.NumberofJobsRetained != null )
                    objLead.of_jobs_retained__c = leadinfo.NumberofJobsRetained;
                if( leadinfo.SMSOptIn != null )
                    objLead.SMS_Opt_In__c = leadinfo.SMSOptIn;
                if( leadinfo.NaicsCode != null )
                    objLead.NAICS_CODE__c = leadinfo.NaicsCode;
                if( leadinfo.DBA != null )
                    objLead.DBA__c = leadinfo.DBA;
                if( leadinfo.StateOfIncorporation != null )
                    objLead.State_of_incopration__c = leadinfo.StateOfIncorporation;
                if( leadinfo.BusinessType != null )
                    objLead.Entity_Type__c = leadinfo.BusinessType;
                if( leadinfo.PurposeOfTheLoan != null )
                {
                    if( RecordTypeName == 'GRANT' || RecordTypeName == 'GRANT-NYR' || RecordTypeName == 'Grant-NYC'){
                        objLead.Purpose_of_Grant__c = leadinfo.PurposeOfTheLoan;
                    }
                    else{
                        objLead.Purpose_of_the_loan__c = leadinfo.PurposeOfTheLoan;
                    }     
                }
                
                if( leadinfo.Other != null )
                    objLead.Other__c = leadinfo.Other;
                if( leadinfo.WillThisLoanCreateMoreJobs != null )
                {
                    if( RecordTypeName == 'GRANT' || RecordTypeName == 'GRANT-NYR' || RecordTypeName == 'Grant-NYC'){
                        objLead.Will_this_grant_create_new_jobs__c = leadinfo.WillThisLoanCreateMoreJobs == true? 'Yes':'No';
                    }
                    else{
                        objLead.Will_this_loan_create_more_Jobs__c = leadinfo.WillThisLoanCreateMoreJobs == true? 'Yes':'No';
                    }
                }
                
                if( leadinfo.NumberOfJobsCreated != null )
                    objLead.of_Jobs_Created__c = leadinfo.NumberOfJobsCreated;
                if( leadinfo.Rural != null )
                    objLead.Rural__c = leadinfo.Rural == true? 'Yes':'No';
                if( leadinfo.Franchise != null )
                    objLead.Franchise__c = leadinfo.Franchise == true? 'Yes':'No';
                if( leadinfo.federal_taxId != null )
                    objLead.Business_EIN__c = leadinfo.federal_taxId;
                if( leadinfo.County != null )
                    objLead.County__c = leadinfo.County;
                    
                    
                if(String.isNotBlank(String.valueOf(leadinfo.ExhaustedPersonalAndNonSBAFinancing))){
                    objLead.Have_you_exhausted_all_personal_non_SB__c = leadinfo.ExhaustedPersonalAndNonSBAFinancing == true? 'Yes':'No';
                } 
                
                if(String.isNotBlank(String.valueOf(leadinfo.DoestheBusinesshaveexistingSBADebt))){
                    objLead.Does_the_Business_have_existing_SBA_Debt__c = leadinfo.DoestheBusinesshaveexistingSBADebt == true? 'Yes':'No';
                }   
                
                if( leadinfo.Rural != null && RecordTypeName == 'GRANT-NYR' )
                    objLead.Minority_Business_Owned__c = leadinfo.Rural == true? 'Yes':'No';
                    
                
                if(leadinfo.OwnerInfoList != null && leadinfo.OwnerInfoList.size()> 0 )
                {
                    for( JSON2Apex.OwnerInfoWrap eachOwner : leadinfo.OwnerInfoList)
                    {
                        if( objLead.Owner_ID_Owner_1__c == eachOwner.owner_id)
                        {
                            
                            if( eachOwner.owner_id != null )
                                objLead.Owner_ID_Owner_1__c = eachOwner.owner_id;
                            if( eachOwner.owner_first_name != null )
                                objLead.FirstName = eachOwner.owner_first_name;
                            if( eachOwner.owner_home_phone_no != null )
                                ObjLead.Phone = eachOwner.owner_home_phone_no;
                            if( eachOwner.owner_SSN != null )
                                objLead.SSN1__c = eachOwner.owner_SSN;
                            if( eachOwner.owner_percentage != null )
                                objLead.of_Ownership_Owner__c = Decimal.valueof(eachOwner.owner_percentage);
                            if( eachOwner.ownerCellChone_no != null )
                                objLead.MobilePhone = eachOwner.ownerCellChone_no;
                            if( eachOwner.owner_dob != null && eachOwner.owner_dob != '')
                                objLead.DOB_Owner_1__c = Date.valueOf(eachOwner.owner_dob);
                            if( eachOwner.ownerCity != null )
                                objLead.City_Owner_1__c = eachOwner.ownerCity;
                            if( eachOwner.owner_email != null )
                                objLead.Email = eachOwner.owner_email;
                            if( eachOwner.owner_home_address != null )
                                objLead.Street_Owner_1__c = eachOwner.owner_home_address;
                            if( eachOwner.owner_state_id != null )
                                objLead.State_Owner_1__c = eachOwner.owner_state_id;
                            if( eachOwner.owner_title != null )
                                objLead.Title = eachOwner.owner_title;
                            if( eachOwner.Owner_zipcode != null )
                                objLead.Zip_Code_Owner_1__c = eachOwner.Owner_zipcode;
                            
                            objLead.Country_Owner_1__c = 'US';
                            if( eachOwner.ownerCellChone_no != null )
                                ObjLead.MobilePhone = eachOwner.ownerCellChone_no;
                            if( eachOwner.RunCreditReport != null )
                                objLead.Run_Credit_Report__c = boolean.valueOf(eachOwner.RunCreditReport);
                            
                            //Addition for Multi-Tenant
                            if( eachOwner.owner_Address2 != null )
                                objLead.Adddress2_Owner__c = eachOwner.owner_Address2;
                            if( eachOwner.owner_County != null )
                                objLead.CountyId_Owner__c = eachOwner.owner_County;
                            
                            //objLead.Owner_Rent_1__c =  eachOwner.owner_rent;
                        }
                        else
                        {
                            if( i == 1 && (objLead.Owner_ID_Owner_1__c == null || objLead.Owner_ID_Owner_1__c == ''))
                            {
                                system.debug('*******eachOwner11 ******'+eachOwner );
                                objLead.Owner_ID_Owner_1__c = eachOwner.owner_id;
                                objLead.FirstName = eachOwner.owner_first_name;
                                ObjLead.Phone = eachOwner.owner_home_phone_no;
                                objLead.SSN1__c = eachOwner.owner_SSN;
                                objLead.of_Ownership_Owner__c = Decimal.valueof(eachOwner.owner_percentage);
                                objLead.MobilePhone = eachOwner.ownerCellChone_no;
                                objLead.DOB_Owner_1__c = Date.valueOf(eachOwner.owner_dob);
                                objLead.City_Owner_1__c = eachOwner.ownerCity;
                                objLead.Email = eachOwner.owner_email;
                                objLead.Street_Owner_1__c = eachOwner.owner_home_address;
                                objLead.State_Owner_1__c = eachOwner.owner_state_id;
                                objLead.Title = eachOwner.owner_title;
                                objLead.Zip_Code_Owner_1__c = eachOwner.Owner_zipcode;
                                objLead.Country_Owner_1__c = 'US';
                                ObjLead.Credit_Score__c = eachOwner.CreditScorefromWebform;
                                //ObjLead.Phone = eachOwner.Phone;ObjLead.MobilePhone = eachOwner.ownerCellChone_no;objLead.Run_Credit_Report__c = boolean.valueOf(eachOwner.RunCreditReport);objLead.Owner_Rent_1__c =eachOwner.owner_rent;
                                
                            }
                        }
                        system.debug('*******i2 ******'+i );
                        
                        if( objLead.Owner_ID_Owner_2__c == eachOwner.owner_id)
                        {
                            system.debug('*******eachOwner 22******'+eachOwner );
                            if( eachOwner.owner_id != null )
                                objLead.Owner_ID_Owner_2__c = eachOwner.owner_id;
                            if( eachOwner.owner_first_name != null )
                                objLead.First_Name_2nd_Owner__c = eachOwner.owner_first_name;
                            if( eachOwner.owner_last_name != null )
                                objLead.Last_Name_2nd_Owner__c = eachOwner.owner_last_name;
                            if( eachOwner.owner_SSN != null )
                                objLead.SSN2__c = eachOwner.owner_SSN;
                            if( eachOwner.owner_percentage != null )
                                objLead.of_Ownership_Second_Owner__c = Decimal.valueof(eachOwner.owner_percentage);
                            if( eachOwner.ownerCity != null )
                                objLead.City_Owner_2__c = eachOwner.ownerCity;
                            if( eachOwner.ownerCellChone_no != null )
                                objLead.Mobile_2nd_Owner__c = eachOwner.ownerCellChone_no;
                            if( eachOwner.owner_dob != null )
                                objLead.DOB_Owner_2__c = Date.valueOf(eachOwner.owner_dob);
                            if( eachOwner.owner_email != null )
                                objLead.Email_2nd_Owner__c = eachOwner.owner_email;
                            if( eachOwner.owner_home_address != null )
                                objLead.Street_Owner_2__c = eachOwner.owner_home_address;
                            if( eachOwner.owner_state_id != null )
                                objLead.State_Owner_2__c = eachOwner.owner_state_id;
                            if( eachOwner.owner_title != null )
                                objLead.Title_2nd_Owner__c = eachOwner.owner_title;
                            if( eachOwner.Owner_zipcode != null )
                                objLead.Zip_Code_Owner_2__c = eachOwner.Owner_zipcode;
                            
                            objLead.Country_Owner_2__c = 'US';
                            if( eachOwner.CreditScorefromWebform != null )
                                ObjLead.Credit_Score_2nd_Owner__c = eachOwner.CreditScorefromWebform;
                            if( eachOwner.owner_home_phone_no != null )
                                ObjLead.Phone_2nd_Owner__c = eachOwner.owner_home_phone_no;
                            if( eachOwner.ownerCellChone_no != null )
                                ObjLead.Mobile_2nd_Owner__c = eachOwner.ownerCellChone_no;
                            if( eachOwner.RunCreditReport != null )
                                objLead.Run_Owner2_Credit_Report__c = boolean.valueOf(eachOwner.RunCreditReport);
                            /* if( eachOwner.owner_rent != null )
ObjLead.Owner_Rent_2__c =  eachOwner.owner_rent;
*/
                        }
                        else
                        {
                            if( i == 2 && (objLead.Owner_ID_Owner_2__c == null || objLead.Owner_ID_Owner_2__c == ''))
                            {
                                
                                if( eachOwner.owner_id != null )
                                    objLead.Owner_ID_Owner_2__c = eachOwner.owner_id;
                                if( eachOwner.owner_first_name != null )
                                    objLead.First_Name_2nd_Owner__c = eachOwner.owner_first_name;
                                if( eachOwner.owner_last_name != null )
                                    objLead.Last_Name_2nd_Owner__c = eachOwner.owner_last_name;
                                if( eachOwner.owner_SSN != null )
                                    objLead.SSN2__c = eachOwner.owner_SSN;
                                if( eachOwner.owner_percentage != null )
                                    objLead.of_Ownership_Second_Owner__c = Decimal.valueof(eachOwner.owner_percentage);
                                if( eachOwner.ownerCity != null )
                                    objLead.City_Owner_2__c = eachOwner.ownerCity;
                                if( eachOwner.ownerCellChone_no != null )
                                    objLead.Mobile_2nd_Owner__c = eachOwner.ownerCellChone_no;
                                if( eachOwner.owner_dob != null )
                                    objLead.DOB_Owner_2__c = Date.valueOf(eachOwner.owner_dob);
                                if( eachOwner.owner_email != null )
                                    objLead.Email_2nd_Owner__c = eachOwner.owner_email;
                                if( eachOwner.owner_home_address != null )
                                    objLead.Street_Owner_2__c = eachOwner.owner_home_address;
                                if( eachOwner.owner_state_id != null )
                                    objLead.State_Owner_2__c = eachOwner.owner_state_id;
                                if( eachOwner.owner_title != null )
                                    objLead.Title_2nd_Owner__c = eachOwner.owner_title;
                                if( eachOwner.Owner_zipcode != null )
                                    objLead.Zip_Code_Owner_2__c = eachOwner.Owner_zipcode;
                                
                                objLead.Country_Owner_2__c = 'US';
                                //ObjLead.Credit_Score_2nd_Owner__c = eachOwner.CreditScorefromWebform;
                                if( eachOwner.owner_home_phone_no != null )
                                    ObjLead.Phone_2nd_Owner__c = eachOwner.owner_home_phone_no;
                                
                                if( eachOwner.RunCreditReport != null )
                                    objLead.Run_Owner2_Credit_Report__c = boolean.valueOf(eachOwner.RunCreditReport);
                                /*if( eachOwner.owner_rent != null )
ObjLead.Owner_Rent_2__c =  eachOwner.owner_rent;
*/
                            }   
                        }
                        
                        if( objLead.Owner_ID_Owner_3__c == eachOwner.owner_id)
                        {
                            
                            if( eachOwner.owner_id != null )
                                objLead.Owner_ID_Owner_3__c = eachOwner.owner_id;
                            if( eachOwner.owner_first_name != null  )
                                objLead.First_Name_3rd_Owner__c = eachOwner.owner_first_name;
                            if( eachOwner.owner_last_name != null )
                                objLead.Last_Name_3rd_Owner__c = eachOwner.owner_last_name;
                            if( eachOwner.owner_SSN != null  )
                                objLead.SSN_3rd_Owner__c = eachOwner.owner_SSN;
                            if( eachOwner.owner_percentage != null  )
                                objLead.of_Ownership_3rd_Owner__c = Decimal.valueof(eachOwner.owner_percentage);
                            if( eachOwner.ownerCity != null  )
                                objLead.City_Owner_3__c = eachOwner.ownerCity;
                            if( eachOwner.ownerCellChone_no != null  )
                                objLead.Mobile_3rd_Owner__c = eachOwner.ownerCellChone_no;
                            if( eachOwner.owner_dob != null  )
                                objLead.DOB_Owner_3__c = Date.valueOf(eachOwner.owner_dob);
                            if( eachOwner.owner_email != null  )
                                objLead.Email_3rd_Owner__c = eachOwner.owner_email;
                            if( eachOwner.owner_home_address != null  )
                                objLead.Street_Owner_3__c = eachOwner.owner_home_address;
                            if( eachOwner.owner_state_id != null  )
                                objLead.State_Owner_3__c = eachOwner.owner_state_id;
                            if( eachOwner.owner_title != null  )
                                objLead.Title_3rd_Owner__c = eachOwner.owner_title;
                            if( eachOwner.Owner_zipcode != null  )
                                objLead.Zip_Code_Owner_3__c = eachOwner.Owner_zipcode;
                            
                            objLead.Country_Owner_3__c = 'US';
                            
                            //ObjLead.Credit_Score_3rd_Owner_from_Webform__c = eachOwner.CreditScorefromWebform;
                            if( eachOwner.owner_home_phone_no != null  )
                                ObjLead.Phone_3rd_Owner__c = eachOwner.owner_home_phone_no;
                            
                            if( eachOwner.RunCreditReport != null  )
                                objLead.Run_Owner3_Credit_Report__c = boolean.valueOf(eachOwner.RunCreditReport);
                            /*if( eachOwner.owner_rent != null  )
ObjLead.Owner_Rent_3__c =  eachOwner.owner_rent;
*/
                        }
                        else
                        {
                            if( i == 3 && (objLead.Owner_ID_Owner_3__c == null || objLead.Owner_ID_Owner_3__c == ''))
                            {
                                
                                if( eachOwner.owner_id != null  )
                                    objLead.Owner_ID_Owner_3__c = eachOwner.owner_id;
                                if( eachOwner.owner_first_name != null  )
                                    objLead.First_Name_3rd_Owner__c = eachOwner.owner_first_name;
                                if( eachOwner.owner_last_name != null  )
                                    objLead.Last_Name_3rd_Owner__c = eachOwner.owner_last_name;
                                if( eachOwner.owner_SSN != null  )
                                    objLead.SSN_3rd_Owner__c = eachOwner.owner_SSN;
                                if( eachOwner.owner_percentage != null  )
                                    objLead.of_Ownership_3rd_Owner__c = Decimal.valueof(eachOwner.owner_percentage);
                                if( eachOwner.ownerCity != null  )
                                    objLead.City_Owner_3__c = eachOwner.ownerCity;
                                if( eachOwner.ownerCellChone_no != null  )
                                    objLead.Mobile_3rd_Owner__c = eachOwner.ownerCellChone_no;
                                if( eachOwner.owner_dob != null  )
                                    objLead.DOB_Owner_3__c = Date.valueOf(eachOwner.owner_dob);
                                if( eachOwner.owner_email != null  )
                                    objLead.Email_3rd_Owner__c = eachOwner.owner_email;
                                if( eachOwner.owner_home_address != null  )
                                    objLead.Street_Owner_3__c = eachOwner.owner_home_address;
                                if( eachOwner.owner_state_id != null  )
                                    objLead.State_Owner_3__c = eachOwner.owner_state_id;
                                if( eachOwner.owner_title != null  )
                                    objLead.Title_3rd_Owner__c = eachOwner.owner_title;
                                if( eachOwner.Owner_zipcode != null  )
                                    objLead.Zip_Code_Owner_3__c = eachOwner.Owner_zipcode;
                                
                                objLead.Country_Owner_3__c = 'US';
                                
                                //ObjLead.Credit_Score_3rd_Owner_from_Webform__c = eachOwner.CreditScorefromWebform;
                                if( eachOwner.owner_home_phone_no != null  )
                                    ObjLead.Phone_3rd_Owner__c = eachOwner.owner_home_phone_no;
                                if( eachOwner.ownerCellChone_no != null  )
                                    ObjLead.Mobile_3rd_Owner__c = eachOwner.ownerCellChone_no;
                                if( eachOwner.RunCreditReport != null  )
                                    objLead.Run_Owner3_Credit_Report__c = boolean.valueOf(eachOwner.RunCreditReport);
                                /*if( eachOwner.owner_rent != null  )
ObjLead.Owner_Rent_3__c =  eachOwner.owner_rent;
*/
                            }
                        }
                        
                        if( objLead.Owner_ID_Owner_4__c == eachOwner.owner_id)
                        {
                            if( eachOwner.owner_id != null  )
                                objLead.Owner_ID_Owner_4__c = eachOwner.owner_id;
                            if( eachOwner.owner_first_name != null  )
                                objLead.First_Name_4th_Owner__c = eachOwner.owner_first_name;
                            if( eachOwner.owner_last_name != null  )
                                objLead.Last_Name_4th_Owner__c = eachOwner.owner_last_name;
                            if( eachOwner.owner_SSN != null  )
                                objLead.SSN_4th_Owner__c = eachOwner.owner_SSN;
                            if( eachOwner.owner_percentage != null  )
                                objLead.of_Ownership_4th_Owner__c = Decimal.valueof(eachOwner.owner_percentage);
                            if( eachOwner.ownerCity != null  )
                                objLead.City_Owner_4__c = eachOwner.ownerCity;
                            if( eachOwner.ownerCellChone_no != null  )
                                objLead.Mobile_4th_Owner__c = eachOwner.ownerCellChone_no;
                            if( eachOwner.owner_dob != null  )
                                objLead.DOB_Owner_4__c = Date.valueOf(eachOwner.owner_dob);
                            if( eachOwner.owner_email != null  )
                                objLead.Email_4th_Owner__c = eachOwner.owner_email;
                            if( eachOwner.owner_home_address != null  )
                                objLead.Street_Owner_4__c = eachOwner.owner_home_address;
                            if( eachOwner.owner_state_id != null  )
                                objLead.State_Owner_4__c = eachOwner.owner_state_id;
                            if( eachOwner.owner_title != null  )
                                objLead.Title_4th_Owner__c = eachOwner.owner_title;
                            if( eachOwner.Owner_zipcode != null  )
                                objLead.Zip_Code_Owner_4__c = eachOwner.Owner_zipcode;
                            
                            objLead.Country_Owner_4__c = 'US';
                            
                            //ObjLead.Credit_Score_4th_Owner_from_Webform__c = eachOwner.CreditScorefromWebform;
                            if( eachOwner.owner_home_phone_no != null  )
                                ObjLead.Phone_4th_Owner__c =eachOwner.owner_home_phone_no;
                            if( eachOwner.ownerCellChone_no != null  )
                                ObjLead.Mobile_4th_Owner__c = eachOwner.ownerCellChone_no;
                            if( eachOwner.RunCreditReport != null  )
                                objLead.Run_Owner4_Credit_Report__c = boolean.valueOf(eachOwner.RunCreditReport);
                            /*if( eachOwner.owner_rent != null  )
ObjLead.Owner_Rent_4__c =  eachOwner.owner_rent;
*/
                        }
                        else
                        {
                            if( i == 4 && (objLead.Owner_ID_Owner_4__c == null || objLead.Owner_ID_Owner_4__c == ''))
                            {
                                
                                if( eachOwner.owner_id != null  )
                                    objLead.Owner_ID_Owner_4__c = eachOwner.owner_id;
                                if( eachOwner.owner_first_name != null  )
                                    objLead.First_Name_4th_Owner__c = eachOwner.owner_first_name;
                                if( eachOwner.owner_last_name != null  )
                                    objLead.Last_Name_4th_Owner__c = eachOwner.owner_last_name;
                                if( eachOwner.owner_SSN != null  )
                                    objLead.SSN_4th_Owner__c = eachOwner.owner_SSN;
                                if( eachOwner.owner_percentage != null  )
                                    objLead.of_Ownership_4th_Owner__c = Decimal.valueof(eachOwner.owner_percentage);
                                if( eachOwner.ownerCity != null  )
                                    objLead.City_Owner_4__c = eachOwner.ownerCity;
                                if( eachOwner.ownerCellChone_no != null  )
                                    objLead.Mobile_4th_Owner__c = eachOwner.ownerCellChone_no;
                                if( eachOwner.owner_dob != null  )
                                    objLead.DOB_Owner_4__c = Date.valueOf(eachOwner.owner_dob);
                                if( eachOwner.owner_email != null  )
                                    objLead.Email_4th_Owner__c = eachOwner.owner_email;
                                if( eachOwner.owner_home_address != null  )
                                    objLead.Street_Owner_4__c = eachOwner.owner_home_address;
                                if( eachOwner.owner_state_id != null  )
                                    objLead.State_Owner_4__c = eachOwner.owner_state_id;
                                if( eachOwner.owner_title != null  )
                                    objLead.Title_4th_Owner__c = eachOwner.owner_title;
                                if( eachOwner.Owner_zipcode != null  )
                                    objLead.Zip_Code_Owner_4__c = eachOwner.Owner_zipcode;
                                
                                objLead.Country_Owner_4__c = 'US';
                                
                                // ObjLead.Credit_Score_4th_Owner_from_Webform__c = eachOwner.CreditScorefromWebform;
                                if( eachOwner.owner_home_phone_no != null  )
                                    ObjLead.Phone_4th_Owner__c = eachOwner.owner_home_phone_no;
                                if( eachOwner.ownerCellChone_no != null  )
                                    ObjLead.Mobile_4th_Owner__c = eachOwner.ownerCellChone_no;
                                if( eachOwner.RunCreditReport != null  )
                                    objLead.Run_Owner4_Credit_Report__c = boolean.valueOf(eachOwner.RunCreditReport);
                                /*if( eachOwner.owner_rent != null  )
ObjLead.Owner_Rent_4__c =  eachOwner.owner_rent;
*/
                            }
                        }
                        
                        if( objLead.Owner_ID_Owner_5__c == eachOwner.owner_id)
                        {
                            if( eachOwner.owner_id != null  )
                                objLead.Owner_ID_Owner_5__c = eachOwner.owner_id;
                            if( eachOwner.owner_first_name != null  )
                                objLead.First_Name_5th_Owner__c = eachOwner.owner_first_name;
                            if( eachOwner.owner_last_name != null  )
                                objLead.Last_Name_5th_Owner__c = eachOwner.owner_last_name;
                            if( eachOwner.owner_SSN != null  )
                                objLead.SSN_5th_Owner__c = eachOwner.owner_SSN;
                            if( eachOwner.owner_percentage != null  )
                                objLead.of_Ownership_5th_Owner__c = Decimal.valueof(eachOwner.owner_percentage);
                            if( eachOwner.ownerCity != null  )
                                objLead.City_Owner_5__c = eachOwner.ownerCity;
                            if( eachOwner.ownerCellChone_no != null  )
                                objLead.Mobile_5th_Owner__c = eachOwner.ownerCellChone_no;
                            if( eachOwner.owner_dob != null  )
                                objLead.DOB_Owner_5__c = Date.valueOf(eachOwner.owner_dob);
                            if( eachOwner.owner_email != null  )
                                objLead.Email_5th_Owner__c = eachOwner.owner_email;
                            if( eachOwner.owner_home_address != null  )
                                objLead.Street_Owner_5__c = eachOwner.owner_home_address;
                            if( eachOwner.owner_state_id != null  )
                                objLead.State_Owner_5__c = eachOwner.owner_state_id;
                            if( eachOwner.owner_title != null  )
                                objLead.Title_5th_Owner__c = eachOwner.owner_title;
                            if( eachOwner.Owner_zipcode != null  )
                                objLead.Zip_Code_Owner_5__c = eachOwner.Owner_zipcode;
                            
                            objLead.Country_Owner_5__c = 'US';
                            //ObjLead.Credit_Score_5th_Owner_from_Webform__c = eachOwner.CreditScorefromWebform;
                            if( eachOwner.owner_home_phone_no != null  )
                                ObjLead.Phone_5th_Owner__c = eachOwner.owner_home_phone_no;
                            
                            if( eachOwner.RunCreditReport != null  )
                                objLead.Run_Owner5_Credit_Report__c = boolean.valueOf(eachOwner.RunCreditReport);
                            /* if( eachOwner.owner_rent != null  )
ObjLead.Owner_Rent_5__c =  eachOwner.owner_rent;
*/
                        }
                        else
                        {
                            if( i == 5 && (objLead.Owner_ID_Owner_5__c == null || objLead.Owner_ID_Owner_5__c == ''))
                            {
                                
                                if( eachOwner.owner_id != null  )
                                    objLead.Owner_ID_Owner_5__c = eachOwner.owner_id;
                                if( eachOwner.owner_first_name != null  )
                                    objLead.First_Name_5th_Owner__c = eachOwner.owner_first_name;
                                if( eachOwner.owner_last_name != null  )
                                    objLead.Last_Name_5th_Owner__c = eachOwner.owner_last_name;
                                if( eachOwner.owner_SSN != null  )
                                    objLead.SSN_5th_Owner__c = eachOwner.owner_SSN;
                                if( eachOwner.owner_percentage != null  )
                                    objLead.of_Ownership_5th_Owner__c = Decimal.valueof(eachOwner.owner_percentage);
                                if( eachOwner.ownerCity != null  )
                                    objLead.City_Owner_5__c = eachOwner.ownerCity;
                                if( eachOwner.ownerCellChone_no != null  )
                                    objLead.Mobile_5th_Owner__c = eachOwner.ownerCellChone_no;
                                if( eachOwner.owner_dob != null  )
                                    objLead.DOB_Owner_5__c = Date.valueOf(eachOwner.owner_dob);
                                if( eachOwner.owner_email != null  )
                                    objLead.Email_5th_Owner__c = eachOwner.owner_email;
                                if( eachOwner.owner_home_address != null  )
                                    objLead.Street_Owner_5__c = eachOwner.owner_home_address;
                                if( eachOwner.owner_state_id != null  )
                                    objLead.State_Owner_5__c = eachOwner.owner_state_id;
                                if( eachOwner.owner_title != null  )
                                    objLead.Title_5th_Owner__c = eachOwner.owner_title;
                                if( eachOwner.Owner_zipcode != null  )
                                    objLead.Zip_Code_Owner_5__c = eachOwner.Owner_zipcode;
                                
                                objLead.Country_Owner_5__c = 'US';
                                
                                if( eachOwner.owner_home_phone_no != null  )
                                    ObjLead.Phone_5th_Owner__c = eachOwner.owner_home_phone_no;
                                
                                if( eachOwner.RunCreditReport != null  )
                                    objLead.Run_Owner5_Credit_Report__c = boolean.valueOf(eachOwner.RunCreditReport);
                                /* if( eachOwner.owner_rent != null  )
ObjLead.Owner_Rent_5__c =  eachOwner.owner_rent;
*/
                                
                            } 
                        }
                        
                        i = i+1;
                        
                    }
                    
                }
                
                update objLead;
                jsonResponse = '{"status": true, "id": "' + objLead.ID+ '", "errors":[]}';
                res.responseBody = blob.valueOf(jsonResponse);                
                res.responseBody = blob.valueOf(jsonResponse);  
                objPortalExceptionHadling.Response__c = jsonResponse;
                objPortalExceptionHadling.Success_Error_Code__c = '200';
                objPortalExceptionHadling.Request__c = request.requestBody.toString();
                objPortalExceptionHadling.exception__c = null;
                objPortalExceptionHadling.Business_Id__c = leadinfo.BusinessId;
                objPortalExceptionHadling.Application_Id__c = leadinfo.application_id;
                objPortalExceptionHadling.Opportunity_Id__c = '';
                objPortalExceptionHadling.Lead_Id__c = objLead.Id;
                
            }
            
        }
        Catch(Exception ex)   
        {
            res.statusCode = 500;
            jsonResponse = '{"status": false, "errors": "[' + ex + ']"}';
            res.responseBody = blob.valueOf(jsonResponse); 
            system.debug('*****Exception *******>>'+ex);
            objPortalExceptionHadling.Response__c = jsonResponse;
            objPortalExceptionHadling.Success_Error_Code__c = '500';
            objPortalExceptionHadling.Request__c = request.requestBody.toString();
            objPortalExceptionHadling.exception__c = string.valueof(ex)+RecordId ;
            objPortalExceptionHadling.Business_Id__c = leadinfo.BusinessId;
            objPortalExceptionHadling.Application_Id__c = leadinfo.application_id;
            objPortalExceptionHadling.Opportunity_Id__c = '';
            objPortalExceptionHadling.Lead_Id__c = objLead.Id;
        } 
        insert objPortalExceptionHadling;
        return;
    }
    
    @HttpDelete 
    global static void deleteOwners() {
        RestRequest request = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String jsonResponse = '';
        JSON2Apex leadinfo = new JSON2Apex();
        Lead objLead = new Lead();
        List<Integer> lstOfOwners = new List<Integer>();
        system.debug('+++Request body+++'+request.requestBody.toString());
        Portal_Integration_Response_Code__c objPortalExceptionHadling = new Portal_Integration_Response_Code__c();
        try
        {
            system.debug('++Enter try++');
            
            //list<JSON2Apex> leadinfo = (list<JSON2Apex> )JSON.deserialize(request.requestBody.toString(), JSON2Apex.class);
            
            leadinfo = JSON2Apex.parse(request.requestBody.toString());
            
            system.debug('***********leadinfo***************>>'+ leadinfo );
            if(leadinfo !=null ){
                objLead = [ Select of_Dials__c,Owner_ID_Owner_1__c,Owner_ID_Owner_2__c,Owner_ID_Owner_3__c,Owner_ID_Owner_4__c,Owner_ID_Owner_5__c,of_Ownership_Owner__c,creditchecker__Adverse_Alert__c,Are_you_COD_30_60_90__c,creditchecker__Average_Score__c,creditchecker__Bankruptcy_Count__c,Brief_History_on_the_business__c,Brief_History_on_the_owner_manager__c,Campaign_Source__c,creditchecker__Charge_Offs_Count__c,creditchecker__Collections_Count__c
                           ,creditchecker__Current_Adverse_Count__c,creditchecker__Derogatory_Count__c,
                           creditchecker__Disputes_Count__c,Do_You_Carry_Life_Insurance__c,Do_you_pay_child_support_or_alimony__c,
                           Entity_Type__c,Explanation_of_any_BKs_defaults_etc__c,First_Name_2nd_Owner__c,Homeowner__c,
                           Last_Name_2nd_Owner__c,Monthly_Rent_Mtg__c,Owner__c,Planned_Changes_In_Next_6_Months__c,
                           creditchecker__Previous_Adverse_Count__c,Profitable_Last_2_Years__c,creditchecker__Public_Record_Count__c,
                           Referral_Partner__c,Referral_type__c,Requested_Amount__c,creditchecker__Revolving_Credit_Utilization__c,
                           Second_Owner__c,TIB_Months__c,creditchecker__Total_High_Credit__c,creditchecker__Total_Inquiry_Count__c,
                           creditchecker__Total_Liability_Balance__c,creditchecker__Total_Liability_PastDue__c,
                           creditchecker__Total_Liability_Payment__c,Use_of_Funds__c,What_are_the_terms_of_your_current_lease__c,
                           What_exactly_does_the_business_do__c,What_is_the_purpose_of_loan__c,Who_is_your_customer_base__c,
                           of_Ownership_Second_Owner__c,Address,Address_3rd_Owner__c,Address_4th_Owner__c,Address_5th_Owner__c,
                           Address_Owner_1__c,Address_Owner_2__c,AnnualRevenue,City,City_2nd_Owner__c,City_Owner_1__c,City_Owner_2__c,
                           City_Owner_3__c,City_Owner_4__c,City_Owner_5__c,Company,IsConverted,ConvertedAccountId,ConvertedContactId,
                           ConvertedDate,ConvertedOpportunityId,Country,Country_2nd_Owner__c,Country_Owner_1__c,Country_Owner_2__c,
                           Country_Owner_3__c,Country_Owner_4__c,Country_Owner_5__c,CreatedById,CreatedDate,Credit_Report_Type__c,
                           Credit_Score_2nd_Owner__c,Credit_Score_3rd_Owner_from_Webform__c,Credit_Score_4th_Owner_from_Webform__c,
                           Credit_Score_5th_Owner_from_Webform__c,Credit_Score__c,Jigsaw,IsDeleted,Description,DoNotCall,Email,
                           Email_2nd_Owner__c,Email_3rd_Owner__c,Email_4th_Owner__c,Email_5th_Owner__c,NumberOfEmployees,FirstName,
                           First_Name_3rd_Owner__c,First_Name_4th_Owner__c,First_Name_5th_Owner__c,Name,GeocodeAccuracy,Industry,
                           JigsawContactId,LastActivityDate,LastModifiedById,LastModifiedDate,LastName,Last_Name_3rd_Owner__c,
                           Last_Name_4th_Owner__c,Last_Name_5th_Owner__c,LastReferencedDate,LastViewedDate,Latitude,Id,LeadSource,
                           Longitude,MasterRecordId,MiddleName,Mobile_2nd_Owner__c,Mobile_3rd_Owner__c,Mobile_4th_Owner__c,
                           Mobile_5th_Owner__c,MobilePhone,Not_Interested__c,of_Ownership_3rd_Owner__c,of_Ownership_4th_Owner__c,
                           of_Ownership_5th_Owner__c,OwnerId,Phone,Phone_2nd_Owner__c,Phone_3rd_Owner__c,Phone_4th_Owner__c,
                           Phone_5th_Owner__c,PhotoUrl,Postal_Code_2nd_Owner__c,Rating,Referral_Partner_Email__c,Sales_Decline__c,
                           Salutation,Source_Web_Form__c,SSN1__c,SSN2__c,SSN_3rd_Owner__c,SSN_4th_Owner__c,SSN_5th_Owner__c,
                           State_2nd_Owner__c,State_Owner_1__c,State_Owner_2__c,State_Owner_3__c,State_Owner_4__c,State_Owner_5__c,
                           State,Status,Status_Detail__c,Street,Street_2nd_Owner__c,Street_Owner_1__c,Street_Owner_2__c,Street_Owner_3__c,
                           Street_Owner_4__c,Street_Owner_5__c,Suffix,SystemModstamp,Title,Title_2nd_Owner__c,Title_3rd_Owner__c,
                           Title_4th_Owner__c,Title_5th_Owner__c,IsUnreadByOwner,UTM_Campaign__c,UTM_Medium__c,UTM_Source__c,Website,
                           Zip_Code_Owner_1__c,Zip_Code_Owner_2__c,Zip_Code_Owner_3__c,Zip_Code_Owner_4__c,Zip_Code_Owner_5__c,
                           PostalCode From Lead Where Id=:leadinfo.LeadId];
                
                
                
                
                if(leadinfo.OwnerInfoList != null && leadinfo.OwnerInfoList.size()> 0 )
                {
                    
                    system.debug('*******leadinfo.OwnerInfoList.size()******'+leadinfo.OwnerInfoList.size());
                    
                    
                    for( JSON2Apex.OwnerInfoWrap eachOwner : leadinfo.OwnerInfoList)
                    {
                        
                        if( objLead.Owner_ID_Owner_1__c == eachOwner.owner_id)
                        {
                            objLead.Owner_ID_Owner_1__c ='';
                            objLead.SSN1__c ='';
                            objLead.of_Ownership_Owner__c =null;
                            
                            objLead.MobilePhone ='';
                            objLead.City_Owner_1__c ='';
                            objLead.Email ='';
                            objLead.Street_Owner_1__c ='';
                            objLead.State_Owner_1__c ='';
                            objLead.Title ='';
                            objLead.Zip_Code_Owner_1__c ='';
                            objLead.Country_Owner_1__c ='';
                            objLead.Credit_Score__c ='';
                            objLead.Phone ='';
                            objLead.MobilePhone ='';
                            objLead.Run_Credit_Report__c =false;
                            
                        }
                        system.debug('*******i2 ******'+i );
                        
                        if( objLead.Owner_ID_Owner_2__c == eachOwner.owner_id)
                        {
                            objLead.Owner_ID_Owner_2__c ='';
                            objLead.First_Name_2nd_Owner__c ='';
                            objLead.Last_Name_2nd_Owner__c ='';
                            objLead.SSN2__c ='';
                            objLead.of_Ownership_Second_Owner__c  =null;
                            objLead.City_Owner_2__c ='';
                            objLead.Mobile_2nd_Owner__c ='';
                            objLead.Email_2nd_Owner__c ='';
                            objLead.Street_Owner_2__c ='';
                            objLead.State_Owner_2__c ='';
                            objLead.Title_2nd_Owner__c ='';
                            objLead.Zip_Code_Owner_2__c ='';
                            objLead.Country_Owner_2__c ='';
                            objLead.Credit_Score_2nd_Owner__c ='';
                            objLead.Phone_2nd_Owner__c ='';
                            objLead.Mobile_2nd_Owner__c ='';
                            objLead.Run_Owner2_Credit_Report__c =false;
                        }
                        system.debug('*******i3 ******'+i );
                        if( objLead.Owner_ID_Owner_3__c == eachOwner.owner_id)
                        {
                            objLead.Owner_ID_Owner_3__c ='';
                            objLead.First_Name_3rd_Owner__c ='';
                            objLead.Last_Name_3rd_Owner__c ='';
                            objLead.SSN_3rd_Owner__c ='';
                            objLead.of_Ownership_3rd_Owner__c  =null;
                            objLead.City_Owner_3__c ='';
                            objLead.Mobile_3rd_Owner__c ='';
                            objLead.Email_3rd_Owner__c ='';
                            objLead.Street_Owner_3__c ='';
                            objLead.State_Owner_3__c ='';
                            objLead.Title_3rd_Owner__c ='';
                            objLead.Zip_Code_Owner_3__c ='';
                            objLead.Country_Owner_3__c ='';
                            objLead.Credit_Score_3rd_Owner_from_Webform__c ='';
                            objLead.Phone_3rd_Owner__c ='';
                            objLead.Mobile_3rd_Owner__c ='';
                            objLead.Run_Owner3_Credit_Report__c =false;
                        }
                        system.debug('*******i4 ******'+i );
                        if( objLead.Owner_ID_Owner_4__c ==  eachOwner.owner_id)
                        {
                            objLead.Owner_ID_Owner_4__c ='';
                            objLead.First_Name_4th_Owner__c ='';
                            objLead.Last_Name_4th_Owner__c ='';
                            objLead.SSN_4th_Owner__c ='';
                            objLead.of_Ownership_4th_Owner__c  =null;
                            objLead.City_Owner_4__c ='';
                            objLead.Mobile_4th_Owner__c ='';
                            // objLead.ConvertedContactId "=" eachOwner.
                            objLead.Email_4th_Owner__c ='';
                            objLead.Street_Owner_4__c ='';
                            objLead.State_Owner_4__c ='';
                            objLead.Title_4th_Owner__c ='';
                            objLead.Zip_Code_Owner_4__c ='';
                            objLead.Country_Owner_4__c ='';
                            objLead.Credit_Score_4th_Owner_from_Webform__c ='';
                            objLead.Phone_4th_Owner__c ='';
                            objLead.Mobile_4th_Owner__c ='';
                            objLead.Run_Owner4_Credit_Report__c =false;
                        }
                        system.debug('*******i5 ******'+i );
                        if( objLead.Owner_ID_Owner_5__c == eachOwner.owner_id)
                        {
                            objLead.Owner_ID_Owner_5__c ='';
                            objLead.First_Name_5th_Owner__c ='';
                            objLead.Last_Name_5th_Owner__c ='';
                            objLead.SSN_5th_Owner__c ='';
                            objLead.of_Ownership_5th_Owner__c  =null;
                            objLead.City_Owner_5__c ='';
                            objLead.Mobile_5th_Owner__c ='';
                            objLead.Email_5th_Owner__c ='';
                            objLead.Street_Owner_5__c ='';
                            objLead.State_Owner_5__c ='';
                            objLead.Title_5th_Owner__c ='';
                            objLead.Zip_Code_Owner_5__c ='';
                            objLead.Country_Owner_5__c ='';
                            objLead.Credit_Score_5th_Owner_from_Webform__c ='';
                            objLead.Phone_5th_Owner__c ='';
                            objLead.Mobile_5th_Owner__c ='';
                            objLead.Run_Owner5_Credit_Report__c =false;
                        }
                        
                    }
                    
                }
                system.debug('*****objLead*******>>'+objLead);
                update objLead;
                res.responseBody = blob.valueOf(jsonResponse);  
                objPortalExceptionHadling.Response__c = jsonResponse;
                objPortalExceptionHadling.Success_Error_Code__c = '200';
                objPortalExceptionHadling.Request__c = request.requestBody.toString();
                objPortalExceptionHadling.exception__c = null;
                objPortalExceptionHadling.Business_Id__c = leadinfo.BusinessId;
                objPortalExceptionHadling.Application_Id__c = leadinfo.application_id;
                objPortalExceptionHadling.Opportunity_Id__c = '';
                objPortalExceptionHadling.Lead_Id__c = objLead.Id;
                
            }  
        }
        Catch(Exception ex)   
        {
            res.statusCode = 500;
            jsonResponse = '{"status": false, "errors": "[' + ex + ']"}';
            res.responseBody = blob.valueOf(jsonResponse); 
            system.debug('*****Exception *******>>'+ex);
            objPortalExceptionHadling.Response__c = request.requestBody.toString();
            objPortalExceptionHadling.Success_Error_Code__c = '500';
            objPortalExceptionHadling.Request__c = request.requestBody.toString();
            objPortalExceptionHadling.exception__c = string.valueof(ex);
            objPortalExceptionHadling.Business_Id__c = leadinfo.BusinessId;
            objPortalExceptionHadling.Application_Id__c = leadinfo.application_id;
            objPortalExceptionHadling.Opportunity_Id__c = '';
            objPortalExceptionHadling.Lead_Id__c = objLead.Id;
        } 
        insert objPortalExceptionHadling;
        return; 
    }
    
    @HttpGet  
    global static mainWrapper  getLeadData() {
        RestRequest request = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String leadId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1); //request.params.get('id');
        String jsonResponse = '';
        JSON2Apex leadinfo = new JSON2Apex();
        Lead objLead = new Lead();
        system.debug('+++Request body+++'+request.requestBody.toString());
        mainWrapper objmainWrapper = new mainWrapper();
        list<OwnerInfoWrap> lstOwners = new list<OwnerInfoWrap>();
        Portal_Integration_Response_Code__c objPortalExceptionHadling = new Portal_Integration_Response_Code__c();
        try
        {
            system.debug('++Enter try++'+leadId);
            
            String dateFormatString = 'MM/dd/yyyy';
            if(leadId !=null && leadId != '' ){
                objLead = [ Select Does_the_Business_have_existing_SBA_Debt__c,Have_you_exhausted_all_personal_non_SB__c,Portal_Application_Status__c,Net_Worth__c,Who_is_Your_Customer_Base1__c,Ethnicity__c,Race__c,Veteran__c,Disabled__c,Women_Owned__c,Owner_Rent_1__c,Owner_Rent_2__c,Owner_Rent_3__c,Owner_Rent_4__c,Owner_Rent_5__c,of_employees_added_in_next_12_months__c,of_customer_served_monthly__c,Business_Start_Date__c, DOB_Owner_1__c,DOB_Owner_2__c,DOB_Owner_3__c,DOB_Owner_4__c,DOB_Owner_5__c,What_does_your_Business_do__c,What_type_of_Business_is_it__c,Tell_us_more__c,Business_Phone__c, Street, City, State, PostalCode, Country, AnnualRevenue, Company, IsConverted, ConvertedAccountId, ConvertedContactId, ConvertedDate, ConvertedOpportunityId, CreatedById, CreatedDate, Jigsaw, IsDeleted, Description, DoNotCall, Email, EmailBouncedDate, EmailBouncedReason, HasOptedOutOfEmail, Fax, HasOptedOutOfFax, Industry, JigsawContactId, LastActivityDate, LastModifiedById, LastModifiedDate, LastReferencedDate,  LastViewedDate, MasterRecordId, Id, OwnerId, LeadSource, Status, MobilePhone, Salutation, FirstName, LastName, NumberOfEmployees, Phone, PhotoUrl, Rating, SystemModstamp, Title, IsUnreadByOwner ,Website,Phone_4th_Owner__c,Country_Owner_5__c,Title_4th_Owner__c,Last_Name_4th_Owner__c,creditchecker__Public_Record_Count__c,Address_3rd_Owner__c,pi__utm_term__c,Credit_Score_3rd_Owner_from_Webform__c,creditchecker__Disputes_Count__c,Mobile_3rd_Owner__c,Campaign_Source__c,creditchecker__Charge_Offs_Count__c,pi__utm_source__c,SSN_4th_Owner__c,Credit_Score_5th_Owner_from_Webform__c,creditchecker__Revolving_Credit_Utilization__c,Actual_Owner3_Credit_Score__c,Run_Owner3_Credit_Report__c,Title_2nd_Owner__c,pi__utm_medium__c,Street_Owner_1__c,creditchecker__Oldest_Date__c,Source_Web_Form__c,Credit_Score_4th_Owner_from_Webform__c,Brief_History_on_the_owner_manager__c,Zip_Code_Owner_5__c,MC4SF__MC_Subscriber__c,pi__comments__c,Referral_Partner__c,pi__utm_campaign__c,Last_Name_3rd_Owner__c,of_Ownership_3rd_Owner__c,Last_Name_2nd_Owner__c,creditchecker__Bankruptcy_Count__c,First_Name_3rd_Owner__c,Owner__c,Street_Owner_2__c,Owner_ID_Owner_2__c,Street_Owner_5__c,Email_4th_Owner__c,pi__last_activity__c,of_Ownership_5th_Owner__c,What_are_the_terms_of_your_current_lease__c,Who_is_your_customer_base__c,of_Ownership_Owner__c,City_Owner_5__c,BusinessId__c,SSN2__c,pi__Needs_Score_Synced__c,City_Owner_1__c,Second_Owner__c,Mobile_4th_Owner__c,Owner_ID_Owner_1__c,Street_Owner_4__c,creditchecker__Derogatory_Count__c,First_Name_5th_Owner__c,creditchecker__Debt_High_Credit__c,pi__score__c,pi__first_activity__c,Credit_Report_Type__c,UTM_Medium__c,Title_3rd_Owner__c,Referral_type__c,pi__grade__c,Owner_ID_Owner_3__c,Homeowner__c,Run_Owner5_Credit_Report__c,pi__conversion_object_name__c,pi__pardot_hard_bounced__c,SSN_5th_Owner__c,Do_You_Carry_Life_Insurance__c,Street_2nd_Owner__c,pi__first_search_term__c,Zip_Code_Owner_3__c,pi__first_search_type__c,TIB_Months__c,Profitable_Last_2_Years__c,creditchecker__Most_Recent_Late__c,Country_Owner_4__c,State_Owner_2__c,State_Owner_4__c,pi__conversion_date__c,Address_Owner_1__c,Use_of_Funds__c,Address_Owner_2__c,creditchecker__Collections_Count__c,Credit_Score_2nd_Owner__c,Email_2nd_Owner__c,Run_Owner2_Credit_Report__c,First_Name_2nd_Owner__c,SSN1__c,pi__campaign__c,City_Owner_2__c,Brief_History_on_the_business__c,City_2nd_Owner__c,pi__conversion_object_type__c,Entity_Type__c,of_Dials__c,Referral_Partner_Email__c,Phone_5th_Owner__c,First_Name_4th_Owner__c,State_Owner_1__c,City_Owner_3__c,creditchecker__Secured_Debt__c,Do_you_pay_child_support_or_alimony__c,Explanation_of_any_BKs_defaults_etc__c,creditchecker__Previous_Adverse_Count__c,Street_Owner_3__c,pi__notes__c,Sales_Decline__c,creditchecker__Unsecured_Debt__c,Country_Owner_3__c,creditchecker__Current_Adverse_Count__c,pi__utm_content__c,SSN_3rd_Owner__c,Actual_Owner4_Credit_Score__c,Address_4th_Owner__c,Phone_3rd_Owner__c,pi__first_touch_url__c,Status_Detail__c,Address_5th_Owner__c,Zip_Code_Owner_1__c,Country_2nd_Owner__c,Zip_Code_Owner_4__c,pi__Pardot_Last_Scored_At__c,Country_Owner_1__c,Not_Interested__c,Country_Owner_2__c,UTM_Source__c,Credit_Score__c,Are_you_COD_30_60_90__c,Mobile_2nd_Owner__c,pi__url__c,creditchecker__Adverse_Alert__c,creditchecker__Total_High_Credit__c,Postal_Code_2nd_Owner__c,creditchecker__Total_Liability_Payment__c,Owner_ID_Owner_5__c,Email_5th_Owner__c,City_Owner_4__c,Monthly_Rent_Mtg__c,State_Owner_3__c,Actual_Owner5_Credit_Score__c,creditchecker__Total_Inquiry_Count__c,Email_3rd_Owner__c,Last_Name_5th_Owner__c,Actual_Owner1_Credit_Score__c,UTM_Campaign__c,Zip_Code_Owner_2__c,pi__created_date__c,Mobile_5th_Owner__c,of_Ownership_Second_Owner__c,State_2nd_Owner__c,Planned_Changes_In_Next_6_Months__c,State_Owner_5__c,What_exactly_does_the_business_do__c,Title_5th_Owner__c,Owner_ID_Owner_4__c,Phone_2nd_Owner__c,Actual_Owner2_Credit_Score__c,of_Ownership_4th_Owner__c,Run_Owner4_Credit_Report__c,creditchecker__Total_Liability_PastDue__c,creditchecker__Date_Completed__c,What_is_the_purpose_of_loan__c,Requested_Amount__c,Run_Credit_Report__c,creditchecker__Average_Score__c,creditchecker__Total_Liability_Balance__c From Lead Where Id=:leadId];
                
                //objmainWrapper.Street= objLead.Street;
                if(objLead != null )
                {
                    
                    system.debug('*******objLead******'+objLead);
                    
                    
                    
                    if( objLead.LastName!=null && objLead.LastName != '')
                    {
                        OwnerInfoWrap objWrap = new OwnerInfoWrap();
                        
                        System.debug('--objLead.DOB_Owner_1__c-------->>'+objLead.DOB_Owner_1__c);
                        if (objLead.DOB_Owner_1__c != null )
                        {
                            Date d = objLead.DOB_Owner_1__c;
                            Datetime dt = Datetime.newInstance(d.year(), d.month(),d.day());
                            String dateString = dt.format(dateFormatString);
                            objWrap.owner_dob = dateString; 
                        }
                        
                        objWrap.Owner_Rent = objLead.Owner_Rent_1__c;
                        
                        objWrap.owner_id = objLead.Owner_ID_Owner_1__c  ;
                        objWrap.owner_first_name = objLead.FirstName ;
                        objWrap.owner_last_name= objLead.LastName ;
                        objWrap.owner_SSN= objLead.SSN1__c ;
                        objWrap.owner_percentage= string.valueof(objLead.of_Ownership_Owner__c ) ;
                        objWrap.ownerCity= objLead.City_Owner_1__c  ;
                        objWrap.ownerCellChone_no= objLead.MobilePhone  ;
                        objWrap.owner_email= objLead.Email ;
                        objWrap.owner_home_address= objLead.Street_Owner_1__c ;
                        objWrap.owner_state_id= objLead.State_Owner_1__c  ;
                        objWrap.owner_title= objLead.Title;
                        objWrap.Owner_zipcode= objLead.Zip_Code_Owner_1__c  ;
                        objWrap.Owner_Country= objLead.Country_Owner_1__c  ;
                        objWrap.CreditScorefromWebform= objLead.Credit_Score__c  ;
                        objWrap.Owner_Phone= objLead.Phone;
                        objWrap.RunCreditReport= string.valueof(objLead.Run_Owner2_Credit_Report__c) ;
                        objWrap.isPrimaryContact = 'True';
                        objWrap.OwnerCreditScore = String.valueOf(objLead.Actual_Owner1_Credit_Score__c);
                        lstOwners.add(objWrap);
                    }
                    system.debug('*******i2 ******'+i );
                    
                    if( objLead.Last_Name_2nd_Owner__c != null && objLead.Last_Name_2nd_Owner__c  != '') 
                    {
                        OwnerInfoWrap objWrap = new OwnerInfoWrap();
                        System.debug('--objLead.DOB_Owner_2__c-------->>'+objLead.DOB_Owner_2__c);
                        
                        if (objLead.DOB_Owner_2__c != null){
                            Date d = objLead.DOB_Owner_2__c;
                            Datetime dt = Datetime.newInstance(d.year(), d.month(),d.day());
                            String dateString = dt.format(dateFormatString);
                            objWrap.owner_dob = dateString;  
                        }
                        
                        objWrap.Owner_Rent = objLead.Owner_Rent_2__c;
                        
                        objWrap.owner_id = objLead.Owner_ID_Owner_2__c ;
                        objWrap.owner_first_name = objLead.First_Name_2nd_Owner__c ;
                        objWrap.owner_last_name= objLead.Last_Name_2nd_Owner__c ;
                        objWrap.owner_SSN= objLead.SSN2__c ;
                        objWrap.owner_percentage= string.valueof(objLead.of_Ownership_Second_Owner__c) ;
                        objWrap.ownerCity= objLead.City_Owner_2__c ;
                        objWrap.ownerCellChone_no= objLead.Mobile_2nd_Owner__c ;
                        objWrap.owner_email= objLead.Email_2nd_Owner__c ;
                        objWrap.owner_home_address= objLead.Street_Owner_2__c ;
                        objWrap.owner_state_id= objLead.State_Owner_2__c ;
                        objWrap.owner_title= objLead.Title_2nd_Owner__c ;
                        objWrap.Owner_zipcode= objLead.Zip_Code_Owner_2__c ;
                        objWrap.Owner_Country= objLead.Country_Owner_2__c ;
                        objWrap.CreditScorefromWebform= objLead.Credit_Score_2nd_Owner__c ;
                        objWrap.Owner_Phone= objLead.Phone_2nd_Owner__c ;
                        objWrap.RunCreditReport= string.valueof(objLead.Run_Owner2_Credit_Report__c) ;
                        objWrap.isPrimaryContact = 'false';
                        objWrap.OwnerCreditScore = String.valueOf(objLead.Actual_Owner2_Credit_Score__c);
                        lstOwners.add(objWrap);
                    }
                    system.debug('*******i3 ******'+i );
                    if( objLead.Last_Name_3rd_Owner__c != null && objLead.Last_Name_3rd_Owner__c != '')
                    {
                        OwnerInfoWrap objWrap = new OwnerInfoWrap();
                        System.debug('--objLead.DOB_Owner_3__c-------->>'+objLead.DOB_Owner_3__c);
                        
                        if(objLead.DOB_Owner_3__c != null){
                            Date d = objLead.DOB_Owner_3__c;
                            Datetime dt = Datetime.newInstance(d.year(), d.month(),d.day());
                            String dateString = dt.format(dateFormatString);
                            objWrap.owner_dob = dateString;
                        }
                        
                        objWrap.Owner_Rent = objLead.Owner_Rent_3__c;
                        
                        objWrap.owner_id = objLead.Owner_ID_Owner_3__c ;
                        objWrap.owner_first_name = objLead.First_Name_3rd_Owner__c ;
                        objWrap.owner_last_name= objLead.Last_Name_3rd_Owner__c ;
                        objWrap.owner_SSN= objLead.SSN_3rd_Owner__c  ;
                        objWrap.owner_percentage= string.valueof(objLead.of_Ownership_3rd_Owner__c ) ;
                        objWrap.ownerCity= objLead.City_Owner_3__c ;
                        objWrap.ownerCellChone_no= objLead.Mobile_3rd_Owner__c;
                        objWrap.owner_email= objLead.Email_3rd_Owner__c ;
                        objWrap.owner_home_address= objLead.Street_Owner_2__c ;
                        objWrap.owner_state_id= objLead.State_Owner_3__c ;
                        objWrap.owner_title= objLead.Title_3rd_Owner__c ;
                        objWrap.Owner_zipcode= objLead.Zip_Code_Owner_3__c ;
                        objWrap.Owner_Country= objLead.Country_Owner_3__c ;
                        objWrap.CreditScorefromWebform= objLead.Credit_Score_3rd_Owner_from_Webform__c  ;
                        objWrap.Owner_Phone= objLead.Phone_3rd_Owner__c ;
                        objWrap.RunCreditReport= string.valueof(objLead.Run_Owner3_Credit_Report__c) ;
                        objWrap.isPrimaryContact = 'false';
                        objWrap.OwnerCreditScore = String.valueOf(objLead.Actual_Owner3_Credit_Score__c);
                        lstOwners.add(objWrap);
                    }
                    system.debug('*******i4 ******'+i );
                    if( objLead.Last_Name_4th_Owner__c != null && objLead.Last_Name_4th_Owner__c  != '' )
                    {
                        OwnerInfoWrap objWrap = new OwnerInfoWrap();
                        System.debug('--objLead.DOB_Owner_4__c-------->>'+objLead.DOB_Owner_4__c);
                        if(objLead.DOB_Owner_4__c != null){
                            Date d = objLead.DOB_Owner_4__c;
                            Datetime dt = Datetime.newInstance(d.year(), d.month(),d.day());
                            String dateString = dt.format(dateFormatString);
                            objWrap.owner_dob = dateString;
                        }
                        
                        objWrap.Owner_Rent = objLead.Owner_Rent_4__c;
                        
                        objWrap.owner_id = objLead.Owner_ID_Owner_4__c ;
                        objWrap.owner_first_name = objLead.First_Name_4th_Owner__c ;
                        objWrap.owner_last_name= objLead.Last_Name_4th_Owner__c ;
                        objWrap.owner_SSN= objLead.SSN_4th_Owner__c  ;
                        objWrap.owner_percentage= string.valueof(objLead.of_Ownership_4th_Owner__c ) ;
                        objWrap.ownerCity= objLead.City_Owner_4__c ;
                        objWrap.ownerCellChone_no= objLead.Mobile_4th_Owner__c;
                        objWrap.owner_email= objLead.Email_4th_Owner__c ;
                        objWrap.owner_home_address= objLead.Street_Owner_2__c ;
                        objWrap.owner_state_id= objLead.State_Owner_4__c ;
                        objWrap.owner_title= objLead.Title_4th_Owner__c ;
                        objWrap.Owner_zipcode= objLead.Zip_Code_Owner_4__c ;
                        objWrap.Owner_Country= objLead.Country_Owner_4__c ;
                        objWrap.CreditScorefromWebform= objLead.Credit_Score_4th_Owner_from_Webform__c  ;
                        objWrap.Owner_Phone= objLead.Phone_4th_Owner__c ;
                        objWrap.RunCreditReport= string.valueof(objLead.Run_Owner4_Credit_Report__c) ;
                        objWrap.isPrimaryContact = 'false';
                        objWrap.OwnerCreditScore = String.valueOf(objLead.Actual_Owner4_Credit_Score__c);
                        lstOwners.add(objWrap);
                    }
                    system.debug('*******i5 ******'+i );
                    if( objLead.Last_Name_5th_Owner__c != null && objLead.Last_Name_5th_Owner__c != '' )
                    {
                        OwnerInfoWrap objWrap = new OwnerInfoWrap();
                        System.debug('--objLead.DOB_Owner_5__c-------->>'+objLead.DOB_Owner_5__c);
                        if(objLead.DOB_Owner_5__c != null){
                            Date d = objLead.DOB_Owner_5__c;
                            Datetime dt = Datetime.newInstance(d.year(), d.month(),d.day());
                            String dateString = dt.format(dateFormatString);
                            objWrap.owner_dob = dateString;
                        }
                        
                        objWrap.Owner_Rent = objLead.Owner_Rent_5__c;
                        
                        objWrap.owner_id = objLead.Owner_ID_Owner_5__c ;
                        objWrap.owner_first_name = objLead.First_Name_5th_Owner__c ;
                        objWrap.owner_last_name= objLead.Last_Name_5th_Owner__c ;
                        objWrap.owner_SSN= objLead.SSN_5th_Owner__c  ;
                        objWrap.owner_percentage= string.valueof(objLead.of_Ownership_5th_Owner__c ) ;
                        objWrap.ownerCity= objLead.City_Owner_5__c ;
                        objWrap.ownerCellChone_no= objLead.Mobile_5th_Owner__c;
                        objWrap.owner_email= objLead.Email_5th_Owner__c ;
                        objWrap.owner_home_address= objLead.Street_Owner_2__c ;
                        objWrap.owner_state_id= objLead.State_Owner_5__c ;
                        objWrap.owner_title= objLead.Title_5th_Owner__c ;
                        objWrap.Owner_zipcode= objLead.Zip_Code_Owner_5__c ;
                        objWrap.Owner_Country= objLead.Country_Owner_5__c ;
                        objWrap.CreditScorefromWebform= objLead.Credit_Score_5th_Owner_from_Webform__c  ;
                        objWrap.Owner_Phone= objLead.Phone_5th_Owner__c ;
                        objWrap.RunCreditReport= string.valueof(objLead.Run_Owner5_Credit_Report__c) ;
                        objWrap.isPrimaryContact = 'false';
                        objWrap.OwnerCreditScore = String.valueOf(objLead.Actual_Owner5_Credit_Score__c);
                        lstOwners.add(objWrap);
                    }
                }
                System.debug('--objLead.Business_Start_Date__c-------->>'+objLead.Business_Start_Date__c);
                if( objLead.Business_Start_Date__c != null )
                {
                    Date Business_Start_Date = objLead.Business_Start_Date__c;
                    Datetime BT = Datetime.newInstance(Business_Start_Date.year(), Business_Start_Date.month(),Business_Start_Date.day());
                    String businessStartdate = BT.format(dateFormatString);
                    objmainWrapper.business_start_date = businessStartdate;
                }
                
                objmainWrapper.Homeowner = objLead.Homeowner__c;
                objmainWrapper.Ethnicity = objLead.Ethnicity__c;
                if( objLead.Net_Worth__c != null )
                    objmainWrapper.Net_Worth =  string.valueof(objLead.Net_Worth__c);
                objmainWrapper.Race = objLead.Race__c;
                objmainWrapper.Veteran = objLead.Veteran__c == 'Yes'? True:False;
                objmainWrapper.Disabled = objLead.Disabled__c == 'Yes'? True:False;
                objmainWrapper.Women_Owned = objLead.Women_Owned__c == 'Yes'? True:False;
                objmainWrapper.of_customer_served_monthly = objLead.of_customer_served_monthly__c;
                objmainWrapper.of_employees_added_in_next_12_months = objLead.of_employees_added_in_next_12_months__c;
                objmainWrapper.What_does_your_Business_do= objLead.What_does_your_Business_do__c;
                
                objmainWrapper.What_type_of_Business_is_it= objLead.What_type_of_Business_is_it__c;
                
                
                objmainWrapper.Tell_us_more= objLead.Tell_us_more__c;
                objmainWrapper.Street= objLead.Street;
                objmainWrapper.City= objLead.City;
                objmainWrapper.State= objLead.State;
                objmainWrapper.PostalCode= objLead.PostalCode;
                objmainWrapper.Country= objLead.country;
                objmainWrapper.AnnualRevenue= string.valueof(objLead.AnnualRevenue);
                objmainWrapper.Company= objLead.Company;
                objmainWrapper.IsConverted= string.valueof(objLead.IsConverted);
                objmainWrapper.ConvertedAccountId= objLead.ConvertedAccountId;   
                objmainWrapper.ConvertedContactId= objLead.ConvertedContactId;
                objmainWrapper.ConvertedDate= string.valueof(objLead.ConvertedDate);
                objmainWrapper.ConvertedOpportunityId= objLead.ConvertedOpportunityId;
                objmainWrapper.CreatedById= objLead.CreatedById;
                objmainWrapper.CreatedDate= string.valueof(objLead.CreatedDate);
                objmainWrapper.Jigsaw= objLead.Jigsaw;
                objmainWrapper.IsDeleted= string.valueof(objLead.IsDeleted);
                objmainWrapper.Description= objLead.Description;
                objmainWrapper.DoNotCall= string.valueof(objLead.DoNotCall);
                objmainWrapper.Email= objLead.Email;
                objmainWrapper.EmailBouncedDate= string.valueof(objLead.EmailBouncedDate);
                objmainWrapper.EmailBouncedReason= objLead.EmailBouncedReason;
                objmainWrapper.HasOptedOutOfEmail= string.valueof(objLead.HasOptedOutOfEmail);
                objmainWrapper.Fax= objLead.Fax;
                objmainWrapper.HasOptedOutOfFax= string.valueof(objLead.HasOptedOutOfFax);
                objmainWrapper.Industry= objLead.Industry;
                objmainWrapper.JigsawContactId= objLead.JigsawContactId;
                //Comment added by Rahul 11/11/2019
                // objmainWrapper.LastActivityDate= string.valueof(objLead.LastActivityDate);
                objmainWrapper.LastModifiedById= objLead.LastModifiedById;
                objmainWrapper.LastModifiedDate= string.valueof(objLead.LastModifiedDate);
                objmainWrapper.LastReferencedDate= string.valueof(objLead.LastReferencedDate);
                // objmainWrapper.LastTransferDate= objLead.Last
                objmainWrapper.LastViewedDate= string.valueof(objLead.LastViewedDate);
                objmainWrapper.MasterRecordId= objLead.MasterRecordId;
                objmainWrapper.Id= objLead.id;
                objmainWrapper.OwnerId= objLead.OwnerId;
                objmainWrapper.LeadSource= objLead.leadSource;
                objmainWrapper.Status= objLead.Status;
                objmainWrapper.MobilePhone= objLead.MobilePhone;
                objmainWrapper.Salutation= objLead.Salutation;
                objmainWrapper.FirstName= objLead.FirstName;
                objmainWrapper.LastName= objLead.LastName;
                objmainWrapper.NumberOfEmployees= string.valueof(objLead.NumberOfEmployees);
                objmainWrapper.Phone= objLead.Business_Phone__c;
                objmainWrapper.PhotoUrl= objLead.PhotoUrl;
                objmainWrapper.Rating= objLead.Rating;
                objmainWrapper.SystemModstamp= string.valueof(objLead.SystemModstamp);
                objmainWrapper.Title= objLead.Title;
                objmainWrapper.IsUnreadByOwner= string.valueof(objLead.IsUnreadByOwner);
                objmainWrapper.Website= objLead.Website;
                
                objmainWrapper.creditchecker_Public_Record_Count= string.valueof(objLead.creditchecker__Public_Record_Count__c);
                objmainWrapper.pi_utm_term= objLead.pi__utm_term__c;
                objmainWrapper.creditchecker_Disputes_Count= string.valueof(objLead.creditchecker__Disputes_Count__c);
                objmainWrapper.Campaign_Source= objLead.Campaign_Source__c;
                objmainWrapper.PortalApplicationStatus = objLead.Portal_Application_Status__c;
                //objmainWrapper.creditchecker= objLead.creditchecker__c
                objmainWrapper.pi_utm_source= objLead.pi__utm_source__c;
                objmainWrapper.creditchecker_Revolving_Credit_Utilization= string.valueof(objLead.creditchecker__Revolving_Credit_Utilization__c);
                objmainWrapper.pi_utm_medium= objLead.pi__utm_medium__c;
                objmainWrapper.creditchecker_Oldest_Date= objLead.creditchecker__Oldest_Date__c;
                objmainWrapper.Source_Web_Form= objLead.Source_Web_Form__c;
                objmainWrapper.MC4SF_MC_Subscriber= objLead.MC4SF__MC_Subscriber__c;
                objmainWrapper.pi_comments= objLead.pi__comments__c;
                objmainWrapper.Referral_Partner= objLead.Referral_Partner__c;
                objmainWrapper.pi_utm_campaign= objLead.pi__utm_campaign__c;
                objmainWrapper.creditchecker_Bankruptcy_Count= string.valueof(objLead.creditchecker__Bankruptcy_Count__c);
                objmainWrapper.pi_last_activity= string.valueof(objLead.pi__last_activity__c);
                objmainWrapper.What_are_the_terms_of_your_current_lease= objLead.What_are_the_terms_of_your_current_lease__c;
                objmainWrapper.Who_is_your_customer_base= objLead.Who_is_Your_Customer_Base1__c;
                objmainWrapper.BusinessId= objLead.BusinessId__c;
                objmainWrapper.SSN2= objLead.SSN2__c;
                objmainWrapper.pi_Needs_Score_Synced= string.valueof(objLead.pi__Needs_Score_Synced__c);
                objmainWrapper.creditchecker_Derogatory_Count= string.valueof(objLead.creditchecker__Derogatory_Count__c);
                objmainWrapper.creditchecker_Debt_High_Credit= string.valueof(objLead.creditchecker__Debt_High_Credit__c);
                objmainWrapper.pi_score= string.valueof(objLead.pi__score__c);
                //objmainWrapper.pi_first_activity= string.valueof(objLead.pi_first_activity__c);
                objmainWrapper.Credit_Report_Type= objLead.Credit_Report_Type__c;
                objmainWrapper.UTM_Medium= objLead.UTM_Medium__c;
                objmainWrapper.Referral_type= objLead.Referral_type__c;
                objmainWrapper.pi_grade= objLead.pi__grade__c;
                //objmainWrapper.pi= objLead.pi_c;
                objmainWrapper.pi_pardot_hard_bounced= string.valueof(objLead.pi__pardot_hard_bounced__c);
                objmainWrapper.Do_You_Carry_Life_Insurance= objLead.Do_You_Carry_Life_Insurance__c;
                objmainWrapper.pi_first_search_term= objLead.pi__first_search_term__c;
                objmainWrapper.pi_first_search_type= objLead.pi__first_search_type__c;
                objmainWrapper.TIB_Months= objLead.TIB_Months__c;
                objmainWrapper.Profitable_Last_2_Years= objLead.Profitable_Last_2_Years__c;
                objmainWrapper.creditchecker_Most_Recent_Late= objLead.creditchecker__Most_Recent_Late__c;
                objmainWrapper.Use_of_Funds= objLead.Use_of_Funds__c;
                //objmainWrapper.pi_collections_Count= objLead.pi__c
                objmainWrapper.SSN1= objLead.SSN1__c;
                objmainWrapper.pi_campaign= objLead.pi__campaign__c;
                objmainWrapper.Brief_History_on_the_business= objLead.Brief_History_on_the_business__c;
                objmainWrapper.pi_conversion_object_type= objLead.pi__conversion_object_type__c;
                objmainWrapper.Entity_Type= objLead.Entity_Type__c;
                objmainWrapper.of_Dials= string.valueof(objLead.of_Dials__c);
                objmainWrapper.Referral_Partner_Email= objLead.Referral_Partner_Email__c;
                objmainWrapper.creditchecker_Secured_Debt= string.valueof(objLead.creditchecker__Secured_Debt__c);
                objmainWrapper.Do_you_pay_child_support_or_alimony= objLead.Do_you_pay_child_support_or_alimony__c;
                objmainWrapper.Explanation_of_any_BKs_defaults_etc= objLead.Explanation_of_any_BKs_defaults_etc__c;
                objmainWrapper.creditchecker_Previous_Adverse_Count= string.valueof(objLead.creditchecker__Previous_Adverse_Count__c);
                objmainWrapper.pi_notes= objLead.pi__notes__c;
                objmainWrapper.Sales_Decline= objLead.Sales_Decline__c;
                objmainWrapper.creditchecker_Unsecured_Debt= string.valueof(objLead.creditchecker__Unsecured_Debt__c);
                //objmainWrapper.pi_current_Adverse_Count= objLead.pi_
                objmainWrapper.pi_utm_content= objLead.pi__utm_content__c;
                objmainWrapper.pi_first_touch_url= objLead.pi__first_touch_url__c;
                objmainWrapper.Status_Detail= objLead.Status_Detail__c;
                objmainWrapper.pi_Pardot_Last_Scored_At= string.valueof(objLead.pi__Pardot_Last_Scored_At__c);
                objmainWrapper.Not_Interested= objLead.Not_Interested__c;
                objmainWrapper.UTM_Source= objLead.UTM_Source__c;
                objmainWrapper.Credit_Score= objLead.Credit_Score__c;
                objmainWrapper.Are_you_COD_30_60_90= objLead.Are_you_COD_30_60_90__c;
                objmainWrapper.pi_url= objLead.pi__url__c;
                objmainWrapper.creditchecker_Adverse_Alert= string.valueof(objLead.creditchecker__Adverse_Alert__c);
                objmainWrapper.creditchecker_Total_High_Credit= string.valueof(objLead.creditchecker__Total_High_Credit__c);
                objmainWrapper.creditchecker_Total_Liability_Payment= string.valueof(objLead.creditchecker__Total_Liability_Payment__c);
                objmainWrapper.Monthly_Rent_Mtg= string.valueof(objLead.Monthly_Rent_Mtg__c);
                objmainWrapper.creditchecker_Total_Inquiry_Count= string.valueof(objLead.creditchecker__Total_Inquiry_Count__c);
                objmainWrapper.UTM_Campaign= objLead.UTM_Campaign__c;
                objmainWrapper.Planned_Changes_In_Next_6_Months= objLead.Planned_Changes_In_Next_6_Months__c;
                objmainWrapper.What_exactly_does_the_business_do= objLead.What_exactly_does_the_business_do__c;
                objmainWrapper.creditchecker_Total_Liability_PastDue= string.valueof(objLead.creditchecker__Total_Liability_PastDue__c);
                objmainWrapper.creditchecker_Date_Completed= string.valueof(objLead.creditchecker__Date_Completed__c);
                objmainWrapper.What_is_the_purpose_of_loan= objLead.What_is_the_purpose_of_loan__c;
                objmainWrapper.Requested_Amount= string.valueof(objLead.Requested_Amount__c);
                objmainWrapper.Run_Credit_Report= string.valueof(objLead.Run_Credit_Report__c);
                objmainWrapper.creditchecker_Average_Score= string.valueof(objLead.creditchecker__Average_Score__c);
                objmainWrapper.creditchecker_Total_Liability_Balance= string.valueof(objLead.creditchecker__Total_Liability_Balance__c);
                objmainWrapper.zlstOwners = lstOwners; 
                if(String.isNotBlank(String.valueOf(objLead.Have_you_exhausted_all_personal_non_SB__c))) 
                objmainWrapper.Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins =  objLead.Have_you_exhausted_all_personal_non_SB__c == 'Yes'? true:false;
                if(String.isNotBlank(String.valueOf(objLead.Does_the_Business_have_existing_SBA_Debt__c))) 
                objmainWrapper.DoestheBusinesshaveexistingSBADebt = objLead.Does_the_Business_have_existing_SBA_Debt__c == 'Yes'? true:false;
                
                system.debug('*****lstOwners*******>>'+lstOwners);
                 system.debug('*****objmainWrapper*******>>'+objmainWrapper);
                
                res.responseBody = blob.valueOf(jsonResponse);  
                objPortalExceptionHadling.Response__c = JSON.serialize(objmainWrapper); //jsonResponse; 852
                objPortalExceptionHadling.Success_Error_Code__c = '200';
                objPortalExceptionHadling.Request__c = request.requestBody.toString();
                objPortalExceptionHadling.exception__c = null;
                objPortalExceptionHadling.Business_Id__c = leadinfo.BusinessId;
                objPortalExceptionHadling.Application_Id__c = leadinfo.application_id;
                objPortalExceptionHadling.Opportunity_Id__c = '';
                objPortalExceptionHadling.Lead_Id__c = objLead.Id;
                //return objmainWrapper;
                
                
            }  
        }
        Catch(Exception ex)   
        {
            res.statusCode = 500;
            jsonResponse = '{"status": false, "errors": "[' + ex + ']"}';
            res.responseBody = blob.valueOf(jsonResponse); 
            system.debug('*****Exception *******>>'+ex);
            objPortalExceptionHadling.Response__c = jsonResponse;
            objPortalExceptionHadling.Success_Error_Code__c = '500';
            objPortalExceptionHadling.Request__c = request.requestBody.toString();
            objPortalExceptionHadling.exception__c = string.valueof(ex);
            objPortalExceptionHadling.Business_Id__c = leadinfo.BusinessId;
            objPortalExceptionHadling.Application_Id__c = leadinfo.application_id;
            objPortalExceptionHadling.Opportunity_Id__c = '';
            objPortalExceptionHadling.Lead_Id__c = objLead.Id;
            
        } 
        insert objPortalExceptionHadling;
        return objmainWrapper;
        
        
    }
    
    
    
    
    
    
    global class mainWrapper {
        public list<OwnerInfoWrap> zlstOwners;
        public string Street;
        public string City;
        public string State;
        public string PostalCode;
        public string Country;
        public string AnnualRevenue;
        public string Company;
        public string IsConverted;
        public string ConvertedAccountId;
        public string ConvertedContactId;
        public string ConvertedDate;
        public string ConvertedOpportunityId;
        public string CreatedById;
        public string CreatedDate;
        public string Jigsaw;
        public string IsDeleted;
        public string Description;
        public string DoNotCall;
        public string Email;
        public string EmailBouncedDate;
        public string EmailBouncedReason;
        public string HasOptedOutOfEmail;
        public string Fax;
        public string HasOptedOutOfFax;
        public string Industry;
        public string JigsawContactId;
        public string LastActivityDate;
        public string LastModifiedById;
        public string LastModifiedDate;
        public string LastReferencedDate;
        public string LastTransferDate;
        public string LastViewedDate;
        public string MasterRecordId;
        public string Id;
        public string OwnerId;
        public string LeadSource;
        public string Status;
        public string MobilePhone;
        public string Salutation;
        public string FirstName;
        public string LastName;
        public string NumberOfEmployees;
        public string Phone;
        public string PhotoUrl;
        public string Rating;
        public string SystemModstamp;
        public string Title;
        public string IsUnreadByOwner;
        public string Website;
        //*************************Lead Custom field api ***************************
        
        public string creditchecker_Public_Record_Count;
        public string pi_utm_term;
        public string creditchecker_Disputes_Count;
        public string Campaign_Source;
        public string creditchecker;
        public string pi_utm_source;
        public string creditchecker_Revolving_Credit_Utilization;
        public string pi_utm_medium;
        public string creditchecker_Oldest_Date;
        public string Source_Web_Form;
        public string MC4SF_MC_Subscriber;
        public string pi_comments;
        public string Referral_Partner;
        public string pi_utm_campaign;
        public string creditchecker_Bankruptcy_Count;
        public string pi_last_activity;
        public string What_are_the_terms_of_your_current_lease;
        public string Who_is_your_customer_base;
        public string BusinessId;
        public string SSN2;
        public string pi_Needs_Score_Synced;
        public string creditchecker_Derogatory_Count;
        public string creditchecker_Debt_High_Credit;
        public string pi_score;
        public string pi_first_activity;
        public string Credit_Report_Type;
        public string UTM_Medium;
        public string Referral_type;
        public string pi_grade;
        public string pi;
        public string pi_pardot_hard_bounced;
        public string Do_You_Carry_Life_Insurance;
        public string pi_first_search_term;
        public string pi_first_search_type;
        public string TIB_Months;
        public string Profitable_Last_2_Years;
        public string creditchecker_Most_Recent_Late;
        public string Use_of_Funds;
        public string pi_collections_Count;
        public string SSN1;
        public string pi_campaign;
        public string Brief_History_on_the_business;
        public string pi_conversion_object_type;
        public string Entity_Type;
        public string of_Dials;
        public string Referral_Partner_Email;
        public string creditchecker_Secured_Debt;
        public string Do_you_pay_child_support_or_alimony;
        public string Explanation_of_any_BKs_defaults_etc;
        public string creditchecker_Previous_Adverse_Count;
        public string pi_notes;
        public string Sales_Decline;
        public string creditchecker_Unsecured_Debt;
        public string pi_current_Adverse_Count;
        public string pi_utm_content;
        public string pi_first_touch_url;
        public string Status_Detail;
        public string pi_Pardot_Last_Scored_At;
        public string Not_Interested;
        public string UTM_Source;
        public string Credit_Score;
        public string Are_you_COD_30_60_90;
        public string pi_url;
        public string creditchecker_Adverse_Alert;
        public string creditchecker_Total_High_Credit;
        public string creditchecker_Total_Liability_Payment;
        public string Monthly_Rent_Mtg;
        public string creditchecker_Total_Inquiry_Count;
        public string UTM_Campaign;
        public string Planned_Changes_In_Next_6_Months;
        public string What_exactly_does_the_business_do;
        public string creditchecker_Total_Liability_PastDue;
        public string creditchecker_Date_Completed;
        public string What_is_the_purpose_of_loan;
        public string Requested_Amount;
        public string Run_Credit_Report;
        public string creditchecker_Average_Score;
        public string creditchecker_Total_Liability_Balance;
        public string What_does_your_Business_do;
        public string What_type_of_Business_is_it;
        public string Tell_us_more;
        public string business_start_date;
        public string of_employees_added_in_next_12_months;
        public string of_customer_served_monthly;
        public String Race ;
        public Boolean Veteran;
        public Boolean Disabled;
        public Boolean Women_Owned ;
        public string Ethnicity;
        public string Homeowner;
        public string Net_Worth;
        public string PortalApplicationStatus;
        public Boolean Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins;
        public Boolean ExhaustedPersonalAndNonSBAFinancing;
        public Boolean DoestheBusinesshaveexistingSBADebt;
        
        
    }
    global class OwnerInfoWrap {
        public String owner_id;
        public String owner_dob;
        public String owner_title;
        public String owner_first_name;
        public String owner_last_name;
        public String ownerCellChone_no;
        public String Owner_Phone;
        public String owner_SSN;
        public String owner_home_address;
        public String ownerCity;
        public String owner_state_id;
        public String Owner_zipcode;
        public String Owner_Country;
        public String owner_email;
        public String owner_percentage;
        public String CreditScorefromWebform;
        public String RunCreditReport;
        public String isPrimaryContact;
        public Decimal Owner_Rent;
        public String OwnerCreditScore;
    }
}