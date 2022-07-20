@RestResource(urlMapping = '/SalesforceOpportuntyUpdateApi/*')

global with sharing class SalesforceOpportuntyUpdateApi {
    
    @HttpPost
    global static void UpdateOpportunity() {
        RestRequest request = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String leadId = request.params.get('id');
        
        String jsonResponse = '';
        set < string > setofOpp = new set < string > ();
        //list<WrapSalesScreenData>  lstOfwrapper = new list<WrapSalesScreenData>();
        Opportunity objOpp = new Opportunity();
        list < Opportunity > lstNewUpdatedOpp = new list < Opportunity > ();
        list <Contact> lstOfContacts = new list< Contact>();
        list <Contact> lstOfExistingContacts = new list< Contact>();
        list <Account> lstOfExistingAccounts = new list< Account>();
        Account objAccount = new Account();
        Contact objContact = new Contact();
        Lead objLead = new Lead();
        Opportunity objOpportunity = new Opportunity();
        Portal_Integration_Response_Code__c objPortalExceptionHadling = new Portal_Integration_Response_Code__c();
        System.debug('#####request.requestBody.toString()######### '+request.requestBody.toString());
        JSON2ApexOppUpdateApi ObjOppJsonApex = JSON2ApexOppUpdateApi.parse(request.requestBody.toString());
        try {
            system.debug('ObjOppJsonApex --29->' + ObjOppJsonApex );

            //JSON2ApexOppUpdateApi ObjOppJsonApex = (JSON2ApexOppUpdateApi )JSON2ApexOppUpdateApi.parse(request.requestBody.toString());
            
                        system.debug('========After JSON Parsing==========>>' + ObjOppJsonApex );
       

            if (ObjOppJsonApex != null && ObjOppJsonApex.OpportunityID != null && ObjOppJsonApex.OpportunityID != '') {
                
                system.debug('ObjOppJsonApex.OpportunityID ' + ObjOppJsonApex.OpportunityID );
                objOpp = [ Select id, Name, RecordType.Name, Loan_Type__C,Have_you_exhausted_all_personal_non_SB__c,Does_the_Business_have_existing_SBA_Debt__c from Opportunity where id=:ObjOppJsonApex.OpportunityID];
                string RecordTypeName= objOpp.RecordType.Name;
                //if(!Test.isRunningTest()){
                     objOpportunity = [ select id,EIDL_AMOUNT_RECEIVED__c,PPP_AMOUNT_RECEIVED__c, contactId,AccountId from Opportunity where id=:ObjOppJsonApex.OpportunityID ];
                    // objLead = [ select id,convertedcontactId,convertedAccountId, convertedOpportunityId from Lead where convertedOpportunityId=:ObjOppJsonApex.OpportunityID ];
                     
                if( objOpportunity.AccountId != null  )
                    objAccount = [ Select id, Name, BillingStreet, BillingState, BillingCountry,BillingCity, BillingPostalCode from Account Where id=:objOpportunity.AccountId];
                if( objOpportunity.ContactId != null )
                    objContact = [ Select id, Name, FirstName, LastName, Email, street__c, city__c, state__c, country__c, Zip_Code__c from Contact Where id=:objOpportunity.contactId]; 
                else if( objOpportunity.ContactId == null )
                    objContact = [ Select id, Name, FirstName, LastName, Email, street__c, city__c, state__c, country__c, Zip_Code__c from Contact Where Accountid=:objOpportunity.AccountId]; 
                
                
               
                
                     if( (ObjOppJsonApex.business_name != null && objAccount.Name != ObjOppJsonApex.business_name) 
                        || (ObjOppJsonApex.Address_Business != null && ObjOppJsonApex.Address_Business !=  objAccount.BillingStreet ) 
                        || (ObjOppJsonApex.businessCity != null && ObjOppJsonApex.businessCity !=  objAccount.BillingCity ) 
                        || (ObjOppJsonApex.businessState != null && ObjOppJsonApex.businessState !=  objAccount.BillingState ) 
                        || (ObjOppJsonApex.business_PostalCode != null && ObjOppJsonApex.business_PostalCode !=  objAccount.BillingPostalCode )  )
                     {
                         if( ObjOppJsonApex.Address_Business != null )
                             objAccount.BillingStreet  = ObjOppJsonApex.Address_Business;
                       
                         if( ObjOppJsonApex.businessState != null )
                             objAccount.BillingState = ObjOppJsonApex.businessState;
                         if( ObjOppJsonApex.businessCity != null )
                             objAccount.BillingCity = ObjOppJsonApex.businessCity;
                         if( ObjOppJsonApex.business_PostalCode != null )
                             objAccount.BillingPostalCode = ObjOppJsonApex.business_PostalCode;
                         if( ObjOppJsonApex.business_name != null )
                             objAccount.Name = ObjOppJsonApex.business_name;
                         
                         lstOfExistingAccounts.add(objAccount);
                     }
                  
                     if( (ObjOppJsonApex.OwnerFirstName != null && objContact.Name != ObjOppJsonApex.OwnerFirstName)
                        || (ObjOppJsonApex.OwnerLastName != null && objContact.LastName != ObjOppJsonApex.OwnerLastName) 
                        || (ObjOppJsonApex.Owner_Address1 != null && ObjOppJsonApex.Owner_Address1 !=  objContact.Street__c ) 
                        || (ObjOppJsonApex.City_Owner_1 != null && ObjOppJsonApex.City_Owner_1 !=  objContact.City__c ) 
                        || (ObjOppJsonApex.State_Owner_1 != null && ObjOppJsonApex.State_Owner_1 !=  objContact.State__c ) 
                        || (ObjOppJsonApex.Owner_County != null && ObjOppJsonApex.Owner_County !=  objContact.Country__c ) 
                        || (ObjOppJsonApex.Zip_Code_Owner_1 != null && ObjOppJsonApex.Zip_Code_Owner_1 !=  objContact.Zip_Code__c )
                        || (ObjOppJsonApex.SSN1 != null && ObjOppJsonApex.SSN1 !=  objContact.SSN1__c )
                        || (ObjOppJsonApex.ownerCellPhone != null && ObjOppJsonApex.ownerCellPhone !=  objContact.MobilePhone ))
                     {
                         if( ObjOppJsonApex.Owner_Address1 != null )
                         objContact.Street__c  = ObjOppJsonApex.Owner_Address1;
                         //if( ObjOppJsonApex.Owner_County != null )
                         //objContact.Country__c = ObjOppJsonApex.Owner_County;
                         if( ObjOppJsonApex.State_Owner_1 != null )
                         objContact.State__c = ObjOppJsonApex.State_Owner_1;
                         if( ObjOppJsonApex.City_Owner_1 != null )
                         objContact.City__c = ObjOppJsonApex.City_Owner_1;
                         if( ObjOppJsonApex.Zip_Code_Owner_1 != null )
                         objContact.Zip_Code__c = ObjOppJsonApex.Zip_Code_Owner_1;
                         if( ObjOppJsonApex.OwnerFirstName != null )
                         objContact.FirstName = ObjOppJsonApex.OwnerFirstName;
                         if( ObjOppJsonApex.OwnerLastName != null )
                         objContact.LastName = ObjOppJsonApex.OwnerLastName;
                         if( ObjOppJsonApex.SSN1 != null )
                         objContact.SSN1__c = ObjOppJsonApex.SSN1;
                         if( ObjOppJsonApex.ownerCellPhone != null )
                         objContact.MobilePhone = ObjOppJsonApex.ownerCellPhone;
                         
                         lstOfContacts.add(objContact);
                     }
                 //}
                
                System.debug('@@@@ObjOppJsonApex.Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins '+ObjOppJsonApex.Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins);
                if(String.isNotBlank(String.valueOf(ObjOppJsonApex.Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins))){
                    objOpp.Have_you_exhausted_all_personal_non_SB__c = ObjOppJsonApex.Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins == true? 'Yes':'No';
                } 
                System.debug('@@@@@@222 ObjOppJsonApex.DoestheBusinesshaveexistingSBADebt '+ObjOppJsonApex.DoestheBusinesshaveexistingSBADebt);
                if(String.isNotBlank(String.valueOf(ObjOppJsonApex.DoestheBusinesshaveexistingSBADebt))){
                    objOpp.Does_the_Business_have_existing_SBA_Debt__c = ObjOppJsonApex.DoestheBusinesshaveexistingSBADebt == true? 'Yes':'No';
                }
                
                if(ObjOppJsonApex.BusinessNonProfitStatus !=null && ObjOppJsonApex.BusinessNonProfitStatus !='')
                    objOpp.Please_confirm_your_non_profit_status__c = ObjOppJsonApex.BusinessNonProfitStatus;
               
                if(ObjOppJsonApex.BusinessTopFourPriorities !=null && ObjOppJsonApex.BusinessTopFourPriorities!='')
                    objOpp.Please_confirm_that_your_organization_se__c = ObjOppJsonApex.BusinessTopFourPriorities;
        /****************************   END  **********************************************************************/ 
                /**********************Lendistry Lending *********************************************************/
                if( ObjOppJsonApex.number_of_employees != null )
                    objOpp.of_Current_Employees__c = Integer.valueof(ObjOppJsonApex.number_of_employees);
                if( ObjOppJsonApex.isPPPLoanForgiven != null )
                    objOpp.Has_your_PPP_loan_been_forgiven__c = ObjOppJsonApex.isPPPLoanForgiven;
                if( ObjOppJsonApex.isOutstandingLiens != null  )
                    objOpp.Do_you_have_any_other_outstanding_liens__c=ObjOppJsonApex.isOutstandingLiens ; 
                if( ObjOppJsonApex.isBankruptsyFiled != null  )
                    objOpp.Have_you_filed_for_bankruptcy__c= ObjOppJsonApex.isBankruptsyFiled ;
                //if(ObjOppJsonApex.pppAmountRcvd != null  )
                    objOpp.PPP_AMOUNT_RECEIVED__c= ObjOppJsonApex.pppAmountRcvd;
                //if(ObjOppJsonApex.eidlAmountRcvd != null  ) 
                    objOpp.EIDL_AMOUNT_RECEIVED__c= ObjOppJsonApex.eidlAmountRcvd;
                    system.debug('???????'+ObjOppJsonApex.previous_loan);
                    objOpp.Did_you_take_out_PPP_or_a_EIDL_loan__c= String.valueOf(ObjOppJsonApex.previous_loan);
                /**********************Lendistry Lending *********************************************************/
                
                if( ObjOppJsonApex.business_name != null )
                    objOpp.Name = ObjOppJsonApex.business_name + '-';
                
                if( ObjOppJsonApex.ownerEmailAddress != null)
                    objOpp.Email__c= ObjOppJsonApex.ownerEmailAddress;
                
                if( ObjOppJsonApex.business_county != null )
                    objOpp.County__c = ObjOppJsonApex.business_county;
                // for previous loan
                   
                if( ObjOppJsonApex.Projected_Close_Date != null )
                {
                    System.debug('-ObjOppJsonApex.Projected_Close_Date------->>'+ObjOppJsonApex.Projected_Close_Date); 
                    objOpp.Projected_Close_Date__c = Date.Valueof(ObjOppJsonApex.Projected_Close_Date);   
                }                   
                
                if( ObjOppJsonApex.Origination_Fee != null )
                    objOpp.Origination_Fee__c = string.Valueof(ObjOppJsonApex.Origination_Fee);
                
                if( ObjOppJsonApex.Partner_Referral_Fee != null )
                    objOpp.Partner_Referral_Fee__c = string.Valueof(ObjOppJsonApex.Partner_Referral_Fee);
                
                if( ObjOppJsonApex.of_customer_served_monthly != null )
                    objOpp.of_customer_served_monthly__c = string.Valueof(ObjOppJsonApex.of_customer_served_monthly);
                if( ObjOppJsonApex.of_employees_added_in_next_12_months != null )
                    objOpp.of_employees_added_in_next_12_months__c = string.Valueof(ObjOppJsonApex.of_employees_added_in_next_12_months);
                if( ObjOppJsonApex.Decline_Withdrawn_Reason != null )
                    objOpp.Decline_Withdrawn_Reason__c = string.Valueof(ObjOppJsonApex.Decline_Withdrawn_Reason);
                
                //===========================NYG=====================================
                if(ObjOppJsonApex.TenantReferralPartnerName !=null  && ObjOppJsonApex.TenantReferralPartnerName != '' &&  objOpp.Loan_Type__C == 'NYR')
                    objOpp.Tenant_Referral_Partner_Name__c = ObjOppJsonApex.TenantReferralPartnerName;
                if(ObjOppJsonApex.PreferredLanguage !=null && ObjOppJsonApex.PreferredLanguage != '' &&  (objOpp.Loan_Type__C == 'NYR' || objOpp.Loan_Type__C == 'NYC'))
                    objOpp.Preferred_Language__c = ObjOppJsonApex.PreferredLanguage;
                //if(ObjOppJsonApex.Annual_Gross_Receipts_for_2019 !=null && ObjOppJsonApex.Annual_Gross_Receipts_for_2019 != '' &&  objOpp.Loan_Type__C == 'NYR')
                 //   objOpp.Annual_Gross_Receipts_for_2019__c = string.valueof(ObjOppJsonApex.Annual_Gross_Receipts_for_2019);
                if(ObjOppJsonApex.Will_this_Loan_create_more_Jobs !=null && objOpp.Loan_Type__C == 'CRG')
                    objOpp.Will_this_loan_create_more_Jobs__c = ObjOppJsonApex.Will_this_Loan_create_more_Jobs;
                 
                 if(ObjOppJsonApex.Will_this_Loan_create_more_Jobs !=null && (objOpp.Loan_Type__C == 'NYR' || objOpp.Loan_Type__C == 'NYC'))
                    objOpp.Was_Your_Business_Profitable_In_2019__c = ObjOppJsonApex.Will_this_Loan_create_more_Jobs;
                    
                if( ObjOppJsonApex.Rural != null && objOpp.Loan_Type__C != null &&  objOpp.Loan_Type__C != 'NYR' )
                    objOpp.Rural__c = string.Valueof(ObjOppJsonApex.Rural);
                else if( objOpp.Loan_Type__C != null &&  objOpp.Loan_Type__C == 'NYR' && ObjOppJsonApex.Rural != null)
                    objOpp.Minority_Business_Owned__c = string.Valueof(ObjOppJsonApex.Rural);
                        
                    system.debug('----ObjOppJsonApex.TenantReferralPartnerName--->' + ObjOppJsonApex.TenantReferralPartnerName);
                    system.debug('----ObjOppJsonApex.PreferredLanguage--->' + ObjOppJsonApex.PreferredLanguage);
                //===========================NYG=====================================
                
                if( ObjOppJsonApex.Interest_Rate != null )
                    objOpp.Interest_Rate__c = Decimal.Valueof(ObjOppJsonApex.Interest_Rate);
                if( ObjOppJsonApex.Term != null )
                    objOpp.Term__c = Decimal.Valueof(ObjOppJsonApex.Term);
                if( ObjOppJsonApex.Final_Loan_Amount != null ){
                    if (RecordTypeName == 'Opportunity Lendistry Default' || RecordTypeName =='Opportunity SBA-CARL'){
                        objOpp.Funded_Amount__c = Decimal.Valueof(ObjOppJsonApex.Final_Loan_Amount);
                    }
                    else{
                        objOpp.Final_Loan_Amount__c = Decimal.Valueof(ObjOppJsonApex.Final_Loan_Amount);
                    }
                }
                    objOpp.Final_Loan_Amount__c = Decimal.Valueof(ObjOppJsonApex.Final_Loan_Amount);
                
                if( ObjOppJsonApex.Status != null )
                    objOpp.Status__c= string.Valueof(ObjOppJsonApex.Status);
                
                if( ObjOppJsonApex.Stage != null )
                    objOpp.StageName = string.Valueof(ObjOppJsonApex.Stage);
                if( ObjOppJsonApex.SalesforceUserID != null && ObjOppJsonApex.SalesforceUserID != '' )
                    {
                        objOpp.Is_Updating_From_Portal__c = true;
                        objOpp.Custom_Last_Modified_By__c = string.Valueof(ObjOppJsonApex.SalesforceUserID);
                    }
                else
                    objOpp.Custom_Last_Modified_By__c = null;
                if( ObjOppJsonApex.Owner_Address1 != null )
                    objOpp.Street_Owner_1__c = ObjOppJsonApex.Owner_Address1;
                if( ObjOppJsonApex.City_Owner_1 != null )
                    objOpp.City_Owner_1__c = string.Valueof(ObjOppJsonApex.City_Owner_1);
                if( ObjOppJsonApex.State_Owner_1 != null )
                    objOpp.State_Owner_1__c = string.Valueof(ObjOppJsonApex.State_Owner_1);
                if( ObjOppJsonApex.Zip_Code_Owner_1 != null )
                    objOpp.Zip_Code_Owner_1__c = string.Valueof(ObjOppJsonApex.Zip_Code_Owner_1);
                if( ObjOppJsonApex.Owner_County != null )
                    objOpp.County_Owner_1__c = string.Valueof(ObjOppJsonApex.Owner_County);
                if( ObjOppJsonApex.DOB_Owner_1 != null )
                    objOpp.DOB_Owner_1__c = Date.Valueof(ObjOppJsonApex.DOB_Owner_1);
                if( ObjOppJsonApex.per_of_Ownership != null )
                    objOpp.Of_Ownership_1__c = Decimal.Valueof(ObjOppJsonApex.per_of_Ownership);
                
                if( ObjOppJsonApex.SSN1 != null )
                    objOpp.SSN1__c = string.Valueof(ObjOppJsonApex.SSN1);
                
                if( ObjOppJsonApex.DBA != null )
                    objOpp.DBA__c = string.Valueof(ObjOppJsonApex.DBA);
                if( ObjOppJsonApex.BusinessEIN != null )
                    objOpp.Business_EIN__c = string.Valueof(ObjOppJsonApex.BusinessEIN);
                if( ObjOppJsonApex.BusinessPhone != null )
                    objOpp.Business_Phone__c = string.Valueof(ObjOppJsonApex.BusinessPhone);
                if( ObjOppJsonApex.Entity_Type != null )
                    objOpp.Entity_Type__c = string.Valueof(ObjOppJsonApex.Entity_Type);
                
                if( ObjOppJsonApex.State_of_incopration != null )
                    objOpp.State_of_incopration__c = string.Valueof(ObjOppJsonApex.State_of_incopration);
                if( ObjOppJsonApex.Address2_Business != null )
                    objOpp.Address2_Business__c = string.Valueof(ObjOppJsonApex.Address2_Business);
                
                if( ObjOppJsonApex.BusinessStartDate != null )
                    objOpp.Business_Start_Date__c = Date.Valueof(ObjOppJsonApex.BusinessStartDate);
                if( ObjOppJsonApex.Website != null )
                    objOpp.Website__c = string.Valueof(ObjOppJsonApex.Website);
                
                if( ObjOppJsonApex.Purpose_of_Grant != null )
                    objOpp.Purpose_of_Grant__c = string.Valueof(ObjOppJsonApex.Purpose_of_Grant);
                if( ObjOppJsonApex.Purpose_of_Grant_other != null )
                    objOpp.Other__c= string.Valueof(ObjOppJsonApex.Purpose_of_Grant_other );
                if( ObjOppJsonApex.Requested_Amount != null )
                    objOpp.Requested_Amount__c = Decimal.Valueof(ObjOppJsonApex.Requested_Amount);
                if( ObjOppJsonApex.Will_this_Loan_create_more_Jobs != null )
                {
                    if(RecordTypeName == 'GRANT' || RecordTypeName == 'GRANT-NYC' || RecordTypeName == 'GRANT-NYR'){
                        objOpp.Will_this_grant_create_new_jobs__c = ObjOppJsonApex.Will_this_Loan_create_more_Jobs;
                    }
                    else{
                        objOpp.Will_this_loan_create_more_Jobs__c = ObjOppJsonApex.Will_this_Loan_create_more_Jobs;
                    } 
                }
                
                if( ObjOppJsonApex.Will_this_Loan_create_more_Jobs != null )
                    objOpp.Will_this_Loan_create_more_Jobs__c = string.Valueof(ObjOppJsonApex.Will_this_Loan_create_more_Jobs);
                if( ObjOppJsonApex.AnnualRevenue1 != null )
                    objOpp.Annual_Gross_Revenue__c = Decimal.Valueof(ObjOppJsonApex.AnnualRevenue1);
                if( ObjOppJsonApex.Number_of_Full_Time_Employees != null )
                    objOpp.Number_of_Full_Time_Employees__c = Integer.Valueof(ObjOppJsonApex.Number_of_Full_Time_Employees);
                
                if( ObjOppJsonApex.Number_of_Part_Time_Employees != null )
                    objOpp.Number_of_Part_Time_Employees__c = Integer.Valueof(ObjOppJsonApex.Number_of_Part_Time_Employees);
                if( ObjOppJsonApex.of_Jobs_Created != null )
                    objOpp.of_Jobs_Created__c = Integer.Valueof(ObjOppJsonApex.of_Jobs_Created);
                if( ObjOppJsonApex.of_Jobs_Created != null )
                    objOpp.of_Jobs_Created_30th_June__c = Integer.Valueof(ObjOppJsonApex.of_Jobs_Created);
                    
                if( ObjOppJsonApex.of_Jobs_Retained != null )
                    objOpp.of_Jobs_Retained__c = Integer.Valueof(ObjOppJsonApex.of_Jobs_Retained);
                if( ObjOppJsonApex.Who_is_Your_Customer_Base1 != null )
                    objOpp.Who_is_Your_Customer_Base1__c = string.Valueof(ObjOppJsonApex.Who_is_Your_Customer_Base1);
                if( ObjOppJsonApex.What_does_your_Business_do != null )
                    objOpp.What_does_your_Business_do__c = string.Valueof(ObjOppJsonApex.What_does_your_Business_do);
                if( ObjOppJsonApex.What_type_of_Business_is_it != null )
                    objOpp.What_type_of_Business_is_it__c = string.Valueof(ObjOppJsonApex.What_type_of_Business_is_it);
                if( ObjOppJsonApex.Tell_us_more != null )
                    objOpp.Tell_us_more__c = string.Valueof(ObjOppJsonApex.Tell_us_more);
                if( ObjOppJsonApex.NAICS_CODE != null )
                    objOpp.NAICS_CODE__c = string.Valueof(ObjOppJsonApex.NAICS_CODE);
                if( ObjOppJsonApex.Women_Owned != null )
                    objOpp.Women_Owned__c = string.Valueof(ObjOppJsonApex.Women_Owned);
                if( ObjOppJsonApex.Veteran != null )
                    objOpp.Veteran__c = string.Valueof(ObjOppJsonApex.Veteran);
                if( ObjOppJsonApex.Disabled != null )
                    objOpp.Disabled__c = string.Valueof(ObjOppJsonApex.Disabled);
                if( ObjOppJsonApex.Race != null )
                    objOpp.Race__c = string.Valueof(ObjOppJsonApex.Race);
                
                if( ObjOppJsonApex.Ethnicity != null )
                    objOpp.Ethnicity__c = string.Valueof(ObjOppJsonApex.Ethnicity);
                if( ObjOppJsonApex.Franchise != null )
                    objOpp.Franchise__c = string.Valueof(ObjOppJsonApex.Franchise);
                
                if(ObjOppJsonApex.Have_you_had_a_25_revenue_drop_between!=null)
                        objOpp.Have_you_had_a_25_revenue_drop_betwee__c  = ObjOppJsonApex.Have_you_had_a_25_revenue_drop_between;
                if(ObjOppJsonApex.Who_originated_your_PPP_loan!=null)
                    objOpp.Who_originated_your_PPP_loan__c = ObjOppJsonApex.Who_originated_your_PPP_loan;
                if(ObjOppJsonApex.Did_you_obtain_a_PPP_loan_in_2020  !=null)
                    objOpp.Did_you_obtain_a_PPP_loan_in_2020__c  = ObjOppJsonApex.Did_you_obtain_a_PPP_loan_in_2020;
                if(ObjOppJsonApex.Did_you_receive_a_Shuttered_Venue_Operat !=null)
                    objOpp.Did_you_receive_a_Shuttered_Venue_Operat__c = ObjOppJsonApex.Did_you_receive_a_Shuttered_Venue_Operat;
                    
                if(ObjOppJsonApex.PPP_First_Draw_SBA_Loan_Number  !=null)
                    objOpp.PPP_First_Draw_SBA_Loan_Number__c = ObjOppJsonApex.PPP_First_Draw_SBA_Loan_Number;
                if(ObjOppJsonApex.PPP_First_Draw_Loan_Amount !=null)
                    objOpp.PPP_First_Draw_Loan_Amount__c = ObjOppJsonApex.PPP_First_Draw_Loan_Amount;
                    
                // 2 jan 2021 added by saurabh kumar3
                if(ObjOppJsonApex.Period_2_Revenue  !=null)
                    objOpp.Period_2_Revenue__c = ObjOppJsonApex.Period_2_Revenue;
                if(ObjOppJsonApex.Last_Years_Period !=null)
                    objOpp.Last_Year_s_Period__c = ObjOppJsonApex.Last_Years_Period;
                
                if(ObjOppJsonApex.Proof_of_25_revenue_drop_2020  !=null)
                    objOpp.Proof_of_25_revenue_drop_2020__c  = ObjOppJsonApex.Proof_of_25_revenue_drop_2020 ;
                if(ObjOppJsonApex.Period_1_Revenue  !=null)
                    objOpp.Period_1_Revenue__c= ObjOppJsonApex.Period_1_Revenue;
                 
                if(ObjOppJsonApex.Refinance_of_Eligible_Economic_Injury_Di   !=null)
                    objOpp.Refinance_of_Eligible_Economic_Injury_Di__c= ObjOppJsonApex.Refinance_of_Eligible_Economic_Injury_Di;
                if(ObjOppJsonApex.Economic_Injury_Disaster_Loan_Number !=null)
                        objOpp.Economic_Injury_Disaster_Loan_Number__c = ObjOppJsonApex.Economic_Injury_Disaster_Loan_Number;
                if( ObjOppJsonApex.Owner_Address2 != null )
                objOpp.Adddress2_Owner__c= string.Valueof(ObjOppJsonApex.Owner_Address2);
                //if( ObjOppJsonApex.ownerFirstName != null )
                
                if( ObjOppJsonApex.ownerCellPhone != null )
                objOpp.Phone__c= ObjOppJsonApex.ownerCellPhone;
                // if( ObjOppJsonApex.ownerAddress != null )
                // objOpp.ownerAddress = Decimal.Valueof(ObjOppJsonApex.ownerAddress);
                
               
                //if( ObjOppJsonApex.BusinessStartDate != null )
                // objOpp.BusinessStartDate = Decimal.Valueof(ObjOppJsonApex.BusinessStartDate);
                if( ObjOppJsonApex.SBA_PPP_Loan_Application_Form != null )
                objOpp.SBA_PPP_Loan_Application_Form__c= ObjOppJsonApex.SBA_PPP_Loan_Application_Form;
                if( ObjOppJsonApex.Tax_Year_Used != null )
                objOpp.Tax_Year__C= ObjOppJsonApex.Tax_Year_Used;
                if( ObjOppJsonApex.CurrentSBAEconomicDisasterInjuryLoanBalance != null )
                objOpp.Curr_SBA_Econ_Disaster_Injury_Loan_Bal__c= ObjOppJsonApex.CurrentSBAEconomicDisasterInjuryLoanBalance;
                
                
                System.debug('######ObjOppJsonApex.howDidYouHearAboutUs#####33 '+ObjOppJsonApex.howDidYouHearAboutUs);
                // NYC Phase 2
                if(ObjOppJsonApex.howDidYouHearAboutUs != null)
                objOpp.How_did_you_hear_about_us__c = ObjOppJsonApex.howDidYouHearAboutUs;
                if(String.isNotBlank(String.valueOf(ObjOppJsonApex.businessStageName)))
                objOpp.Business_Stage__c= ObjOppJsonApex.businessStageName;
                if(String.isNotBlank(String.valueOf(ObjOppJsonApex.businessBoroughName)))
                objOpp.Business_Borough__c= ObjOppJsonApex.businessBoroughName;
                if(String.isNotBlank(String.valueOf(ObjOppJsonApex.locationTypeName)))
                objOpp.Location_Type__c= ObjOppJsonApex.locationTypeName;
                if(String.isNotBlank(String.valueOf(ObjOppJsonApex.numberOfTempFullTimeEmployees)))
                objOpp.of_Employees_Temporary_Full_Time_2020__c= Decimal.valueOf(ObjOppJsonApex.numberOfTempFullTimeEmployees);
                if(String.isNotBlank(String.valueOf(ObjOppJsonApex.numberOfTempPartTimeEmployees)))
                objOpp.of_Employees_Temporary_Part_Time_2020__c= Decimal.valueOf(ObjOppJsonApex.numberOfTempPartTimeEmployees);
                
                
               } 
            system.debug('-----lstOfContacts ----->' + lstOfContacts);
            
            system.debug('-----lstOfExistingAccounts ----->' + lstOfExistingAccounts);

            if( lstOfExistingAccounts != null && lstOfExistingAccounts.size() > 0 )
                update lstOfExistingAccounts; 
                
            if( lstOfContacts != null && lstOfContacts.size() > 0 ){
                update lstOfContacts;
            }
            
            
            ///mapOfOpp.put(each.OpportunityId, each.StageName);
            system.debug('-----lstNewUpdatedOpp ----->' + lstNewUpdatedOpp);
            system.debug('-----objOpobjOppp ----->' + objOpp);
            system.debug('-----objOpobjOppp ----->' + objOpp.Id);
            update objOpp;
            
            jsonResponse = '{"status": true, "OpportunityID": "' + ObjOppJsonApex.OpportunityID + '", "errors":[]}';
            res.responseBody = blob.valueOf(jsonResponse);
            objPortalExceptionHadling.Response__c = string.valueof(objOpp);
            objPortalExceptionHadling.Success_Error_Code__c = '200';
            objPortalExceptionHadling.Request__c = request.requestBody.toString();
            objPortalExceptionHadling.exception__c = null;
            //return objmainWrapper;
       } Catch(Exception ex) {
            res.statusCode = 500;
            jsonResponse = '{"status": false, "errors": "[' + ex + ']"}';
            res.responseBody = blob.valueOf(jsonResponse);
            system.debug('*****Exception *******>>' + ex);
            objPortalExceptionHadling.Response__c = jsonResponse;
            objPortalExceptionHadling.Success_Error_Code__c = '500';
            objPortalExceptionHadling.Request__c = 'test'; //request.requestBody.toString();
            objPortalExceptionHadling.exception__c = string.valueof(ex);
            
        }
        insert objPortalExceptionHadling;
        //return jsonResponse;
        
        
    }
    
    
}