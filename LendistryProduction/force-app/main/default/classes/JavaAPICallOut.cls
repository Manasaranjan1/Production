/**
* @File Name          : JavaAPICallOut.cls
* @Description        : 
* @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
* @Group              : 
* @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
* @Last Modified On   : 4/24/2020, 9:45:36 PM
* @Modification Log   : 
* Ver       Date            Author                 Modification
* 1.0    4/13/2020   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
public class JavaAPICallOut {
    //list<Portal_Integration_Response_Code__c > lstOfExceptions = new list< Portal_Integration_Response_Code__c >();
    public static boolean isRecursiveLeadToOppCall = true;
    public static boolean isRecursiveSalesScreen = true;
    public static boolean isRecursiveCreditReports = true;
    public static boolean isRecursiveSendLeadData = true;
    
    @future (callout=true) // Lead To Opportunity Api Call
    public static void makeJavaPortalAPICall(string PortalAPIEndPoint, string businessID , string OpportuntiyConvertedID , string LeadId, string ApplicationID)
    {
        
        System.debug('-----Testing--->'+'Boddh');
        list<Portal_Integration_Response_Code__c > lstOfExceptions = new list< Portal_Integration_Response_Code__c >();
        list<Quick_Cash_Flow__c> lstQuick_Cash_Flow = new list<Quick_Cash_Flow__c>();
        list<QuickCashFlowDetailsDtos> lstQuickCashFlowDetailsDtos = new list<QuickCashFlowDetailsDtos>();
        list<wrapper> lstOfOwnersWrapper = new list<wrapper>();
        wrapLead WrapperLead = new wrapLead();
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        string endPointURL = PortalAPIEndPoint+System.Label.JavaPortalEndPointUrl;
        System.debug('------Lead To Oppp----Boddh---->' + endPointURL);
        req.setEndpoint(endPointURL);
        string userName =  System.Label.JavaPortalUserName;
        string password = System.Label.JavaPortalPassword;
        req.setBody('{"username": "'+ System.Label.JavaPortalUserName+'","secure": "'+ System.Label.JavaPortalPassword+'"}');
        string strReqBody = '{"username": "'+ System.Label.JavaPortalUserName+'","secure": "'+ System.Label.JavaPortalPassword+'"}';
        string accessToken = '';
        Http http = new Http();
        //  HTTPResponse response = http.send(req);
        HTTPResponse response = new HttpResponse();
        if(Test.isRunningTest()) {
            HttpResponse res = new HttpResponse();
            res.setBody('{"username": "'+System.Label.JavaPortalUserName+'","secure": "'+System.Label.JavaPortalPassword+'"}');
            response = res;
        }
        else {
            response = http.send(req);
        } 
        System.debug('Body ' + response.getBody());
        System.debug('Status ' + response.getStatus());
        System.debug('Status code ' + response.getStatusCode());
        // Inserting Request, Response and Response code into the custom object for error handling
        Portal_Integration_Response_Code__c  Portalobj = new  Portal_Integration_Response_Code__c ();
        Portalobj.Request__c = strReqBody;
        Portalobj.Response__c = response.getBody();
        Portalobj.Business_Id__c = businessID;
        Portalobj.Application_Id__c = ApplicationID;
        Portalobj.Opportunity_Id__c = OpportuntiyConvertedID;
        Portalobj.Lead_Id__c = LeadId;
        Portalobj.Success_Error_Code__c = String.valueOf(response.getStatusCode());
        // added by saurabh for converison tracking
        Portalobj.API_Name__c = 'Portal Login API';
        Portalobj.Method_Name__c = 'makeJavaPortalAPICall';
        integer statusCodeAuth = response.getStatusCode();
        System.debug('----------statusCodeAuth----->>'+statusCodeAuth);
        lstOfExceptions.add(Portalobj);
        System.debug('OpportuntiyConvertedID--->'+OpportuntiyConvertedID);
        Opportunity ConvertedOpp = new Opportunity();
        Lead ConvertedLead = [ Select Does_the_Business_have_existing_SBA_Debt__c,Have_you_exhausted_all_personal_non_SB__c,Application_ID__c,EIDL_AMOUNT_RECEIVED__c,of_Current_Employees__c,Did_you_take_out_PPP_or_a_EIDL_loan__c, Has_your_PPP_loan_been_forgiven__c, 
                              Do_you_have_any_other_outstanding_liens__c, Have_you_filed_for_bankruptcy__c, PPP_AMOUNT_RECEIVED__c,
                              recordType.Name,Was_Your_Business_Profitable_In_2019__c,Minority_Business_Owned__c, Tenant_Referral_Partner_Name__c, Preferred_Language__c, Loan_Type__c,SBA_PPP_Loan_Application_Form__c,Tax_Year__c,Purpose_of_the_loan__c,Will_this_loan_create_more_Jobs__c,
                                Purpose_of_Grant__c,Will_this_grant_create_new_jobs__c,NAICS_CODE__c,SBSS_SCORE__c,SBA_Application_Approval__c,Rural__c,
                                Do_50_of_empl_earn_less_than_51859__c,X0KSB_Scholar_Alumni__c,Other__c,Application_ID_SBAPPP__c,Business_ID_SBAPPP__c,
                                Curr_SBA_Econ_Disaster_Injury_Loan_Bal__c,SBA_PPP_Loan_Application__c,exhausted_personal_nonSBA_financing__c,
                                Submit_loan_req_SBAfinancial_COVID19__c,BusinessId__c,net_worth__c,Business_Phone__c,Who_is_Your_Customer_Base1__c,
                                What_does_your_Business_do__c,What_type_of_Business_is_it__c,Tell_us_more__c, DOB_Owner_1__c,DOB_Owner_2__c,DOB_Owner_3__c,
                                DOB_Owner_4__c,DOB_Owner_5__c,Owner_Rent_1__c, Owner_Rent_2__c, Owner_Rent_3__c, Owner_Rent_4__c, Owner_Rent_5__c, Disabled__c,
                                Ethnicity__c,Race__c,Veteran__c,Women_Owned__c,of_customer_served_monthly__c,of_employees_added_in_next_12_months__c,
                                of_Dials__c,Owner_ID_Owner_1__c,Owner_ID_Owner_2__c,Owner_ID_Owner_3__c,Owner_ID_Owner_4__c,Owner_ID_Owner_5__c,
                                of_Ownership_Owner__c,creditchecker__Adverse_Alert__c,Are_you_COD_30_60_90__c,creditchecker__Average_Score__c,
                                creditchecker__Bankruptcy_Count__c,Brief_History_on_the_business__c,Brief_History_on_the_owner_manager__c,Campaign_Source__c,
                                creditchecker__Charge_Offs_Count__c,creditchecker__Collections_Count__c,creditchecker__Current_Adverse_Count__c,
                                creditchecker__Derogatory_Count__c,creditchecker__Disputes_Count__c,Do_You_Carry_Life_Insurance__c,
                                Do_you_pay_child_support_or_alimony__c,Entity_Type__c,Explanation_of_any_BKs_defaults_etc__c,First_Name_2nd_Owner__c,
                                Homeowner__c,Last_Name_2nd_Owner__c,Monthly_Rent_Mtg__c,Owner__c,Planned_Changes_In_Next_6_Months__c,
                                creditchecker__Previous_Adverse_Count__c,Profitable_Last_2_Years__c,creditchecker__Public_Record_Count__c,Referral_Partner__c,
                                Referral_type__c,Requested_Amount__c,creditchecker__Revolving_Credit_Utilization__c,Second_Owner__c,TIB_Months__c,
                                creditchecker__Total_High_Credit__c,creditchecker__Total_Inquiry_Count__c,creditchecker__Total_Liability_Balance__c,
                                creditchecker__Total_Liability_PastDue__c,creditchecker__Total_Liability_Payment__c,Use_of_Funds__c,
                                What_are_the_terms_of_your_current_lease__c,What_exactly_does_the_business_do__c,What_is_the_purpose_of_loan__c,
                                Who_is_your_customer_base__c,of_Ownership_Second_Owner__c,Address,Address_3rd_Owner__c,Address_4th_Owner__c,
                                Address_5th_Owner__c,Address_Owner_1__c,Address_Owner_2__c,AnnualRevenue,City, country,City_2nd_Owner__c,City_Owner_1__c,
                                City_Owner_2__c,City_Owner_3__c,City_Owner_4__c,City_Owner_5__c,Company,IsConverted,ConvertedAccountId,ConvertedContactId,
                                ConvertedDate,ConvertedOpportunityId,Country_2nd_Owner__c,Country_Owner_1__c,Country_Owner_2__c,Country_Owner_3__c,
                                Country_Owner_4__c,Country_Owner_5__c,CreatedById,CreatedDate,Credit_Report_Type__c,Credit_Score_2nd_Owner__c,
                                Credit_Score_3rd_Owner_from_Webform__c,Credit_Score_4th_Owner_from_Webform__c,Credit_Score_5th_Owner_from_Webform__c,
                                Credit_Score__c,Jigsaw,IsDeleted,Description,DoNotCall,Email,Email_2nd_Owner__c,Email_3rd_Owner__c,Email_4th_Owner__c,
                                Email_5th_Owner__c,NumberOfEmployees,FirstName,First_Name_3rd_Owner__c,First_Name_4th_Owner__c,First_Name_5th_Owner__c,
                                Name,GeocodeAccuracy,Industry,JigsawContactId,LastActivityDate,LastModifiedById,LastModifiedDate,LastName,
                                Last_Name_3rd_Owner__c,Last_Name_4th_Owner__c,Last_Name_5th_Owner__c,LastReferencedDate,LastViewedDate,Latitude,Id,
                                LeadSource,Longitude,MasterRecordId,MiddleName,Mobile_2nd_Owner__c,Mobile_3rd_Owner__c,Mobile_4th_Owner__c,Mobile_5th_Owner__c,
                                MobilePhone,Not_Interested__c,of_Ownership_3rd_Owner__c,of_Ownership_4th_Owner__c,of_Ownership_5th_Owner__c,OwnerId,Phone,
                                Phone_2nd_Owner__c,Phone_3rd_Owner__c,Phone_4th_Owner__c,Phone_5th_Owner__c,PhotoUrl,Postal_Code_2nd_Owner__c,
                                Rating,Referral_Partner_Email__c,Sales_Decline__c,Salutation,Source_Web_Form__c,SSN1__c,SSN2__c,SSN_3rd_Owner__c,
                                SSN_4th_Owner__c,SSN_5th_Owner__c,State_2nd_Owner__c,State_Owner_1__c,State_Owner_2__c,State_Owner_3__c,State_Owner_4__c,
                                State_Owner_5__c,State,Status,Status_Detail__c,Street,Street_2nd_Owner__c,Street_Owner_1__c,Street_Owner_2__c,Street_Owner_3__c,
                                Street_Owner_4__c,Street_Owner_5__c,Suffix,SystemModstamp,Title,Title_2nd_Owner__c,Title_3rd_Owner__c,Title_4th_Owner__c,
                                Title_5th_Owner__c,IsUnreadByOwner,UTM_Campaign__c,UTM_Medium__c,UTM_Source__c,Website,Zip_Code_Owner_1__c,Zip_Code_Owner_2__c,
                                Zip_Code_Owner_3__c,Zip_Code_Owner_4__c,Zip_Code_Owner_5__c,PostalCode ,Period_2_Revenue__c,Last_Year_s_Period__c,Proof_of_25_revenue_drop_2020__c,Network_Selection__c,
                        Period_1_Revenue__c,Refinance_of_Eligible_Economic_Injury_Di__c,Economic_Injury_Disaster_Loan_Number__c,Have_you_had_a_25_revenue_drop_between__c,Who_originated_your_PPP_loan__c,
                              Did_you_obtain_a_PPP_loan_in_2020__c,Did_you_receive_a_Shuttered_Venue_Operat__c,PPP_First_Draw_SBA_Loan_Number__c,PPP_First_Draw_Loan_Amount__c,
                              How_did_you_hear_about_us__c,Business_Stage__c,Business_Borough__c,Location_Type__c,of_Employees_Temporary_Full_Time_2020__c,of_Employees_Temporary_Part_Time_2020__c
                                
                              From Lead  Where Id=:LeadId ];
        if( OpportuntiyConvertedID != null && OpportuntiyConvertedID != '' )
            ConvertedOpp = [ Select Id,How_did_you_hear_about_us__c,Business_Stage__c,Business_Borough__c,Location_Type__c,of_Employees_Temporary_Full_Time_2020__c,of_Employees_Temporary_Part_Time_2020__c,Tenant_Referral_Partner_Name__c, Preferred_Language__c, Loan__c, Partner_Referral_Fee__c,Interest_Type__c,Sales_Decline__c, Loan_Type__c,name,Due_to_Lendistry_Rep__c,What_exactly_does_the_business_do__c,True_FICO__c, EPC_EIN__c, Brief_History_on_the_business__c, Referral_Partner__c, Referral_Source__c, Monthly_Rent__c, Disabled__c, Time_at_Address__c, Women_Owned__c, Requested_Amount__c, TIB_Months__c, Processing_Packaging_Fee__c, Referral_Partner_Fee__c,Homeowner__c,Origination_Fee__c,Interest_Rate__c, Brief_History_on_the_owner_manager__c, Veteran__c,Race__c,Ethnicity__c from Opportunity Where Id=:OpportuntiyConvertedID];
        string leadaddress = ConvertedLead.city + ' ' + ConvertedLead.Country + ' ' +ConvertedLead.postalCode+ ' ' + ConvertedLead.State + ' ' + ConvertedLead.Street;
        lstQuick_Cash_Flow = [SELECT Id,Year_CY__c, Year_CY_1__c, Year_CY_2__c, Year_CY_3__c, CreatedById, Test__c, Months_CY1__c, Months_CY__c, Months_CY2__c, Months_CY3__c, Sales_CY__c, Sales_CY1__c, Sales_CY2__c, Sales_CY3__c, Net_Profit_CY__c, Net_Profit_CY1__c, Net_Profit_CY2__c, Net_Profit_CY3__c, New_Rents_CY__c, New_Rents_CY1__c, New_Rents_CY2__c, New_Rents_CY3__c, Interest_Exp_CY__c, Interest_Exp_CY1__c, Interest_Exp_CY2__c, Interest_Exp_CY3__c, Non_Recurring_Expenses_CY__c, Non_Recurring_Expenses_CY1__c, Non_Recurring_Expenses_CY2__c, Non_Recurring_Expenses_CY3__c, Affilliate_Income_CY__c, Affilliate_Income_CY1__c, Affilliate_Income_CY2__c, Affilliate_Income_CY3__c, Owner_1_Personal_Disc_SD_CY1__c, Owner_1_Personal_Disc_SD_CY2__c, Owner_1_Personal_Disc_SD_CY__c, Owner_1_Personal_Disc_SD_CY3__c, Owner_2_Personal_Disc_SD_CY__c, Owner_2_Personal_Disc_SD_CY1__c, Owner_2_Personal_Disc_SD_CY2__c, Owner_2_Personal_Disc_SD_CY3__c, Owner_3_Personal_Disc_SD_CY__c, Owner_3_Personal_Disc_SD_CY1__c, Owner_3_Personal_Disc_SD_CY2__c, Owner_3_Personal_Disc_SD_CY3__c, Owner_4_Personal_Disc_SD_CY__c, Owner_4_Personal_Disc_SD_CY1__c, Owner_4_Personal_Disc_SD_CY2__c, Owner_4_Personal_Disc_SD_CY3__c, Total_First_CY__c, Total_First_CY1__c, Total_First_CY2__c, Monthly_Existing_Installment_Debt_CY__c, Total_First_CY3__c, Monthly_Existing_Installment_Debt_CY1__c, Monthly_Existing_Installment_Debt_CY2__c, Monthly_Existing_Installment_Debt_CY3__c, Annual_Existing_P_I_CY__c, Annual_Existing_P_I_CY1__c, Annual_Existing_P_I_CY2__c, Annual_Existing_P_I_CY3__c, Proposed_P_I_CY__c, Proposed_P_I_CY1__c, Proposed_P_I_CY2__c, Proposed_P_I_CY3__c, Total_Second_CY__c, Total_Second_CY2__c, Total_Second_CY1__c, Total_Second_CY3__c, Global_Coverage_Ratio_CY__c, Global_Coverage_Ratio_CY1__c, Global_Coverage_Ratio_CY2__c, Global_Coverage_Ratio_CY3__c, Business_Coverage_Ratio_CY__c, Business_Coverage_Ratio_CY1__c, Business_Coverage_Ratio_CY2__c, Business_Coverage_Ratio_CY3__c, Discretionary_Coverage_Ratio_CY__c, Discretionary_Coverage_Ratio_CY1__c, Discretionary_Coverage_Ratio_CY2__c, Discretionary_Coverage_Ratio_CY3__c, Highest_Credit_Score__c, Time_in_Business_Months__c, Estimated_CCR__c, Industry_High_Risk__c, Loan_Amount_Actual__c, Loan_Amount_Adjusted__c, Loan_Amount_Status__c, Interest_Rate_Actual__c, Interest_Rate_Adjusted__c, Interest_Rate_Status__c, Term_Months_Actual__c, Term_Months_Adjusted__c, Term_Months_Status__c, DueIn_Months_Actual__c, DueIn_Months_Adjusted__c, DueIn_Months_Status__c, Projected_Daily_Payment__c, Projected_Monthly_Payment__c, Projected_Weekly_Payment__c, Projected_Annual_Payment__c, Projected_BiWeekly_Payment__c, Projected_SemiMonthly_Payment__c, Interestdividend_Income_O1_CY__c, Interestdividend_Income_O2_CY__c, Interestdividend_Income_O3_CY__c, Interestdividend_Income_O4_CY__c, Interestdividend_Income_O5_CY__c, Interestdividend_Income_CY1__c, Interestdividend_Income_O2_CY1__c, Interestdividend_Income_O3_CY1__c, Interestdividend_Income_O4_CY1__c, Interestdividend_Income_O5_CY1__c, Interestdividend_Income_CY2__c, Interestdividend_Income_O2_CY2__c, Interestdividend_Income_O3_CY2__c, Interestdividend_Income_O4_CY2__c, Interestdividend_Income_O5_CY2__c, Interestdividend_Income_CY3__c, Interestdividend_Income_O2_CY3__c, Interestdividend_Income_O3_CY3__c, Interestdividend_Income_O4_CY3__c, Interestdividend_Income_O5_CY3__c, K1_Distributions_O1_CY__c, K1_Distributions_O2_CY__c, K1_Distributions_O3_CY__c, K1_Distributions_O4_CY__c, K1_Distributions_O5_CY__c, K1_Distributions_O1_CY1__c, K1_Distributions_O2_CY1__c, K1_Distributions_O3_CY1__c, K1_Distributions_O4_CY1__c, K1_Distributions_O5_CY1__c, K1_Distributions_O1_CY2__c, K1_Distributions_O2_CY2__c, K1_Distributions_O3_CY2__c, K1_Distributions_O4_CY2__c, K1_Distributions_O5_CY2__c, K1_Distributions_O1_CY3__c, K1_Distributions_O2_CY3__c, K1_Distributions_O3_CY3__c, K1_Distributions_O4_CY3__c, K1_Distributions_O5_CY3__c, Other_Guaranteed_wages_affiliates_O1_CY__c, Other_Guaranteed_wages_affiliates_O2_CY__c, Other_Guaranteed_wages_affiliates_O3_CY__c, Other_Guaranteed_wages_affiliates_O4_CY__c, Other_Guaranteed_wages_affiliates_O5_CY__c, Other_Income_O1_CY__c, Other_Income_O2_CY__c, Other_Income_O3_CY__c, Other_Income_O4_CY__c, Other_Income_O5_CY__c, Other_Income_O1_CY1__c, Other_Income_O2_CY1__c, Other_Income_O3_CY1__c, Other_Income_O4_CY1__c, Other_Income_O5_CY1__c, Other_Income_O1_CY2__c, Other_Income_O2_CY2__c, Other_Income_O1_CY3__c, Other_Income_O4_CY2__c, Other_Income_O5_CY2__c, Other_Income_O3_CY3__c, Other_Income_O4_CY3__c, Other_Income_O5_CY3__c, PensionIRA_Distributions_O1_CY__c, PensionIRA_Distributions_O2_CY__c, PensionIRA_Distributions_O3_CY__c, PensionIRA_Distributions_O4_CY__c, PensionIRA_Distributions_O5_CY__c, PensionIRA_Distributions_O1_CY1__c, PensionIRA_Distributions_O2_CY1__c, PensionIRA_Distributions_O3_CY1__c, PensionIRA_Distributions_O4_CY1__c, PensionIRA_Distributions_O5_CY1__c, PensionIRA_Distributions_O1_CY2__c, PensionIRA_Distributions_O2_CY2__c, PensionIRA_Distributions_O3_CY2__c, PensionIRA_Distributions_O4_CY2__c, PensionIRA_Distributions_O5_CY2__c, PensionIRA_Distributions_O1_CY3__c, PensionIRA_Distributions_O2_CY3__c, PensionIRA_Distributions_O3_CY3__c, PensionIRA_Distributions_O4_CY3__c, PensionIRA_Distributions_O5_CY3__c, Salary_Wages_Borrower_O1_CY__c, Salary_Wages_Borrower_O2_CY__c, Salary_Wages_Borrower_O3_CY__c, Salary_Wages_Borrower_O4_CY__c, Salary_Wages_Borrower_O5_CY__c, Salary_Wages_Borrower_O2_CY1__c, Salary_Wages_Borrower_O3_CY1__c, Salary_Wages_Borrower_O1_CY1__c, Salary_Wages_Borrower_O4_CY1__c, Salary_Wages_Borrower_O5_CY1__c, Salary_Wages_Borrower_O1_CY2__c, Salary_Wages_Borrower_O2_CY2__c, Salary_Wages_Borrower_O3_CY2__c, Salary_Wages_Borrower_O4_CY2__c, Salary_Wages_Borrower_O5_CY2__c, Salary_Wages_Borrower_O1_CY3__c, Salary_Wages_Borrower_O2_CY3__c, Salary_Wages_Borrower_O3_CY3__c, Salary_Wages_Borrower_O4_CY3__c, Salary_Wages_Borrower_O5_CY3__c, Salary_Wages_Spouse_O1_CY__c, Salary_Wages_Spouse_O2_CY__c, Salary_Wages_Spouse_O3_CY__c, Salary_Wages_Spouse_O4_CY__c, Salary_Wages_Spouse_O5_CY__c, Salary_Wages_Spouse_O1_CY1__c, Salary_Wages_Spouse_O2_CY1__c, Salary_Wages_Spouse_O3_CY1__c, Salary_Wages_Spouse_O4_CY1__c, Salary_Wages_Spouse_O5_CY1__c, Salary_Wages_Spouse_O1_CY2__c, Salary_Wages_Spouse_O2_CY2__c, Salary_Wages_Spouse_O3_CY2__c, Salary_Wages_Spouse_O4_CY2__c, Salary_Wages_Spouse_O5_CY2__c, Salary_Wages_Spouse_O1_CY3__c, Salary_Wages_Spouse_O2_CY3__c, Salary_Wages_Spouse_O3_CY3__c, Salary_Wages_Spouse_O4_CY3__c, Salary_Wages_Spouse_O5_CY3__c, Sch_D_Capital_gainslosses_O1_CY__c, Sch_D_Capital_gainslosses_O2_CY__c, Sch_D_Capital_gainslosses_O3_CY__c, Sch_D_Capital_gainslosses_O4_CY__c, Sch_D_Capital_gainslosses_O5_CY__c, Sch_D_Capital_gainslosses_O1_CY1__c, Sch_D_Capital_gainslosses_O2_CY1__c, Sch_D_Capital_gainslosses_O3_CY1__c, Sch_D_Capital_gainslosses_O4_CY1__c, Sch_D_Capital_gainslosses_O5_CY1__c, Sch_D_Capital_gainslosses_O1_CY2__c, Sch_D_Capital_gainslosses_O2_CY2__c, Sch_D_Capital_gainslosses_O3_CY2__c, Sch_D_Capital_gainslosses_O4_CY2__c, Sch_D_Capital_gainslosses_O5_CY2__c, Sch_D_Capital_gainslosses_O1_CY3__c, Sch_D_Capital_gainslosses_O2_CY3__c, Sch_D_Capital_gainslosses_O3_CY3__c, Sch_D_Capital_gainslosses_O4_CY3__c, Schedule_C_Income_O1_CY__c, Schedule_C_Income_O2_CY__c, Sch_D_Capital_gainslosses_O5_CY3__c, Schedule_C_Income_O3_CY__c, Schedule_C_Income_O4_CY__c, Schedule_C_Income_O5_CY__c, Schedule_C_Income_O1_CY1__c, Schedule_C_Income_O2_CY1__c, Schedule_C_Income_O3_CY1__c, Schedule_C_Income_O4_CY1__c, Schedule_C_Income_O5_CY1__c, Schedule_C_Income_O1_CY2__c, Schedule_C_Income_O2_CY2__c, Schedule_C_Income_O3_CY2__c, Schedule_C_Income_O4_CY2__c, Schedule_C_Income_O5_CY2__c, Schedule_C_Income_O1_CY3__c, Schedule_C_Income_O2_CY3__c, Schedule_C_Income_O3_CY3__c, Schedule_C_Income_O4_CY3__c, Schedule_C_Income_O5_CY3__c, Schedule_E_Rental_O1_CY__c, Schedule_E_Rental_O2_CY__c, Schedule_E_Rental_O3_CY__c, Schedule_E_Rental_O4_CY__c, Schedule_E_Rental_O5_CY__c, Schedule_E_Rental_O1_CY1__c, Schedule_E_Rental_O2_CY1__c, Schedule_E_Rental_O3_CY1__c, Schedule_E_Rental_O4_CY1__c, Schedule_E_Rental_O5_CY1__c, Schedule_E_Rental_O1_CY2__c, Schedule_E_Rental_O2_CY2__c, Schedule_E_Rental_O3_CY2__c, Schedule_E_Rental_O4_CY2__c, Schedule_E_Rental_O5_CY2__c, Schedule_E_Rental_O1_CY3__c, Schedule_E_Rental_O2_CY3__c, Schedule_E_Rental_O3_CY3__c, Schedule_E_Rental_O4_CY3__c, Schedule_E_Rental_O5_CY3__c, Other_Income_O2_CY3__c, Other_Income_O1CY3__c, Other_GuaranteedwagesaffiliatesO1CY1__c, Other_GuaranteedwagesaffiliatesO2CY1__c, Other_GuaranteedwagesaffiliatesO3CY1__c, Other_GuaranteedwagesaffiliatesO4CY1__c, Other_GuaranteedwagesaffiliatesO5CY1__c, Other_GuaranteedwagesaffiliatesO1CY2__c, Other_GuaranteedwagesaffiliatesO2CY2__c, Other_GuaranteedwagesaffiliatesO3CY2__c, Other_GuaranteedwagesaffiliatesO4CY2__c, Other_GuaranteedwagesaffiliatesO5CY2__c, Other_GuaranteedwagesaffiliatesO1CY3__c, Other_GuaranteedwagesaffiliatesO2CY3__c, Other_GuaranteedwagesaffiliatesO3CY3__c, Other_GuaranteedwagesaffiliatesO4CY3__c, Other_GuaranteedwagesaffiliatesO5CY3__c, Lead__c FROM Quick_Cash_Flow__c where lead__r.id=:leadID ];
        if (response.getStatusCode() == 200 || Test.isRunningTest()) {
            JSONParser parser = JSON.createParser(response.getBody()); 
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() =='accessToken' || Test.isRunningTest())){
                    parser.nextToken();
                    accessToken= parser.getText();
                    system.debug('accessTokenaccessToken'+accessToken);
                }
            }
        }
        Integer CY = Date.Today().Year();
        Integer CY_1 = (CY-1);
        Integer CY_2 = (CY-2);
        Integer CY_3 = (CY-3);
        if(ConvertedLead != null )
        {
            if( lstQuick_Cash_Flow != null && lstQuick_Cash_Flow.size() > 0 )
            {
                if(CY != null )
                {
                    QuickCashFlowDetailsDtos objFirstYear = new QuickCashFlowDetailsDtos();
                    objFirstYear.year = Integer.valueOf(CY);
                    objFirstYear.months = Integer.valueOf(lstQuick_Cash_Flow[0].Months_CY__c);
                    objFirstYear.sales = lstQuick_Cash_Flow[0].Sales_CY__c;
                    objFirstYear.netProfit = lstQuick_Cash_Flow[0].Net_Profit_CY__c;
                    objFirstYear.depreciationAmortizationDepletion = lstQuick_Cash_Flow[0].New_Rents_CY__c;
                    objFirstYear.interestExpense = lstQuick_Cash_Flow[0].Interest_Exp_CY__c;
                    objFirstYear.nonRecurringExpense = lstQuick_Cash_Flow[0].Non_Recurring_Expenses_CY__c;
                    
                    lstQuickCashFlowDetailsDtos.add(objFirstYear);
                    
                }
                if(CY_1 != null)
                {
                    QuickCashFlowDetailsDtos objSecondYear = new QuickCashFlowDetailsDtos();
                    objSecondYear.year = Integer.valueOf(CY_1);
                    objSecondYear.months = Integer.valueOf(lstQuick_Cash_Flow[0].Months_CY1__c);
                    objSecondYear.sales = lstQuick_Cash_Flow[0].Sales_CY1__c;
                    objSecondYear.netProfit = lstQuick_Cash_Flow[0].Net_Profit_CY1__c;
                    objSecondYear.depreciationAmortizationDepletion = lstQuick_Cash_Flow[0].New_Rents_CY1__c;
                    objSecondYear.interestExpense = lstQuick_Cash_Flow[0].Interest_Exp_CY1__c;
                    objSecondYear.nonRecurringExpense = lstQuick_Cash_Flow[0].Non_Recurring_Expenses_CY1__c;
                    
                    lstQuickCashFlowDetailsDtos.add(objSecondYear);
                }
                if(CY_2 != null)
                {
                    QuickCashFlowDetailsDtos objThirdYear = new QuickCashFlowDetailsDtos();
                    objThirdYear.year = Integer.valueOf(CY_2);
                    objThirdYear.months = Integer.valueOf(lstQuick_Cash_Flow[0].Months_CY2__c);
                    objThirdYear.sales = lstQuick_Cash_Flow[0].Sales_CY2__c;
                    objThirdYear.netProfit = lstQuick_Cash_Flow[0].Net_Profit_CY2__c;
                    objThirdYear.depreciationAmortizationDepletion = lstQuick_Cash_Flow[0].New_Rents_CY2__c;
                    objThirdYear.interestExpense = lstQuick_Cash_Flow[0].Interest_Exp_CY2__c;
                    objThirdYear.nonRecurringExpense = lstQuick_Cash_Flow[0].Non_Recurring_Expenses_CY2__c;
                    
                    lstQuickCashFlowDetailsDtos.add(objThirdYear);
                }
                if(CY_3 != null)
                {
                    QuickCashFlowDetailsDtos objFourthYear = new QuickCashFlowDetailsDtos();
                    objFourthYear.year = Integer.valueOf(CY_3);
                    objFourthYear.months = Integer.valueOf(lstQuick_Cash_Flow[0].Months_CY3__c);
                    objFourthYear.sales = lstQuick_Cash_Flow[0].Sales_CY3__c;
                    objFourthYear.netProfit = lstQuick_Cash_Flow[0].Net_Profit_CY3__c;
                    objFourthYear.depreciationAmortizationDepletion = lstQuick_Cash_Flow[0].New_Rents_CY3__c;
                    objFourthYear.interestExpense = lstQuick_Cash_Flow[0].Interest_Exp_CY3__c;
                    objFourthYear.nonRecurringExpense = lstQuick_Cash_Flow[0].Non_Recurring_Expenses_CY3__c;
                    
                    lstQuickCashFlowDetailsDtos.add(objFourthYear);
                }
            }
            if(ConvertedLead != null )
            {
                WrapperLead.application_id = ConvertedLead.Application_ID__c;
                if( ConvertedLead.SBSS_SCORE__c != null ){
                    string SBA_ApplicationNumber = String.valueof(ConvertedLead.SBSS_SCORE__c.trim()).replaceAll('-','');
                    WrapperLead.SBA_ApplicationNumber= long.valueof(SBA_ApplicationNumber);
                }
                if( ConvertedLead.recordType.Name == 'Lendistry Lending' )  
                {
                    if( ConvertedLead.Has_your_PPP_loan_been_forgiven__c != null )
                        WrapperLead.isPPPLoanForgiven=ConvertedLead.Has_your_PPP_loan_been_forgiven__c;
                    if( ConvertedLead.Do_you_have_any_other_outstanding_liens__c != null )
                        WrapperLead.isOutstandingLiens=ConvertedLead.Do_you_have_any_other_outstanding_liens__c;
                    if( ConvertedLead.Have_you_filed_for_bankruptcy__c != null )
                        WrapperLead.isBankruptsyFiled=ConvertedLead.Have_you_filed_for_bankruptcy__c;
                    if(ConvertedLead.PPP_AMOUNT_RECEIVED__c != null )
                        WrapperLead.pppAmountRcvd=ConvertedLead.PPP_AMOUNT_RECEIVED__c;
                    if(ConvertedLead.EIDL_AMOUNT_RECEIVED__c != null )
                        WrapperLead.eidlAmountRcvd=ConvertedLead.EIDL_AMOUNT_RECEIVED__c;
                }    
                if( ConvertedLead.NAICS_CODE__c != null )
                    WrapperLead.NAICSCode = String.valueof(ConvertedLead.NAICS_CODE__c);
                if( ConvertedLead.SBA_Application_Approval__c != null){
                    string SBALoanNumber = String.valueof(ConvertedLead.SBA_Application_Approval__c.trim()).replaceAll('-',''); 
                    WrapperLead.SBALoanNumber = long.valueof(SBALoanNumber);
                    
                }
                
                if( ConvertedLead.Loan_Type__c == 'PA CARES' || ConvertedLead.Loan_Type__c == 'YoCo STRONG'){
                    if(ConvertedLead.Will_this_grant_create_new_jobs__c != null)
                        WrapperLead.Willthisloancreatemorejobs = ConvertedLead.Will_this_grant_create_new_jobs__c == 'Yes'? true:false;
                }
                if(ConvertedLead.Loan_Type__c == 'NYR' )
                {
                    WrapperLead.Willthisloancreatemorejobs = ConvertedLead.Was_Your_Business_Profitable_In_2019__c == 'Yes'? true:false;
                }
                else if(ConvertedLead.Will_this_loan_create_more_Jobs__c != null && ConvertedLead.Loan_Type__c != 'PA CARES' && ConvertedLead.Loan_Type__c != 'YoCo STRONG' && ConvertedLead.Loan_Type__c != 'NYR' ){
                        WrapperLead.Willthisloancreatemorejobs = ConvertedLead.Will_this_loan_create_more_Jobs__c == 'Yes'? true:false;
                }  
                    
                    if( ConvertedLead.Loan_Type__c == 'PA CARES' || ConvertedLead.Loan_Type__c == 'YoCo STRONG'){
                        if(ConvertedLead.Purpose_of_Grant__c != null)
                        WrapperLead.Purposeofloan = ConvertedLead.Purpose_of_Grant__c;
                    }
                    else{
                        if(ConvertedLead.Purpose_of_the_loan__c != null)
                        WrapperLead.Purposeofloan = ConvertedLead.Purpose_of_the_loan__c;
                    }  
                    
                WrapperLead.Do_50percentemployeeEarnLess =ConvertedLead.Do_50_of_empl_earn_less_than_51859__c;
                WrapperLead.scholar_Alumini =ConvertedLead.X0KSB_Scholar_Alumni__c;
                
                WrapperLead.business_id =  ConvertedLead.BusinessId__c != null?ConvertedLead.BusinessId__c:ConvertedLead.Business_ID_SBAPPP__c; 
                WrapperLead.Opportunity_Id = ConvertedLead.ConvertedOpportunityId;
                WrapperLead.Lead_Id = ConvertedLead.id;
                WrapperLead.corporate_name = ConvertedLead.Company;
                WrapperLead.business_address = ConvertedLead.Street;
                WrapperLead.business_state_id = ConvertedLead.State;
                 // added by saurabh kumar on 17 Nov 2020 for Pincode 
                String bussZipCode =  ConvertedLead.postalCode;
                if(bussZipCode !=null && bussZipCode.contains('-')){
                    bussZipCode = bussZipCode.replaceall('-','');
                    bussZipCode = bussZipCode.substring(0,5);
                    WrapperLead.business_zipcode = bussZipCode;
                }
                else
                    WrapperLead.business_zipcode = ConvertedLead.postalCode;
                //END
               // WrapperLead.business_zipcode = ConvertedLead.postalCode;
                WrapperLead.business_country = ConvertedLead.Country;
                WrapperLead.business_city = ConvertedLead.city;
                WrapperLead.Phone= String.valueof(ConvertedLead.Business_Phone__c);
                
                 if( ConvertedLead.recordType.Name == 'Lendistry Lending' )  
                    WrapperLead.number_of_employees = String.valueof(ConvertedLead.of_Current_Employees__c);
                else
                    WrapperLead.number_of_employees = String.valueof(ConvertedLead.NumberOfEmployees);
                    
                WrapperLead.website_url = ConvertedLead.Website;
                WrapperLead.campaign = ConvertedLead.Campaign_Source__c;
                WrapperLead.system_identifier = ConvertedLead.Id;
                WrapperLead.lead_status = ConvertedLead.Status;
                WrapperLead.lead_type = ConvertedLead.LeadSource;
                WrapperLead.is_home_owner = ConvertedLead.Homeowner__c == 'Yes'?'true':'false';
                WrapperLead.is_disabled = ConvertedLead.Disabled__c == 'Yes'?'true':'false';
                WrapperLead.ethnicity= ConvertedLead.Ethnicity__c;
                WrapperLead.race= ConvertedLead.Race__c;
                WrapperLead.is_veteran = ConvertedLead.Veteran__c == 'Yes'?'true':'false';
                WrapperLead.is_women_owned = ConvertedLead.Women_Owned__c == 'Yes'?'true':'false';
                WrapperLead.amount_requested = string.valueof(ConvertedLead.Requested_Amount__c);
                WrapperLead.business_duration = ConvertedLead.TIB_Months__c;
                WrapperLead.email = ConvertedLead.Email;
                WrapperLead.of_employees_added_in_next_12_months = ConvertedLead.of_employees_added_in_next_12_months__c;
                WrapperLead.of_customer_served_monthly = ConvertedLead.of_customer_served_monthly__c;
                WrapperLead.net_worth = string.valueof(ConvertedLead.Net_Worth__c);
                WrapperLead.loan_number = ConvertedOpp.Loan__c;
                //WrapperLead.interest_type = ConvertedOpp.Interest_Type__c;
                WrapperLead.sales_decline_reason = ConvertedOpp.Sales_Decline__c;
                WrapperLead.loan_type = ConvertedOpp.Loan_Type__c;
                WrapperLead.processing_fee = string.valueof(ConvertedOpp.Processing_Packaging_Fee__c);
                WrapperLead.origination_fee = ConvertedOpp.Origination_Fee__c;
                WrapperLead.referral_part_fee = ConvertedOpp.Partner_Referral_Fee__c;
                WrapperLead.referral_source = ConvertedOpp.Referral_Source__c;
                WrapperLead.What_your_customer_base = ConvertedLead.Who_is_Your_Customer_Base1__c;
                WrapperLead.What_does_your_Business_do = ConvertedLead.What_does_your_Business_do__c;
                WrapperLead.What_type_of_Business_is_it = ConvertedLead.What_type_of_Business_is_it__c;
                // Added by Rahul 08/11/2019
                WrapperLead.Tell_us_more = ConvertedLead.Tell_us_more__c;
                // ISQ Section Fields  
                WrapperLead.BriefHistoryontheowner = ConvertedLead.Brief_History_on_the_owner_manager__c;  
                WrapperLead.Whatexactlydoesthebusinessdo = ConvertedLead.What_exactly_does_the_business_do__c;  
                WrapperLead.Whoisyourcustomerbase = ConvertedLead.Who_is_your_customer_base__c;  
                WrapperLead.DoYouCarryLifeInsurance = ConvertedLead.Do_You_Carry_Life_Insurance__c;  
                WrapperLead.PlannedChangesInNext6Months = ConvertedLead.Planned_Changes_In_Next_6_Months__c;  
                WrapperLead.BriefHistoryonthebusiness = ConvertedLead.Brief_History_on_the_business__c;  
                WrapperLead.Whatarethetermsofyourcurrentlease = ConvertedLead.What_are_the_terms_of_your_current_lease__c;                
                WrapperLead.Whatisthepurposeofloan = ConvertedLead.What_is_the_purpose_of_loan__c; 
                WrapperLead.AreyouCOD306090 = ConvertedLead.Are_you_COD_30_60_90__c;  
                WrapperLead.Doyoupaychildsupportoralimony = ConvertedLead.Do_you_pay_child_support_or_alimony__c;  
                WrapperLead.ExplanationofanyBKsdefaultsetc = ConvertedLead.Explanation_of_any_BKs_defaults_etc__c;
                /******************************************************************************************************
                            Added  by saurabh Kumar on 25 jan2021
                *****************************************************************************************************/
                WrapperLead.Have_you_had_a_25_revenue_drop_between = ConvertedLead.Have_you_had_a_25_revenue_drop_between__c;
                WrapperLead.Who_originated_your_PPP_loan = ConvertedLead.Who_originated_your_PPP_loan__c;
                WrapperLead.Did_you_obtain_a_PPP_loan_in_2020 = ConvertedLead.Did_you_obtain_a_PPP_loan_in_2020__c;
                WrapperLead.Did_you_receive_a_Shuttered_Venue_Operat = ConvertedLead.Did_you_receive_a_Shuttered_Venue_Operat__c;
                WrapperLead.PPP_First_Draw_SBA_Loan_Number = ConvertedLead.PPP_First_Draw_SBA_Loan_Number__c;
                WrapperLead.PPP_First_Draw_Loan_Amount = ConvertedLead.PPP_First_Draw_Loan_Amount__c;
                WrapperLead.networkSelection = ConvertedLead.Network_Selection__c;
                WrapperLead.Period_2_Revenue = ConvertedLead.Period_2_Revenue__c;
                WrapperLead.Period_1_Revenue = ConvertedLead.Period_1_Revenue__c;
                WrapperLead.Last_Years_Period = ConvertedLead.Last_Year_s_Period__c;
                WrapperLead.Proof_of_25_revenue_drop_2020  = ConvertedLead.Proof_of_25_revenue_drop_2020__c;
                WrapperLead.Refinance_of_Eligible_Economic_Injury_Di= ConvertedLead.Refinance_of_Eligible_Economic_Injury_Di__c;
                WrapperLead.Economic_Injury_Disaster_Loan_Number = ConvertedLead.Economic_Injury_Disaster_Loan_Number__c;
                WrapperLead.Tax_Year_Used = ConvertedLead.Tax_Year__c;
                WrapperLead.SBA_PPP_Loan_Application_Form = ConvertedLead.SBA_PPP_Loan_Application_Form__c;
                WrapperLead.CurrentSBAEconomicDisasterInjuryLoanBalance = ConvertedLead.Curr_SBA_Econ_Disaster_Injury_Loan_Bal__c;
                //===========================NYG=====================================
                if(ConvertedLead.Tenant_Referral_Partner_Name__c !=null && ConvertedLead.Tenant_Referral_Partner_Name__c !='')
                    WrapperLead.TenantReferralPartnerName = ConvertedLead.Tenant_Referral_Partner_Name__c;
                if(ConvertedLead.Preferred_Language__c !=null && ConvertedLead.Preferred_Language__c !='')
                    WrapperLead.PreferredLanguage = ConvertedLead.Preferred_Language__c;
                 if( ConvertedLead.Minority_Business_Owned__c != null && ConvertedLead.Loan_Type__c == 'NYR' )
                    WrapperLead.Rural = ConvertedLead.Minority_Business_Owned__c ;
                 else if( ConvertedLead.Rural__c != null && ConvertedLead.Loan_Type__c != 'NYR')
                       WrapperLead.Rural = ConvertedLead.Rural__c;
                //===========================NYG=====================================
                
                if(String.isNotBlank(String.valueOf(ConvertedLead.How_did_you_hear_about_us__c)))
                WrapperLead.howDidYouHearAboutUs = ConvertedLead.How_did_you_hear_about_us__c;
                
                if(String.isNotBlank(String.valueOf(ConvertedLead.Business_Stage__c)))
                WrapperLead.businessStageName = ConvertedLead.Business_Stage__c;
                
                if(String.isNotBlank(String.valueOf(ConvertedLead.Business_Borough__c)))
                WrapperLead.businessBoroughName = ConvertedLead.Business_Borough__c;
                
                if(String.isNotBlank(String.valueOf(ConvertedLead.Location_Type__c)))
                WrapperLead.locationTypeName = ConvertedLead.Location_Type__c;
                
                if(String.isNotBlank(String.valueOf(ConvertedLead.of_Employees_Temporary_Full_Time_2020__c)))
                WrapperLead.numberOfTempFullTimeEmployees = String.valueOf(ConvertedLead.of_Employees_Temporary_Full_Time_2020__c);
                
                if(String.isNotBlank(String.valueOf(ConvertedLead.of_Employees_Temporary_Part_Time_2020__c)))
                WrapperLead.numberOfTempPartTimeEmployees = String.valueOf(ConvertedLead.of_Employees_Temporary_Part_Time_2020__c);
               
               if(String.isNotBlank(String.valueOf(ConvertedLead.Have_you_exhausted_all_personal_non_SB__c))) 
                WrapperLead.Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins =  ConvertedLead.Have_you_exhausted_all_personal_non_SB__c == 'Yes'? true:false;
               if(String.isNotBlank(String.valueOf(ConvertedLead.Does_the_Business_have_existing_SBA_Debt__c)))
                WrapperLead.DoestheBusinesshaveexistingSBADebt = ConvertedLead.Does_the_Business_have_existing_SBA_Debt__c == 'Yes'? true:false;
                
                
                /********************END*********************************************************************************/
                
                if(ConvertedLead.Owner_ID_Owner_1__c != null && ConvertedLead.Owner_ID_Owner_1__c != '')
                {
                    wrapper obj1 = new wrapper();
                    obj1.owner_id = ConvertedLead.Owner_ID_Owner_1__c;
                    obj1.ownerCity = ConvertedLead.City_Owner_1__c;
                    if( (ConvertedLead.of_Ownership_Owner__c == null ||  ConvertedLead.of_Ownership_Owner__c == 0 ) && ConvertedLead.recordType.Name=='SBA - PPP' )
                    obj1.owner_percentage = '100';
                    else
                    obj1.owner_percentage = string.valueof(ConvertedLead.of_Ownership_Owner__c);
                    obj1.ownerCellChone_no = ConvertedLead.MobilePhone;
                    Obj1.owner_home_phone_no = ConvertedLead.Phone;
                    if( ConvertedLead.DOB_Owner_1__c != null )
                    {
                        Date d = ConvertedLead.DOB_Owner_1__c;
                        String dt = DateTime.newInstance(d.year(),d.month(),d.day()).format('MM/dd/yyy');
                        Obj1.owner_dob = dt;
                    }
                    
                    obj1.owner_first_name = ConvertedLead.FirstName;
                    obj1.owner_last_name = ConvertedLead.LastName;
                    obj1.owner_email = ConvertedLead.Email;
                    // added by saurabh kumar on 17 Nov 2020 for Pincode 
                    String owner1ZipCode =  ConvertedLead.Zip_Code_Owner_1__c;
                    if(owner1ZipCode !=null && owner1ZipCode.contains('-')){
                        owner1ZipCode = owner1ZipCode.replaceall('-','');
                        owner1ZipCode = owner1ZipCode.substring(0,5);
                        obj1.Owner_zipcode = owner1ZipCode;
                    }
                    else
                        obj1.Owner_zipcode = ConvertedLead.Zip_Code_Owner_1__c;
                    //END
                    //obj1.Owner_zipcode = ConvertedLead.PostalCode;
                    obj1.owner_state_id = ConvertedLead.State_Owner_1__c;
                    obj1.owner_title = ConvertedLead.Title;
                    obj1.highest_credit_score = null;
                    obj1.owner_SSN = ConvertedLead.SSN1__c;
                    obj1.owner_rent = ConvertedLead.Owner_Rent_1__c;
                    obj1.isPrimaryContact = true;
                    obj1.CreditScorefromWebform = string.valueof(ConvertedLead.Credit_Score__c);
                    obj1.owner_home_address = ConvertedLead.Street_Owner_1__c;
                    
                    
                    lstOfOwnersWrapper.add(obj1);
                }
                if( ConvertedLead.Owner_ID_Owner_2__c != null && ConvertedLead.Owner_ID_Owner_2__c != '')
                {
                    wrapper obj2 = new wrapper();
                    obj2.owner_id = ConvertedLead.Owner_ID_Owner_2__c;
                    obj2.ownerCity = ConvertedLead.City_Owner_2__c;
                    obj2.owner_percentage = string.valueof(ConvertedLead.of_Ownership_Second_Owner__c);
                    obj2.ownerCellChone_no = ConvertedLead.Mobile_2nd_Owner__c;
                    obj2.owner_first_name = ConvertedLead.First_Name_2nd_Owner__c;
                    obj2.owner_last_name = ConvertedLead.Last_Name_2nd_Owner__c;
                    obj2.owner_email = ConvertedLead.Email_2nd_Owner__c;
                    //obj2.Owner_zipcode = ConvertedLead.Zip_Code_Owner_2__c;
                    // added by saurabh kumar on 17 Nov 2020 for Pincode 
                   
                    String owner2ZipCode =  ConvertedLead.Zip_Code_Owner_2__c;
                    if(owner2ZipCode !=null && owner2ZipCode.contains('-')){
                        owner2ZipCode = owner2ZipCode.replaceall('-','');
                        owner2ZipCode = owner2ZipCode.substring(0,5);
                        obj2.Owner_zipcode = owner2ZipCode;
                    }
                    else
                        obj2.Owner_zipcode = ConvertedLead.Zip_Code_Owner_2__c;
                    //END
                    obj2.owner_state_id = ConvertedLead.State_Owner_2__c;
                    obj2.owner_title = ConvertedLead.Title_2nd_Owner__c;
                    obj2.highest_credit_score = null;
                    obj2.owner_SSN = ConvertedLead.SSN2__c;
                    obj2.owner_rent = ConvertedLead.Owner_Rent_2__c;
                    obj2.isPrimaryContact = false;
                    Obj2.owner_home_phone_no = ConvertedLead.Phone_2nd_Owner__c;
                    if( ConvertedLead.DOB_Owner_2__c != null ){
                    Date d = ConvertedLead.DOB_Owner_2__c;
                    String dt = DateTime.newInstance(d.year(),d.month(),d.day()).format('MM/dd/yyy');
                    Obj2.owner_dob = dt;
                }
                    obj2.owner_home_address = ConvertedLead.Street_Owner_2__c;
                    lstOfOwnersWrapper.add(obj2);
                    
                }
                if( ConvertedLead.Owner_ID_Owner_3__c != null && ConvertedLead.Owner_ID_Owner_3__c != '' )
                {
                    wrapper obj3 = new wrapper();
                    obj3.owner_id = ConvertedLead.Owner_ID_Owner_3__c;
                    obj3.ownerCity = ConvertedLead.City_Owner_3__c;
                    obj3.owner_percentage = string.valueof(ConvertedLead.of_Ownership_3rd_Owner__c);
                    obj3.ownerCellChone_no = ConvertedLead.Mobile_3rd_Owner__c;
                    obj3.ownerCellChone_no = ConvertedLead.Mobile_2nd_Owner__c;
                    obj3.owner_first_name = ConvertedLead.First_Name_3rd_Owner__c;
                    obj3.owner_last_name = ConvertedLead.Last_Name_3rd_Owner__c;
                    obj3.owner_email = ConvertedLead.Email_3rd_Owner__c;
                     // added by saurabh kumar on 17 Nov 2020 for Pincode
                    String owner3ZipCode =  ConvertedLead.Zip_Code_Owner_3__c;
                    if(owner3ZipCode !=null && owner3ZipCode.contains('-')){
                        owner3ZipCode = owner3ZipCode.replaceall('-','');
                        owner3ZipCode = owner3ZipCode.substring(0,5);
                        obj3.Owner_zipcode = owner3ZipCode;
                    }
                    else
                    obj3.Owner_zipcode = ConvertedLead.Zip_Code_Owner_3__c;
                    obj3.owner_state_id = ConvertedLead.State_Owner_3__c;
                    obj3.owner_title = ConvertedLead.Title_3rd_Owner__c;
                    obj3.highest_credit_score = null;
                    obj3.owner_SSN = ConvertedLead.SSN_3rd_Owner__c;
                    obj3.owner_rent = ConvertedLead.Owner_Rent_3__c;
                    obj3.isPrimaryContact = false;
                    obj3.owner_home_phone_no = ConvertedLead.Phone_3rd_Owner__c;
                    if( ConvertedLead.DOB_Owner_3__c != null)
                    {
                        Date d = ConvertedLead.DOB_Owner_3__c;
                        String dt = DateTime.newInstance(d.year(),d.month(),d.day()).format('MM/dd/yyy');
                        Obj3.owner_dob = dt;
                    }
                    obj3.owner_home_address = ConvertedLead.Street_Owner_3__c;
                    lstOfOwnersWrapper.add(obj3);
                    
                }
                if(  ConvertedLead.Owner_ID_Owner_4__c != null && ConvertedLead.Owner_ID_Owner_4__c != '' )
                {
                    wrapper obj4 = new wrapper();
                    obj4.owner_id = ConvertedLead.Owner_ID_Owner_4__c;
                    obj4.ownerCity = ConvertedLead.City_Owner_4__c;
                    obj4.owner_percentage = string.valueof(ConvertedLead.of_Ownership_4th_Owner__c);
                    obj4.ownerCellChone_no = ConvertedLead.Mobile_4th_Owner__c;
                    obj4.owner_first_name = ConvertedLead.First_Name_4th_Owner__c;
                    obj4.owner_last_name = ConvertedLead.Last_Name_4th_Owner__c;
                    obj4.owner_email = ConvertedLead.Email_4th_Owner__c;
                     // added by saurabh kumar on 17 Nov 2020 for Pincode
                    String owner4ZipCode =  ConvertedLead.Zip_Code_Owner_4__c;
                    if(owner4ZipCode !=null && owner4ZipCode.contains('-')){
                        owner4ZipCode = owner4ZipCode.replaceall('-','');
                        owner4ZipCode = owner4ZipCode.substring(0,5);
                        obj4.Owner_zipcode = owner4ZipCode;
                    }
                    else
                    obj4.Owner_zipcode = ConvertedLead.Zip_Code_Owner_4__c;
                    obj4.owner_state_id = ConvertedLead.State_Owner_4__c;
                    obj4.owner_title = ConvertedLead.Title_4th_Owner__c;
                    obj4.highest_credit_score = null;
                    obj4.owner_SSN = ConvertedLead.SSN_4th_Owner__c;
                    obj4.owner_rent = ConvertedLead.Owner_Rent_4__c;
                    obj4.isPrimaryContact = false;
                    obj4.owner_home_phone_no = ConvertedLead.Phone_4th_Owner__c;
                    if( ConvertedLead.DOB_Owner_4__c != null ) 
                    {
                         Date d = ConvertedLead.DOB_Owner_4__c;
                         String dt = DateTime.newInstance(d.year(),d.month(),d.day()).format('MM/dd/yyy');
                         Obj4.owner_dob = dt;
                    }
                    obj4.owner_home_address = ConvertedLead.Street_Owner_4__c;
                    lstOfOwnersWrapper.add(obj4);
                    
                }
                if( ConvertedLead.Owner_ID_Owner_5__c != null && ConvertedLead.Owner_ID_Owner_5__c != ''  )
                {
                    wrapper obj5 = new wrapper();
                    obj5.owner_id = ConvertedLead.Owner_ID_Owner_5__c;
                    obj5.ownerCity = ConvertedLead.City_Owner_5__c;
                    obj5.owner_percentage = string.valueof(ConvertedLead.of_Ownership_5th_Owner__c);
                    obj5.ownerCellChone_no = ConvertedLead.Mobile_5th_Owner__c;
                    obj5.owner_first_name = ConvertedLead.First_Name_5th_Owner__c;
                    obj5.owner_last_name = ConvertedLead.Last_Name_5th_Owner__c;
                    obj5.owner_email = ConvertedLead.Email_5th_Owner__c;
                     // added by saurabh kumar on 17 Nov 2020 for Pincode
                    String owner5ZipCode =  ConvertedLead.Zip_Code_Owner_5__c;
                    if(owner5ZipCode !=null && owner5ZipCode.contains('-')){
                        owner5ZipCode = owner5ZipCode.replaceall('-','');
                        owner5ZipCode = owner5ZipCode.substring(0,5);
                        obj5.Owner_zipcode = owner5ZipCode;
                    }
                    else
                    obj5.Owner_zipcode = ConvertedLead.Zip_Code_Owner_5__c;
                    obj5.owner_state_id = ConvertedLead.State_Owner_5__c;
                    obj5.owner_title = ConvertedLead.Title_5th_Owner__c;
                    obj5.highest_credit_score = null;
                    obj5.owner_SSN = ConvertedLead.SSN_5th_Owner__c;
                    obj5.owner_rent = ConvertedLead.Owner_Rent_5__c;
                    obj5.isPrimaryContact = false;
                    Obj5.owner_home_phone_no = ConvertedLead.Phone_5th_Owner__c;
                    if( ConvertedLead.DOB_Owner_5__c !=  null )
                    {
                        Date d = ConvertedLead.DOB_Owner_5__c;
                        String dt = DateTime.newInstance(d.year(),d.month(),d.day()).format('MM/dd/yyy');
                        system.debug('--------dt---------->'+dt);
                        Obj5.owner_dob = dt;
                    }   
                    obj5.owner_home_address = ConvertedLead.Street_Owner_5__c;
                    lstOfOwnersWrapper.add(obj5);
                }
                WrapperLead.ownerInfoList= lstOfOwnersWrapper;
                WrapperLead.quickCashFlowDetailsDtos =  lstQuickCashFlowDetailsDtos;
            }
            system.debug('*****lstOfOwnersWrapper****>>'+ JSON.serialize(lstOfOwnersWrapper));
            //*********************** Calling Java API *************************************
            if( accessToken != null && accessToken != '' || Test.isRunningTest())
            {
                Http http1 = new Http();
                HttpRequest request1 = new HttpRequest();
                request1.setHeader('Authorization', accessToken);
                request1.setHeader('Content-Type', 'application/json');
                string endPointURL1 = PortalAPIEndPoint+System.Label.JavaPortalEndPointUrlOpp;
                system.debug('------Testing Prod2 Lead To Opp URL--->'+endPointURL1);
                request1.setEndpoint(endPointURL1);
                request1.setMethod('POST');                
                request1.setBody( JSON.serialize(WrapperLead) );
                request1.setTimeout(30000);

                HttpResponse response1 = http1.send(request1);
                //Inserting Request, Response and Response code into the custom object for error handling
                Portal_Integration_Response_Code__c  Portalobj1 = new  Portal_Integration_Response_Code__c ();
                Portalobj1.Request__c = request1.getBody();
                Portalobj1.Response__c = response1.getBody();
                Portalobj1.Business_Id__c = businessID;
                Portalobj1.Application_Id__c = ApplicationID;
                Portalobj1.Opportunity_Id__c = OpportuntiyConvertedID;
                Portalobj1.Lead_Id__c = LeadId;
                Portalobj1.Success_Error_Code__c = String.valueOf(response1.getStatusCode());
                // added by saurabh kumar on 27 november 2020
                Portalobj1.API_Name__c = 'JavaAPICallOut';
                Portalobj1.Method_Name__c = 'makeJavaPortalAPICall';
                //Portalobj1.Record need to discuss with JD
                lstOfExceptions.add(Portalobj1);
                 System.debug('response1response1'+response1);
                 if(Portalobj1.Response__c.contains('false') && response1.getStatusCode()==200)// send mail here
                   sendMailController.sendEmail(Portalobj1.Request__c, Portalobj1.Response__c,businessID,ApplicationID);
                
                // Parse the JSON response
                if (response1.getStatusCode() != 201) {
                    System.debug('The status code returned was not expected: ' +
                                 response1.getStatusCode() + ' ' + response1.getStatus());
                } else {
                    System.debug(response1.getBody());
                }
                
                
            } 
            system.debug('@@@lstOfExceptions'+lstOfExceptions);
            insert lstOfExceptions;  
        }
    }
    
    @future (callout=true)
    public static void makeJavaPortalFileAPICall(string portalEndPointUrl, string ownerId, string businessId, string parentid, string ApplicationID )
    {
        list<Portal_Integration_Response_Code__c > lstOfExceptions1 = new list< Portal_Integration_Response_Code__c >();
        system.debug('---ownerId--'+ownerId);
        system.debug('---parentid--'+parentid);
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        string endPointURL = portalEndPointUrl+System.Label.JavaPortalEndPointUrl;
        req.setEndpoint(endPointURL);
        string userName =  System.Label.JavaPortalUserName;
        string password = System.Label.JavaPortalPassword;
        req.setBody('{"username": "'+ System.Label.JavaPortalUserName+'","secure": "'+ System.Label.JavaPortalPassword+'"}');
        string strReqBody = '{"username": "'+ System.Label.JavaPortalUserName+'","secure": "'+ System.Label.JavaPortalPassword+'"}';
        string accessToken = '';
        Http http = new Http();
        HTTPResponse response = http.send(req);
        System.debug('Body ' + response.getBody());
        System.debug('Status ' + response.getStatus());
        System.debug('Status code ' + response.getStatusCode());
        
        // Inserting Request, Response and Response code into the custom object for error handling
        Portal_Integration_Response_Code__c  Portalobj2 = new  Portal_Integration_Response_Code__c ();
        Portalobj2.Request__c = strReqBody;
        Portalobj2.Response__c = parentid ;
        Portalobj2.Business_Id__c = businessID;
        Portalobj2.Application_Id__c = ApplicationID;
        Portalobj2.Opportunity_Id__c = '';
        Portalobj2.Lead_Id__c = parentid;
        Portalobj2.Success_Error_Code__c = String.valueOf(response.getStatusCode());
        lstOfExceptions1.add(Portalobj2);
        
        if (response.getStatusCode() == 200) {
            JSONParser parser = JSON.createParser(response.getBody()); 
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() =='accessToken' || Test.isRunningTest())){
                    parser.nextToken();
                    accessToken= parser.getText();
                }
            }
        }
        if( parentid != null && parentid != '')
        {
            
            list<creditchecker__Credit_Report__c> lstofCreditcheckerReportsData   = [ Select id,name, creditchecker__CoApplicants_SSN__c,creditchecker__Secured_Debt__c,creditchecker__Property_City__c,creditchecker__Requested_By__c,creditchecker__Total_Inquiry_Count__c,creditchecker__Total_Liability_Balance__c,creditchecker__CoApplicants_Date_Of_Birth__c,creditchecker__Total_Liability_PastDue__c,creditchecker__Credit_Bureau__c,creditchecker__Date_Ordered__c,creditchecker__Total_Score_Model__c,creditchecker__Property_StateCode__c,creditchecker__Property_Country__c,creditchecker__Applicants_Residency_Type__c,creditchecker__Current_City__c,creditchecker__X30_Days_PastDue__c,creditchecker__Current_Country__c,creditchecker__X60_Days_PastDue__c,creditchecker__CoApplicant_Current_City__c,creditchecker__Property_Line__c,creditchecker__Bankruptcy_Count__c,creditchecker__Current_Line__c,creditchecker__Lead__c,creditchecker__Applicants_Date_Of_Birth__c,creditchecker__Previous_City__c,creditchecker__CoApplicant_Current_Country__c,creditchecker__Previous_StateCode__c,creditchecker__Charge_Offs_Count__c,creditchecker__CoApplicants_Middle_Name__c,creditchecker__Average_Score__c,creditchecker__Contact__c,creditchecker__File__c,creditchecker__Total_Liability_Payment__c,creditchecker__Status__c,creditchecker__Unsecured_Debt__c,creditchecker__CoApplicant_Current_Line__c,creditchecker__Next_Run_Time__c,creditchecker__Previous_Country__c,creditchecker__Property_Zip_Code__c,creditchecker__Previous_Adverse_Count__c,creditchecker__Revolving_Credit_Utilization__c,creditchecker__Previous_Zip_Code__c,creditchecker__Report_Generated__c,creditchecker__Applicants_Email__c,creditchecker__Current_Zip_Code__c,creditchecker__X90_Days_PastDue__c,creditchecker__Oldest_Date__c,creditchecker__Status_Description__c,creditchecker__Applicants_First_Name__c,creditchecker__Applicants_Suffix__c,creditchecker__Total_High_Credit__c,creditchecker__Previous_Line__c,creditchecker__Current_StateCode__c,creditchecker__Date_Completed__c,creditchecker__CoApplicant_Current_Zip_Code__c,creditchecker__Applicants_Last_Name__c,creditchecker__Debt_High_Credit__c,creditchecker__Parent_Record_Id__c,creditchecker__CoApplicants_First_Name__c,creditchecker__Adverse_Alert__c,creditchecker__CoApplicants_Last_Name__c,creditchecker__Opportunity__c,creditchecker__Current_Adverse_Count__c,creditchecker__Score_Tier__c,creditchecker__Applicants_Middle_Name__c,creditchecker__Account__c,creditchecker__CoApplicants_Suffix__c,creditchecker__Disputes_Count__c,creditchecker__Applicants_SSN__c,creditchecker__Party_Name__c,creditchecker__Applicants_Phone__c,creditchecker__Collections_Count__c,creditchecker__CoApplicant_Current_StateCode__c,creditchecker__CoApplicants_Residency_Type__c,creditchecker__Most_Recent_Late__c,creditchecker__Public_Record_Count__c,creditchecker__Derogatory_Count__c,creditchecker__Use_Secondary_Account__c from creditchecker__Credit_Report__c Where Id=:parentid];
            list<creditchecker__Trade_Summary__c> lstofcreditcheckerTradeSummaryData = [ select id, Name,creditchecker__Balance__c,creditchecker__Payment__c,creditchecker__Credit_Report__c,creditchecker__Count__c,creditchecker__High_Credit__c,creditchecker__Past_Due__c,creditchecker__Type__c From creditchecker__Trade_Summary__c Where creditchecker__Credit_Report__c=:parentid];
            list<creditchecker__Tradeline__c> lstOfcreditcheckerTradelineData = [ Select id,  Name,creditchecker__Creditor_Address__c,creditchecker__Account_Balance_Date__c,creditchecker__Monthly_Payment_Amount__c,creditchecker__Past_Due__c,creditchecker__Payment_Pattern__c,creditchecker__Loan_Type__c,creditchecker__Charge_Off_Date__c,creditchecker__Months_Reviewed__c,creditchecker__Account_Status__c,creditchecker__Account_Type__c,creditchecker__Last_Payment_Date__c,creditchecker__Account_Identifier__c,creditchecker__Charge_Off_Amount__c,creditchecker__Collateral_Description__c,creditchecker__Date_Reported__c,creditchecker__Terms_Description__c,creditchecker__Payment_Pattern_Start_Date__c,creditchecker__Rating_Code__c,creditchecker__Creditor_Business_Type__c,creditchecker__Credit_Limit_Amount__c,creditchecker__Account_Closed_Date__c,creditchecker__Whose__c,creditchecker__X90__c,creditchecker__Ownership_Type__c,creditchecker__Composite_Key__c,creditchecker__Creditor__c,creditchecker__Date_Opened__c,creditchecker__Terms_Month__c,creditchecker__Credit_Bureau__c,creditchecker__Account_Paid_Date__c,creditchecker__Credit_Report__c,creditchecker__Balance__c,creditchecker__High_Balance_Amount__c,creditchecker__Derogatory_DataIndicator__c,creditchecker__Actual_Payment_Amount__c,creditchecker__Account_Status_Date__c,creditchecker__X60__c,creditchecker__Rating_Type__c,creditchecker__LastActivity_Date__c,creditchecker__X30__c from creditchecker__Tradeline__c Where creditchecker__Credit_Report__c=:parentid ];
            list<creditchecker__Public_Record__c> lstOfcreditcheckerPublicRecordData = [Select id, name, creditchecker__Derogatory_Data_Indicator__c,creditchecker__Credit_Report__c,creditchecker__Whose__c,creditchecker__Court_Name__c,creditchecker__Plaintiff_Name__c,creditchecker__Composite_Key__c,creditchecker__Docket_Identifier__c,creditchecker__Ownership_Type__c,creditchecker__Record_Type__c,creditchecker__Obligation_Amount__c,creditchecker__Manual_Update_Indicator__c,creditchecker__Record_Filed_Date__c,creditchecker__Disposition_Date__c,creditchecker__Other_Description__c,creditchecker__Disposition_Type__c from creditchecker__Public_Record__c Where creditchecker__Credit_Report__c=:parentid ];
            list<creditchecker__Credit_Inquiry__c> lstOfcreditcheckerInquiryData = [ Select Id, name, creditchecker__Composite_Key__c,creditchecker__Date__c,creditchecker__Whose__c,creditchecker__Creditor__c,creditchecker__Inquiry_Age__c,creditchecker__Credit_Report__c,creditchecker__Creditor_Business_Type__c,creditchecker__Credit_Bureau__c from creditchecker__Credit_Inquiry__c Where creditchecker__Credit_Report__c=:parentid]; 
            System.debug('parentid--'+parentid);
            Attachment[] eachAttach = [select id, Name, Body, ParentId  from Attachment where ParentId=:parentid ];
            system.debug('******eachAttach*****>>'+eachAttach);
            if( eachAttach!= null && eachAttach.size()>0 ) // || Test.isRunningTest() 
            {
                Blob file_body = eachAttach[0].Body;
                String file_name = eachAttach[0].Name;
                
                String auth_header = 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(username + ':' + password));
                
                String boundary = '----------------------------741e90d31eff';
                String header = '--' + boundary + '\n' +
                    'Content-Disposition: form-data; name="file"; filename="' + file_name + '";\n' +
                    'Content-Type: application/octet-stream';
                
                String footer = '--' + boundary + '--';
                String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header + '\r\n\r\n'));
                while (headerEncoded.endsWith('=')) {
                    header += ' ';
                    headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
                }
                
                String bodyEncoded = EncodingUtil.base64Encode(file_body);
                
                Blob bodyBlob = null;
                String last4Bytes = bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());
                
                if (last4Bytes.endsWith('==')) {
                    last4Bytes = last4Bytes.substring(0, 2) + '0K';
                    bodyEncoded = bodyEncoded.substring(0, bodyEncoded.length() - 4) + last4Bytes;
                    
                    String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                    bodyBlob = EncodingUtil.base64Decode(headerEncoded + bodyEncoded + footerEncoded);
                } else if (last4Bytes.endsWith('=')) {
                    last4Bytes = last4Bytes.substring(0, 3) + 'N';
                    bodyEncoded = bodyEncoded.substring(0, bodyEncoded.length() - 4) + last4Bytes;
                    footer = '\n' + footer;
                    String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                    bodyBlob = EncodingUtil.base64Decode(headerEncoded + bodyEncoded + footerEncoded);
                } else {
                    footer = '\r\n' + footer;
                    String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                    bodyBlob = EncodingUtil.base64Decode(headerEncoded + bodyEncoded + footerEncoded);
                }
                //*********************** Calling Java API *************************************
                if( accessToken != null && accessToken != '' )
                {
                    Http http1 = new Http();
                    HttpRequest request1 = new HttpRequest();
                    request1.setHeader('Authorization', accessToken);
                    request1.setHeader('Content-Type', 'application/json');
                    string endPointURLFile = portalEndPointUrl+System.Label.JavaPortalEndPointFileUpload;
                    request1.setEndpoint(endPointURLFile);
                    request1.setMethod('POST');
                    string pdfBytes = EncodingUtil.base64Encode(bodyBlob);
                    system.debug('---pdfBytes --->>'+pdfBytes );
                    
                    // Set the body as a JSON object
                    request1.setBody('{"file": "'+ pdfBytes +'","ownerId": "'+ ownerId +'","businessId": "'+ businessId +'","lstofcreditcheckerTradeSummaryData":'+ JSON.serialize(lstofcreditcheckerTradeSummaryData) +',"lstofCreditcheckerReportsData":'+ JSON.serialize(lstofCreditcheckerReportsData ) +', "lstOfcreditcheckerTradelineData":'+ JSON.serialize(lstOfcreditcheckerTradelineData) +', "lstOfcreditcheckerPublicRecordData":'+ JSON.serialize(lstOfcreditcheckerPublicRecordData) +', "lstOfcreditcheckerInquiry":'+ JSON.serialize(lstOfcreditcheckerInquiryData) +',"json": "TestJSON226"}');
                    //request1.setBody('{"file": "'+ pdfBytes +'","ownerId": "'+ ownerId +'","businessId": "'+ businessId +'","json": "TestJSON226"}');
                    string strReqBody1 = '{"file": "'+ pdfBytes +'","ownerId": "'+ ownerId +'","businessId": "'+ businessId +'","json": "TestJSON226"}';
                    system.debug('credit reports attachements call----->>'+'{"file": "'+ pdfBytes +'","ownerId": "'+ ownerId +'","businessId": "'+ businessId +'","json": "TestJSON226"}');
                    
                    HttpResponse response1 = http1.send(request1);
                    
                    // Inserting Request, Response and Response code into the custom object for error handling
                    Portal_Integration_Response_Code__c  Portalobj3 = new  Portal_Integration_Response_Code__c ();
                    Portalobj3.Request__c = eachAttach[0].id ;
                    Portalobj3.Business_Id__c = businessID;
                    Portalobj3.Application_Id__c = ApplicationID;
                    Portalobj3.Opportunity_Id__c = '';
                    Portalobj3.Credit_Report_ID__c = eachAttach[0].id;
                    Portalobj3.Response__c = eachAttach[0].id +'-------list of credit records----->>';//+'"creditcheckerTradeSummaryData":"'+ lstofcreditcheckerTradeSummaryData +'","creditcheckerReportsData":"'+ ObjCreditcheckerReportsData +'", "creditcheckerTradelineData":"'+ lstOfcreditcheckerTradelineData +'", "creditcheckerPublicRecordData":"'+ lstOfcreditcheckerPublicRecordData +'", "creditcheckerInquiryData":"'+ lstOfcreditcheckerInquiryData +'", "json": "TestJSON226"}';
                    Portalobj3.Success_Error_Code__c = String.valueOf(response1.getStatusCode());
                    lstOfExceptions1.add(Portalobj3);
                    
                    // Parse the JSON response
                    if (response1.getStatusCode() != 201) {
                        System.debug('The status code returned was not expected: ' +
                                     response1.getStatusCode() + ' ' + response1.getStatus());
                    } else {
                        System.debug(response1.getBody());
                    }
                }
            }
        }
        insert lstOfExceptions1;
        
    }
    
    //*************************************************************************Send The List Of Active Users To Java DB ****************************************************************************************
    @future (callout=true)
    public static void makeJavaPortalUserAPICall(String portalEndPoint)
    {
       system.debug('JavaPortalUserAPiBASEURL'+portalEndPoint);
        list<Portal_Integration_Response_Code__c > lstOfExceptions2 = new list< Portal_Integration_Response_Code__c >();
        list<wrapperUserData> lstOfActiveusers = new list<wrapperUserData>();
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        string endPointURL = portalEndPoint+ System.Label.JavaPortalEndPointUrl;
        system.debug('endPointURLendPointURL'+endPointURL);
        req.setEndpoint(endPointURL);
        string userName =  System.Label.JavaPortalUserName;
        string password = System.Label.JavaPortalPassword;
        req.setBody('{"username": "'+ System.Label.JavaPortalUserName+'","secure": "'+ System.Label.JavaPortalPassword+'"}');
        string strReqBody = '{"username": "'+ System.Label.JavaPortalUserName+'","secure": "'+ System.Label.JavaPortalPassword+'"}';
        string accessToken = '';
        Http http = new Http();
        HTTPResponse response = http.send(req);
        System.debug('Body ' + response.getBody());
        System.debug('Status ' + response.getStatus());
        System.debug('Status code ' + response.getStatusCode());
        
        // Inserting Request, Response and Response code into the custom object for error handling
        Portal_Integration_Response_Code__c  Portalobj4 = new  Portal_Integration_Response_Code__c ();
        Portalobj4.Request__c = strReqBody;
        Portalobj4.Response__c = response.getBody();
        Portalobj4.Success_Error_Code__c = String.valueOf(response.getStatusCode());
        lstOfExceptions2.add(Portalobj4);
        
        if (response.getStatusCode() == 200) {
            JSONParser parser = JSON.createParser(response.getBody()); 
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() =='accessToken' || Test.isRunningTest())){
                    parser.nextToken();
                    accessToken= parser.getText();
                }
            }
        }
        //Map<Id,Profile> profileIds = new Map<id,profile>([SELECT Id,UserLicenseId FROM Profile where UserLicenseId  in (SELECT Id FROM UserLicense where name ='Salesforce')]);
        set<string> setOfgrpusers = new set< string>();
        group objQueue = [select Id, Name from Group where  Type = 'Queue' AND NAME = 'Direct Team'];
        list<groupmember>  lstOfGroupMember = [Select userorgroupid from groupmember Where group.name = 'Portal User Group'];
        for( groupmember eachmember : lstOfGroupMember )
            setOfgrpusers.add(eachmember.userorgroupid);
        
        if( setOfgrpusers != null && setOfgrpusers.size() >0)
        {
            list<user> lstOfSFusers = [ Select id, isActive, email, username, Name from User where Id IN:setOfgrpusers];
            if( lstOfSFusers != null && lstOfSFusers.size() > 0 )
            {
                for(user eachuser : lstOfSFusers )
                {
                    wrapperUserData objWrap = new wrapperUserData();
                    objWrap.isActive = string.valueof(eachuser.isActive);
                    objWrap.salesforceUserId = eachuser.id;
                    objWrap.email = eachuser.email;
                    objWrap.name= eachuser.Name;
                    objWrap.isSalesUser = 'true';
                    objWrap.userName = eachuser.username;
                    lstOfActiveusers.add(objWrap);
                    
                }
                wrapperUserData objWrap = new wrapperUserData();
                objWrap.isActive = 'true';
                objWrap.salesforceUserId = objQueue.id;
                objWrap.name= 'Please match me with a Lendistry Team member';
                objWrap.isSalesUser = 'true';
                lstOfActiveusers.add(objWrap);
                
            }
        }
        list<user> lstOfNotSalesUser = [ Select id, isActive, email, username, Name from User where Id NOT IN:setOfgrpusers AND isActive=true];
        if( lstOfNotSalesUser != null && lstOfNotSalesUser.size() > 0 )
        {
            for(user eachuser : lstOfNotSalesUser )
            {
                wrapperUserData objWrap = new wrapperUserData();
                objWrap.isActive = string.valueof(eachuser.isActive);
                objWrap.salesforceUserId = eachuser.id;
                objWrap.email = eachuser.email;
                objWrap.name= eachuser.Name;
                objWrap.isSalesUser = 'False';
                objWrap.userName = eachuser.username;
                lstOfActiveusers.add(objWrap);
            }
            
        }
        
        if( accessToken != null && accessToken != '' || Test.isRunningTest())
        {
            Http http1 = new Http();
            HttpRequest request1 = new HttpRequest();
            request1.setHeader('Authorization', accessToken);
            request1.setHeader('Content-Type', 'application/json');
            string endPointURLFile = portalEndPoint+ System.Label.JavaPortalEndPointUserData;
            request1.setEndpoint(endPointURLFile);
            request1.setMethod('POST');
            request1.setTimeout(30000);
            // Set the body as a JSON object
            request1.setBody(JSON.serialize(lstOfActiveusers));
            system.debug('Testing User Call----->>'+JSON.serialize(lstOfActiveusers));
            
            HttpResponse response1 = http1.send(request1);
            
            // Parse the JSON response
            if (response1.getStatusCode() != 201 ) {
                System.debug('The status code returned was not expected: ' +
                             response1.getStatusCode() + ' ' + response1.getStatus());
                
                // Inserting Request, Response and Response code into the custom object for error handling
                Portal_Integration_Response_Code__c  Portalobj5 = new  Portal_Integration_Response_Code__c ();
                Portalobj5.Request__c = ' Sending all the salesforce users';
                Portalobj5.Response__c = response1.getBody();
                
                Portalobj5.Success_Error_Code__c = String.valueOf(response1.getStatusCode());
                lstOfExceptions2.add(Portalobj5);
            } else {
                System.debug(response1.getBody());
                
                // Inserting Request, Response and Response code into the custom object for error handling
                Portal_Integration_Response_Code__c  Portalobj6 = new  Portal_Integration_Response_Code__c ();
                Portalobj6.Request__c = ' Sending all the salesforce users';
                Portalobj6.Response__c = response1.getBody();
                Portalobj6.Success_Error_Code__c = String.valueOf(response1.getStatusCode());
                lstOfExceptions2.add(Portalobj6);
            }
        }
        insert lstOfExceptions2;
    }
    
    // On Lead update 
    @future (callout=true)
    public static void sendLeadDataToJavaDB( string PortalAPIEndPoint,string businessID , string LeadId, string OpportuntiyConvertedID, string ApplicationID )
    {
        list<Portal_Integration_Response_Code__c > lstOfExceptions = new list< Portal_Integration_Response_Code__c >();
        WrapLeadUpdateRes WrapperLead = new WrapLeadUpdateRes();
        Opportunity ConvertedOpp = new Opportunity();
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        string endPointURL= PortalAPIEndPoint+System.Label.JavaPortalEndPointUrl;
        req.setEndpoint(endPointURL);
        string userName =  System.Label.JavaPortalUserName;
        string password = System.Label.JavaPortalPassword;
        req.setBody('{"username": "'+ System.Label.JavaPortalUserName+'","secure": "'+ System.Label.JavaPortalPassword+'"}');
        string strReqBody = '{"username": "'+ System.Label.JavaPortalUserName+'","secure": "'+ System.Label.JavaPortalPassword+'"}';
        string accessToken = '';
        Http http = new Http();
        HTTPResponse response = http.send(req);
        System.debug('Body ' + response.getBody());
        System.debug('Status ' + response.getStatus());
        System.debug('Status code ' + response.getStatusCode());
        // Inserting Request, Response and Response code into the custom object for error handling
        Portal_Integration_Response_Code__c  Portalobj = new  Portal_Integration_Response_Code__c ();
        Portalobj.Request__c = strReqBody;
        Portalobj.Response__c = response.getBody();
        Portalobj.Success_Error_Code__c = String.valueOf(response.getStatusCode());
        Portalobj.Business_Id__c = businessID;
        Portalobj.Application_Id__c = ApplicationID;
        Portalobj.Opportunity_Id__c = OpportuntiyConvertedID;
        Portalobj.Lead_Id__c = LeadId;
     
        lstOfExceptions.add(Portalobj);
            system.debug('LeadId------->'+LeadId);
        Lead objLead= [ Select Does_the_Business_have_existing_SBA_Debt__c,Have_you_exhausted_all_personal_non_SB__c,BusinessId__c,Application_ID_SBAPPP__c,Business_ID_SBAPPP__c,Partner_Referral_Fee__c,Owner.Name, Interest_Type__c,Loan_Type__c, Referral_Partner_Email__c,Referral_Partner__r.Name,Sales_Decline__c,processing_fee__c, Origination_Fee__c,Referral_part_fee__c,Closing_Fee__c ,Referral_type__c
                       From Lead Where Id=:LeadId limit 1];
        
        if( OpportuntiyConvertedID != null && OpportuntiyConvertedID != '')
            ConvertedOpp = [Select id, name, Loan__c from Opportunity Where id=:OpportuntiyConvertedID limit 1];
        
        WrapperLead.business_id = businessID;
        WrapperLead.interest_type = objLead.Interest_Type__c;
        WrapperLead.referral_partner = objLead.Referral_Partner__r.Name;
        WrapperLead.sales_representative = objLead.Owner.Name;
        WrapperLead.referral_partner_email = objLead.Referral_Partner_Email__c;
        WrapperLead.sales_decline_reason = objLead.Sales_Decline__c;
        WrapperLead.loan_type = objLead.Loan_Type__c;
        WrapperLead.referral_source =    objLead.Referral_type__c;     
        WrapperLead.processing_fee = string.valueof(objLead.processing_fee__c) ;
        WrapperLead.origination_fee = string.valueof(objLead.Origination_Fee__c);
        WrapperLead.referral_part_fee = objLead.Partner_Referral_Fee__c;
        WrapperLead.closing_fee = string.valueof(objLead.Closing_Fee__c);
        if(String.isNotBlank(String.valueOf(objLead.Have_you_exhausted_all_personal_non_SB__c))) 
            WrapperLead.Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins =  objLead.Have_you_exhausted_all_personal_non_SB__c == 'Yes'? true:false;
        if(String.isNotBlank(String.valueOf(objLead.Does_the_Business_have_existing_SBA_Debt__c)))
            WrapperLead.DoestheBusinesshaveexistingSBADebt = objLead.Does_the_Business_have_existing_SBA_Debt__c == 'Yes'? true:false;
        
        if( ConvertedOpp != null && ConvertedOpp.Loan__c != null )
            WrapperLead.system_identifier = ConvertedOpp.Loan__c;
        
        if (response.getStatusCode() == 200) {
            JSONParser parser = JSON.createParser(response.getBody()); 
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() =='accessToken')){
                    parser.nextToken();
                    accessToken= parser.getText();
                }
            }
        }
        //*********************** Calling Java API *************************************
        if( accessToken != null && accessToken != ''|| Test.isRunningTest())
        {
            
            
            {
                Http http1 = new Http();
                HttpRequest request1 = new HttpRequest();
                request1.setHeader('Authorization', accessToken);
                request1.setHeader('Content-Type', 'application/json');
                string endPointURL1 = PortalAPIEndPoint+System.Label.JAVAPortalLeadUpdateAPI;
                request1.setEndpoint(endPointURL1);
                request1.setTimeout(120000); // timeout in milliseconds
                request1.setMethod('POST');
                system.debug('------JSON.serialize(WrapperLead)---->>'+JSON.serialize(WrapperLead));
                
                request1.setBody(JSON.serialize(WrapperLead));
                
                HttpResponse response1 = http1.send(request1);
               

                //Inserting Request, Response and Response code into the custom object for error handling
                Portal_Integration_Response_Code__c  Portalobj1 = new  Portal_Integration_Response_Code__c ();
                Portalobj1.Request__c = string.valueof(request1.getBody());
                Portalobj1.Response__c = '-------sendLeadDataToJavaDB-------'+string.valueof(response1.getBody());
                Portalobj1.Success_Error_Code__c = String.valueOf(response1.getStatusCode());
                Portalobj1.Business_Id__c = businessID;
                Portalobj1.Application_Id__c = ApplicationID;
                Portalobj1.Opportunity_Id__c = OpportuntiyConvertedID;
                Portalobj1.Lead_Id__c = LeadId;
               
                lstOfExceptions.add(Portalobj1);
                
                // Parse the JSON response
                if (response1.getStatusCode() != 201) {
                    System.debug('The status code returned was not expected: ' +
                                 response1.getStatusCode() + ' ' + response1.getStatus());
                } else {
                    System.debug(response1.getBody());
                }
            }
        } 
        system.debug('@@@lstOfExceptions'+lstOfExceptions);
        insert lstOfExceptions;  
    }
    
    
    //=============Send List Of Lead Data to Java Portal ==================================================
    //==================================================Send List Of Leads========================
    @future (callout=true)
    public static void sendListOfLeadData( set<Id> setOfLeads , String portalEndPointUrl)
    {
        
        list<Portal_Integration_Response_Code__c > lstOfExceptions4 = new list< Portal_Integration_Response_Code__c >();
        list<Portal_Integration_Response_Code__c > listResponsePortal = new list< Portal_Integration_Response_Code__c >();
        list<lead> listOfLeads = new list<lead>();
        list<lead> Not_SentDataList = new list<lead>();
        list<lead> ListOfResponseLeads = new list<lead>();
        map<string, lead> mapOfBatchPickedData = new map<string, lead>();
        list<JSON2ApexListOfLeadsResponse> ListresponseData = new list<JSON2ApexListOfLeadsResponse>();
        list<ListOfLeadData> lstOfJSONLeads = new list<ListOfLeadData>();
        list<Multiple_Files_Upload__c> listOfExternalDocs = new list<Multiple_Files_Upload__c>(); 
        
        list<ListOfOwnersData> listOfOwners = new list<ListOfOwnersData>();
        webToLeadWrapper objWebWrapper = new webToLeadWrapper();
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        string endPointURL = portalEndPointUrl+System.Label.JavaPortalEndPointUrl;    // dynamic URl based on server endpoint
        req.setEndpoint(endPointURL);
        string userName =  System.Label.JavaPortalUserName;
        string password = System.Label.JavaPortalPassword;
        req.setBody('{"username": "'+ System.Label.JavaPortalUserName+'","secure": "'+ System.Label.JavaPortalPassword+'"}');
        string strReqBody = '{"username": "'+ System.Label.JavaPortalUserName+'","secure": "'+ System.Label.JavaPortalPassword+'"}';
        string accessToken = '';
        Http http = new Http();
        HTTPResponse response = new HttpResponse();
        if(Test.isRunningTest()) {
            response = new HttpResponse();
            response.setBody('{"username": "'+System.Label.JavaPortalUserName+'","secure": "'+System.Label.JavaPortalPassword+'"}');
            response = response;
        }
        else
            response = http.send(req);
        
        // code added by saurbah as missing code or setting tokem value
        if (response.getStatusCode() == 200 || Test.isRunningTest()) {
            JSONParser parser = JSON.createParser(response.getBody()); 
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() =='accessToken' || Test.isRunningTest())){
                    parser.nextToken();
                    accessToken= parser.getText();
                }
            }
        }
        System.debug('Body ' + response.getBody());
        System.debug('Status ' + response.getStatus());
        System.debug('Status code ' + response.getStatusCode());
        // Inserting Request, Response and Response code into the custom object for error handling
        Portal_Integration_Response_Code__c  Portalobj = new  Portal_Integration_Response_Code__c ();
        Portalobj.Request__c = strReqBody;
        Portalobj.Response__c = response.getBody();
        //Portalobj.Business_Id__c = businessID;
        // Portalobj.Application_Id__c = ApplicationID;
        //Portalobj.Opportunity_Id__c = OpportuntiyConvertedID;
        //Portalobj.Lead_Id__c = LeadId;
        Portalobj.Success_Error_Code__c = String.valueOf(response.getStatusCode());
        lstOfExceptions4.add(Portalobj);
        listOfLeads = [ Select Have_you_exhausted_all_personal_non_SB__c,NAICS_CODE__c,recordType.Name,Loan_Type__c, Purpose_of_Grant__c,
                        Will_this_grant_create_new_jobs__c, County__c,SBSS_SCORE__c,SBA_Application_Approval__c ,DBA__c,
                        Is_the_US_Principal_place_of_residence__c,Other__c,Franchise__c,Curr_SBA_Econ_Disaster_Injury_Loan_Bal__c,Purpose_of_the_loan__c,
                        BusinessId__c,of_Current_Employees__c, of_Jobs_Retained__c,of_Jobs_Created_30th_June__c,Average_Monthly_Payroll__c,
                        Business_Start_Date__c,Will_this_loan_create_more_Jobs__c,of_employees_as_of_12_31_19__c,of_employees_as_of_2_15_2020__c,
                        X2019_Annual_Gross_Revenue__c,X2019_Annual_Payroll_Cost__c,Have_you_ever_been_convicted_of_a_crime__c,
                        Legal_action_pending_against_youspouse__c,Do_you_have_a_tax_lien_of_taxes_due__c,Have_you_ever_defaulted_on_a_govt_loan__c,
                        exhausted_personal_nonSBA_financing__c,Majority_owner_US_CitizenLegal_Resident__c,Does_the_Business_have_existing_SBA_Debt__c,
                        Submit_loan_req_SBAfinancial_COVID19__c,State_of_incopration__c,Business_EIN__c,Do_you_rent_own_business_space__c,Run_Credit_Report__c,
                        Net_Worth__c,of_customer_served_monthly__c,Business_Phone__c,Who_is_Your_Customer_Base1__c,What_does_your_Business_do__c,
                        What_type_of_Business_is_it__c,Tell_us_more__c, DOB_Owner_1__c,DOB_Owner_2__c,DOB_Owner_3__c,DOB_Owner_4__c,DOB_Owner_5__c,
                        Owner_Rent_1__c, Owner_Rent_2__c, Owner_Rent_3__c, Owner_Rent_4__c, Owner_Rent_5__c, Disabled__c,Ethnicity__c,Race__c,Veteran__c,
                        Women_Owned__c,of_employees_added_in_next_12_months__c,of_Dials__c,Owner_ID_Owner_1__c,Owner_ID_Owner_2__c,Owner_ID_Owner_3__c,
                        Owner_ID_Owner_4__c,Owner_ID_Owner_5__c,of_Ownership_Owner__c,creditchecker__Adverse_Alert__c,Are_you_COD_30_60_90__c,
                        creditchecker__Average_Score__c,creditchecker__Bankruptcy_Count__c,Brief_History_on_the_business__c,
                        Brief_History_on_the_owner_manager__c,Campaign_Source__c,creditchecker__Charge_Offs_Count__c,creditchecker__Collections_Count__c,
                        creditchecker__Current_Adverse_Count__c,creditchecker__Derogatory_Count__c,creditchecker__Disputes_Count__c,
                        Do_You_Carry_Life_Insurance__c,Do_you_pay_child_support_or_alimony__c,Entity_Type__c,Explanation_of_any_BKs_defaults_etc__c,
                        First_Name_2nd_Owner__c,Homeowner__c,Last_Name_2nd_Owner__c,Monthly_Rent_Mtg__c,Owner__c,Planned_Changes_In_Next_6_Months__c,
                        creditchecker__Previous_Adverse_Count__c,Profitable_Last_2_Years__c,creditchecker__Public_Record_Count__c,Referral_Partner__c,
                        Referral_type__c,Requested_Amount__c,creditchecker__Revolving_Credit_Utilization__c,Second_Owner__c,TIB_Months__c,
                        creditchecker__Total_High_Credit__c,creditchecker__Total_Inquiry_Count__c,creditchecker__Total_Liability_Balance__c,
                        creditchecker__Total_Liability_PastDue__c,creditchecker__Total_Liability_Payment__c,Use_of_Funds__c,
                        What_are_the_terms_of_your_current_lease__c,What_exactly_does_the_business_do__c,What_is_the_purpose_of_loan__c,
                        Who_is_your_customer_base__c,of_Ownership_Second_Owner__c,Address,Address_3rd_Owner__c,Address_4th_Owner__c,Address_5th_Owner__c,
                        Address_Owner_1__c,Address_Owner_2__c,AnnualRevenue,City, country,City_2nd_Owner__c,City_Owner_1__c,City_Owner_2__c,City_Owner_3__c,
                        City_Owner_4__c,City_Owner_5__c,Company,IsConverted,ConvertedAccountId,ConvertedContactId,ConvertedDate,ConvertedOpportunityId,
                        Country_2nd_Owner__c,Country_Owner_1__c,Country_Owner_2__c,Country_Owner_3__c,Country_Owner_4__c,Country_Owner_5__c,CreatedById,
                        CreatedDate,Credit_Report_Type__c,Credit_Score_2nd_Owner__c,Credit_Score_3rd_Owner_from_Webform__c,
                        Credit_Score_4th_Owner_from_Webform__c,Credit_Score_5th_Owner_from_Webform__c,Credit_Score__c,Jigsaw,IsDeleted,Description,DoNotCall,
                        Email,Email_2nd_Owner__c,Email_3rd_Owner__c,Email_4th_Owner__c,Email_5th_Owner__c,NumberOfEmployees,FirstName,First_Name_3rd_Owner__c,
                        First_Name_4th_Owner__c,First_Name_5th_Owner__c,Name,GeocodeAccuracy,Industry,JigsawContactId,LastActivityDate,LastModifiedById,
                        LastModifiedDate,LastName,Last_Name_3rd_Owner__c,Last_Name_4th_Owner__c,Last_Name_5th_Owner__c,LastReferencedDate,LastViewedDate,
                        Latitude,Id,LeadSource,Longitude,MasterRecordId,MiddleName,Mobile_2nd_Owner__c,Mobile_3rd_Owner__c,Mobile_4th_Owner__c,
                        Mobile_5th_Owner__c,MobilePhone,Not_Interested__c,of_Ownership_3rd_Owner__c,of_Ownership_4th_Owner__c,of_Ownership_5th_Owner__c,
                        OwnerId,Phone,Phone_2nd_Owner__c,Phone_3rd_Owner__c,Phone_4th_Owner__c,Phone_5th_Owner__c,PhotoUrl,Postal_Code_2nd_Owner__c,Rating,
                        Referral_Partner_Email__c,Sales_Decline__c,Salutation,Source_Web_Form__c,SSN1__c,SSN2__c,SSN_3rd_Owner__c,SSN_4th_Owner__c,
                        SSN_5th_Owner__c,State_2nd_Owner__c,State_Owner_1__c,State_Owner_2__c,State_Owner_3__c,State_Owner_4__c,State_Owner_5__c,State,
                        Status,Status_Detail__c,Street,Street_2nd_Owner__c,Street_Owner_1__c,Street_Owner_2__c,Street_Owner_3__c,Street_Owner_4__c,
                        Street_Owner_5__c,Suffix,SystemModstamp,Title,Title_2nd_Owner__c,Title_3rd_Owner__c,Title_4th_Owner__c,Title_5th_Owner__c,
                        IsUnreadByOwner,UTM_Campaign__c,UTM_Medium__c,UTM_Source__c,Website,Zip_Code_Owner_1__c,Zip_Code_Owner_2__c,Zip_Code_Owner_3__c,
                        Zip_Code_Owner_4__c,Zip_Code_Owner_5__c,PostalCode,Period_2_Revenue__c,Last_Year_s_Period__c,Proof_of_25_revenue_drop_2020__c,Network_Selection__c,
                        Period_1_Revenue__c,Refinance_of_Eligible_Economic_Injury_Di__c,Economic_Injury_Disaster_Loan_Number__c,Have_you_had_a_25_revenue_drop_between__c,Who_originated_your_PPP_loan__c,Did_you_obtain_a_PPP_loan_in_2020__c,Did_you_receive_a_Shuttered_Venue_Operat__c,PPP_First_Draw_SBA_Loan_Number__c,PPP_First_Draw_Loan_Amount__c
                                
                         From Lead  Where Id IN:setofLeads ];
        
        listOfExternalDocs = [ select id,Lead__c,Attachment_Url__c,Type__c from Multiple_Files_Upload__c where Lead__c IN:setofLeads];
    
        if( listOfLeads != null && listOfLeads.size() > 0 )
        {
            for( lead eachLead : listOfLeads )
            {
             
             
                
                if(  eachLead.Business_EIN__c != null && eachLead.Business_EIN__c != '' )
                {
                   string BusEIN = '';
                   
                   if( string.valueof(eachLead.Business_EIN__c).contains('-'))
                   BusEIN =  string.valueof(eachLead.Business_EIN__c).replaceAll('-',''); 
                   else
                   BusEIN = eachLead.Business_EIN__c;
                   
                    boolean IsNumbericBusinessEIN =  BusEIN.isNumeric();
                    system.debug('----IsNumbericBusinessEIN --->'+IsNumbericBusinessEIN);
                    if(  IsNumbericBusinessEIN  == false )
                    {
                        lead objPickedLead= new lead(id=eachLead.id );
                         objPickedLead.Is_Batch_Picked__c= true;
                        ListOfResponseLeads.add(objPickedLead);
                    }
                    if(  IsNumbericBusinessEIN  == true )
                    {
                        mapOfBatchPickedData.put(eachLead.id, eachLead);
                list<Documents> lstOfDocuments = new list<Documents>();
              
                for(Multiple_Files_Upload__c eachDoc : listOfExternalDocs )
                {
                    if( eachDoc.Lead__c == eachLead.id)
                    {
                        
                        if( eachDoc.Type__c != null && eachDoc.Type__c == 'SBA PPP')
                        {
                            Documents  objDoc = new Documents();
                            objDoc.type = 'SBA_APPLICATION';
                            string pathUrl = eachDoc.Attachment_Url__c.replace(System.Label.AWS_JSON_File_Url,'salesforceupload');
                            objDoc.path = pathUrl;
                            lstOfDocuments.add(objDoc);
                        }
                        if( eachDoc.Type__c != null && eachDoc.Type__c == 'Corporate Documentation')
                        {
                            Documents  objDoc = new Documents();
                            objDoc.type = 'CORPORATE_DOCS';
                            string pathUrl = eachDoc.Attachment_Url__c.replace(System.Label.AWS_JSON_File_Url,'salesforceupload');
                            objDoc.path = pathUrl;
                            lstOfDocuments.add(objDoc);
                        }
                        if( eachDoc.Type__c != null && eachDoc.Type__c == 'Payroll Documentation')
                        {
                            Documents  objDoc = new Documents();
                            objDoc.type = 'LAST_YEAR_PAYROLL';
                            string pathUrl = eachDoc.Attachment_Url__c.replace(System.Label.AWS_JSON_File_Url,'salesforceupload');
                            objDoc.path = pathUrl;
                            lstOfDocuments.add(objDoc);
                        }
                        if( eachDoc.Type__c != null && eachDoc.Type__c == 'Tax Documentation')
                        {
                            Documents  objDoc = new Documents();
                            objDoc.type = 'LAST_YEAR_BUSINESS_TAX_RETURN';
                            string pathUrl = eachDoc.Attachment_Url__c.replace(System.Label.AWS_JSON_File_Url,'salesforceupload');
                            objDoc.path = pathUrl;
                            lstOfDocuments.add(objDoc);
                        }
                        
                        
                        
                    }
                    
                }
               
                system.debug('-----lstOfDocuments--BBBB--->'+string.valueof(JSON.serialize(lstOfDocuments) ));                 
                ListOfLeadData objJSONLead = new ListOfLeadData();
                objJSONLead.Naics = eachlead.NAICS_CODE__c;
                objJSONLead.TIB = eachlead.TIB_Months__c;
                //if( eachLead.Credit_Score__c != null )
                // objJSONLead.PrimaryOwner_credit_Score = Decimal.valueof(eachLead.Credit_Score__c);
                // New mapping done
                objJSONLead.contactPosition = 'Position';
                objJSONLead.ReferralPartner = 'WEBFORM';
              /*  
                objJSONLead.County = eachlead.County__c;
                if( eachlead.SBSS_SCORE__c != null)
                objJSONLead.SBAApplicationNumber = Integer.valueof(eachlead.SBSS_SCORE__c);
                if( eachlead.SBA_Application_Approval__c != null)
                objJSONLead.SBALoanNumber = Integer.valueof(eachlead.SBA_Application_Approval__c);
                */
                objJSONLead.contactEmail = eachlead.Email;
                objJSONLead.LeadId = String.valueof(eachLead.ID);
                objJSONLead.dbaName = eachLead.DBA__c;
                objJSONLead.FirstName = eachLead.FirstName;
                objJSONLead.LastName = eachLead.LastName;
                if(eachLead.MobilePhone !=null && eachLead.MobilePhone.contains('('))
                    objJSONLead.PhonrNumber = formatingPhone(eachLead.Business_Phone__c);
                 else
                 objJSONLead.PhonrNumber = String.valueof(eachLead.Business_Phone__c);
                
                if( eachLead.DOB_Owner_1__c != null )
                    {
                        Date d = eachLead.DOB_Owner_1__c;
                        String dt = DateTime.newInstance(d.year(),d.month(),d.day()).format('MM/dd/yyy');
                        objJSONLead.owner_dob = dt;
                    }
                if( eachLead.Email != null )
                objJSONLead.Email = string.valueof(eachLead.Email);
                if( eachLead.Email != null)
                objJSONLead.ownerEmailAddress = string.valueof(eachLead.Email);
                objJSONLead.BusinessName = eachLead.Company;
                objJSONLead.corporateName = eachLead.Company;
                objJSONLead.Whoisyourcustomerbase = eachLead.Who_is_Your_Customer_Base1__c;
                objJSONLead.Whatdoesyourbusinessdo = eachLead.What_does_your_Business_do__c;
                objJSONLead.WhattypeofBusinessisit = eachLead.What_type_of_Business_is_it__c;
                objJSONLead.TellusMore = eachLead.Tell_us_more__c;
                        objJSONLead.BusinessStartDate = String.valueof(eachLead.Business_Start_Date__c);
                        objJSONLead.AmountRequested = Integer.valueof(eachLead.Requested_Amount__c);
                        if( eachLead.Loan_Type__c == 'PA CARES' || eachLead.Loan_Type__c == 'YoCo STRONG')
                        {
                            if(eachLead.Will_this_grant_create_new_jobs__c != null)
                            objJSONLead.Willthisloancreatemorejobs = eachLead.Will_this_grant_create_new_jobs__c == 'Yes'? true:false;
                        }
                        else
                        {
                            if(eachLead.Will_this_loan_create_more_Jobs__c != null)
                            objJSONLead.Willthisloancreatemorejobs = eachLead.Will_this_loan_create_more_Jobs__c == 'Yes'? true:false;
                        }  
                        
                        objJSONLead.CurrentSBAEconomicDisasterInjuryLoanBalance = eachLead.Curr_SBA_Econ_Disaster_Injury_Loan_Bal__c;
                objJSONLead.Franchise = eachLead.Franchise__c== 'Yes'? true:false;
                objJSONLead.of_Jobs_Retained = Integer.valueof(eachLead.of_Jobs_Retained__c);
                
                objJSONLead.of_Jobs_Created_30th_June = String.valueof(eachLead.of_Jobs_Created_30th_June__c);
                objJSONLead.Average_Monthly_Payroll = String.valueof(eachLead.Average_Monthly_Payroll__c);
                
                objJSONLead.ofemployeesasof12_31_19 = Integer.valueof(eachLead.of_Current_Employees__c);
                objJSONLead.ofemployeesasof2_15_2020 = Integer.valueof(eachLead.of_Jobs_Created_30th_June__c);
                objJSONLead.AnnualGrossRevenue = Integer.valueof(eachLead.of_Jobs_Retained__c);
                objJSONLead.AnnualPayrollCost = Integer.valueof(eachLead.Average_Monthly_Payroll__c);
                
                objJSONLead.WomenOwnedBusiness = eachLead.Women_Owned__c== 'Yes'? true:false;
                objJSONLead.Ethnicity = eachLead.Ethnicity__c;
                objJSONLead.Race = eachLead.Race__c;
                objJSONLead.Veteran = eachLead.Veteran__c== 'Yes'? true:false;
                objJSONLead.Disabled = eachLead.Disabled__c== 'Yes'? true:false;
                objJSONLead.Have_you_had_a_25_revenue_drop_between = eachLead.Have_you_had_a_25_revenue_drop_between__c;
                objJSONLead.Who_originated_your_PPP_loan =eachLead.Who_originated_your_PPP_loan__c;
                objJSONLead.Did_you_obtain_a_PPP_loan_in_2020 = eachLead.Did_you_obtain_a_PPP_loan_in_2020__c;
                objJSONLead.Did_you_receive_a_Shuttered_Venue_Operat = eachLead.Did_you_receive_a_Shuttered_Venue_Operat__c;
                objJSONLead.Haveyoueverbeenconvictedofacrime = eachLead.Have_you_ever_been_convicted_of_a_crime__c == 'Yes'? true:false;
                if(eachLead.PPP_First_Draw_SBA_Loan_Number__c  !=null)
                        objJSONLead.PPP_First_Draw_SBA_Loan_Number = eachLead.PPP_First_Draw_SBA_Loan_Number__c;
                    if(eachLead.PPP_First_Draw_Loan_Amount__c !=null)
                        objJSONLead.PPP_First_Draw_Loan_Amount = eachLead.PPP_First_Draw_Loan_Amount__c;
                        
                        
                     ///////////// New fields 25 Ja 2021 Saurabh Kumar added   
                    if(eachLead.Period_2_Revenue__c  !=null)
                        objJSONLead.Period_2_Revenue = eachLead.Period_2_Revenue__c;
                    if(eachLead.Network_Selection__c != null)
                        objJSONLead.networkSelection = eachLead.Network_Selection__c;
                    if(eachLead.Last_Year_s_Period__c!=null)
                        objJSONLead.Last_Years_Period = eachLead.Last_Year_s_Period__c;
                    if(eachLead.Proof_of_25_revenue_drop_2020__c !=null)
                        objJSONLead.Proof_of_25_revenue_drop_2020 = eachLead.Proof_of_25_revenue_drop_2020__c;
                    if(eachLead.Period_1_Revenue__c !=null)
                        objJSONLead.Period_1_Revenue  = eachLead.Period_1_Revenue__c;
                    if(eachLead.Refinance_of_Eligible_Economic_Injury_Di__c  !=null)
                        objJSONLead.Refinance_of_Eligible_Economic_Injury_Di = eachLead.Refinance_of_Eligible_Economic_Injury_Di__c;
                    if(eachLead.Economic_Injury_Disaster_Loan_Number__c !=null)
                        objJSONLead.Economic_Injury_Disaster_Loan_Number = eachLead.Economic_Injury_Disaster_Loan_Number__c;
                           
                           ///////////////////25 Jan2021 END////////////   
                objJSONLead.Arethereanylegalactionspendingagainstyou_oryourspouse = eachLead.Legal_action_pending_against_youspouse__c== 'Yes'? true:false;
                objJSONLead.Doyouhaveataxlienoftaxesdue = eachLead.Do_you_have_a_tax_lien_of_taxes_due__c== 'Yes'? true:false;
                objJSONLead.Haveyoueverdefaultedonagovernmentloan_includedSBAloan_Studentloan_etc = eachLead.Have_you_ever_defaulted_on_a_govt_loan__c== 'Yes'? true:false;
                objJSONLead.Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins = eachLead.exhausted_personal_nonSBA_financing__c == 'Yes'? true:false;
                objJSONLead.arethemajorityownesofthebusinessUSCitizensorLegalPermanentResidents = eachLead.Majority_owner_US_CitizenLegal_Resident__c== 'Yes'? true:false;
                objJSONLead.DoestheBusinesshaveexistingSBADebt = eachLead.Does_the_Business_have_existing_SBA_Debt__c== 'Yes'? true:false;
                objJSONLead.HaveyousubmittedaloanrequersttoSBAoranyotheragencyorfinancialinstutiontinconnectionwithCovid_19 = eachLead.Submit_loan_req_SBAfinancial_COVID19__c== 'Yes'? true:false;
                objJSONLead.IsTheUnitedStatesThePrincipalPlaceOfResidenceForAllEmployees = eachLead.Is_the_US_Principal_place_of_residence__c== 'Yes'? true:false;
                // State of Incorporation is not sent in JSON as Portal API is NOT currently accepting it. It breaks portal API
                //objJSONLead.Stateofincopration = eachLead.State_of_incopration__c;
               /* if( eachLead.Business_EIN__c != null && eachLead.Business_EIN__c != '' && string.valueof(eachLead.Business_EIN__c).contains('-'))
                    objJSONLead.BusinessEIN = string.valueof(eachLead.Business_EIN__c).replaceAll('-',''); 
                else
                 objJSONLead.BusinessEIN = string.valueof(eachLead.Business_EIN__c);                    
                */   
                   if( eachLead.Business_EIN__c != null && eachLead.Business_EIN__c != '')
                    objJSONLead.BusinessEIN = string.valueof(eachLead.Business_EIN__c.deleteWhitespace()).replace('-','');
               /* if( eachLead.Business_EIN__c != null && eachLead.Business_EIN__c != '' )
                    objJSONLead.BusinessEIN = string.valueof(eachLead.Business_EIN__c).replaceAll('[^0-9]', '');
                */
                objJSONLead.BusinessType = eachLead.Entity_Type__c;
                objJSONLead.BuinessAddress = eachLead.Street;
                objJSONLead.BusinessState = eachLead.State;
                objJSONLead.BuinessCity = eachLead.City;
                objJSONLead.BuinessZip = eachLead.PostalCode;
                objJSONLead.BusinessWebAdress = eachLead.Website;
                if(String.isNotBlank(String.valueOf(eachLead.Have_you_exhausted_all_personal_non_SB__c))) 
                objJSONLead.Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins =  eachLead.Have_you_exhausted_all_personal_non_SB__c == 'Yes'? true:false;
               if(String.isNotBlank(String.valueOf(eachLead.Does_the_Business_have_existing_SBA_Debt__c)))
                objJSONLead.DoestheBusinesshaveexistingSBADebt = eachLead.Does_the_Business_have_existing_SBA_Debt__c == 'Yes'? true:false;
                        if( eachLead.Loan_Type__c == 'PA CARES' || eachLead.Loan_Type__c == 'YoCo STRONG')
                        {
                            if(eachLead.Purpose_of_Grant__c != null)
                                objJSONLead.Purposeofloan = eachLead.Purpose_of_Grant__c;
                        }
                        else
                        {
                            if(eachLead.Purpose_of_the_loan__c != null)
                                objJSONLead.Purposeofloan = eachLead.Purpose_of_the_loan__c;
                        }  
                        
                
                objJSONLead.Other = eachLead.Other__c;
                objJSONLead.DoyourentORownbusinessspace = eachLead.Do_you_rent_own_business_space__c== 'Yes'? true:false;
                objJSONLead.AmountofrentORmtg = Integer.valueof(eachLead.Monthly_Rent_Mtg__c);
                objJSONLead.documents  =lstOfDocuments;
                objJSONLead.BuinessState = eachLead.State_Owner_1__c;
                // Assigning Values for Primary Owner when SSN is not NULL
                if( eachLead.LastName != null && eachLead.LastName != '' ) // need to update it again with ssn check
                {
                    ListOfOwnersData objOwnerJSON = new ListOfOwnersData();
                    objOwnerJSON.Owner = String.valueof(eachLead.Owner__c);
                    objOwnerJSON.LeadId = eachLead.Id;
                    //objOwnerJSON.RunCreditReport = eachLead.Run_Credit_Report__c;
                    objOwnerJSON.ownerCity = eachLead.City_Owner_1__c;
                     if(eachLead.MobilePhone !=null && eachLead.MobilePhone.contains('('))
                        objOwnerJSON.ownerCellChone_no = formatingPhone(eachLead.MobilePhone);
                    else
                        objOwnerJSON.ownerCellChone_no = eachLead.MobilePhone;
                    objOwnerJSON.Owner_zipcode = eachLead.Zip_Code_Owner_1__c;
                    objOwnerJSON.owner_title = eachLead.Title;
                    objOwnerJSON.owner_state = eachLead.State_Owner_1__c;
                    objOwnerJSON.owner_SSN = eachLead.SSN1__c;
                    objOwnerJSON.Owner_Rent = String.valueof(eachLead.Owner_Rent_1__c);
                    if(eachLead.Phone!=null && eachLead.Phone.contains('('))
                        objOwnerJSON.Owner_Phone = formatingPhone(eachLead.Phone);
                     else
                         objOwnerJSON.Owner_Phone = eachLead.Phone;
                    if( (eachLead.of_Ownership_Owner__c == null ||  eachLead.of_Ownership_Owner__c == 0 ) && eachLead.recordType.Name=='SBA - PPP' )
                    objOwnerJSON.owner_percentage = 100;
                    else
                    objOwnerJSON.owner_percentage = Integer.valueof(eachLead.of_Ownership_Owner__c);
                    objOwnerJSON.owner_last_name = eachLead.lastname;
                    
                    objOwnerJSON.owner_home_address = eachLead.Street_Owner_1__c;
                    objOwnerJSON.owner_first_name = eachLead.firstname;
                    objOwnerJSON.owner_email = eachLead.email;
                    objOwnerJSON.owner_dob = String.valueof(eachLead.DOB_Owner_1__c);
                    objOwnerJSON.Owner_Country = eachLead.country;
                    objOwnerJSON.isPrimaryContact = True;
                    // objOwnerJSON.CreditScorefromWebform = eachLead.Credit_Score__c;
                    
                    listOfOwners.add(objOwnerJSON);
                    system.debug('------listOfOwners----->'+listOfOwners);
                }
                
                
                
                objJSONLead.listOfOwnersData = listOfOwners;
                
                lstOfJSONLeads.add(objJSONLead);
                
                
                system.debug('------listOfOwners---->'+listOfOwners);
                //lstOfJSONLeads = new list<ListOfLeadData>();
                listOfOwners = new list<ListOfOwnersData>();
                //objWebWrapper = new webToLeadWrapper();
            }
            objWebWrapper.listOfLeadData = lstOfJSONLeads;
            system.debug('------objWebWrapper---->'+objWebWrapper);
        }
        
       
        }}
        
        if( accessToken != null && accessToken != '' || Test.isRunningTest())
        {
            Http http1 = new Http();
            HttpRequest request1 = new HttpRequest();
            request1.setHeader('Authorization', accessToken);
            request1.setHeader('Content-Type', 'application/json');
            string endPointURL1 = portalEndPointUrl+System.Label.JavaPortalLeadApi;
            request1.setEndpoint(endPointURL1);
            request1.setTimeout(120000);
            request1.setMethod('POST');
            
            request1.setBody( JSON.serialize(objWebWrapper) );
            system.debug('------JSON.serialize(objWebWrapper)----->>>'+JSON.serialize(objWebWrapper));
            HttpResponse response1 = http1.send(request1);
            //Inserting Request, Response and Response code into the custom object for error handling
            Portal_Integration_Response_Code__c  Portalobj1 = new  Portal_Integration_Response_Code__c ();
            Portalobj1.Request__c = JSON.serialize(string.valueof(setOfLeads));  
            if(!Test.isRunningTest()){         
                response = http.send(req);
                 
                Portalobj1.Response__c = response1.getBody();
                Portalobj1.Success_Error_Code__c = String.valueOf(response1.getStatusCode());
                  System.debug('The status code returned was not expected:----->> ' +response1.getStatusCode());
                   System.debug('1111122221-------->>'+response1.getBody());
                if (response1.getStatusCode() != 201) {
                    System.debug('The status code returned was not expected: ' +
                                 response1.getStatusCode() + ' ' + response1.getStatus());
                    ListresponseData = JSON2ApexListOfLeadsResponse.parse(response1.getBody());
                    if( ListresponseData != null && ListresponseData.size() > 0)
                    {
                        for(JSON2ApexListOfLeadsResponse eachRes  : ListresponseData )
                        {
                            for( string batchPickedId : mapOfBatchPickedData.keySet())
                            {
                                if(eachRes.leadId != batchPickedId && eachRes.status != true && eachRes.status != false )
                                {
                                     lead objPickedLead= new lead(id=batchPickedId );
                                    objPickedLead.Is_Batch_Picked__c= true;
                                    ListOfResponseLeads.add(objPickedLead);
                                }
                                
                            
                            
                            if( eachRes.status == true && eachRes.leadId == batchPickedId )
                            {
                                Portal_Integration_Response_Code__c  objPortalError = new  Portal_Integration_Response_Code__c ();
                                objPortalError.Lead_Id__c  = eachRes.leadId;
                                objPortalError.IsSyncWithPortal__c = true;
                                objPortalError.Application_ID__c = eachRes.Application_Id ;
                                objPortalError.Business_Id__c =eachRes.Business_Id ;
                                objPortalError.Primary_Owner_Id__c = eachRes.PrimaryOwnerId;
                                
                                lead objSyncLead = new lead(id=eachRes.leadId);
                                objSyncLead.IsSyncWithPortal__c = true;
                                objSyncLead.Is_Batch_Picked__c= true;
                                
                                objSyncLead.Application_ID_SBAPPP__c =eachRes.Application_Id ;
                                objSyncLead.Business_ID_SBAPPP__c =eachRes.Business_Id ; 
                                objSyncLead.Owner_ID_Owner_1__c = eachRes.PrimaryOwnerId;
                                ListOfResponseLeads.add(objSyncLead);
                                lstOfExceptions4.add(objPortalError);
                            }
                            else if( eachRes.status == false && eachRes.leadId == batchPickedId)
                            {
                                lead objSyncLead = new lead(id=eachRes.leadId);
                                objSyncLead.IsSyncWithPortal__c = false;
                                objSyncLead.Is_Batch_Picked__c= true;
                                Portal_Integration_Response_Code__c  objPortalError = new  Portal_Integration_Response_Code__c ();
                                objPortalError.Lead_Id__c  = eachRes.leadId;
                                objPortalError.IsSyncWithPortal__c = false;
                                objPortalError.Application_ID__c = eachRes.Application_Id ;
                                objPortalError.Business_Id__c =eachRes.Business_Id ;
                                objPortalError.Primary_Owner_Id__c = eachRes.PrimaryOwnerId;
                                lstOfExceptions4.add(objPortalError);
                                ListOfResponseLeads.add(objSyncLead);
                            }
                            }
                        }
                        System.debug('??????????????'+ListOfResponseLeads );
                        System.debug('1111122221'+response1.getBody());
                       
                    }
                } else {
                    System.debug('??????????????'+response1.getBody());
                }
                lstOfExceptions4.add(Portalobj1);
            }
            //============Added to check whether Opportunity is Synced Or NOT with the Portal===========================================
            
            //============End block Added to check whether Opportunity is Synced Or NOT with the Portal===========================================
        } 
        if( ListOfResponseLeads != null && ListOfResponseLeads.size() > 0)
        update ListOfResponseLeads;
        if(lstOfExceptions4 != null && lstOfExceptions4.size() > 0){
            insert lstOfExceptions4;
        }
        
    }
    
    
    /*****************************************************************************************************
    
    
    *********************************************************************************************************/
    public static String formatingPhone(String strphone){
        String target = '(';
        String target2 = ') ';
        String finalString;
        if(strphone.contains('(')){
            String s2 = strphone.replace(target, '');
            finalString = s2.replace(target2, '-');     
        }
        return finalString;
}
    
    /***************************************************************************************END*********/
    // =================Send List Of Documents on SBA Lead Conversion========================================================================
    @future (callout=true)
    public static void makeAdditionalDocumentsApiCall(String portalendPointUrl, string leadId, string businessId,  string OpportuntiyConvertedID )
    {
        list<Portal_Integration_Response_Code__c > lstOfExceptions2 = new list< Portal_Integration_Response_Code__c >();
        list<wrapperUserData> lstOfActiveusers = new list<wrapperUserData>();
        list<Multiple_Files_Upload__c> listOfExternalDocs = new list<Multiple_Files_Upload__c>(); 
        
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        string endPointURL = portalendPointUrl+System.Label.JavaPortalEndPointUrl;
        req.setEndpoint(endPointURL);
        string userName =  System.Label.JavaPortalUserName;
        string password = System.Label.JavaPortalPassword;
        req.setBody('{"username": "'+ System.Label.JavaPortalUserName+'","secure": "'+ System.Label.JavaPortalPassword+'"}');
        string strReqBody = '{"username": "'+ System.Label.JavaPortalUserName+'","secure": "'+ System.Label.JavaPortalPassword+'"}';
        string accessToken = '';
        Http http = new Http();
        HTTPResponse response = http.send(req);
        System.debug('Body ' + response.getBody());
        System.debug('Status ' + response.getStatus());
        System.debug('Status code ' + response.getStatusCode());
        
        // Inserting Request, Response and Response code into the custom object for error handling
        Portal_Integration_Response_Code__c  Portalobj4 = new  Portal_Integration_Response_Code__c ();
        Portalobj4.Request__c = strReqBody;
        Portalobj4.Response__c = response.getBody();
        Portalobj4.Success_Error_Code__c = String.valueOf(response.getStatusCode());
        lstOfExceptions2.add(Portalobj4);
        
        if (response.getStatusCode() == 200) {
            JSONParser parser = JSON.createParser(response.getBody()); 
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() =='accessToken' || Test.isRunningTest())){
                    parser.nextToken();
                    accessToken= parser.getText();
                }
            }
        }
        listOfExternalDocs = [ select id, Lead__c,Attachment_Url__c,IsAdditionalDocument__c,Type__c from Multiple_Files_Upload__c where Lead__c=:leadId AND IsAdditionalDocument__c = true ];
        
        SBA_Documents objDocsWrapper = new SBA_Documents();
        
        list<Documents> lstOfDocuments = new list<Documents>();
        if(( listOfExternalDocs != null && listOfExternalDocs.size( ) > 0 ) || Test.isRunningTest() )  //Test.isRunningTest() 
        {
            for(Multiple_Files_Upload__c eachDoc : listOfExternalDocs )
            {
                if( eachDoc.Attachment_Url__c != null && eachDoc.Attachment_Url__c != '' && eachDoc.IsAdditionalDocument__c == true)
                {
                    Documents  objDoc = new Documents();
                    objDoc.type = 'Supporting_Documents';
                    string pathUrl = eachDoc.Attachment_Url__c.replace(System.Label.AWS_JSON_File_Url,'salesforceupload');
                    objDoc.path = pathUrl;
                    lstOfDocuments.add(objDoc);
                }
                
                /*    
if( eachDoc.Type__c != null && eachDoc.Type__c == 'SBA PPP')
{
Documents  objDoc = new Documents();
objDoc.type = 'SBA_APPLICATION';
string pathUrl = eachDoc.Attachment_Url__c.replace(System.Label.AWS_JSON_File_Url,'salesforceupload');
objDoc.path = pathUrl;
lstOfDocuments.add(objDoc);
}
if( eachDoc.Type__c != null && eachDoc.Type__c == 'Corporate Documentation')
{
Documents  objDoc = new Documents();
objDoc.type = 'CORPORATE_DOCS';
string pathUrl = eachDoc.Attachment_Url__c.replace(System.Label.AWS_JSON_File_Url,'salesforceupload');
objDoc.path = pathUrl;
lstOfDocuments.add(objDoc);
}
if( eachDoc.Type__c != null && eachDoc.Type__c == 'Payroll Documentation')
{
Documents  objDoc = new Documents();
objDoc.type = 'LAST_YEAR_PAYROLL';
string pathUrl = eachDoc.Attachment_Url__c.replace(System.Label.AWS_JSON_File_Url,'salesforceupload');
objDoc.path = pathUrl;
lstOfDocuments.add(objDoc);
}
if( eachDoc.Type__c != null && eachDoc.Type__c == 'Tax Documentation')
{
Documents  objDoc = new Documents();
objDoc.type = 'LAST_YEAR_BUSINESS_TAX_RETURN';
string pathUrl = eachDoc.Attachment_Url__c.replace(System.Label.AWS_JSON_File_Url,'salesforceupload');
objDoc.path = pathUrl;
lstOfDocuments.add(objDoc);
}
*/
                
            }
            objDocsWrapper.Documents = lstOfDocuments;
            objDocsWrapper.businessId = businessId;
            
            system.debug('-----objDocsWrapper---Main JSON->'+JSON.serialize(objDocsWrapper));
        }
        
        
        if( (accessToken != null && accessToken != '') || Test.isRunningTest())
        {
            Http http1 = new Http();
            HttpRequest request1 = new HttpRequest();
            request1.setHeader('Authorization', accessToken);
            request1.setHeader('Content-Type', 'application/json');
            string endPointURLFile = portalendPointUrl+System.Label.JavaPortalAdditionalDocuments;
            request1.setEndpoint(endPointURLFile);
            request1.setMethod('POST');
            
            // Set the body as a JSON object
            request1.setBody(JSON.serialize(objDocsWrapper));
            system.debug('Testing User Call----->>'+JSON.serialize(objDocsWrapper));
            
            HttpResponse response1 = http1.send(request1);
            
            // Parse the JSON response
            if (response1.getStatusCode() != 201 ) {
                System.debug('The status code returned was not expected: ' +
                             response1.getStatusCode() + ' ' + response1.getStatus());
                
                // Inserting Request, Response and Response code into the custom object for error handling
                Portal_Integration_Response_Code__c  Portalobj5 = new  Portal_Integration_Response_Code__c ();
                Portalobj5.Request__c = request1.getBody();
                Portalobj5.Response__c = response1.getBody();
                Portalobj5.Success_Error_Code__c = String.valueOf(response1.getStatusCode());
                Portalobj5.Business_Id__c = businessID;
                Portalobj5.Opportunity_Id__c = OpportuntiyConvertedID;
                Portalobj5.Lead_Id__c = LeadId;
                lstOfExceptions2.add(Portalobj5);
            } else {
                System.debug(response1.getBody());
                
                // Inserting Request, Response and Response code into the custom object for error handling
                Portal_Integration_Response_Code__c  Portalobj6 = new  Portal_Integration_Response_Code__c ();
                Portalobj6.Request__c = request1.getBody();
                Portalobj6.Response__c = response1.getBody();
                Portalobj6.Business_Id__c = businessID;
                Portalobj6.Opportunity_Id__c = OpportuntiyConvertedID;
                Portalobj6.Lead_Id__c = LeadId;
                Portalobj6.Success_Error_Code__c = String.valueOf(response1.getStatusCode());
                lstOfExceptions2.add(Portalobj6);
            }
        }
        insert lstOfExceptions2;
    }
    public class webToLeadWrapper
    {
        public list<ListOfLeadData>  listOfLeadData;
    }
    public class ListOfLeadData {
        public string owner_dob;
        public string Have_you_had_a_25_revenue_drop_between;
        public string Who_originated_your_PPP_loan;
        public string Did_you_obtain_a_PPP_loan_in_2020;
        public string Did_you_receive_a_Shuttered_Venue_Operat; 
        public String PPP_First_Draw_SBA_Loan_Number;
        public Decimal PPP_First_Draw_Loan_Amount;
        public Decimal Period_2_Revenue;
        public String networkSelection;
        public String Last_Years_Period;
        public String Proof_of_25_revenue_drop_2020 ;
        public Decimal Period_1_Revenue;
        public String Refinance_of_Eligible_Economic_Injury_Di;
        public String Economic_Injury_Disaster_Loan_Number;
        public string County;
        public string ReferralPartner ;
        public Integer SBAApplicationNumber;
        Public Integer SBALoanNumber;
        public Integer of_Jobs_Retained;
        public string Other;
        public string BuinessState ;       
        public String of_Jobs_Created_30th_June;
        public String Average_Monthly_Payroll;
        public String LeadId ; 
        public String corporateName ; 
        public String dbaName ; 
        public String FirstName ; 
        public String LastName ; 
        public String PhonrNumber ; 
        public String federalTaxId ; 
        public String useOfFunding ; 
        public String salesforceUserId ; 
        public String Email ; 
        public String BusinessName ; 
        public String Whoisyourcustomerbase ; 
        public String Whatdoesyourbusinessdo ; 
        public String WhattypeofBusinessisit ; 
        public String TellusMore ; 
        public boolean Franchise;
        public decimal CurrentSBAEconomicDisasterInjuryLoanBalance;
        
        public String BusinessStartDate ; 
        
        public Integer AmountRequested ; 
        public Boolean Willthisloancreatemorejobs ; 
        public Integer ofemployeesasof12_31_19 ; 
        public Integer ofemployeesasof2_15_2020 ; 
        public Integer AnnualGrossRevenue ; 
        public Integer AnnualPayrollCost ; 
        public Boolean WomenOwnedBusiness ; 
        public String Ethnicity ; 
        public String Race ; 
        public Boolean Veteran ; 
        public Boolean Disabled ; 
        public String ownerEmailAddress ; 
        public String contactEmail ; 
        public String contactFirstName ; 
        public String contactLastName ; 
        public String contactPhone ; 
        public String contactPosition ; 
        public Boolean isBusinessDebtSettled ; 
        public Integer referredBySalesUserId ; 
        public String referredBy ; 
        public Boolean Haveyoueverbeenconvictedofacrime ; 
        public Boolean Arethereanylegalactionspendingagainstyou_oryourspouse ; 
        public Boolean Doyouhaveataxlienoftaxesdue ; 
        public Boolean Haveyoueverdefaultedonagovernmentloan_includedSBAloan_Studentloan_etc ; 
        public Boolean Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins ; 
        public Boolean arethemajorityownesofthebusinessUSCitizensorLegalPermanentResidents ; 
        public Boolean DoestheBusinesshaveexistingSBADebt ; 
        public Boolean HaveyousubmittedaloanrequersttoSBAoranyotheragencyorfinancialinstutiontinconnectionwithCovid_19 ; 
        public Boolean IsTheUnitedStatesThePrincipalPlaceOfResidenceForAllEmployees;
        //converted Integer to String
        public String Stateofincopration ; 
        public String Purposeofloan;
        public String BusinessEIN ; 
        public String BusinessPhone;
        public String Naics;
        public String TIB; 
        //converted Integer to String
        public String BusinessType ; 
        public String BuinessAddress ; 
        public String BuinessCity ; 
        public string BusinessState;
        public String BuinessZip ; 
        public String BusinessWebAdress ; 
        public Boolean DoyourentORownbusinessspace ; 
        public Integer AmountofrentORmtg ; 
        public Integer personalCashBalance ; 
        public String rangeValue ; 
        public Integer netWorth ; 
        public List<Documents> documents ; 
        public List<ListOfOwnersData> listOfOwnersData ;
        //public Boolean Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins ;
        //public Boolean DoestheBusinesshaveexistingSBADebt ;
    }
    
    public class SBA_Documents{
        public string businessId;
        public list<Documents> documents;
    }
    public class Documents {
        public String type;
        public String path;
    }
    public class ListOfOwnersData {
        public String Owner ; 
        public String LeadId ; 
        public String RunCreditReport ; 
        public String ownerCity ; 
        public String ownerCellChone_no ; 
        public String Owner_zipcode ; 
        public String owner_title ; 
        //Converted Integer to String
        public String owner_state ; 
        
        public String owner_SSN ; 
        //Converted Object to String 
        public String Owner_Rent ; 
        
        public String Owner_Phone ; 
        public Integer owner_percentage ; 
        public String owner_last_name ; 
        
        
        public String owner_home_address ; 
        public String owner_first_name ; 
        public String owner_email ; 
        public String owner_dob ; 
        public String Owner_Country ; 
        public Boolean isPrimaryContact ; 
        public Integer CreditScorefromWebform ; 
    }
    
    public class wrapper
    {
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
        public String highest_credit_score;
        public Decimal owner_rent;
        public string owner_home_phone_no;
        public Boolean isPrimaryContact;
        
    }
    
    public class wrapperUserData
    {
        public string salesforceUserId ;
        public string userName ;
        public string email ;
        public string isActive ;
        public string name;
        public string isSalesUser;
    }
    
    
    public class QuickCashFlowDetailsDtos {
        
        public Integer year;
        public Integer months ;
        public Double sales;
        public Double netProfit;
        public Double depreciationAmortizationDepletion;
        public Double interestExpense;
        public Double nonRecurringExpense;
    }
    
    Public class wrapLead {
        public String howDidYouHearAboutUs;
        public String businessStageName;
        public String businessBoroughName;
        public String locationTypeName;
        public String numberOfTempFullTimeEmployees;
        public String numberOfTempPartTimeEmployees;
        
        public String application_id;
        public double eidlAmountRcvd;
        public double pppAmountRcvd;
        public string isPPPLoanForgiven;
        public string isOutstandingLiens;
        public string isBankruptsyFiled;
        
        public string TenantReferralPartnerName;
        public string PreferredLanguage;
        public string Have_you_had_a_25_revenue_drop_between;
        public string Who_originated_your_PPP_loan;
        public string Did_you_obtain_a_PPP_loan_in_2020;
        public string Did_you_receive_a_Shuttered_Venue_Operat; 
        public String PPP_First_Draw_SBA_Loan_Number;
        public Decimal PPP_First_Draw_Loan_Amount;
        public Decimal Period_2_Revenue;
        public String networkSelection;
        public String Last_Years_Period;
        public String Proof_of_25_revenue_drop_2020 ;
        public Decimal Period_1_Revenue;
        public String Refinance_of_Eligible_Economic_Injury_Di;
        public String Economic_Injury_Disaster_Loan_Number;
        public long SBA_ApplicationNumber;
        public long SBALoanNumber;
        public string NAICSCode;
        public string Rural;
        public string scholar_Alumini;
        public string Do_50percentemployeeEarnLess;
        public string net_worth;
        public string business_id;                       
        public string Opportunity_Id;                                  
        public string Lead_Id;                     
        public string corporate_name;                                       
        public string number_of_employees;                      
        public string website_url;                       
        public string campaign;                        
        public string system_identifier ;                      
        public string lead_status;                      
        public string lead_type;                       
        public string is_home_owner;                        
        public string is_disabled;                       
        public string ethnicity;                       
        public string race ;                      
        public string is_veteran;                       
        public string is_women_owned ;                       
        public string amount_requested ;                       
        public string business_duration ;                       
        public string email; 
        
        
        public string loan_number;
        
        public string interest_type;
        public string sales_decline_reason;
        public string loan_type;
        public string processing_fee;
        public string origination_fee;
        public string referral_part_fee;
        public string referral_source;
        
        public String of_employees_added_in_next_12_months;
        public string of_customer_served_monthly;
        
        
        public String business_address;
        public String business_city;
        public String business_state_id;
        public String business_zipcode;
        public String business_country;
        
        public String What_type_of_Business_is_it;
        public String What_does_your_Business_do;
        public String What_your_customer_base;
        public String Tell_us_more;
        public string Phone;
        // ISQ Section Fields  
        public String BriefHistoryontheowner;  
        public String whatExactlyDoesTheBusinessdo;  
        public String Whoisyourcustomerbase;  
        public String DoYouCarryLifeInsurance;  
        public String PlannedChangesInNext6Months;  
        public String BriefHistoryonthebusiness;  
        public String Whatarethetermsofyourcurrentlease;  
        public String Whatisthepurposeofloan;  
        public String AreyouCOD306090;  
        public String Doyoupaychildsupportoralimony;  
        public String ExplanationofanyBKsdefaultsetc;
        public Boolean Willthisloancreatemorejobs ; 
        public String Purposeofloan;
        public String SBA_PPP_Loan_Application_Form;
        public String Tax_Year_Used;
        public decimal CurrentSBAEconomicDisasterInjuryLoanBalance;
        public list<wrapper> ownerInfoList;
        public List<QuickCashFlowDetailsDtos> quickCashFlowDetailsDtos;
        public Boolean Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins;
        public Boolean DoestheBusinesshaveexistingSBADebt;
    }
    
    public class WrapLeadUpdateRes
    {
        public string business_id;
        public string sales_decline_reason;
        public string processing_fee;
        public string origination_fee;
        public string referral_part_fee;
        public string referral_source;
        public string closing_fee;
        public String system_identifier;
        public String interest_type;
        public String referral_partner;
        public String sales_representative;
        public String referral_partner_email;
        public String loan_type;
        public Boolean Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins;
        public Boolean DoestheBusinesshaveexistingSBADebt;
        
    }
    
}