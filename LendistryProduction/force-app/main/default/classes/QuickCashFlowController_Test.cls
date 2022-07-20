@isTest(seeAllData=true)
public class QuickCashFlowController_Test {
public  static testMethod void setup()
    {
        
        
        Lead objLead = new Lead();
        objLead.Title = 'Mr.';
        objLead.FirstName = 'FirstName';
        objLead.LastName = 'test';
        objLead.Company = 'Test';
        objlead.Base64_Encoded_Pardot_Url_Parameter__c = 'MDBRMmEwMDAwMDVPbkxGRUEwfHwwMi4wMi4yMDIwIDE5OjAw';
        objLead.Entity_Type__c = 'Corporation';
        objlead.DoNotCall = false;
        objlead.HasOptedOutOfFax = false;
        objlead.Phone = '963-258-7410';
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
        //objlead.DOB_Owner_1__c = Date.valueof(System.now()-100;
        
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
        ObjLead.Phone_2nd_Owner__c = '894-752-3713';
        objLead.of_Ownership_Second_Owner__c = 10;
        objLead.City_Owner_2__c = 'Anthill';
        ObjLead.Credit_Score_2nd_Owner__c = '600 to 650';
        objLead.Run_Owner2_Credit_Report__c =true;
        objLead.Owner_ID_Owner_2__c = '124';
       // objlead.DOB_Owner_2__c = Date.valueof(System.now()-100);
        //Third Owner Details
        objLead.First_Name_3rd_Owner__c = 'ThirdName';
        objLead.Last_Name_3rd_Owner__c = 'LastName';
        objLead.SSN_3rd_Owner__c = '000-00-0001';
        objLead.of_Ownership_3rd_Owner__c = 10;
        objLead.City_Owner_3__c = 'Anthill';
        objLead.Email_3rd_Owner__c = 'third@gmail.com';
        objLead.Street_Owner_3__c = '220 Locust Ave';
        objLead.State_Owner_3__c = 'MO';
        objLead.Title_3rd_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_3__c ='65488';
        objLead.Country_Owner_3__c = 'US';
        ObjLead.Credit_Score_3rd_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_3rd_Owner__c = '894-752-3713';
        objLead.Run_Owner3_Credit_Report__c =true;
        objLead.Owner_ID_Owner_3__c = '125';
       // objlead.DOB_Owner_3__c = Date.valueof(System.now()-100);
        //Fourth Owner details
        objLead.First_Name_4th_Owner__c = 'FourthName';
        objLead.Last_Name_4th_Owner__c = 'LastName';
        objLead.SSN_4th_Owner__c = '000-00-0001';
        objLead.of_Ownership_4th_Owner__c = 10;
        objLead.City_Owner_4__c = 'Anthill';
        objLead.Email_4th_Owner__c = 'fourth@gmail.com';
        objLead.Street_Owner_4__c = '220 Locust Ave';
        objLead.State_Owner_4__c = 'MO';
        objLead.Title_4th_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_4__c = '65488';
        objLead.Country_Owner_4__c = 'US';
        ObjLead.Credit_Score_4th_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_4th_Owner__c = '894-752-3713';
        objLead.Run_Owner4_Credit_Report__c=true;
        objLead.Owner_ID_Owner_4__c = '126';
        //
        //objlead.DOB_Owner_4__c = Date.valueof(System.now()-100);
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
        ObjLead.Phone_5th_Owner__c = '894-752-3713';
        ObjLead.Run_Owner5_Credit_Report__c =true;
        objLead.Owner_ID_Owner_5__c = '127';
       // objlead.DOB_Owner_5__c = Date.valueof(System.now()-100);
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
        objlead.Loan_Type__c = 'STL';
        insert objLead;
        
        
        //Insert quickCashFlow 
        
        Quick_Cash_Flow__c quickCashFlow = new Quick_Cash_Flow__c ();
        quickCashFlow.Taxes_O1_CY__c = 785;
        quickCashFlow.Taxes_O2_CY__c = 78;
        quickCashFlow.Taxes_O3_CY__c = 78;
        quickCashFlow.Taxes_O4_CY__c = 79;
        quickCashFlow.Taxes_O5_CY__c = 96;
        quickCashFlow.Interest_Exp_CY3__c = 11221;
        quickCashFlow.Non_Recurring_Expenses_CY__c = 1;
        quickCashFlow.Non_Recurring_Expenses_CY1__c = 1;
        quickCashFlow.Non_Recurring_Expenses_CY2__c = 1;
        quickCashFlow.Non_Recurring_Expenses_CY3__c = 11212;
        quickCashFlow.Affilliate_Income_CY__c = 12;
        quickCashFlow.Affilliate_Income_CY1__c = 12;
        quickCashFlow.Affilliate_Income_CY2__c = 12;
        quickCashFlow.Affilliate_Income_CY3__c = 121212;
        quickCashFlow.Owner_1_Personal_Disc_SD_CY1__c = -12000;
        quickCashFlow.Owner_1_Personal_Disc_SD_CY2__c = -12000;
        quickCashFlow.Owner_1_Personal_Disc_SD_CY__c = -12000;
        quickCashFlow.Owner_1_Personal_Disc_SD_CY3__c = -11000;
        quickCashFlow.Owner_2_Personal_Disc_SD_CY__c = -11962;
        quickCashFlow.Owner_2_Personal_Disc_SD_CY1__c = -11963;
        quickCashFlow.Owner_2_Personal_Disc_SD_CY2__c = -11964;
        quickCashFlow.Owner_2_Personal_Disc_SD_CY3__c = -10978;
        quickCashFlow.Owner_3_Personal_Disc_SD_CY__c = 0;
        quickCashFlow.Owner_3_Personal_Disc_SD_CY1__c = 0;
        quickCashFlow.Owner_3_Personal_Disc_SD_CY2__c = 0;
        quickCashFlow.Owner_3_Personal_Disc_SD_CY3__c = 0;
        quickCashFlow.Owner_4_Personal_Disc_SD_CY__c = 0;
        quickCashFlow.Owner_4_Personal_Disc_SD_CY1__c = 0;
        quickCashFlow.Owner_4_Personal_Disc_SD_CY2__c = 0;
        quickCashFlow.Owner_4_Personal_Disc_SD_CY3__c = 0;
        quickCashFlow.Total_First_CY__c = 4;
        quickCashFlow.Total_First_CY1__c = 4;
        quickCashFlow.Total_First_CY2__c = 4;
        quickCashFlow.Monthly_Existing_Installment_Debt_CY__c = 300;
        quickCashFlow.Total_First_CY3__c = 44856;
        quickCashFlow.Monthly_Existing_Installment_Debt_CY1__c = 300;
        quickCashFlow.Monthly_Existing_Installment_Debt_CY2__c = 300;
        quickCashFlow.Monthly_Existing_Installment_Debt_CY3__c = 300;
        quickCashFlow.Annual_Existing_P_I_CY__c = 3600;
        quickCashFlow.Annual_Existing_P_I_CY1__c = 3600;
        quickCashFlow.Annual_Existing_P_I_CY2__c = 3600;
        quickCashFlow.Annual_Existing_P_I_CY3__c = 3300;
        quickCashFlow.Proposed_P_I_CY__c = 37147;
        quickCashFlow.Proposed_P_I_CY1__c = 37147;
        quickCashFlow.Proposed_P_I_CY2__c = 37147;
        quickCashFlow.Proposed_P_I_CY3__c = 34051.4;
        quickCashFlow.Total_Second_CY__c = 40747;
        quickCashFlow.Total_Second_CY2__c = 40747;
        quickCashFlow.Total_Second_CY1__c = 40747;
        quickCashFlow.Total_Second_CY3__c = 37351.4;
        quickCashFlow.Global_Coverage_Ratio_CY__c = -0.59;
        quickCashFlow.Global_Coverage_Ratio_CY1__c = -0.59;
        quickCashFlow.Global_Coverage_Ratio_CY2__c = -0.59;
        quickCashFlow.Global_Coverage_Ratio_CY3__c = 3.86;
        quickCashFlow.Business_Coverage_Ratio_CY__c = 0;
        quickCashFlow.Business_Coverage_Ratio_CY1__c = 0;
        quickCashFlow.Business_Coverage_Ratio_CY2__c = 0;
        quickCashFlow.Business_Coverage_Ratio_CY3__c = 1.2;
        quickCashFlow.Time_in_Business_Months__c = 227;
        quickCashFlow.Estimated_CCR__c = 1;
        quickCashFlow.Industry_High_Risk__c = false;
        quickCashFlow.Loan_Amount_Actual__c = 150000;
        quickCashFlow.Loan_Amount_Status__c = true;
        quickCashFlow.Interest_Rate_Adjusted__c = 8.75;
        quickCashFlow.Interest_Rate_Status__c = false;
        quickCashFlow.Term_Months_Actual__c = 25;
        quickCashFlow.Term_Months_Adjusted__c = 60;
        quickCashFlow.Term_Months_Status__c = false;
        quickCashFlow.DueIn_Months_Actual__c = 19;
        quickCashFlow.DueIn_Months_Status__c = false;
        quickCashFlow.Projected_Daily_Payment__c = 147.4086773328258;
        quickCashFlow.Projected_Monthly_Payment__c = 3095.5822239893414;
        quickCashFlow.Projected_Weekly_Payment__c = 714.3651286129249;
        quickCashFlow.Projected_Annual_Payment__c = 37146.98668787209;
        quickCashFlow.Projected_BiWeekly_Payment__c = 1428.73025722585;
        quickCashFlow.Projected_SemiMonthly_Payment__c = 1547.7911119946707;
        quickCashFlow.Interestdividend_Income_O1_CY__c = 2;
        quickCashFlow.Interestdividend_Income_CY1__c = 2;
        quickCashFlow.Interestdividend_Income_CY2__c = 2;
        quickCashFlow.Interestdividend_Income_CY3__c = 2;
        quickCashFlow.K1_Distributions_O1_CY__c = 5;
        quickCashFlow.K1_Distributions_O1_CY1__c = 5;
        quickCashFlow.K1_Distributions_O1_CY2__c = 5;
        quickCashFlow.K1_Distributions_O1_CY3__c = 5;
        quickCashFlow.Other_Income_O1_CY__c = 4;
        quickCashFlow.Other_Income_O1_CY1__c = 4;
        quickCashFlow.Other_Income_O1_CY2__c = 3;
        quickCashFlow.Other_Income_O1_CY3__c = 2;
        quickCashFlow.PensionIRA_Distributions_O1_CY__c = 5;
        quickCashFlow.PensionIRA_Distributions_O1_CY1__c = 5;
        quickCashFlow.PensionIRA_Distributions_O1_CY2__c = 5;
        quickCashFlow.Salary_Wages_Borrower_O1_CY__c = 3;
        quickCashFlow.Salary_Wages_Borrower_O1_CY1__c = 2;
        quickCashFlow.Salary_Wages_Borrower_O1_CY2__c = 2;
        quickCashFlow.Salary_Wages_Borrower_O1_CY3__c = 1;
        quickCashFlow.Salary_Wages_Spouse_O1_CY__c = 2;
        quickCashFlow.Salary_Wages_Spouse_O1_CY1__c = 2;
        quickCashFlow.Salary_Wages_Spouse_O1_CY2__c = 2;
        quickCashFlow.Salary_Wages_Spouse_O1_CY3__c = 2;
        quickCashFlow.Sch_D_Capital_gainslosses_O1_CY__c = 5;
        quickCashFlow.Sch_D_Capital_gainslosses_O1_CY1__c = 5;
        quickCashFlow.Sch_D_Capital_gainslosses_O1_CY2__c = 5;
        quickCashFlow.Sch_D_Capital_gainslosses_O1_CY3__c = 5;
        quickCashFlow.Schedule_C_Income_O1_CY__c = 5;
        quickCashFlow.Schedule_C_Income_O1_CY1__c = 5;
        quickCashFlow.Schedule_C_Income_O1_CY2__c = 5;
        quickCashFlow.Schedule_E_Rental_O1_CY__c = 5;
        quickCashFlow.Schedule_E_Rental_O1_CY1__c = 5;
        quickCashFlow.Schedule_E_Rental_O1_CY2__c = 5;
        quickCashFlow.Schedule_E_Rental_O1_CY3__c = 5;
        quickCashFlow.Other_GuaranteedwagesaffiliatesO1CY1__c = 2;
        quickCashFlow.Other_GuaranteedwagesaffiliatesO1CY2__c = 2;
        quickCashFlow.Other_GuaranteedwagesaffiliatesO1CY3__c = 2;
        quickCashFlow.Owner1_Adult__c = 1;
        quickCashFlow.Owner2_Adult__c = 1;
        quickCashFlow.Owner1_Kid__c = 2;
        quickCashFlow.Owner1_Adult_Currency__c = 6000;
        quickCashFlow.Owner2_Adult_Currency__c = 6000;
        quickCashFlow.Owner1_Kid_Currency__c = 6000;
        quickCashFlow.Owner2_Kid_Currency__c = 6000;
        quickCashFlow.Residence_Mortgage_Owner_1__c = 22;
        quickCashFlow.Residence_Mortgage_Owner_2__c = 22;
        quickCashFlow.Residence_Mortgage_Owner_3__c = 33;
        quickCashFlow.Residence_Mortgage_Owner_4__c = 44;
        quickCashFlow.Residence_Mortgage_Owner_5__c = 55;
        quickCashFlow.Rental_Payment_Owner_1__c = 2;
        quickCashFlow.HELOC_Owner_1__c = 3;
        quickCashFlow.Installment_Debt_Owner_1__c = 4;
        quickCashFlow.Total_Annual_Debt_Service_Owner_1__c = 24;
        quickCashFlow.Months_CY1__c = 12;
        quickCashFlow.Months_CY__c = 12;
        quickCashFlow.Months_CY2__c = 12;
        quickCashFlow.Months_CY3__c = 11;
        quickCashFlow.Sales_CY__c = 1;
        quickCashFlow.Sales_CY1__c = 1;
        quickCashFlow.Sales_CY2__c = 1;
        quickCashFlow.Sales_CY3__c = 1212;
        quickCashFlow.Net_Profit_CY__c = 1;
        quickCashFlow.Net_Profit_CY1__c = 1;
        quickCashFlow.Net_Profit_CY2__c = 1;
        quickCashFlow.Net_Profit_CY3__c = 11212;
        quickCashFlow.New_Rents_CY__c = 1;
        quickCashFlow.New_Rents_CY1__c = 1;
        quickCashFlow.New_Rents_CY2__c = 1;
        quickCashFlow.New_Rents_CY3__c = 11211;
        quickCashFlow.Interest_Exp_CY__c = 1;
        quickCashFlow.Interest_Exp_CY1__c = 1;
        quickCashFlow.Interest_Exp_CY2__c = 1;
        quickCashFlow.Lead__c = objLead.Id;
        insert quickCashFlow;
    
    
    
    }

    public static Lead getLeadByFirstNameLastNameCompany(String fistName, String Lastname, String Company) {
        Lead objLead = [SELECT ID 
                              FROM Lead
                              WHERE FirstName =:fistName AND lastname =:Lastname AND Company =:Company
                              LIMIT 1];
        return objLead;
    }

   
    private static testMethod void testRunQuickCashFlow() {
        setup();
        Lead objLead = getLeadByFirstNameLastNameCompany('FirstName', 'test','test');
        Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());

        QuickCashFlowController.mainWrapper mainWrapper = new QuickCashFlowController.mainWrapper();
        QuickCashFlowController.mainWrapper mainWrapper2 = new QuickCashFlowController.mainWrapper();

        Test.startTest();
            mainWrapper2 = QuickCashFlowController.getQuickCashFlowData(mainWrapper ,objLead.Id);
            QuickCashFlowController.saveQCFData(mainWrapper2,objLead.Id);
        Test.stopTest();
        
      
    }

    
    private static testmethod void testSaveQCFData() {
    setup();
        Lead objLead = getLeadByFirstNameLastNameCompany('FirstName', 'test','test');
        Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());
        QuickCashFlowController.mainWrapper mainWrapper = new QuickCashFlowController.mainWrapper();
        QuickCashFlowController.mainWrapper mainWrapper2 = new QuickCashFlowController.mainWrapper();

        Test.startTest();
            mainWrapper2 = QuickCashFlowController.getQuickCashFlowData(mainWrapper ,objLead.Id);
            QuickCashFlowController.runQuickCashFlow(mainWrapper2,objLead.Id);
        Test.stopTest();
        
      
    }
}