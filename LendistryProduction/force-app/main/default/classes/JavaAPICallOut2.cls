public class JavaAPICallOut2 {
    @future (callout=true) 
    public static void updateLeadSFToPortal(set<id>listOfLeadid, String prodEndPoint){
        // query all leads
        if(listOfLeadid !=null && listOfLeadid.size()>0){
            Set<String> setOfApplicationId = new Set<String>();
            HttpRequest req = new HttpRequest();
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            string endPointURL = prodEndPoint+System.Label.JavaPortalEndPointUrl;
            req.setEndpoint(endPointURL);
            string userName =  System.Label.JavaPortalUserName;
            string password = System.Label.JavaPortalPassword;
            req.setBody('{"username": "'+ System.Label.JavaPortalUserName+'","secure": "'+ System.Label.JavaPortalPassword+'"}');
            string strReqBody = '{"username": "'+ System.Label.JavaPortalUserName+'","secure": "'+ System.Label.JavaPortalPassword+'"}';
            string accessToken = '';
            Http http = new Http();
            HTTPResponse response = new HttpResponse();
            if(System.Test.isRunningTest()) {
                HttpResponse res = new HttpResponse();
                res.setBody('{"username": "'+System.Label.JavaPortalUserName+'","secure": "'+System.Label.JavaPortalPassword+'"}');
                response = res;
            }
            else {
                response = http.send(req);
            } 
            
            if (response.getStatusCode() == 200 || System.Test.isRunningTest()) {
                JSONParser parser = JSON.createParser(response.getBody()); 
                while (parser.nextToken() != null) {
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() =='accessToken' || System.Test.isRunningTest())){
                        parser.nextToken();
                        accessToken= parser.getText();
                    }
                }
                List<Lead>  listOfLeads = [ SELECT RecordType.Name, EIDL_AMOUNT_RECEIVED__c, Has_your_PPP_loan_been_forgiven__c, Do_you_have_any_other_outstanding_liens__c, 
                                           Have_you_filed_for_bankruptcy__c, PPP_AMOUNT_RECEIVED__c,
                                           LastName, Was_Your_Business_Profitable_In_2019__c, 
                                           Tenant_Referral_Partner_Name__c, Preferred_Language__c,
                                           Minority_Business_Owned__c ,
                                           Actual_Owner1_Credit_Score__c, 
                                           Actual_Owner2_Credit_Score__c, 
                                           Actual_Owner3_Credit_Score__c, 
                                           Actual_Owner4_Credit_Score__c, 
                                           Actual_Owner5_Credit_Score__c, 
                                           Adddress2_Owner__c,
                                           How_did_you_hear_about_us__c,
                                           Business_Stage__c,
                                           Business_Borough__c,
                                           Location_Type__c,
                                           of_Employees_Temporary_Full_Time_2020__c,
                                           of_Employees_Temporary_Part_Time_2020__c, 
                                           Address, 
                                           Address2_Business__c, 
                                           Address2_Owner_2__c, 
                                           Address2_Owner_3__c, 
                                           Address2_Owner_4__c, 
                                           Address2_Owner_5__c, 
                                           Address_3rd_Owner__c, 
                                           Address_4th_Owner__c, 
                                           Address_5th_Owner__c, 
                                           Address_Owner_1__c, 
                                           Address_Owner_2__c, 
                                           AnnualRevenue, 
                                           Annual_Gross_Revenue__c, 
                                           Application_Certification__c, 
                                           Application_ID_SBAPPP__c, 
                                           Application_ID__c, 
                                           Approved__c, 
                                           Are_you_COD_30_60_90__c, 
                                           Are_you_delinquent_on_child_support__c, 
                                           Assigned_Underwriter__c, 
                                           Average_Monthly_Payroll__c, 
                                           Base64CreatedDate__c, 
                                           Base64_Encoded_Pardot_Url_Parameter__c, 
                                           Brief_History_on_the_business__c, 
                                           Brief_History_on_the_owner_manager__c, 
                                           BusinessId__c, 
                                           Business_EIN__c, 
                                           Business_ID_SBAPPP__c, 
                                           Business_License_if_Sole_Prop_No_SOS__c, 
                                           Business_operates_in_a_designated__c, 
                                           Business_Phone__c, 
                                           Business_Start_Date__c, 
                                           Business_tax_liens_from_the_IRS_or_State__c, 
                                           CAIVRS__c, 
                                           Campaign_Source__c, 
                                           CAVIRS_COMPLETE__c, 
                                           City, 
                                           City_2nd_Owner__c, 
                                           City_Owner_1__c, 
                                           City_Owner_2__c, 
                                           City_Owner_3__c, 
                                           City_Owner_4__c, 
                                           City_Owner_5__c, 
                                           CLEAR_COMPLETE__c, 
                                           CLEAR__c, 
                                           Closing_Fee__c, 
                                           Company, 
                                           Consideration_Round__c, 
                                           ConvertedAccountId, 
                                           ConvertedContactId, 
                                           ConvertedDate, 
                                           ConvertedOpportunityId, 
                                           Convicted_of_a_crime_in_past_6_months__c, 
                                           Corp_DocsNo_need_for_existing_customer__c, 
                                           Corp_Doc_Review_Complete__c, 
                                           Corp_Doc_Review__c, 
                                           Country, 
                                           Country_2nd_Owner__c, 
                                           Country_Owner_1__c, 
                                           Country_Owner_2__c, 
                                           Country_Owner_3__c, 
                                           Country_Owner_4__c, 
                                           Country_Owner_5__c, 
                                           CountyId_Business__c, 
                                           CountyId_Owner__c, 
                                           County_Owner_2__c, 
                                           County_Owner_3__c, 
                                           County_Owner_4__c, 
                                           County_Owner_5__c, 
                                           County_Population_Loss__c, 
                                           County__c,
                                           Credit_Score_2nd_Owner__c, 
                                           Credit_Score_3rd_Owner_from_Webform__c, 
                                           Credit_Score_4th_Owner_from_Webform__c, 
                                           Credit_Score_5th_Owner_from_Webform__c, 
                                           Credit_Score__c, 
                                           Crime_Conviction_Range__c, 
                                           Curr_SBA_Econ_Disaster_Injury_Loan_Bal__c, 
                                           Custom_Last_Modified_By__c, 
                                           Custom_Last_Modified_Date__c, 
                                           DBAFBN__c, 
                                           DBA__c, 
                                           Degree_to_which_the_business_was_impact__c, 
                                           Description, 
                                           Did_you_take_out_PPP_or_a_EIDL_loan__c, 
                                           Disabled__c, 
                                           DOB_Owner_1__c, 
                                           DOB_Owner_2__c, 
                                           DOB_Owner_3__c, 
                                           DOB_Owner_4__c, 
                                           DOB_Owner_5__c, 
                                           Does_the_Business_have_existing_SBA_Debt__c, 
                                           DoNotCall, 
                                           Do_50_of_empl_earn_less_than_51859__c, 
                                           Do_You_Carry_Life_Insurance__c, 
                                           Do_you_have_a_tax_lien_of_taxes_due__c, 
                                           Do_you_own_a_real_estate__c, 
                                           Do_you_pay_child_support_or_alimony__c, 
                                           Do_you_rent_own_business_space__c, 
                                           Elevate_Dials__c, 
                                           Email, 
                                           EmailBouncedDate, 
                                           EmailBouncedReason, 
                                           Email_2nd_Owner__c, 
                                           Email_3rd_Owner__c, 
                                           Email_4th_Owner__c, 
                                           Email_5th_Owner__c, 
                                           Entity_Documents__c, 
                                           Entity_Type__c, 
                                           Ethnicity__c, 
                                           ETRAN__c, 
                                           exhausted_personal_nonSBA_financing__c, 
                                           Existing_Customer__c, 
                                           Explanation_of_any_BKs_defaults_etc__c, 
                                           Fax, 
                                           Filter_Number__c, 
                                           FirstName, 
                                           First_Name_2nd_Owner__c, 
                                           First_Name_3rd_Owner__c, 
                                           First_Name_4th_Owner__c, 
                                           First_Name_5th_Owner__c, 
                                           Franchise__c, 
                                           From_a_rural_county__c, 
                                           GeocodeAccuracy, 
                                           HasOptedOutOfEmail, 
                                           HasOptedOutOfFax, 
                                           Have_you_ever_been_convicted_of_a_crime__c, 
                                           Have_you_ever_defaulted_on_a_govt_loan__c, 
                                           Homeowner__c, 
                                           Id, 
                                           IndividualId, 
                                           Industry, 
                                           Industry_retail_food_health_care__c, 
                                           Interest_Type__c, 
                                           Interim_Financial_start_up_only__c, 
                                           isApproved__c, 
                                           IsConverted, 
                                           IsDeleted, 
                                           IsSyncWithPortal__c, 
                                           IsUnreadByOwner, 
                                           Is_Batch_Picked__c, 
                                           Is_Finished__c, 
                                           Is_the_US_Principal_place_of_residence__c, 
                                           Last_Name_2nd_Owner__c, 
                                           Last_Name_3rd_Owner__c, 
                                           Last_Name_4th_Owner__c, 
                                           Last_Name_5th_Owner__c, 
                                           LeadSource, 
                                           Legal_action_pending_against_youspouse__c, 
                                           Loan_Approval_Date__c, 
                                           Loan_Type__c, 
                                           Longitude, 
                                           Low_Income_Owner__c, 
                                           Majority_owner_US_CitizenLegal_Resident__c, 
                                           MasterRecordId, 
                                           MC4SF__MC_Subscriber__c, 
                                           MiddleName, 
                                           MobilePhone, 
                                           Mobile_2nd_Owner__c, 
                                           Mobile_3rd_Owner__c, 
                                           Mobile_4th_Owner__c, 
                                           Mobile_5th_Owner__c, 
                                           Monthly_Rent_Mtg__c, 
                                           NACIS_CODE__c, 
                                           NAICS_CODE__c, 
                                           NAICS__c, 
                                           Name, 
                                           Network_Selection__c, 
                                           NETWORK_VIP__c, 
                                           Net_Worth__c, 
                                           Not_Interested__c, 
                                           Not_Prior_Receipt__c, 
                                           NumberOfEmployees, 
                                           Number_of_Full_Time_Employees__c, 
                                           Number_of_Part_Time_Employees__c, 
                                           OFAC_Status_Description__c, 
                                           of_Current_Employees__c, 
                                           of_customer_served_monthly__c, 
                                           of_Dials__c, 
                                           Of_Documents__c, 
                                           of_employees_added_in_next_12_months__c, 
                                           of_employees_as_of_2_15_2020__c, 
                                           of_employees_as_of_12_31_19__c, 
                                           of_Jobs_Created_30th_June__c, 
                                           of_Jobs_Created__c, 
                                           of_Jobs_Retained__c, 
                                           of_Ownership_3rd_Owner__c, 
                                           of_Ownership_4th_Owner__c, 
                                           of_Ownership_5th_Owner__c, 
                                           of_Ownership_Owner__c, 
                                           of_Ownership_Second_Owner__c, 
                                           Origination_Fee__c, 
                                           Other__c, 
                                           OwnerId, 
                                           Owner_ID_Owner_1__c, 
                                           Owner_ID_Owner_2__c, 
                                           Owner_ID_Owner_3__c, 
                                           Owner_ID_Owner_4__c, 
                                           Owner_ID_Owner_5__c, 
                                           Owner_Rent_1__c, 
                                           Owner_Rent_2__c, 
                                           Owner_Rent_3__c, 
                                           Owner_Rent_4__c, 
                                           Owner_Rent_5__c, 
                                           Owner__c, 
                                           PACER_if_BK__c, 
                                           Partner_Referral_Fee__c, 
                                           Payroll_Calculator_Complete__c, 
                                           Payroll_Calculator_Provided__c, 
                                           Pending_Follow_Up_48_hour_SMS_Sent__c, 
                                           Pending_Follow_Up_96_hour_SMS_Sent__c, 
                                           Phone, 
                                           Phone_2nd_Owner__c, 
                                           Phone_3rd_Owner__c, 
                                           Phone_4th_Owner__c, 
                                           Phone_5th_Owner__c, 
                                           Plaid_Integration_Complete__c, 
                                           Plaid_Verification__c, 
                                           Plaid__c, 
                                           Planned_Changes_In_Next_6_Months__c, 
                                           Portal_Application_Status__c, 
                                           PostalCode, 
                                           Postal_Code_2nd_Owner__c, 
                                           PPP_Note_Created__c, 
                                           Pre_Note_Date__c, 
                                           Pre_Note__c, 
                                           processing_fee__c, 
                                           Profitable_Last_2_Years__c, 
                                           Proof_of_Tax_Plan_if_not_current__c, 
                                           Purpose_of_Grant__c, 
                                           Purpose_of_the_loan__c, 
                                           Q1_2020_Payroll_Summary__c, 
                                           Race__c, 
                                           Rating, 
                                           RecordTypeId, 
                                           Referral_Partner1__c, 
                                           Referral_Partner_Email__c, 
                                           Referral_Partner__c, 
                                           Referral_part_fee__c, 
                                           Referral_type__c, 
                                           Requested_Amount__c, 
                                           Review_Credit_Report_for_BK__c, 
                                           Run_Credit_Report__c, 
                                           Run_Joint_Credit_Report__c, 
                                           Run_Owner2_Credit_Report__c, 
                                           Run_Owner3_Credit_Report__c, 
                                           Run_Owner4_Credit_Report__c, 
                                           Run_Owner5_Credit_Report__c, 
                                           Rural__c, 
                                           Sales_Decline__c, 
                                           Salutation, 
                                           SBA_Application_Approval__c, 
                                           SBA_PPP_Loan_Application__c, 
                                           SBSS_SCORE__c, 
                                           Schedule_C_Sole_Prop__c, 
                                           Second_Owner__c, 
                                           SMS_Opt_In__c, 
                                           SMS_Sent_Date__c, 
                                           SOS__c, 
                                           Source_Web_Form__c, 
                                           SSN1__c, 
                                           SSN2__c, 
                                           SSN_3rd_Owner__c, 
                                           SSN_4th_Owner__c, 
                                           SSN_5th_Owner__c, 
                                           State, 
                                           State_2nd_Owner__c, 
                                           State_of_incopration__c, 
                                           State_Owner_1__c, 
                                           State_Owner_2__c, 
                                           State_Owner_3__c, 
                                           State_Owner_4__c, 
                                           State_Owner_5__c, 
                                           Status, 
                                           Status_Detail__c, 
                                           Street, 
                                           Street_2nd_Owner__c, 
                                           Street_Owner_1__c, 
                                           Street_Owner_2__c, 
                                           Street_Owner_3__c, 
                                           Street_Owner_4__c, 
                                           Street_Owner_5__c, 
                                           Submit_loan_req_SBAfinancial_COVID19__c, 
                                           Suffix, 
                                           SystemModstamp, 
                                           TAX_FORM__c, 
                                           Tax_Return_18_or_19__c, 
                                           Tax_Year__c, 
                                           tdc_tsw__Phone_Status__c, 
                                           tdc_tsw__Phone_Verification_Status__c, 
                                           tdc_tsw__Phone_Verify_Result_Msg__c, 
                                           tdc_tsw__Result__c, 
                                           tdc_tsw__SMS_Opt_out__c, 
                                           tdc_tsw__Type__c, 
                                           tdc_tsw__Verified_Phone__c, 
                                           Telesales__c, 
                                           Tell_us_more__c, 
                                           Tenant_Details__c, 
                                           Tenant_Id__c, 
                                           Tenant_Name1__c, 
                                           Tenant_Name__c, 
                                           Tenant_URL__c, 
                                           TIB_Months__c, 
                                           TIB__c, 
                                           Title, 
                                           Title_2nd_Owner__c, 
                                           Title_3rd_Owner__c, 
                                           Title_4th_Owner__c, 
                                           Title_5th_Owner__c, 
                                           Total_Score__c, 
                                           Transfer_Date__c, 
                                           Unqualified_Reason__c, 
                                           Use_of_Funds__c, 
                                           UTM_Campaign__c, 
                                           UTM_Medium__c, 
                                           UTM_Source__c, 
                                           U_S_CDFI_Fund_Investment_Area_OR_Low_In__c, 
                                           Veritax_Requested__c, 
                                           Veritax_Request_Date__c, 
                                           Veritax_Review__c, 
                                           Veritax_Verification__c, 
                                           Veritax__c, 
                                           Veteran__c, 
                                           Website, 
                                           What_are_the_terms_of_your_current_lease__c, 
                                           What_does_your_Business_do__c, 
                                           What_exactly_does_the_business_do__c, 
                                           What_is_the_purpose_of_loan__c, 
                                           What_type_of_Business_is_it__c, 
                                           Who_is_Your_Customer_Base1__c, 
                                           Who_is_your_customer_base__c, 
                                           Will_this_grant_create_new_jobs__c, 
                                           Will_this_loan_create_more_Jobs__c, 
                                           Woman_Owned__c, 
                                           Women_Owned__c, 
                                           X0KSB_Scholar_Alumni__c, 
                                           X019_Tax_Return18_Tax_Return_19_FYE__c, 
                                           X0192020_Group_Health_Benefits_Paid__c, 
                                           X0192020_IRS_Form_940_IRS_Form_941__c, 
                                           X0192020_Retirement_Benefits_Paid__c, 
                                           X2_Month_Payroll_Report940941Retire__c, 
                                           X2018_Tax_Return_2019_FYE_Financial_Sta__c, 
                                           X2019_Annual_Gross_Revenue__c, 
                                           X2019_Annual_Payroll_Cost__c, 
                                           Zip_Code_Owner_1__c, 
                                           Zip_Code_Owner_2__c, 
                                           Zip_Code_Owner_3__c, 
                                           Zip_Code_Owner_4__c, 
                                           Zip_Code_Owner_5__c, 
                                           Have_you_exhausted_all_personal_non_SB__c,
                                           What_is_the_value_of_your_personal_asset__c, 
                                           Time_At_Address__c,
                                           Current_outstanding_for_tax_lientax_due__c,
                                           Monthly_payment_for_tax_lien_or_tax_due__c,
                                           Current_Outstand_Bal_Busi_TaxLienTaxDue__c,
                                           Monthly_Payment_Business_TaxLienTaxDue__c,
                                           Please_confirm_your_non_profit_status__c ,
                                           Please_confirm_that_your_organization_se__c ,
                                           Have_you_had_a_25_revenue_drop_between__c,
                                           SBA_PPP_Loan_Application_Form__c,
                                           Who_originated_your_PPP_loan__c,Did_you_obtain_a_PPP_loan_in_2020__c,
                                           Did_you_receive_a_Shuttered_Venue_Operat__c,PPP_First_Draw_SBA_Loan_Number__c,PPP_First_Draw_Loan_Amount__c,
                                           Economic_Injury_Disaster_Loan_Number__c,Refinance_of_Eligible_Economic_Injury_Di__c,Period_1_Revenue__c,
                                           Proof_of_25_revenue_drop_2020__c,Last_Year_s_Period__c,Period_2_Revenue__c
                                           FROM Lead  
                                           WHERE Id IN: listOfLeadid];
                
                if(listOfLeads !=null  && listOfLeads.size()>0){
                    javaAPILeadSysnc.MainWrapper objWrapper = new javaAPILeadSysnc.MainWrapper();
                    
                    for(lead objlead : listOfLeads){
                        setOfApplicationId.add(objlead.Application_ID__c);
                        javaAPILeadSysnc.LeadWrapper objWrap = new javaAPILeadSysnc.LeadWrapper();
                        
                        objWrap.LoanType = objlead.Loan_Type__c;
                       
                         
                         if(objWrap.LoanType == 'NYC'){
                            if(String.isNotBlank(objlead.How_did_you_hear_about_us__c))
                              objWrap.howDidYouHearAboutUs = objlead.How_did_you_hear_about_us__c;
                            if(String.isNotBlank(objlead.Business_Stage__c))
                              objWrap.businessStageName = objlead.Business_Stage__c;
                            if(String.isNotBlank(objlead.Business_Borough__c))
                              objWrap.businessBoroughName = objlead.Business_Borough__c;  
                            if(String.isNotBlank(objlead.Location_Type__c))
                              objWrap.locationTypeName = objlead.Location_Type__c;
                            if(String.isNotBlank(String.valueOf(objlead.of_Employees_Temporary_Full_Time_2020__c)))
                              objWrap.numberOfTempFullTimeEmployees = Integer.valueOf(objlead.of_Employees_Temporary_Full_Time_2020__c);
                            if(String.isNotBlank(String.valueOf(objlead.of_Employees_Temporary_Part_Time_2020__c)))
                              objWrap.numberOfTempPartTimeEmployees = Integer.valueOf(objlead.of_Employees_Temporary_Part_Time_2020__c);        
                        }
                        if( objlead.RecordType.Name == 'Lendistry Lending') 
                        {
                            system.debug('Record type name'+ objlead.RecordType.Name + objlead.Has_your_PPP_loan_been_forgiven__c);
                            if( objlead.Has_your_PPP_loan_been_forgiven__c != null )
                                objWrap.isPPPLoanForgiven=objlead.Has_your_PPP_loan_been_forgiven__c;
                            if( objlead.Do_you_have_any_other_outstanding_liens__c != null )
                                objWrap.isOutstandingLiens=objlead.Do_you_have_any_other_outstanding_liens__c;
                            if( objlead.Have_you_filed_for_bankruptcy__c != null )
                                objWrap.isBankruptsyFiled=objlead.Have_you_filed_for_bankruptcy__c;
                            if(objlead.PPP_AMOUNT_RECEIVED__c != null )
                                objWrap.pppAmountRcvd=objlead.PPP_AMOUNT_RECEIVED__c;
                            if(objlead.EIDL_AMOUNT_RECEIVED__c != null )
                                objWrap.eidlAmountRcvd=objlead.EIDL_AMOUNT_RECEIVED__c;
                          
                        }
                        if(objlead.SBA_PPP_Loan_Application_Form__c != null)
                          objWrap.SBA_PPP_Loan_Application_Form = objlead.SBA_PPP_Loan_Application_Form__c;
                        if(objlead.Tax_Year__c != null)
                          objWrap.Tax_Year_Used = objlead.Tax_Year__c;
                        
                        if(objLead.Please_confirm_your_non_profit_status__c !=null )
                            objWrap.BusinessNonProfitStatus = objlead.Please_confirm_your_non_profit_status__c ;
                       
                        if(objlead.Please_confirm_that_your_organization_se__c !=null)
                            objWrap.BusinessTopFourPriorities = objlead.Please_confirm_that_your_organization_se__c ;
                /****************************   END  **********************************************************************/ 
                        if(objLead.Referral_Partner_Email__c !=null )
                            objWrap.referralPartnerEmail = objLead.Referral_Partner_Email__c;
                        if(objLead.Referral_type__c !=null )
                            objWrap.leadType = objLead.Referral_type__c;
                        if(objLead.What_is_the_value_of_your_personal_asset__c !=null )
                            objWrap.whatIsTheValueOfYourPersonalAsset = objLead.What_is_the_value_of_your_personal_asset__c;
                        if(objLead.Time_At_Address__c !=null )
                            objWrap.timeAtAddress = objLead.Time_At_Address__c;
                        if(objLead.Owner_Rent_1__c !=null )
                            objWrap.Owner1RentAmount = objLead.Owner_Rent_1__c;
                        if(objLead.Owner_Rent_2__c !=null )
                            objWrap.Owner2RentAmount = objLead.Owner_Rent_2__c;
                        if(objLead.Owner_Rent_3__c !=null )
                            objWrap.Owner3RentAmount = objLead.Owner_Rent_3__c;
                        if(objLead.Owner_Rent_4__c !=null )
                            objWrap.Owner4RentAmount = objLead.Owner_Rent_4__c;
                        if(objLead.Owner_Rent_5__c !=null )
                            objWrap.Owner5RentAmount = objLead.Owner_Rent_5__c;
                        if(objLead.exhausted_personal_nonSBA_financing__c!= null )
                            objWrap.ExhaustedPersonalAndNonSBAFinancing= objLead.exhausted_personal_nonSBA_financing__c == 'Yes'? true: false;
                        if(objLead.Current_outstanding_for_tax_lientax_due__c !=null )
                            objWrap.CurrentOutstandingBalanceForTaxLienOrTaxesDue = objLead.Current_outstanding_for_tax_lientax_due__c;
                        if(objLead.Monthly_payment_for_tax_lien_or_tax_due__c !=null )
                            objWrap.MonthlyPaymentForTaxLienOrTaxesDue = objLead.Monthly_payment_for_tax_lien_or_tax_due__c;
                        
                        if(objLead.Current_Outstand_Bal_Busi_TaxLienTaxDue__c !=null )
                            objWrap.CurrentOutstandingBalanceForBusinessTaxLienOrTaxesDue = objLead.Current_Outstand_Bal_Busi_TaxLienTaxDue__c;
                        if(objLead.Monthly_Payment_Business_TaxLienTaxDue__c !=null )
                            objWrap.MonthlyPaymentForBusinessTaxLienOrTaxesDue = objLead.Monthly_Payment_Business_TaxLienTaxDue__c;
                        
                        if(objLead.X0KSB_Scholar_Alumni__c != null )
                            objWrap.ScholarAlumini = objLead.X0KSB_Scholar_Alumni__c;
                        if(objLead.Do_you_have_a_tax_lien_of_taxes_due__c!= null )
                            objWrap.DoYouHaveTaxLien= objLead.Do_you_have_a_tax_lien_of_taxes_due__c== 'Yes'? true: false;
                        if(objLead.Have_you_ever_defaulted_on_a_govt_loan__c!= null )
                            objWrap.HaveYouEverDefaultedOnGovernmentLoan= objLead.Have_you_ever_defaulted_on_a_govt_loan__c =='Yes'? true: false;
                        if(objLead.Legal_action_pending_against_youspouse__c!= null )
                            objWrap.AreThereAnyLegalActionPendingAgainstYou= objLead.Legal_action_pending_against_youspouse__c =='Yes'? true: false;
                        
                        if(objLead.Are_you_delinquent_on_child_support__c != null )
                            objWrap.areYouDelinquentOnChildSupport = objLead.Are_you_delinquent_on_child_support__c =='Yes'? true: false;
                        if(objLead.Business_tax_liens_from_the_IRS_or_State__c !=null )
                            objWrap.businesstaxliensfromIRSorState = objLead.Business_tax_liens_from_the_IRS_or_State__c == 'Yes'? true: false;
                        if(objLead.Convicted_of_a_crime_in_past_6_months__c !=null )
                            objWrap.convictedOfacrimeinPast6months = objLead.Convicted_of_a_crime_in_past_6_months__c == 'Yes'? true: false;
                        if(objLead.Did_you_take_out_PPP_or_a_EIDL_loan__c !=null && objLead.Did_you_take_out_PPP_or_a_EIDL_loan__c !='')
                            objWrap.didYouTakeoutPPPoraEIDLLoan = objLead.Did_you_take_out_PPP_or_a_EIDL_loan__c ;
                        if(objLead.Do_you_own_a_real_estate__c !=null )
                            objWrap.doYouownaRealeState = objLead.Do_you_own_a_real_estate__c == 'Yes'? true: false;
                        if(objLead.crime_Conviction_Range__c !=null && objLead.crime_Conviction_Range__c!='')
                            objWrap.crimeConvictionRange = objLead.crime_Conviction_Range__c;
                        if(objlead.Will_this_loan_create_more_Jobs__c !=null && objlead.Loan_Type__c != 'NYR')
                            objWrap.Willthisloancreatemorejobs = objlead.Will_this_loan_create_more_Jobs__c == 'Yes'? true:false;
                        if(objlead.Was_Your_Business_Profitable_In_2019__c !=null && objlead.Loan_Type__c == 'NYR')
                            objWrap.Willthisloancreatemorejobs = objlead.Was_Your_Business_Profitable_In_2019__c == 'Yes'? true:false;
                        if( objlead.recordType.Name == 'Lendistry Lending' )  
                    objWrap.NumberOfEmployees = String.valueOf(objlead.of_Current_Employees__c);
                else
                    objWrap.NumberOfEmployees = String.valueOf(objlead.NumberOfEmployees);
                    
                        if( objLead.of_employees_added_in_next_12_months__c != null && objLead.of_employees_added_in_next_12_months__c !='' )
                                objWrap.of_employees_added_in_next_12_months = objLead.of_employees_added_in_next_12_months__c;
                        if( objLead.of_customer_served_monthly__c != null && objLead.of_customer_served_monthly__c != '')
                                objWrap.of_customer_served_monthly = objLead.of_customer_served_monthly__c;
                        if( objLead.Homeowner__c != null && objLead.Homeowner__c != '')
                                objWrap.is_home_owner = objLead.Homeowner__c == 'Yes'? true: false;
                        if( objLead.Net_Worth__c != null)
                                objWrap.net_worth = String.valueof(objLead.Net_Worth__c);
                        
                        if( objlead.Loan_Type__c != null &&  objlead.Loan_Type__c == 'SBA-PPP' )
                        {
                            objWrap.Application_Id = objlead.Application_ID_SBAPPP__c;
                            objWrap.Business_Id = objlead.Business_ID_SBAPPP__c;
                            
                            if(objlead.Purpose_of_the_loan__c !=null)
                                objWrap.Purposeofloan = objlead.Purpose_of_the_loan__c; 
                            
                            
                        }
                        system.debug(objlead.Loan_Type__c );
                        if(  objlead.Loan_Type__c != 'SBA-PPP' )
                        {
                            objWrap.Application_Id = objlead.Application_ID__c;
                            objWrap.Business_Id = objlead.BusinessId__c;
                            if(objlead.Purpose_of_Grant__c !=null)
                                objWrap.Purposeofloan = objlead.Purpose_of_Grant__c ; 
                            if( objlead.Address2_Business__c != null )
                                objWrap.businessAddress2   = objlead.Address2_Business__c;
                            
                            if(objlead.Will_this_grant_create_new_jobs__c !=null && objlead.Loan_Type__c != 'NYR')
                                objWrap.Willthisloancreatemorejobs = objlead.Will_this_grant_create_new_jobs__c == 'Yes'? true:false;
                        }
                        
                        if(objlead.Rural__c !=null)
                            objWrap.Rural= string.valueOf(objlead.Rural__c );
                        
                        if(objlead.Number_of_Full_Time_Employees__c!=null)
                            objWrap.numberOfFullTimeEmployees = Integer.valueOf(objlead.Number_of_Full_Time_Employees__c);
                        if(objlead.Number_of_Part_Time_Employees__c!=null)
                            objWrap.numberOfPartTimeEmployees = Integer.valueOf(objlead.Number_of_Part_Time_Employees__c);
                        if(objlead.of_Jobs_Retained__c !=null)
                            objWrap.numberOfJobRetained = Integer.valueOf(objlead.of_Jobs_Retained__c);
                        if(objlead.SMS_Opt_In__c !=null)
                            objWrap.isSmsAllowed = objlead.SMS_Opt_In__c;
                        if(objlead.NAICS_CODE__c!=null)
                            objWrap.NAICSCode= Integer.valueOf(objlead.NAICS_CODE__c);
                        if(objlead.of_Jobs_Created__c!=null)
                            objWrap.noofJobsCreated = Integer.valueOf(objlead.of_Jobs_Created__c);
                         //===========================NYG=====================================
                        if( objlead.Loan_Type__c!= null && objlead.Loan_Type__c=='NYR' && objlead.Tenant_Referral_Partner_Name__c !=null && objlead.Tenant_Referral_Partner_Name__c !='' )
                            objWrap.TenantReferralPartnerName = string.valueof(objlead.Tenant_Referral_Partner_Name__c);
                        if(objlead.Loan_Type__c!= null && (objlead.Loan_Type__c=='NYR' || objlead.Loan_Type__c=='NYC') && objlead.Preferred_Language__c !=null && objlead.Preferred_Language__c !='')
                            objWrap.PreferredLanguage = string.valueof(objlead.Preferred_Language__c);
                        if( objlead.Minority_Business_Owned__c != null && objlead.Loan_Type__c=='NYR' )
                            objWrap.Rural = objlead.Minority_Business_Owned__c ;
                        else if(objlead.Rural__c !=null && objlead.Loan_Type__c != 'NYR' )
                            objWrap.Rural= string.valueOf(objlead.Rural__c );
                        //===========================NYG=====================================
                        
                        
                        
                        if(objlead.Do_50_of_empl_earn_less_than_51859__c!=null)
                            objWrap.DoFiftyPercentEmployeeEarnLessThan = string.valueOf(objlead.Do_50_of_empl_earn_less_than_51859__c);
                        
                        if(objlead.X0KSB_Scholar_Alumni__c !=null)
                            objWrap.ScholarAlumini = string.valueOf(objlead.X0KSB_Scholar_Alumni__c);
                        if(objlead.of_Current_Employees__c !=null)
                            objWrap.of_Current_Employees = Integer.valueOf(objlead.of_Current_Employees__c);
                        if(objlead.Status !=null)
                            objWrap.LeadStatus = objlead.Status;
                        if(objlead.Women_Owned__c !=null)
                            objWrap.WomenOwnedBusiness= objlead.Women_Owned__c== 'Yes'? true:false;
                        
                        
                        if(objlead.Who_is_Your_Customer_Base1__c !=null)
                            objWrap.Whoisyourcustomerbase = objlead.Who_is_Your_Customer_Base1__c;
                        if(objlead.What_type_of_Business_is_it__c !=null)
                            objWrap.WhattypeofBusinessisit = objlead.What_type_of_Business_is_it__c;
                        if(objlead.What_does_your_Business_do__c !=null)
                            objWrap.Whatdoesyourbusinessdo = objlead.What_does_your_Business_do__c;                     
                        objWrap.salesforceUserId = objlead.ownerid;
                        if(objlead.Veteran__c !=null)
                            objWrap.Veteran= objlead.Veteran__c== 'Yes'? true:false;
                        
                        if(objlead.Use_of_Funds__c !=null)
                            objWrap.useOfFunding = objlead.Use_of_Funds__c;
                        if(objlead.Tell_us_more__c !=null)
                            objWrap.TellusMore = objlead.Tell_us_more__c;
                        if(objlead.State_of_incopration__c !=null)
                            objWrap.Stateofincopration = objlead.State_of_incopration__c;
                        if(objlead.SBA_Application_Approval__c !=null){
                            string SBALoanNumber = String.valueof(objlead.SBA_Application_Approval__c.trim()).replaceAll('-',''); 
                            objWrap.SBALoanNumber = long.valueOf(SBALoanNumber);
                        }
                        if(objlead.SBSS_SCORE__c !=null)
                            objWrap.SBAApplicationNumber = long.valueOf(objlead.SBSS_SCORE__c);
                        if(objlead.Referral_Partner1__c !=null)
                            objWrap.ReferralPartner = objlead.Referral_Partner1__c;
                        if(objlead.Race__c !=null)
                            objWrap.Race = objlead.Race__c;
                        
                        
                        if(objlead.Business_Phone__c !=null)
                            objWrap.PhonrNumber = String.valueOf(objlead.Business_Phone__c);
                        if(objlead.Email !=null)
                            objWrap.ownerEmailAddress = string.valueof(objlead.Email);  
                        if(objlead.Other__c !=null) 
                            objWrap.Other = objlead.Other__c;
                        if(objLead.of_employees_as_of_2_15_2020__c !=null)
                            objWrap.ofemployeesasof2_15_2020 = Integer.valueOf(objlead.of_employees_as_of_2_15_2020__c);
                        if(objlead.of_employees_as_of_12_31_19__c !=null)
                            objWrap.ofemployeesasof12_31_19 = objlead.of_employees_as_of_12_31_19__c;
                        if(objlead.of_Jobs_Retained__c !=null)
                            objWrap.of_Jobs_Retained = Integer.valueOf(objlead.of_Jobs_Retained__c); 
                        if(objlead.of_Jobs_Created_30th_June__c !=null)
                            objWrap.of_Jobs_Created_30th_June = Integer.valueOf(objlead.of_Jobs_Created_30th_June__c);
                        if(objlead.ID !=null)   
                            objWrap.LeadId = String.valueof(objlead.ID);
                        if(objlead.LastName !=null)
                            objWrap.LastName = objlead.LastName;
                        if(objlead.Is_the_US_Principal_place_of_residence__c !=null)
                            objWrap.IsTheUnitedStatesThePrincipalPlaceOfResidenceForAllEmployees = objlead.Is_the_US_Principal_place_of_residence__c== 'Yes'? true:false;
                        if(objlead.Submit_loan_req_SBAfinancial_COVID19__c !=null) 
                            objWrap.HaveyousubmittedaloanrequersttoSBAoranyotheragencyorfinancialinstutiontinconnectionwithCovid_19 = objlead.Submit_loan_req_SBAfinancial_COVID19__c== 'Yes'? true:false;
                       // if(objlead.exhausted_personal_nonSBA_financing__c !=null)
                            //objWrap.Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins =  objlead.exhausted_personal_nonSBA_financing__c == 'Yes'? true:false; 
                        if(objlead.Have_you_ever_defaulted_on_a_govt_loan__c !=null)
                            objWrap.Haveyoueverdefaultedonagovernmentloan_includedSBAloan_Studentloan_etc  =  objlead.Have_you_ever_defaulted_on_a_govt_loan__c== 'Yes'? true:false;
                        if(objlead.Have_you_ever_been_convicted_of_a_crime__c !=null)
                            objWrap.Haveyoueverbeenconvictedofacrime  =  objlead.Have_you_ever_been_convicted_of_a_crime__c == 'Yes'? true:false;
                        if(objlead.Franchise__c !=null)
                            objWrap.Franchise = objlead.Franchise__c== 'Yes'? true:false;
                        objWrap.FirstName= objlead.firstname;
                        if(objlead.Ethnicity__c !=null)
                            objWrap.ethnicity= objlead.Ethnicity__c;
                        if(objlead.Email !=null)
                            objWrap.email = objlead.Email;
                        if(objlead.Do_you_rent_own_business_space__c !=null)
                            objWrap.DoyourentORownbusinessspace = objlead.Do_you_rent_own_business_space__c== 'Yes'? true:false;
                        if(objlead.Do_you_have_a_tax_lien_of_taxes_due__c !=null)
                            objWrap.Doyouhaveataxlienoftaxesdue = objlead.Do_you_have_a_tax_lien_of_taxes_due__c== 'Yes'? true:false;
                        //if(objlead.Does_the_Business_have_existing_SBA_Debt__c !=null)
                            //objWrap.DoestheBusinesshaveexistingSBADebt = objlead.Does_the_Business_have_existing_SBA_Debt__c== 'Yes'? true:false;
                        
                        // added by saurabh Kumar on 22 jan 2021
                        if(objlead.Have_you_had_a_25_revenue_drop_between__c!=null)
                            objWrap.Have_you_had_a_25_revenue_drop_between = objlead.Have_you_had_a_25_revenue_drop_between__c;
                        if(objlead.Who_originated_your_PPP_loan__c!=null)
                            objWrap.Who_originated_your_PPP_loan = objlead.Who_originated_your_PPP_loan__c;
                        if(objlead.Did_you_obtain_a_PPP_loan_in_2020__c  !=null)
                            objWrap.Did_you_obtain_a_PPP_loan_in_2020  = objlead.Did_you_obtain_a_PPP_loan_in_2020__c;
                        if(objlead.Did_you_receive_a_Shuttered_Venue_Operat__c !=null)
                            objWrap.Did_you_receive_a_Shuttered_Venue_Operat = objlead.Did_you_receive_a_Shuttered_Venue_Operat__c;
                            
                        if(objlead.PPP_First_Draw_SBA_Loan_Number__c  !=null)
                            objWrap.PPP_First_Draw_SBA_Loan_Number = objlead.PPP_First_Draw_SBA_Loan_Number__c;
                        if(objlead.PPP_First_Draw_Loan_Amount__c !=null)
                            objWrap.PPP_First_Draw_Loan_Amount = objlead.PPP_First_Draw_Loan_Amount__c;
                            
                            
                         ///////////// New fields 25 Ja 2021 Saurabh Kumar added   
                        if(objlead.Period_2_Revenue__c  !=null)
                            objWrap.Period_2_Revenue = objlead.Period_2_Revenue__c;
                        if(objlead.Network_Selection__c != null)
                            objWrap.networkSelection = objlead.Network_Selection__c;
                        if(objlead.Last_Year_s_Period__c!=null)
                            objWrap.Last_Years_Period = objlead.Last_Year_s_Period__c;
                        if(objlead.Proof_of_25_revenue_drop_2020__c !=null)
                            objWrap.Proof_of_25_revenue_drop_2020 = objlead.Proof_of_25_revenue_drop_2020__c;
                        if(objlead.Period_1_Revenue__c !=null)
                            objWrap.Period_1_Revenue  = objlead.Period_1_Revenue__c;
                        if(objlead.Refinance_of_Eligible_Economic_Injury_Di__c  !=null)
                            objWrap.Refinance_of_Eligible_Economic_Injury_Di = objlead.Refinance_of_Eligible_Economic_Injury_Di__c;
                        if(objlead.Economic_Injury_Disaster_Loan_Number__c !=null)
                            objWrap.Economic_Injury_Disaster_Loan_Number = objlead.Economic_Injury_Disaster_Loan_Number__c;
                           
                           ///////////////////25 Jan2021 END////////////          
                        if(objlead.Disabled__c !=null)
                            objWrap.Disabled = objlead.Disabled__c == 'Yes'?true:false;
                        if(objlead.DBA__c !=null)
                            objWrap.dbaName = objlead.DBA__c;
                        if(objlead.Curr_SBA_Econ_Disaster_Injury_Loan_Bal__c !=null)
                            objWrap.CurrentSBAEconomicDisasterInjuryLoanBalance = objlead.Curr_SBA_Econ_Disaster_Injury_Loan_Bal__c;
                        if(objlead.County__c !=null)
                            objWrap.County = objlead.County__c;
                        if(objlead.Company !=null)
                            objWrap.corporateName = objlead.Company;
                        objWrap.contactPosition = 'Position';
                        if( objlead.Email !=null)
                            objWrap.contactEmail = objlead.Email;
                        if(objlead.Website !=null)
                            objWrap.BusinessWebAdress = objlead.Website;
                        if(objlead.Entity_Type__c !=null)
                            objWrap.BusinessType = objlead.Entity_Type__c;
                        
                        if(objlead.Business_Start_Date__c !=null)
                            objWrap.BusinessStartDate = String.valueof(objlead.Business_Start_Date__c);
                        if(objlead.Company !=null)
                            objWrap.BusinessName = objlead.Company;
                        if( objlead.Business_EIN__c != null && objlead.Business_EIN__c != '')
                            objWrap.BusinessEIN = string.valueof(objlead.Business_EIN__c.deleteWhitespace()).replace('-','');
                        if(objlead.PostalCode !=null)
                        {
                            // added by Rahul kumar on 05 Jan 2021 for Pincode 
                            String BuinessZip =  objlead.PostalCode;
                            if(BuinessZip !=null && BuinessZip.contains('-')){
                                BuinessZip = BuinessZip.replaceall('-','');
                                BuinessZip = BuinessZip.substring(0,5);
                                objWrap.BuinessZip = BuinessZip;
                            }
                            else
                                objWrap.BuinessZip = objlead.PostalCode;
                    //END
                        }
                            //objWrap.BuinessZip = objlead.PostalCode;
                        if(objlead.State !=null)
                                objWrap.BuinessState = objlead.State;
                        if(objlead.City !=null)
                            objWrap.BuinessCity = objlead.City;
                        if(objlead.Street !=null)
                            objWrap.BuinessAddress = objlead.Street;
                        if(objlead.Average_Monthly_Payroll__c !=null)
                            objWrap.Average_Monthly_Payroll = Integer.valueOf(objlead.Average_Monthly_Payroll__c);
                        if(objlead.Legal_action_pending_against_youspouse__c !=null)
                            objWrap.Arethereanylegalactionspendingagainstyou_oryourspouse = objlead.Legal_action_pending_against_youspouse__c== 'Yes'? true:false;
                        objWrap.arethemajorityownesofthebusinessUSCitizensorLegalPermanentResidents = objlead.Majority_owner_US_CitizenLegal_Resident__c== 'Yes'? true:false;
                        if(objlead.Average_Monthly_Payroll__c !=null)
                            objWrap.AnnualPayrollCost = Integer.valueOf(objlead.Average_Monthly_Payroll__c);
                        if(objlead.Annual_Gross_Revenue__c!=null)
                            objWrap.AnnualGrossRevenue = Integer.valueof(objlead.Annual_Gross_Revenue__c);
                        if(objlead.Requested_Amount__c !=null)
                            objWrap.AmountRequested = Integer.valueof(objlead.Requested_Amount__c);
                        if(objlead.Monthly_Rent_Mtg__c !=null)
                            objWrap.AmountofrentORmtg = Integer.valueof(objlead.Monthly_Rent_Mtg__c);
                        
                        
                        if(String.isNotBlank(String.valueOf(objlead.Have_you_exhausted_all_personal_non_SB__c))) 
                            objWrap.Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins =  objlead.Have_you_exhausted_all_personal_non_SB__c == 'Yes'? true:false;
                        if(String.isNotBlank(String.valueOf(objlead.Does_the_Business_have_existing_SBA_Debt__c)))
                            objWrap.DoestheBusinesshaveexistingSBADebt = objlead.Does_the_Business_have_existing_SBA_Debt__c == 'Yes'? true:false;
                        
                        // List of Owners Wrapper
                        // First Owner Wrapper
                        if(objlead.Owner_ID_Owner_1__c != null && objlead.Owner_ID_Owner_1__c != '')
                        {
                            javaAPILeadSysnc.ownerWrapper objOwnerJSON = new javaAPILeadSysnc.ownerWrapper();                           
                            objOwnerJSON.LeadId = objlead.Id;
                            if(objlead.CountyId_Owner__c!=null)
                                objOwnerJSON.ownerCounty = string.valueOf(objlead.CountyId_Owner__c);
                            if(objlead.Adddress2_Owner__c !=null){
                                objOwnerJSON.ownerHomeAddress2 = string.valueOf(objlead.Adddress2_Owner__c);
                                objOwnerJSON.owner_home_address2= string.valueOf(objlead.Adddress2_Owner__c);
                            }
                            objOwnerJSON.ownerCity = objlead.City_Owner_1__c;
                            objOwnerJSON.ownerCellChone_no = objlead.MobilePhone;
                            // added by Rahul kumar on 05 Jan 20201 for Pincode 
                            String owner1ZipCode =  objlead.Zip_Code_Owner_1__c;
                            if(owner1ZipCode !=null && owner1ZipCode.contains('-')){
                                owner1ZipCode = owner1ZipCode.replaceall('-','');
                                owner1ZipCode = owner1ZipCode.substring(0,5);
                                objOwnerJSON.Owner_zipcode = owner1ZipCode;
                            }
                            else
                                objOwnerJSON.Owner_zipcode = objlead.Zip_Code_Owner_1__c;
                            //END
                            //objOwnerJSON.Owner_zipcode = objlead.Zip_Code_Owner_1__c;
                            objOwnerJSON.owner_title = objlead.Title;
                            objOwnerJSON.owner_state = objlead.State_Owner_1__c;
                            objOwnerJSON.owner_SSN = objlead.SSN1__c;
                            objOwnerJSON.Owner_Rent = String.valueof(objlead.Owner_Rent_1__c);
                            objOwnerJSON.Owner_Phone = String.valueof(objlead.Phone);
                            objOwnerJSON.owner_percentage = Integer.valueof(objlead.of_Ownership_Owner__c);
                            objOwnerJSON.owner_last_name = objlead.lastname;                            
                            objOwnerJSON.owner_home_address = objlead.Street_Owner_1__c;
                            objOwnerJSON.owner_first_name = objlead.firstname;
                            objOwnerJSON.owner_email = objlead.email;
                            objOwnerJSON.owner_dob = String.valueof(objlead.DOB_Owner_1__c);
                            objOwnerJSON.Owner_Country = objlead.Country_Owner_1__c;
                            objOwnerJSON.LeadId = objlead.Id;
                            objOwnerJSON.isPrimaryContact = True;
                            objOwnerJSON.Owner_Id = objlead.Owner_ID_Owner_1__c;
                           // objOwnerJSON.CreditScorefromWebform = string.valueof(objlead.Credit_Score__c);
                            
                            objWrap.listOfOwnersData.add(objOwnerJSON);
                            system.debug('------listOfOwners----->'+objWrap.listOfOwnersData);
                        }
                        
                        // Second Owner Wrapper
                        if(objlead.Owner_ID_Owner_2__c != null && objlead.Owner_ID_Owner_2__c != '')
                        {                            
                            javaAPILeadSysnc.ownerWrapper objOwnerJSON = new javaAPILeadSysnc.ownerWrapper();                           
                            objOwnerJSON.LeadId = objlead.Id;
                            if(objlead.County_Owner_2__c!=null)
                                objOwnerJSON.ownerCounty = string.valueOf(objlead.County_Owner_2__c);
                            if(objlead.Address2_Owner_2__c !=null){
                                objOwnerJSON.ownerHomeAddress2 = string.valueOf(objlead.Address2_Owner_2__c);
                                objOwnerJSON.owner_home_address2= string.valueOf(objlead.Address2_Owner_2__c);
                            }
                            objOwnerJSON.ownerCity = objlead.City_Owner_2__c;
                            objOwnerJSON.ownerCellChone_no = objlead.Mobile_2nd_Owner__c;
                            // added by Rahul kumar on 05 Jan 20201 for Pincode 
                            String owner2ZipCode =  objlead.Zip_Code_Owner_2__c;
                            if(owner2ZipCode !=null && owner2ZipCode.contains('-')){
                                owner2ZipCode = owner2ZipCode.replaceall('-','');
                                owner2ZipCode = owner2ZipCode.substring(0,5);
                                objOwnerJSON.Owner_zipcode = owner2ZipCode;
                            }
                            else
                                objOwnerJSON.Owner_zipcode = objlead.Zip_Code_Owner_2__c;
                            //END
                            //objOwnerJSON.Owner_zipcode = objlead.Zip_Code_Owner_2__c;
                            objOwnerJSON.owner_title = objlead.Title_2nd_Owner__c;
                            objOwnerJSON.owner_state = objlead.State_Owner_2__c;
                            objOwnerJSON.owner_SSN = objlead.SSN2__c;
                            objOwnerJSON.Owner_Rent = String.valueof(objlead.Owner_Rent_2__c);
                            objOwnerJSON.Owner_Phone = String.valueof(objlead.Phone_2nd_Owner__c);
                            objOwnerJSON.owner_percentage = Integer.valueof(objlead.of_Ownership_Second_Owner__c);
                            objOwnerJSON.owner_last_name = objlead.Last_Name_2nd_Owner__c;                            
                            objOwnerJSON.owner_home_address = objlead.Street_Owner_2__c;
                            objOwnerJSON.owner_first_name = objlead.First_Name_2nd_Owner__c;
                            objOwnerJSON.owner_email = objlead.Email_2nd_Owner__c;
                            objOwnerJSON.owner_dob = String.valueof(objlead.DOB_Owner_2__c);
                            objOwnerJSON.Owner_Country = objlead.Country_Owner_2__c;
                            objOwnerJSON.LeadId = objlead.Id;
                            objOwnerJSON.isPrimaryContact = False;
                            objOwnerJSON.Owner_Id = objlead.Owner_ID_Owner_2__c;
                            //objOwnerJSON.CreditScorefromWebform = string.valueof(objlead.Credit_Score_2nd_Owner__c);
                            
                            objWrap.listOfOwnersData.add(objOwnerJSON);
                        }
                        
                        // Third Owner Wrapper
                        if(objlead.Owner_ID_Owner_3__c != null && objlead.Owner_ID_Owner_3__c != '')
                        {
                            javaAPILeadSysnc.ownerWrapper objOwnerJSON = new javaAPILeadSysnc.ownerWrapper();                           
                            objOwnerJSON.LeadId = objlead.Id;
                            if(objlead.County_Owner_3__c!=null)
                                objOwnerJSON.ownerCounty = string.valueOf(objlead.County_Owner_3__c);
                            if(objlead.Address2_Owner_3__c !=null){
                                objOwnerJSON.ownerHomeAddress2 = string.valueOf(objlead.Address2_Owner_3__c);
                                objOwnerJSON.owner_home_address2= string.valueOf(objlead.Address2_Owner_3__c);
                            }
                            objOwnerJSON.ownerCity = objlead.City_Owner_3__c;
                            objOwnerJSON.ownerCellChone_no = objlead.Mobile_3rd_Owner__c;
                            objOwnerJSON.Owner_zipcode = objlead.Zip_Code_Owner_3__c;
                            objOwnerJSON.owner_title = objlead.Title_3rd_Owner__c;
                            objOwnerJSON.owner_state = objlead.State_Owner_3__c;
                            objOwnerJSON.owner_SSN = objlead.SSN_3rd_Owner__c;
                            objOwnerJSON.Owner_Rent = String.valueof(objlead.Owner_Rent_3__c);
                            objOwnerJSON.Owner_Phone = String.valueof(objlead.Phone_3rd_Owner__c);
                            objOwnerJSON.owner_percentage = Integer.valueof(objlead.of_Ownership_3rd_Owner__c);
                            objOwnerJSON.owner_last_name = objlead.Last_Name_3rd_Owner__c;                            
                            objOwnerJSON.owner_home_address = objlead.Street_Owner_3__c;
                            objOwnerJSON.owner_first_name = objlead.First_Name_3rd_Owner__c;
                            objOwnerJSON.owner_email = objlead.Email_3rd_Owner__c;
                            objOwnerJSON.owner_dob = String.valueof(objlead.DOB_Owner_3__c);
                            objOwnerJSON.Owner_Country = objlead.Country_Owner_3__c;
                            objOwnerJSON.LeadId = objlead.Id;
                            objOwnerJSON.isPrimaryContact = False;
                            objOwnerJSON.Owner_Id = objlead.Owner_ID_Owner_3__c;
                           // objOwnerJSON.CreditScorefromWebform = string.valueof(objlead.Credit_Score_3rd_Owner_from_Webform__c);
                            
                            objWrap.listOfOwnersData.add(objOwnerJSON);
                        }
                        
                        // Fourth Owner Wrapper
                        if(objlead.Owner_ID_Owner_4__c != null && objlead.Owner_ID_Owner_4__c != '')
                        {
                            javaAPILeadSysnc.ownerWrapper objOwnerJSON = new javaAPILeadSysnc.ownerWrapper();                           
                            objOwnerJSON.LeadId = objlead.Id;
                            if(objlead.County_Owner_4__c!=null)
                                objOwnerJSON.ownerCounty = string.valueOf(objlead.County_Owner_4__c);
                            if(objlead.Address2_Owner_4__c !=null){
                                objOwnerJSON.ownerHomeAddress2 = string.valueOf(objlead.Address2_Owner_4__c);
                                objOwnerJSON.owner_home_address2= string.valueOf(objlead.Address2_Owner_4__c);
                            }
                            objOwnerJSON.ownerCity = objlead.City_Owner_4__c;
                            objOwnerJSON.ownerCellChone_no = objlead.Mobile_4th_Owner__c;
                            objOwnerJSON.Owner_zipcode = objlead.Zip_Code_Owner_4__c;
                            objOwnerJSON.owner_title = objlead.Title_4th_Owner__c;
                            objOwnerJSON.owner_state = objlead.State_Owner_4__c;
                            objOwnerJSON.owner_SSN = objlead.SSN_4th_Owner__c;
                            objOwnerJSON.Owner_Rent = String.valueof(objlead.Owner_Rent_4__c);
                            objOwnerJSON.Owner_Phone = String.valueof(objlead.Phone_4th_Owner__c);
                            objOwnerJSON.owner_percentage = Integer.valueof(objlead.of_Ownership_4th_Owner__c);
                            objOwnerJSON.owner_last_name = objlead.Last_Name_4th_Owner__c;                            
                            objOwnerJSON.owner_home_address = objlead.Street_Owner_4__c;
                            objOwnerJSON.owner_first_name = objlead.First_Name_4th_Owner__c;
                            objOwnerJSON.owner_email = objlead.Email_4th_Owner__c;
                            objOwnerJSON.owner_dob = String.valueof(objlead.DOB_Owner_4__c);
                            objOwnerJSON.Owner_Country = objlead.Country_Owner_4__c;
                            objOwnerJSON.LeadId = objlead.Id;
                            objOwnerJSON.isPrimaryContact = False;
                            objOwnerJSON.Owner_Id = objlead.Owner_ID_Owner_4__c;
                           // objOwnerJSON.CreditScorefromWebform = string.valueof(objlead.Credit_Score_4th_Owner_from_Webform__c);
                            
                            objWrap.listOfOwnersData.add(objOwnerJSON);
                        }
                        
                        // Fifth Owner Wrapper
                        if(objlead.Owner_ID_Owner_5__c != null && objlead.Owner_ID_Owner_5__c != '')
                        {
                            javaAPILeadSysnc.ownerWrapper objOwnerJSON = new javaAPILeadSysnc.ownerWrapper();                           
                            objOwnerJSON.LeadId = objlead.Id;
                            if(objlead.County_Owner_5__c!=null)
                                objOwnerJSON.ownerCounty = string.valueOf(objlead.County_Owner_5__c);
                            if(objlead.Address2_Owner_5__c !=null){
                                objOwnerJSON.ownerHomeAddress2 = string.valueOf(objlead.Address2_Owner_5__c);
                                objOwnerJSON.owner_home_address2= string.valueOf(objlead.Address2_Owner_5__c);
                            }
                            objOwnerJSON.ownerCity = objlead.City_Owner_5__c;
                            objOwnerJSON.ownerCellChone_no = objlead.Mobile_5th_Owner__c;
                            objOwnerJSON.Owner_zipcode = objlead.Zip_Code_Owner_5__c;
                            objOwnerJSON.owner_title = objlead.Title_5th_Owner__c;
                            objOwnerJSON.owner_state = objlead.State_Owner_5__c;
                            objOwnerJSON.owner_SSN = objlead.SSN_5th_Owner__c;
                            objOwnerJSON.Owner_Rent = String.valueof(objlead.Owner_Rent_5__c);
                            objOwnerJSON.Owner_Phone = String.valueof(objlead.Phone_5th_Owner__c);
                            objOwnerJSON.owner_percentage = Integer.valueof(objlead.of_Ownership_5th_Owner__c);
                            objOwnerJSON.owner_last_name = objlead.Last_Name_5th_Owner__c;                            
                            objOwnerJSON.owner_home_address = objlead.Street_Owner_5__c;
                            objOwnerJSON.owner_first_name = objlead.First_Name_5th_Owner__c;
                            objOwnerJSON.owner_email = objlead.Email_5th_Owner__c;
                            objOwnerJSON.owner_dob = String.valueof(objlead.DOB_Owner_5__c);
                            objOwnerJSON.Owner_Country = objlead.Country_Owner_5__c;
                            objOwnerJSON.LeadId = objlead.Id;
                            objOwnerJSON.isPrimaryContact = False;
                            objOwnerJSON.Owner_Id = objlead.Owner_ID_Owner_5__c;
                            //objOwnerJSON.CreditScorefromWebform = string.valueof(objlead.Credit_Score_5th_Owner_from_Webform__c);
                            
                            objWrap.listOfOwnersData.add(objOwnerJSON);
                        }
                        
                        // Adding all owner wrapper to main wrapper
                        objWrapper.listOfLeadData.add(objWrap);
                        
                    }
                    
                    // Making actual API call out
                    if( accessToken != null && accessToken != '' ){
                        Http http1 = new Http();
                        HttpRequest request1 = new HttpRequest();
                        request1.setHeader('Authorization', accessToken);
                        request1.setHeader('Content-Type', 'application/json');
                        string endPointURLFile = prodEndPoint+System.Label.JavaPortalLeadPatchSBA;
                        request1.setEndpoint(endPointURLFile);
                        request1.setMethod('POST');                        
                        // Set the body as a JSON object
                        request1.setBody(JSON.serialize(objWrapper));
                        system.debug('Testing User Call----->>'+JSON.serialize(objWrapper));                        
                        HttpResponse response1 = http1.send(request1);                        
                        // Parse the JSON response
                        if (response1.getStatusCode() != 201 ) {
                            createFile(response,strReqBody,listOfLeadid,setOfApplicationId);
                            createFile(response1,request1.getBody(),listOfLeadid,setOfApplicationId);
                        }
                        else{
                            createFile(response,strReqBody,listOfLeadid,setOfApplicationId);
                            createFile(response1,request1.getBody(),listOfLeadid,setOfApplicationId);
                        }
                    }
                }
            }   
        }         
    }
    
    //============updateLeadQuestions Update=======================JavaPortalQuestionsPatchApi
    
    
     @future (callout=true) 
    public static void updateLeadQuestions(set<String> setQuestionsIds,String portalEndPoint ){    
        Set<String> setOfApplicationId = new Set<String>();
        Set<Id> setOfLeadid = new Set<Id>();
        JSON2ApexQuestionsWithSubQst objQuestionsJSON = new JSON2ApexQuestionsWithSubQst();
        list<JSON2ApexQuestionsWithSubQst.Questionnaire> lstOfQuestions = new list<JSON2ApexQuestionsWithSubQst.Questionnaire>();
        list<Lead_Questions__c>  newQuestions = [ select id,Tenant_Id__c ,Lead__r.PortalAPIEndPoint__c ,Lead__r.Id,Lead__r.Application_ID__c,Business_Id__c ,Name,Answer__c,Question_Id__c,Is_SubQuestion__c,Lead__c,Opportunity__c,Question__c,Question_Type__c,
                                                    (select id,Answer__c,Sub_Question_Id__c,Parent_Question_Id__c,Question__c,Question_Type__c from Sub_Questions__r)
                                                  from Lead_Questions__c where id IN:setQuestionsIds ];
       // system.debug('-------newQuestions--------->>'+newQuestions[0].Opportunity__c);
         // objQuestionsJSON.OpportunityId = ;
        if(newQuestions != null && newQuestions.size() > 0 ){
            for(Lead_Questions__c each : newQuestions){
                setOfApplicationId.add(each.Lead__r.Application_ID__c);
                setOfLeadid.add(each.Lead__r.Id);
                JSON2ApexQuestionsWithSubQst.Questionnaire objQ = new JSON2ApexQuestionsWithSubQst.Questionnaire();
                
                objQ.questionType = each.Question_Type__c;
                objQ.answer = each.Answer__c;
                System.debug('#######sub.QuString.valueOf(estion__c######## '+each.Question__c);
                objQ.questionDesc = String.valueOf(each.Question__c);
                objQ.questionId = Integer.valueof(each.Question_Id__c);
                objQ.isSubQuestion = each.Is_SubQuestion__c;
                if(each.Sub_Questions__r !=null && each.Sub_Questions__r .size()>0){
                    for(Sub_Question__c  sub : each.Sub_Questions__r){
                        JSON2ApexQuestionsWithSubQst.SubQuestionnaire subWrapper = new JSON2ApexQuestionsWithSubQst.SubQuestionnaire();
                        System.debug('#######sub.Question__c######## '+sub.Question__c);
                        subWrapper.questionDesc = String.valueOf(sub.Question__c);
                        subWrapper.questionType  = sub.Question_Type__c;
                        if(objQ.isSubQuestion)
                            subWrapper.answer = sub.Answer__c;
                        else
                            subWrapper.answer = '';
                        subWrapper.subQuestionId  = Integer.valueOf(sub.Sub_Question_Id__c);
                        subWrapper.parentQuestionId  = Integer.valueOf(sub.Parent_Question_Id__c);
                        objQ.listOfSubQuestion.add(subWrapper);
                    }
                }
                  
                
                lstOfQuestions.add(objQ);
            }
            if( newQuestions[0].Business_Id__c != null && newQuestions[0].Business_Id__c != '' )
                objQuestionsJSON.businessId = Integer.valueof(newQuestions[0].Business_Id__c);
            if(newQuestions[0].Lead__c != null )
                objQuestionsJSON.LeadId = newQuestions[0].Lead__c;
            if(newQuestions[0].Opportunity__c != null  )
                objQuestionsJSON.OpportunityId = newQuestions[0].Opportunity__c;
            if( newQuestions[0].Tenant_Id__c != null && newQuestions[0].Tenant_Id__c != '' )
                objQuestionsJSON.TenantId = Integer.valueof(newQuestions[0].Tenant_Id__c);
            
            objQuestionsJSON.Questionnaire = lstOfQuestions;
            
            system.debug('-------JSON--------->>'+JSON.serialize(objQuestionsJSON));  
            
        }
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        string endPointURL = portalEndPoint+System.Label.JavaPortalEndPointUrl;
        req.setEndpoint(endPointURL);
        string userName =  System.Label.JavaPortalUserName;
        string password = System.Label.JavaPortalPassword;
        req.setBody('{"username": "'+ System.Label.JavaPortalUserName+'","secure": "'+ System.Label.JavaPortalPassword+'"}');
        string strReqBody = '{"username": "'+ System.Label.JavaPortalUserName+'","secure": "'+ System.Label.JavaPortalPassword+'"}';
        string accessToken = '';
        Http http = new Http();
        HTTPResponse response = new HttpResponse();
        if(System.Test.isRunningTest()) {
            HttpResponse res = new HttpResponse();
            res.setBody('{"username": "'+System.Label.JavaPortalUserName+'","secure": "'+System.Label.JavaPortalPassword+'"}');
            response = res;
        }
        else {
            response = http.send(req);
            System.debug('response.getStatusCode----> '+response.getStatusCode() );
        } 
        
        //createFile(response,strReqBody);
        
        if (response.getStatusCode() == 200 || System.Test.isRunningTest()) {
            JSONParser parser = JSON.createParser(response.getBody()); 
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() =='accessToken' || System.Test.isRunningTest())){
                    parser.nextToken();
                    accessToken= parser.getText();
                    system.debug('222222222222'+accessToken);
                }
            }
            
            
        }
        
        // call out
        system.debug('Checking Value for Access Token----->>'+accessToken);
        if( accessToken != null && accessToken != '' ){
            Http http1 = new Http();
            HttpRequest request1 = new HttpRequest();
            request1.setHeader('Authorization', accessToken);
            request1.setHeader('Content-Type', 'application/json');            
            string endPointURLFile = portalEndPoint+System.Label.JavaPortalQuestionsPatchApi;
            request1.setEndpoint(endPointURLFile);
            request1.setMethod('POST');                        
            // Set the body as a JSON object
            request1.setBody(JSON.serialize(objQuestionsJSON));
            system.debug('Testing User Call----->>'+JSON.serialize(objQuestionsJSON));                        
            HttpResponse response1 = http1.send(request1);                        
            // Parse the JSON response
            if (response1.getStatusCode() != 201 ) {
                createFile(response,strReqBody,setOfLeadid,setOfApplicationId);
                createFile(response1,request1.getBody(),setOfLeadid,setOfApplicationId);
            }
            else{
                createFile(response,strReqBody,setOfLeadid,setOfApplicationId);
                createFile(response1,request1.getBody(),setOfLeadid,setOfApplicationId);
            }
        }
      
        
    }
    
    public static void createFile(HTTPResponse response,String strReqBody,Set<Id> setOfLeadId, Set<String> setOfApplId){
        // Inserting Request, Response and Response code into the custom object for error handling
        List<Attachment> listOfAttachment = new List<Attachment>();
        Portal_Integration_Response_Code__c  Portalobj = new  Portal_Integration_Response_Code__c ();
        Portalobj.Request__c = String.valueOf(setOfLeadId);
        Portalobj.Response__c = String.valueOf(setOfApplId);
        Portalobj.Success_Error_Code__c = String.valueOf(response.getStatusCode());
        insert Portalobj;
        integer statusCodeAuth = response.getStatusCode();
        System.debug('----------statusCodeAuth----->>'+statusCodeAuth);
        // request file
        Attachment attachmentrequest = new Attachment();
        attachmentrequest.Body = Blob.valueOf(strReqBody);
        attachmentrequest.Name = String.valueOf('Request.txt');
        attachmentrequest.ParentId = Portalobj.Id; 
        listOfAttachment.add(attachmentrequest);
        
        // response file
        Attachment attachmentresponse = new Attachment();
        attachmentresponse.Body = Blob.valueOf(response.getBody());
        attachmentresponse.Name = String.valueOf('Response.txt');
        attachmentresponse.ParentId = Portalobj.Id; 
        listOfAttachment.add(attachmentresponse);
        DataBase.insert(listOfAttachment);
        
    }
}