public with sharing class QuickCashFlowController {
   
    public static Double highestCreditScore;
    @AuraEnabled
    public static mainWrapper getQuickCashFlowData( mainWrapper mainWrapperData, string leadID) {
        mainWrapper objMainWrapper = new mainWrapper(); 
        list<Quick_Cash_Flow__c> lstQuick_Cash_Flow = new list<Quick_Cash_Flow__c>();
        // DESCENDING ORDER
		List<Double> highestCreditScoreList = new List<Double>();
        String PortalBaseURL;
        //objMainWrapper=mainWrapperData;
        list<Portal_Integration_Response_Code__c > lstOfExceptions = new list< Portal_Integration_Response_Code__c >();
        lead objlead = new lead();
        Quick_Cash_Flow__c ObjQuickCashFlow = new Quick_Cash_Flow__c();
        system.debug('leadID---->>'+leadID);
        
        Integer CY = Date.Today().Year();
        Integer CY_1 = (CY-1);
        Integer CY_2 = (CY-2);
        Integer CY_3 = (CY-3);
        if( leadID != null && leadID != '')
        {
        objlead =[ Select Id,PortalAPIEndPoint__c,Actual_Owner1_Credit_Score__c, Actual_Owner2_Credit_Score__c,Actual_Owner3_Credit_Score__c,Actual_Owner4_Credit_Score__c,Actual_Owner5_Credit_Score__c, SSN1__c,Name,SSN2__c,First_Name_2nd_Owner__c,Last_Name_2nd_Owner__c, SSN_3rd_Owner__c,First_Name_3rd_Owner__c,Last_Name_3rd_Owner__c,SSN_4th_Owner__c,
                  First_Name_4th_Owner__c,Last_Name_4th_Owner__c,SSN_5th_Owner__c,First_Name_5th_Owner__c,Last_Name_5th_Owner__c,Application_ID__c,Loan_Type__c,BusinessId__c,Requested_Amount__c,
                  Referral_Partner__c,TIB_Months__c,OwnerId,Referral_Partner__r.Name,owner.name from lead where id=:leadID]; 
        
        lstQuick_Cash_Flow = [SELECT Id, RETaxes_O1_CY__c,RETaxes_O1_CY1__c,RETaxes_O1_CY2__c,RETaxes_O1_CY3__c,RETaxes_O2_CY__c,RETaxes_O2_CY1__c,RETaxes_O2_CY2__c,RETaxes_O2_CY3__c,RETaxes_O3_CY__c,RETaxes_O3_CY1__c,RETaxes_O3_CY2__c,RETaxes_O3_CY3__c,RETaxes_O4_CY__c,RETaxes_O4_CY1__c,RETaxes_O4_CY2__c,RETaxes_O4_CY3__c,RETaxes_O5_CY__c,RETaxes_O5_CY1__c,RETaxes_O5_CY2__c,RETaxes_O5_CY3__c,Taxes_O1_CY__c,Taxes_O1_CY1__c,Taxes_O1_CY2__c,Taxes_O1_CY3__c,Taxes_O2_CY__c,Taxes_O2_CY1__c,Taxes_O2_CY2__c,Taxes_O2_CY3__c,Taxes_O3_CY__c,Taxes_O3_CY1__c,Taxes_O3_CY2__c,Taxes_O3_CY3__c,Taxes_O4_CY__c,Taxes_O4_CY1__c,Taxes_O4_CY2__c,Taxes_O4_CY3__c,Taxes_O5_CY__c,Taxes_O5_CY1__c,Taxes_O5_CY2__c,Taxes_O5_CY3__c,Total_Taxes_O1_CY__c,Total_Taxes_O1_CY1__c,Total_Taxes_O1_CY2__c,Total_Taxes_O1_CY3__c,Total_Taxes_O2_CY__c,Total_Taxes_O2_CY1__c,Total_Taxes_O2_CY2__c,Total_Taxes_O2_CY3__c,Total_Taxes_O3_CY__c,Total_Taxes_O3_CY1__c,Total_Taxes_O3_CY2__c,Total_Taxes_O3_CY3__c,Total_Taxes_O4_CY__c,Total_Taxes_O4_CY1__c,Total_Taxes_O4_CY2__c,Total_Taxes_O4_CY3__c,Total_Taxes_O5_CY__c,Total_Taxes_O5_CY1__c,Total_Taxes_O5_CY2__c,Total_Taxes_O5_CY3__c,Living_Expenses_O1_CY__c,Living_Expenses_O1_CY1__c,Living_Expenses_O1_CY2__c,Living_Expenses_O1_CY3__c,Living_Expenses_O2_CY__c,Living_Expenses_O2_CY1__c,Living_Expenses_O2_CY2__c,Living_Expenses_O2_CY3__c,Living_Expenses_O3_CY__c,Living_Expenses_O3_CY1__c,Living_Expenses_O3_CY2__c,Living_Expenses_O3_CY3__c,Living_Expenses_O4_CY__c,Living_Expenses_O4_CY1__c,Living_Expenses_O4_CY2__c,Living_Expenses_O4_CY3__c,Living_Expenses_O5_CY__c,Living_Expenses_O5_CY1__c,Living_Expenses_O5_CY2__c,Living_Expenses_O5_CY3__c,Total_Estimated_Personal_O5_CY3__c, Total_Estimated_Personal_O5_CY2__c, Total_Estimated_Personal_O5_CY1__c, Total_Estimated_Personal_O5_CY__c, Total_Estimated_Personal_O4_CY3__c, Total_Estimated_Personal_O4_CY2__c, Total_Estimated_Personal_O4_CY1__c, Total_Estimated_Personal_O4_CY__c, Total_Estimated_Personal_O3_CY3__c, Total_Estimated_Personal_O3_CY2__c, Total_Estimated_Personal_O3_CY1__c, Total_Estimated_Personal_O3_CY__c,Total_Estimated_Personal_O2_CY3__c, Total_Estimated_Personal_O2_CY2__c, Total_Estimated_Personal_O2_CY1__c, Total_Estimated_Personal_O2_CY__c,  Total_Estimated_Personal_O1_CY3__c, Total_Estimated_Personal_O1_CY2__c, Total_Estimated_Personal_O1_CY1__c, Total_Estimated_Personal_O1_CY__c, OwnerId,Residence_Mortgage_Owner_1__c, Residence_Mortgage_Owner_2__c, Residence_Mortgage_Owner_3__c, Residence_Mortgage_Owner_4__c,
        Residence_Mortgage_Owner_5__c, Rental_Payment_Owner_1__c, Rental_Payment_Owner_2__c, Rental_Payment_Owner_3__c, Rental_Payment_Owner_4__c, Rental_Payment_Owner_5__c, HELOC_Owner_1__c  , HELOC_Owner_2__c  , HELOC_Owner_3__c  , HELOC_Owner_4__c  , HELOC_Owner_5__c  , Installment_Debt_Owner_1__c, Installment_Debt_Owner_2__c  , Installment_Debt_Owner_3__c   , Installment_Debt_Owner_4__c   , Installment_Debt_Owner_5__c   , Credit_Card_Debt_Owner_1__c, Credit_Card_Debt_Owner_2__c, Credit_Card_Debt_Owner_3__c, Credit_Card_Debt_Owner_4__c, Credit_Card_Debt_Owner_5__c, Other_debt_Owner_1__c, Other_debt_Owner_2__c, Other_debt_Owner_3__c, Other_debt_Owner_4__c, Other_debt_Owner_5__c, Total_Annual_Debt_Service_Owner_1__c, Total_Annual_Debt_Service_Owner_2__c, Total_Annual_Debt_Service_Owner_3__c, Total_Annual_Debt_Service_Owner_4__c, Total_Annual_Debt_Service_Owner_5__c,  IsDeleted, Name, CreatedDate, CreatedById, Test__c, Months_CY1__c, 
                              Months_CY__c, Months_CY2__c, Months_CY3__c, Sales_CY__c, Sales_CY1__c, Sales_CY2__c, Sales_CY3__c, Net_Profit_CY__c, Net_Profit_CY1__c, 
                              Net_Profit_CY2__c, Net_Profit_CY3__c, New_Rents_CY__c, New_Rents_CY1__c, New_Rents_CY2__c, New_Rents_CY3__c, Interest_Exp_CY__c, Interest_Exp_CY1__c, 
                              Interest_Exp_CY2__c, Interest_Exp_CY3__c, Non_Recurring_Expenses_CY__c, Non_Recurring_Expenses_CY1__c, Non_Recurring_Expenses_CY2__c, 
                              Non_Recurring_Expenses_CY3__c, Affilliate_Income_CY__c, Affilliate_Income_CY1__c, Affilliate_Income_CY2__c, Affilliate_Income_CY3__c, 
                              Owner_1_Personal_Disc_SD_CY1__c, Owner_1_Personal_Disc_SD_CY2__c, Owner_1_Personal_Disc_SD_CY__c, Owner_1_Personal_Disc_SD_CY3__c, 
                              Owner_2_Personal_Disc_SD_CY__c, Owner_2_Personal_Disc_SD_CY1__c, Owner_2_Personal_Disc_SD_CY2__c, Owner_2_Personal_Disc_SD_CY3__c, 
                              Owner_3_Personal_Disc_SD_CY__c, Owner_3_Personal_Disc_SD_CY1__c, Owner_3_Personal_Disc_SD_CY2__c, Owner_3_Personal_Disc_SD_CY3__c, 
                              Owner_4_Personal_Disc_SD_CY__c, Owner_4_Personal_Disc_SD_CY1__c, Owner_4_Personal_Disc_SD_CY2__c, Owner_4_Personal_Disc_SD_CY3__c, Total_First_CY__c, 
                              Total_First_CY1__c, Total_First_CY2__c, Monthly_Existing_Installment_Debt_CY__c, Total_First_CY3__c, Monthly_Existing_Installment_Debt_CY1__c, 
                              Monthly_Existing_Installment_Debt_CY2__c, Monthly_Existing_Installment_Debt_CY3__c, Annual_Existing_P_I_CY__c, Annual_Existing_P_I_CY1__c, 
                              Annual_Existing_P_I_CY2__c, Annual_Existing_P_I_CY3__c, Proposed_P_I_CY__c, Proposed_P_I_CY1__c, Proposed_P_I_CY2__c, Proposed_P_I_CY3__c, 
                              Total_Second_CY__c, Total_Second_CY2__c, Total_Second_CY1__c, Total_Second_CY3__c, Global_Coverage_Ratio_CY__c, Global_Coverage_Ratio_CY1__c, 
                              Global_Coverage_Ratio_CY2__c, Global_Coverage_Ratio_CY3__c, Business_Coverage_Ratio_CY__c, Business_Coverage_Ratio_CY1__c, Business_Coverage_Ratio_CY2__c, 
                              Business_Coverage_Ratio_CY3__c, Discretionary_Coverage_Ratio_CY__c, Discretionary_Coverage_Ratio_CY1__c, Discretionary_Coverage_Ratio_CY2__c, 
                              Discretionary_Coverage_Ratio_CY3__c, Highest_Credit_Score__c, Time_in_Business_Months__c, Estimated_CCR__c, Industry_High_Risk__c, Loan_Amount_Actual__c, 
                              Loan_Amount_Adjusted__c,  Interest_Rate_Actual__c, Interest_Rate_Adjusted__c,  Term_Months_Actual__c, 
                              Term_Months_Adjusted__c, DueIn_Months_Actual__c, DueIn_Months_Adjusted__c,  Projected_Daily_Payment__c, 
                              Projected_Monthly_Payment__c, Projected_Weekly_Payment__c, Projected_Annual_Payment__c, Projected_BiWeekly_Payment__c, Projected_SemiMonthly_Payment__c, 
                              Other_Income_O3_CY2__c,Interestdividend_Income_O1_CY__c, Interestdividend_Income_O2_CY__c, Interestdividend_Income_O3_CY__c, Interestdividend_Income_O4_CY__c, Interestdividend_Income_O5_CY__c, Interestdividend_Income_CY1__c, Interestdividend_Income_O2_CY1__c, Interestdividend_Income_O3_CY1__c, Interestdividend_Income_O4_CY1__c, Interestdividend_Income_O5_CY1__c, Interestdividend_Income_CY2__c, Interestdividend_Income_O2_CY2__c, Interestdividend_Income_O3_CY2__c, Interestdividend_Income_O4_CY2__c, Interestdividend_Income_O5_CY2__c, Interestdividend_Income_CY3__c, Interestdividend_Income_O2_CY3__c, Interestdividend_Income_O3_CY3__c, Interestdividend_Income_O4_CY3__c, Interestdividend_Income_O5_CY3__c, K1_Distributions_O1_CY__c, K1_Distributions_O2_CY__c, K1_Distributions_O3_CY__c, K1_Distributions_O4_CY__c, K1_Distributions_O5_CY__c, K1_Distributions_O1_CY1__c, K1_Distributions_O2_CY1__c, K1_Distributions_O3_CY1__c, K1_Distributions_O4_CY1__c, K1_Distributions_O5_CY1__c, K1_Distributions_O1_CY2__c, K1_Distributions_O2_CY2__c, K1_Distributions_O3_CY2__c, K1_Distributions_O4_CY2__c, K1_Distributions_O5_CY2__c, K1_Distributions_O1_CY3__c, K1_Distributions_O2_CY3__c, K1_Distributions_O3_CY3__c, K1_Distributions_O4_CY3__c, K1_Distributions_O5_CY3__c, Other_Guaranteed_wages_affiliates_O1_CY__c, Other_Guaranteed_wages_affiliates_O2_CY__c, Other_Guaranteed_wages_affiliates_O3_CY__c, Other_Guaranteed_wages_affiliates_O4_CY__c, Other_Guaranteed_wages_affiliates_O5_CY__c, Other_Income_O1_CY__c, Other_Income_O2_CY__c, Other_Income_O3_CY__c, Other_Income_O4_CY__c, Other_Income_O5_CY__c, Other_Income_O1_CY1__c, Other_Income_O2_CY1__c, Other_Income_O3_CY1__c, Other_Income_O4_CY1__c, Other_Income_O5_CY1__c, Other_Income_O1_CY2__c, Other_Income_O2_CY2__c, Other_Income_O1_CY3__c, Other_Income_O4_CY2__c, Other_Income_O5_CY2__c, Other_Income_O3_CY3__c, Other_Income_O4_CY3__c, Other_Income_O5_CY3__c, PensionIRA_Distributions_O1_CY__c, PensionIRA_Distributions_O2_CY__c, PensionIRA_Distributions_O3_CY__c, PensionIRA_Distributions_O4_CY__c, PensionIRA_Distributions_O5_CY__c, PensionIRA_Distributions_O1_CY1__c, PensionIRA_Distributions_O2_CY1__c, PensionIRA_Distributions_O3_CY1__c, PensionIRA_Distributions_O4_CY1__c, PensionIRA_Distributions_O5_CY1__c, PensionIRA_Distributions_O1_CY2__c, PensionIRA_Distributions_O2_CY2__c, PensionIRA_Distributions_O3_CY2__c, PensionIRA_Distributions_O4_CY2__c, PensionIRA_Distributions_O5_CY2__c, PensionIRA_Distributions_O1_CY3__c, PensionIRA_Distributions_O2_CY3__c, PensionIRA_Distributions_O3_CY3__c, PensionIRA_Distributions_O4_CY3__c, PensionIRA_Distributions_O5_CY3__c, Salary_Wages_Borrower_O1_CY__c, Salary_Wages_Borrower_O2_CY__c, Salary_Wages_Borrower_O3_CY__c, Salary_Wages_Borrower_O4_CY__c, Salary_Wages_Borrower_O5_CY__c, Salary_Wages_Borrower_O2_CY1__c, Salary_Wages_Borrower_O3_CY1__c, Salary_Wages_Borrower_O1_CY1__c, Salary_Wages_Borrower_O4_CY1__c, Salary_Wages_Borrower_O5_CY1__c, Salary_Wages_Borrower_O1_CY2__c, Salary_Wages_Borrower_O2_CY2__c, Salary_Wages_Borrower_O3_CY2__c, Salary_Wages_Borrower_O4_CY2__c, Salary_Wages_Borrower_O5_CY2__c, Salary_Wages_Borrower_O1_CY3__c, Salary_Wages_Borrower_O2_CY3__c, Salary_Wages_Borrower_O3_CY3__c, Salary_Wages_Borrower_O4_CY3__c, Salary_Wages_Borrower_O5_CY3__c, Salary_Wages_Spouse_O1_CY__c, Salary_Wages_Spouse_O2_CY__c, Salary_Wages_Spouse_O3_CY__c, Salary_Wages_Spouse_O4_CY__c, Salary_Wages_Spouse_O5_CY__c, Salary_Wages_Spouse_O1_CY1__c, Salary_Wages_Spouse_O2_CY1__c, Salary_Wages_Spouse_O3_CY1__c, Salary_Wages_Spouse_O4_CY1__c, Salary_Wages_Spouse_O5_CY1__c, Salary_Wages_Spouse_O1_CY2__c, Salary_Wages_Spouse_O2_CY2__c, Salary_Wages_Spouse_O3_CY2__c, Salary_Wages_Spouse_O4_CY2__c, Salary_Wages_Spouse_O5_CY2__c, Salary_Wages_Spouse_O1_CY3__c, Salary_Wages_Spouse_O2_CY3__c, Salary_Wages_Spouse_O3_CY3__c, Salary_Wages_Spouse_O4_CY3__c, Salary_Wages_Spouse_O5_CY3__c, Sch_D_Capital_gainslosses_O1_CY__c, Sch_D_Capital_gainslosses_O2_CY__c, Sch_D_Capital_gainslosses_O3_CY__c, Sch_D_Capital_gainslosses_O4_CY__c, Sch_D_Capital_gainslosses_O5_CY__c, Sch_D_Capital_gainslosses_O1_CY1__c, Sch_D_Capital_gainslosses_O2_CY1__c, Sch_D_Capital_gainslosses_O3_CY1__c, Sch_D_Capital_gainslosses_O4_CY1__c, Sch_D_Capital_gainslosses_O5_CY1__c, Sch_D_Capital_gainslosses_O1_CY2__c, Sch_D_Capital_gainslosses_O2_CY2__c, Sch_D_Capital_gainslosses_O3_CY2__c, Sch_D_Capital_gainslosses_O4_CY2__c, Sch_D_Capital_gainslosses_O5_CY2__c, Sch_D_Capital_gainslosses_O1_CY3__c, Sch_D_Capital_gainslosses_O2_CY3__c, Sch_D_Capital_gainslosses_O3_CY3__c, Sch_D_Capital_gainslosses_O4_CY3__c, Schedule_C_Income_O1_CY__c, Schedule_C_Income_O2_CY__c, Sch_D_Capital_gainslosses_O5_CY3__c, Schedule_C_Income_O3_CY__c, Schedule_C_Income_O4_CY__c, Schedule_C_Income_O5_CY__c, Schedule_C_Income_O1_CY1__c, Schedule_C_Income_O2_CY1__c, Schedule_C_Income_O3_CY1__c, Schedule_C_Income_O4_CY1__c, Schedule_C_Income_O5_CY1__c, Schedule_C_Income_O1_CY2__c, Schedule_C_Income_O2_CY2__c, Schedule_C_Income_O3_CY2__c, Schedule_C_Income_O4_CY2__c, Schedule_C_Income_O5_CY2__c, Schedule_C_Income_O1_CY3__c, Schedule_C_Income_O2_CY3__c, Schedule_C_Income_O3_CY3__c, Schedule_C_Income_O4_CY3__c, Schedule_C_Income_O5_CY3__c, Schedule_E_Rental_O1_CY__c, Schedule_E_Rental_O2_CY__c, Schedule_E_Rental_O3_CY__c, Schedule_E_Rental_O4_CY__c, Schedule_E_Rental_O5_CY__c, Schedule_E_Rental_O1_CY1__c, Schedule_E_Rental_O2_CY1__c, Schedule_E_Rental_O3_CY1__c, Schedule_E_Rental_O4_CY1__c, Schedule_E_Rental_O5_CY1__c, Schedule_E_Rental_O1_CY2__c, Schedule_E_Rental_O2_CY2__c, Schedule_E_Rental_O3_CY2__c, Schedule_E_Rental_O4_CY2__c, Schedule_E_Rental_O5_CY2__c, Schedule_E_Rental_O1_CY3__c, Schedule_E_Rental_O2_CY3__c, Schedule_E_Rental_O3_CY3__c, Schedule_E_Rental_O4_CY3__c, Schedule_E_Rental_O5_CY3__c, Other_Income_O2_CY3__c, Other_Income_O1CY3__c, Other_GuaranteedwagesaffiliatesO1CY1__c, Other_GuaranteedwagesaffiliatesO2CY1__c, Other_GuaranteedwagesaffiliatesO3CY1__c, Other_GuaranteedwagesaffiliatesO4CY1__c, Other_GuaranteedwagesaffiliatesO5CY1__c, Other_GuaranteedwagesaffiliatesO1CY2__c, Other_GuaranteedwagesaffiliatesO2CY2__c, Other_GuaranteedwagesaffiliatesO3CY2__c, Other_GuaranteedwagesaffiliatesO4CY2__c, Other_GuaranteedwagesaffiliatesO5CY2__c, Other_GuaranteedwagesaffiliatesO1CY3__c, Other_GuaranteedwagesaffiliatesO2CY3__c, Other_GuaranteedwagesaffiliatesO3CY3__c, Other_GuaranteedwagesaffiliatesO4CY3__c, Other_GuaranteedwagesaffiliatesO5CY3__c, Owner1_Adult__c,Owner2_Adult__c,Owner3_Adult__c,Owner4_Adult__c,Owner5_Adult__c,Owner1_Kid__c,Owner2_Kid__c,Owner3_Kid__c,Owner4_Kid__c,Owner5_Kid__c,Owner1_Adult_Currency__c,Owner2_Adult_Currency__c,Owner3_Adult_Currency__c,Owner4_Adult_Currency__c,Owner5_Adult_Currency__c,Owner1_Kid_Currency__c,Owner2_Kid_Currency__c,Owner3_Kid_Currency__c,Owner4_Kid_Currency__c,Owner5_Kid_Currency__c,Lead__c FROM Quick_Cash_Flow__c where lead__r.id = :objlead.id limit 1];   
       
        if( objlead.PortalAPIEndPoint__c != null )
            PortalBaseURL = string.valueof(objlead.PortalAPIEndPoint__c);
            
        //Checking if First Owner exist on Lead
        if(objlead.SSN1__c != null )
        {
            objMainWrapper.IsFirstOwner = true;
            objMainWrapper.FirstOwnerName= string.valueof(objlead.Name);
            highestCreditScoreList.add(Double.valueof(objlead.Actual_Owner1_Credit_Score__c));
        }
        //Checking if Second Owner exist on Lead    
        if(objlead.SSN2__c != null )
        {
            objMainWrapper.SecondOwnerName = string.valueof(objlead.First_Name_2nd_Owner__c + ' ' +objlead.Last_Name_2nd_Owner__c);
            objMainWrapper.IsSecondOwner = true;
            highestCreditScoreList.add(Double.valueof(objlead.Actual_Owner2_Credit_Score__c));
        }
        //Checking if Third Owner exist on Lead
        if(objlead.SSN_3rd_Owner__c != null )
        {
            objMainWrapper.ThirdOwnerName = string.valueof(objlead.First_Name_3rd_Owner__c + ' ' +objlead.Last_Name_3rd_Owner__c);
            objMainWrapper.IsThirdOwner = true;
            highestCreditScoreList.add(Double.valueof(objlead.Actual_Owner3_Credit_Score__c));
        }
        //Checking if Fourth Owner exist on Lead
        if(objlead.SSN_4th_Owner__c != null )
        {
            objMainWrapper.FourthOwnerName = string.valueof(objlead.First_Name_4th_Owner__c + ' ' +objlead.Last_Name_4th_Owner__c);
            objMainWrapper.IsFourthOwner = true;
            highestCreditScoreList.add(Double.valueof(objlead.Actual_Owner4_Credit_Score__c));
        }
        //Checking if Fifth Owner exist on Lead
        if(objlead.SSN_5th_Owner__c != null )
        {
            objMainWrapper.FifthOwnerName = string.valueof(objlead.First_Name_5th_Owner__c + ' ' +objlead.Last_Name_5th_Owner__c);
            objMainWrapper.IsFifthOwner = true;
            highestCreditScoreList.add(Double.valueof(objlead.Actual_Owner5_Credit_Score__c));
        }
        }
        IF( objlead.Loan_Type__c != NULL && objlead.Loan_Type__c != '')
        objMainWrapper.loanType = objlead.Loan_Type__c;
        objMainWrapper.CurrentYear = CY ; 
        objMainWrapper.CurrentYear_1 = CY_1; 
        objMainWrapper.CurrentYear_2 = CY_2; 
        objMainWrapper.CurrentYear_3 = CY_3; 
        IF( objLead.Application_ID__c != NULL && objLead.Application_ID__c != '')
        objMainWrapper.Application_ID = objLead.Application_ID__c;
        IF( objLead.Owner.name != NULL && objLead.Owner.name != '')
        objMainWrapper.Lendistry_Sales_Rep = objLead.Owner.name;
        IF( objLead.Referral_Partner__r.Name != NULL && objLead.Referral_Partner__r.Name != '' )
        objMainWrapper.Referral_Partner = objLead.Referral_Partner__r.Name;
       If( objlead.Requested_Amount__c != null )
        objMainWrapper.Loan_Amount_Actual =  Double.valueOf(objlead.Requested_Amount__c);
        IF( objlead.TIB_Months__c != NULL )
        //objMainWrapper.Term_Months_Actual = double.valueof(objlead.TIB_Months__c);
        objMainWrapper.Time_in_Business_Months = double.valueof(objlead.TIB_Months__c);
        //==================Auto Populated Quick Cash Flow Code===========Start Block=============================
    if( highestCreditScoreList != null && highestCreditScoreList.size() > 0 )
    {
    for(Integer i = 0 ; i < highestCreditScoreList.size() ; i ++) {
    for(integer j = i+1 ; j <= highestCreditScoreList.size() -1 ; j ++ ){
    Double x = 0 ;
    if(highestCreditScoreList[i] <  highestCreditScoreList[j]){
    x = highestCreditScoreList[i]  ;
    highestCreditScoreList[i] = highestCreditScoreList[j]  ;
    highestCreditScoreList[j]  = x;
    // system.debug(integerList) ;
    }
    }
    }
     objMainWrapper.Highest_Credit_Score = highestCreditScoreList[0];  
     highestCreditScore = highestCreditScoreList[0]; 
    }
        
        if(lstQuick_Cash_Flow != null && lstQuick_Cash_Flow.size() > 0)
       {
        objMainWrapper.Taxes_O1_CY  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O1_CY__c);
        objMainWrapper.Taxes_O2_CY  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O2_CY__c);
        objMainWrapper.Taxes_O3_CY  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O3_CY__c);
        objMainWrapper.Taxes_O4_CY  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O4_CY__c);
        objMainWrapper.Taxes_O5_CY  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O5_CY__c);
        objMainWrapper.Taxes_O1_CY1  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O1_CY1__c);
        objMainWrapper.Taxes_O2_CY1  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O2_CY1__c);
        objMainWrapper.Taxes_O3_CY1  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O3_CY1__c);
        objMainWrapper.Taxes_O4_CY1  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O4_CY1__c);
        objMainWrapper.Taxes_O5_CY1  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O5_CY1__c);
        objMainWrapper.Taxes_O1_CY2  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O1_CY2__c);
        objMainWrapper.Taxes_O2_CY2  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O2_CY2__c);
        objMainWrapper.Taxes_O3_CY2  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O3_CY2__c);
        objMainWrapper.Taxes_O4_CY2  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O4_CY2__c);
        objMainWrapper.Taxes_O5_CY2  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O5_CY2__c);
        objMainWrapper.Taxes_O1_CY3  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O1_CY3__c);
        objMainWrapper.Taxes_O2_CY3  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O2_CY3__c);
        objMainWrapper.Taxes_O3_CY3  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O3_CY3__c);
        objMainWrapper.Taxes_O4_CY3  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O4_CY3__c);
        objMainWrapper.Taxes_O5_CY3  = Double.valueof(lstQuick_Cash_Flow[0].Taxes_O5_CY3__c);
        
        objMainWrapper.RETaxes_O1_CY  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O1_CY__c);
        objMainWrapper.RETaxes_O2_CY  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O2_CY__c);
        objMainWrapper.RETaxes_O3_CY  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O3_CY__c);
        objMainWrapper.RETaxes_O4_CY  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O4_CY__c);
        objMainWrapper.RETaxes_O5_CY  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O5_CY__c);
        objMainWrapper.RETaxes_O1_CY1  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O1_CY1__c);
        objMainWrapper.RETaxes_O2_CY1  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O2_CY1__c);
        objMainWrapper.RETaxes_O3_CY1  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O3_CY1__c);
        objMainWrapper.RETaxes_O4_CY1  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O4_CY1__c);
        objMainWrapper.RETaxes_O5_CY1  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O5_CY1__c);
        objMainWrapper.RETaxes_O1_CY2  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O1_CY2__c);
        objMainWrapper.RETaxes_O2_CY2  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O2_CY2__c);
        objMainWrapper.RETaxes_O3_CY2  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O3_CY2__c);
        objMainWrapper.RETaxes_O4_CY2  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O4_CY2__c);
        objMainWrapper.RETaxes_O5_CY2  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O5_CY2__c);
        objMainWrapper.RETaxes_O1_CY3  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O1_CY3__c);
        objMainWrapper.RETaxes_O2_CY3  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O2_CY3__c);
        objMainWrapper.RETaxes_O3_CY3  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O3_CY3__c);
        objMainWrapper.RETaxes_O4_CY3  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O4_CY3__c);
        objMainWrapper.RETaxes_O5_CY3  = Double.valueof(lstQuick_Cash_Flow[0].RETaxes_O5_CY3__c);
        
        objMainWrapper.Living_Expenses_O1_CY  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O1_CY__c);
        objMainWrapper.Living_Expenses_O2_CY  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O2_CY__c);
        objMainWrapper.Living_Expenses_O3_CY  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O3_CY__c);
        objMainWrapper.Living_Expenses_O4_CY  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O4_CY__c);
        objMainWrapper.Living_Expenses_O5_CY  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O5_CY__c);
        objMainWrapper.Living_Expenses_O1_CY1  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O1_CY1__c);
        objMainWrapper.Living_Expenses_O2_CY1  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O2_CY1__c);
        objMainWrapper.Living_Expenses_O3_CY1  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O3_CY1__c);
        objMainWrapper.Living_Expenses_O4_CY1  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O4_CY1__c);
        objMainWrapper.Living_Expenses_O5_CY1  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O5_CY1__c);
        objMainWrapper.Living_Expenses_O1_CY2  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O1_CY2__c);
        objMainWrapper.Living_Expenses_O2_CY2  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O2_CY2__c);
        objMainWrapper.Living_Expenses_O3_CY2  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O3_CY2__c);
        objMainWrapper.Living_Expenses_O4_CY2  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O4_CY2__c);
        objMainWrapper.Living_Expenses_O5_CY2  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O5_CY2__c);
        objMainWrapper.Living_Expenses_O1_CY3  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O1_CY3__c);
        objMainWrapper.Living_Expenses_O2_CY3  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O2_CY3__c);
        objMainWrapper.Living_Expenses_O3_CY3  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O3_CY3__c);
        objMainWrapper.Living_Expenses_O4_CY3  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O4_CY3__c);
        objMainWrapper.Living_Expenses_O5_CY3  = Double.valueof(lstQuick_Cash_Flow[0].Living_Expenses_O5_CY3__c);
        
        objMainWrapper.Total_Taxes_O1_CY  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O1_CY__c);
        objMainWrapper.Total_Taxes_O2_CY  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O2_CY__c);
        objMainWrapper.Total_Taxes_O3_CY  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O3_CY__c);
        objMainWrapper.Total_Taxes_O4_CY  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O4_CY__c);
        objMainWrapper.Total_Taxes_O5_CY  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O5_CY__c);
        objMainWrapper.Total_Taxes_O1_CY1  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O1_CY1__c);
        objMainWrapper.Total_Taxes_O2_CY1  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O2_CY1__c);
        objMainWrapper.Total_Taxes_O3_CY1  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O3_CY1__c);
        objMainWrapper.Total_Taxes_O4_CY1  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O4_CY1__c);
        objMainWrapper.Total_Taxes_O5_CY1  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O5_CY1__c);
        objMainWrapper.Total_Taxes_O1_CY2  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O1_CY2__c);
        objMainWrapper.Total_Taxes_O2_CY2  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O2_CY2__c);
        objMainWrapper.Total_Taxes_O3_CY2  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O3_CY2__c);
        objMainWrapper.Total_Taxes_O4_CY2  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O4_CY2__c);
        objMainWrapper.Total_Taxes_O5_CY2  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O5_CY2__c);
        objMainWrapper.Total_Taxes_O1_CY3  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O1_CY3__c);
        objMainWrapper.Total_Taxes_O2_CY3  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O2_CY3__c);
        objMainWrapper.Total_Taxes_O3_CY3  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O3_CY3__c);
        objMainWrapper.Total_Taxes_O4_CY3  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O4_CY3__c);
        objMainWrapper.Total_Taxes_O5_CY3  = Double.valueof(lstQuick_Cash_Flow[0].Total_Taxes_O5_CY3__c);
           
           
           
        
      objMainWrapper.Total_Estimated_Personal_O5_CY =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O5_CY__c);
objMainWrapper.Total_Estimated_Personal_O5_CY1 =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O5_CY1__c);
objMainWrapper.Total_Estimated_Personal_O5_CY2 =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O5_CY2__c);
objMainWrapper.Total_Estimated_Personal_O5_CY3 =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O5_CY3__c);
objMainWrapper.Total_Estimated_Personal_O4_CY =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O4_CY__c);
objMainWrapper.Total_Estimated_Personal_O4_CY1 =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O4_CY1__c);
objMainWrapper.Total_Estimated_Personal_O4_CY2 =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O4_CY2__c);
objMainWrapper.Total_Estimated_Personal_O4_CY3 =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O4_CY3__c);
objMainWrapper.Total_Estimated_Personal_O3_CY =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O3_CY__c);
objMainWrapper.Total_Estimated_Personal_O3_CY1 =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O3_CY1__c);
objMainWrapper.Total_Estimated_Personal_O3_CY2 =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O3_CY2__c);
objMainWrapper.Total_Estimated_Personal_O3_CY3 =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O3_CY3__c);
objMainWrapper.Total_Estimated_Personal_O2_CY =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O2_CY__c);
objMainWrapper.Total_Estimated_Personal_O2_CY1 =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O2_CY1__c);
objMainWrapper.Total_Estimated_Personal_O2_CY2 =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O2_CY2__c);
objMainWrapper.Total_Estimated_Personal_O2_CY3 =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O2_CY3__c);
objMainWrapper.Total_Estimated_Personal_O1_CY =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O1_CY__c);
objMainWrapper.Total_Estimated_Personal_O1_CY1 =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O1_CY1__c);
objMainWrapper.Total_Estimated_Personal_O1_CY2 =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O1_CY2__c);
objMainWrapper.Total_Estimated_Personal_O1_CY3 =  Double.valueof(lstQuick_Cash_Flow[0].Total_Estimated_Personal_O1_CY3__c);

            objMainWrapper.Other_GuaranteedwagesaffiliatesO1CY = Double.valueof(lstQuick_Cash_Flow[0].Other_Guaranteed_wages_affiliates_O1_CY__c);
            objMainWrapper.Other_GuaranteedwagesaffiliatesO2CY = Double.valueof(lstQuick_Cash_Flow[0].Other_Guaranteed_wages_affiliates_O2_CY__c);
            objMainWrapper.Other_GuaranteedwagesaffiliatesO3CY = Double.valueof(lstQuick_Cash_Flow[0].Other_Guaranteed_wages_affiliates_O3_CY__c);
            objMainWrapper.Other_GuaranteedwagesaffiliatesO4CY = Double.valueof(lstQuick_Cash_Flow[0].Other_Guaranteed_wages_affiliates_O4_CY__c);
            objMainWrapper.Other_GuaranteedwagesaffiliatesO5CY = Double.valueof(lstQuick_Cash_Flow[0].Other_Guaranteed_wages_affiliates_O5_CY__c);
        
            objMainWrapper.Residence_Mortgage_Owner_1 = Integer.valueof(lstQuick_Cash_Flow[0].Residence_Mortgage_Owner_1__c);
            objMainWrapper.Residence_Mortgage_Owner_2 = Integer.valueof(lstQuick_Cash_Flow[0].Residence_Mortgage_Owner_2__c);
            objMainWrapper.Residence_Mortgage_Owner_3 = Integer.valueof(lstQuick_Cash_Flow[0].Residence_Mortgage_Owner_3__c);
            objMainWrapper.Residence_Mortgage_Owner_4 = Integer.valueof(lstQuick_Cash_Flow[0].Residence_Mortgage_Owner_4__c);
            objMainWrapper.Residence_Mortgage_Owner_5 = Integer.valueof(lstQuick_Cash_Flow[0].Residence_Mortgage_Owner_5__c);
            objMainWrapper.Rental_Payment_Owner_1 = Integer.valueof(lstQuick_Cash_Flow[0].Rental_Payment_Owner_1__c);
            objMainWrapper.Rental_Payment_Owner_2 = Integer.valueof(lstQuick_Cash_Flow[0].Rental_Payment_Owner_2__c);
            objMainWrapper.Rental_Payment_Owner_3 = Integer.valueof(lstQuick_Cash_Flow[0].Rental_Payment_Owner_3__c);
            objMainWrapper.Rental_Payment_Owner_4 = Integer.valueof(lstQuick_Cash_Flow[0].Rental_Payment_Owner_4__c);
            objMainWrapper.Rental_Payment_Owner_5 = Integer.valueof(lstQuick_Cash_Flow[0].Rental_Payment_Owner_5__c);
            objMainWrapper.HELOC_Owner_1 = Integer.valueof(lstQuick_Cash_Flow[0].HELOC_Owner_1__c); 
            objMainWrapper.HELOC_Owner_2 = Integer.valueof(lstQuick_Cash_Flow[0].HELOC_Owner_2__c); 
            objMainWrapper.HELOC_Owner_3 = Integer.valueof(lstQuick_Cash_Flow[0].HELOC_Owner_3__c); 
            objMainWrapper.HELOC_Owner_4 = Integer.valueof(lstQuick_Cash_Flow[0].HELOC_Owner_4__c); 
            objMainWrapper.HELOC_Owner_5 = Integer.valueof(lstQuick_Cash_Flow[0].HELOC_Owner_5__c); 
            objMainWrapper.Installment_Debt_Owner_1 = Integer.valueof(lstQuick_Cash_Flow[0].Installment_Debt_Owner_1__c);
            objMainWrapper.Installment_Debt_Owner_2 = Integer.valueof(lstQuick_Cash_Flow[0].Installment_Debt_Owner_2__c);   
            objMainWrapper.Installment_Debt_Owner_3 = Integer.valueof(lstQuick_Cash_Flow[0].Installment_Debt_Owner_3__c);   
            objMainWrapper.Installment_Debt_Owner_4 = Integer.valueof(lstQuick_Cash_Flow[0].Installment_Debt_Owner_4__c);   
            objMainWrapper.Installment_Debt_Owner_5 = Integer.valueof(lstQuick_Cash_Flow[0].Installment_Debt_Owner_5__c);   
            objMainWrapper.Credit_Card_Debt_Owner_1 = Integer.valueof(lstQuick_Cash_Flow[0].Credit_Card_Debt_Owner_1__c);
            objMainWrapper.Credit_Card_Debt_Owner_2 = Integer.valueof(lstQuick_Cash_Flow[0].Credit_Card_Debt_Owner_2__c);
            objMainWrapper.Credit_Card_Debt_Owner_3 = Integer.valueof(lstQuick_Cash_Flow[0].Credit_Card_Debt_Owner_3__c);
            objMainWrapper.Credit_Card_Debt_Owner_4 = Integer.valueof(lstQuick_Cash_Flow[0].Credit_Card_Debt_Owner_4__c);
            objMainWrapper.Credit_Card_Debt_Owner_5 = Integer.valueof(lstQuick_Cash_Flow[0].Credit_Card_Debt_Owner_5__c);
            objMainWrapper.Other_debt_Owner_1 = Integer.valueof(lstQuick_Cash_Flow[0].Other_debt_Owner_1__c);
            objMainWrapper.Other_debt_Owner_2 = Integer.valueof(lstQuick_Cash_Flow[0].Other_debt_Owner_2__c);
            objMainWrapper.Other_debt_Owner_3 = Integer.valueof(lstQuick_Cash_Flow[0].Other_debt_Owner_3__c);
            objMainWrapper.Other_debt_Owner_4 = Integer.valueof(lstQuick_Cash_Flow[0].Other_debt_Owner_4__c);
            objMainWrapper.Other_debt_Owner_5 = Integer.valueof(lstQuick_Cash_Flow[0].Other_debt_Owner_5__c);
            objMainWrapper.Total_Annual_Debt_Service_Owner_1 = Integer.valueof(lstQuick_Cash_Flow[0].Total_Annual_Debt_Service_Owner_1__c);
            objMainWrapper.Total_Annual_Debt_Service_Owner_2 = Integer.valueof(lstQuick_Cash_Flow[0].Total_Annual_Debt_Service_Owner_2__c);
            objMainWrapper.Total_Annual_Debt_Service_Owner_3 = Integer.valueof(lstQuick_Cash_Flow[0].Total_Annual_Debt_Service_Owner_3__c);
            objMainWrapper.Total_Annual_Debt_Service_Owner_4 = Integer.valueof(lstQuick_Cash_Flow[0].Total_Annual_Debt_Service_Owner_4__c);
            objMainWrapper.Total_Annual_Debt_Service_Owner_5 = Integer.valueof(lstQuick_Cash_Flow[0].Total_Annual_Debt_Service_Owner_5__c);

            objMainWrapper.Adult_Owner1 = Integer.valueof(lstQuick_Cash_Flow[0].Owner1_Adult__c);
            objMainWrapper.Adult_Owner2 = Integer.valueof(lstQuick_Cash_Flow[0].Owner2_Adult__c);
            objMainWrapper.Adult_Owner3 = Integer.valueof(lstQuick_Cash_Flow[0].Owner3_Adult__c);
            objMainWrapper.Adult_Owner4 = Integer.valueof(lstQuick_Cash_Flow[0].Owner4_Adult__c);
            objMainWrapper.Adult_Owner5 = Integer.valueof(lstQuick_Cash_Flow[0].Owner5_Adult__c);
            objMainWrapper.AdultCurrency_Owner1 = Integer.valueof(lstQuick_Cash_Flow[0].Owner1_Adult_Currency__c);
            objMainWrapper.AdultCurrency_Owner2 = Integer.valueof(lstQuick_Cash_Flow[0].Owner2_Adult_Currency__c);
            objMainWrapper.AdultCurrency_Owner3 = Integer.valueof(lstQuick_Cash_Flow[0].Owner3_Adult_Currency__c);
            objMainWrapper.AdultCurrency_Owner4 = Integer.valueof(lstQuick_Cash_Flow[0].Owner4_Adult_Currency__c);
            objMainWrapper.AdultCurrency_Owner5 = Integer.valueof(lstQuick_Cash_Flow[0].Owner5_Adult_Currency__c);
            objMainWrapper.Kid_Owner1  = Integer.valueof(lstQuick_Cash_Flow[0].Owner1_Kid__c);
            objMainWrapper.Kid_Owner2  = Integer.valueof(lstQuick_Cash_Flow[0].Owner2_Kid__c);
            objMainWrapper.Kid_Owner3  = Integer.valueof(lstQuick_Cash_Flow[0].Owner3_Kid__c);
            objMainWrapper.Kid_Owner4  = Integer.valueof(lstQuick_Cash_Flow[0].Owner4_Kid__c);
            objMainWrapper.Kid_Owner5  = Integer.valueof(lstQuick_Cash_Flow[0].Owner5_Kid__c);
            objMainWrapper.KidCurrency_Owner1 = Integer.valueof(lstQuick_Cash_Flow[0].Owner1_Kid_Currency__c);
            objMainWrapper.KidCurrency_Owner2 = Integer.valueof(lstQuick_Cash_Flow[0].Owner2_Kid_Currency__c);
            objMainWrapper.KidCurrency_Owner3 = Integer.valueof(lstQuick_Cash_Flow[0].Owner3_Kid_Currency__c);
            objMainWrapper.KidCurrency_Owner4 = Integer.valueof(lstQuick_Cash_Flow[0].Owner4_Kid_Currency__c);
            objMainWrapper.KidCurrency_Owner5 = Integer.valueof(lstQuick_Cash_Flow[0].Owner5_Kid_Currency__c);
            
            
            objMainWrapper.Total_Second_CY = lstQuick_Cash_Flow[0].Total_Second_CY__c;  
            objMainWrapper.Total_Second_CY3 = lstQuick_Cash_Flow[0].Total_Second_CY3__c;  
            objMainWrapper.Total_Second_CY2 = lstQuick_Cash_Flow[0].Total_Second_CY2__c;  
            objMainWrapper.Total_Second_CY1 = lstQuick_Cash_Flow[0].Total_Second_CY1__c;  
            objMainWrapper.Total_First_CY = lstQuick_Cash_Flow[0].Total_First_CY__c;  
            objMainWrapper.Total_First_CY3 = lstQuick_Cash_Flow[0].Total_First_CY3__c;  
            objMainWrapper.Total_First_CY2 = lstQuick_Cash_Flow[0].Total_First_CY2__c;  
            objMainWrapper.Total_First_CY1 = lstQuick_Cash_Flow[0].Total_First_CY1__c;  
            objMainWrapper.Time_in_Business_Months = lstQuick_Cash_Flow[0].Time_in_Business_Months__c;  
            //objMainWrapper.lstQuick_Cash_Flow[0] = lstQuick_Cash_Flow[0].lstQuick_Cash_Flow[0]__c;  
              
            objMainWrapper.Term_Months_Adjusted = lstQuick_Cash_Flow[0].Term_Months_Adjusted__c;  
            objMainWrapper.Term_Months_Actual = lstQuick_Cash_Flow[0].Term_Months_Actual__c; 
            objMainWrapper.Schedule_E_Rental_O5_CY = lstQuick_Cash_Flow[0].Schedule_E_Rental_O5_CY__c;  
            objMainWrapper.Schedule_E_Rental_O5_CY3 = lstQuick_Cash_Flow[0].Schedule_E_Rental_O5_CY3__c;  
            objMainWrapper.Schedule_E_Rental_O5_CY2 = lstQuick_Cash_Flow[0].Schedule_E_Rental_O5_CY2__c;  
            objMainWrapper.Schedule_E_Rental_O5_CY1 = lstQuick_Cash_Flow[0].Schedule_E_Rental_O5_CY1__c;  
            objMainWrapper.Schedule_E_Rental_O4_CY = lstQuick_Cash_Flow[0].Schedule_E_Rental_O4_CY__c;  
            objMainWrapper.Schedule_E_Rental_O4_CY3 = lstQuick_Cash_Flow[0].Schedule_E_Rental_O4_CY3__c;  
            objMainWrapper.Schedule_E_Rental_O4_CY2 = lstQuick_Cash_Flow[0].Schedule_E_Rental_O4_CY2__c;  
            objMainWrapper.Schedule_E_Rental_O4_CY1 = lstQuick_Cash_Flow[0].Schedule_E_Rental_O4_CY1__c;  
            objMainWrapper.Schedule_E_Rental_O3_CY = lstQuick_Cash_Flow[0].Schedule_E_Rental_O3_CY__c;  
            objMainWrapper.Schedule_E_Rental_O3_CY3 = lstQuick_Cash_Flow[0].Schedule_E_Rental_O3_CY3__c;  
            objMainWrapper.Schedule_E_Rental_O3_CY2 = lstQuick_Cash_Flow[0].Schedule_E_Rental_O3_CY2__c;  
            objMainWrapper.Schedule_E_Rental_O3_CY1 = lstQuick_Cash_Flow[0].Schedule_E_Rental_O3_CY1__c;  
            objMainWrapper.Schedule_E_Rental_O2_CY = lstQuick_Cash_Flow[0].Schedule_E_Rental_O2_CY__c;  
            objMainWrapper.Schedule_E_Rental_O2_CY3 = lstQuick_Cash_Flow[0].Schedule_E_Rental_O2_CY3__c;  
            objMainWrapper.Schedule_E_Rental_O2_CY2 = lstQuick_Cash_Flow[0].Schedule_E_Rental_O2_CY2__c;  
            objMainWrapper.Schedule_E_Rental_O2_CY1 = lstQuick_Cash_Flow[0].Schedule_E_Rental_O2_CY1__c;  
            objMainWrapper.Schedule_E_Rental_O1_CY = lstQuick_Cash_Flow[0].Schedule_E_Rental_O1_CY__c;  
            objMainWrapper.Schedule_E_Rental_O1_CY3 = lstQuick_Cash_Flow[0].Schedule_E_Rental_O1_CY3__c;  
            objMainWrapper.Schedule_E_Rental_O1_CY2 = lstQuick_Cash_Flow[0].Schedule_E_Rental_O1_CY2__c;  
            objMainWrapper.Schedule_E_Rental_O1_CY1 = lstQuick_Cash_Flow[0].Schedule_E_Rental_O1_CY1__c;  
            objMainWrapper.Schedule_C_Income_O5_CY = lstQuick_Cash_Flow[0].Schedule_C_Income_O5_CY__c;  
            objMainWrapper.Schedule_C_Income_O5_CY3 = lstQuick_Cash_Flow[0].Schedule_C_Income_O5_CY3__c;  
            objMainWrapper.Schedule_C_Income_O5_CY2 = lstQuick_Cash_Flow[0].Schedule_C_Income_O5_CY2__c;  
            objMainWrapper.Schedule_C_Income_O5_CY1 = lstQuick_Cash_Flow[0].Schedule_C_Income_O5_CY1__c;  
            objMainWrapper.Schedule_C_Income_O4_CY = lstQuick_Cash_Flow[0].Schedule_C_Income_O4_CY__c;  
            objMainWrapper.Schedule_C_Income_O4_CY3 = lstQuick_Cash_Flow[0].Schedule_C_Income_O4_CY3__c;  
            objMainWrapper.Schedule_C_Income_O4_CY2 = lstQuick_Cash_Flow[0].Schedule_C_Income_O4_CY2__c;  
            objMainWrapper.Schedule_C_Income_O4_CY1 = lstQuick_Cash_Flow[0].Schedule_C_Income_O4_CY1__c;  
            objMainWrapper.Schedule_C_Income_O3_CY = lstQuick_Cash_Flow[0].Schedule_C_Income_O3_CY__c;  
            objMainWrapper.Schedule_C_Income_O3_CY3 = lstQuick_Cash_Flow[0].Schedule_C_Income_O3_CY3__c;  
            objMainWrapper.Schedule_C_Income_O3_CY2 = lstQuick_Cash_Flow[0].Schedule_C_Income_O3_CY2__c;  
            objMainWrapper.Schedule_C_Income_O3_CY1 = lstQuick_Cash_Flow[0].Schedule_C_Income_O3_CY1__c;  
            objMainWrapper.Schedule_C_Income_O2_CY = lstQuick_Cash_Flow[0].Schedule_C_Income_O2_CY__c;  
            objMainWrapper.Schedule_C_Income_O2_CY3 = lstQuick_Cash_Flow[0].Schedule_C_Income_O2_CY3__c;  
            objMainWrapper.Schedule_C_Income_O2_CY2 = lstQuick_Cash_Flow[0].Schedule_C_Income_O2_CY2__c;  
            objMainWrapper.Schedule_C_Income_O2_CY1 = lstQuick_Cash_Flow[0].Schedule_C_Income_O2_CY1__c;  
            objMainWrapper.Schedule_C_Income_O1_CY = lstQuick_Cash_Flow[0].Schedule_C_Income_O1_CY__c;  
            objMainWrapper.Schedule_C_Income_O1_CY3 = lstQuick_Cash_Flow[0].Schedule_C_Income_O1_CY3__c;  
            objMainWrapper.Schedule_C_Income_O1_CY2 = lstQuick_Cash_Flow[0].Schedule_C_Income_O1_CY2__c;  
            objMainWrapper.Schedule_C_Income_O1_CY1 = lstQuick_Cash_Flow[0].Schedule_C_Income_O1_CY1__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O5_CY = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O5_CY__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O5_CY3 = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O5_CY3__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O5_CY2 = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O5_CY2__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O5_CY1 = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O5_CY1__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O4_CY = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O4_CY__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O4_CY3 = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O4_CY3__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O4_CY2 = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O4_CY2__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O4_CY1 = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O4_CY1__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O3_CY = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O3_CY__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O3_CY3 = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O3_CY3__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O3_CY2 = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O3_CY2__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O3_CY1 = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O3_CY1__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O2_CY = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O2_CY__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O2_CY3 = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O2_CY3__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O2_CY2 = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O2_CY2__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O2_CY1 = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O2_CY1__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O1_CY = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O1_CY__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O1_CY3 = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O1_CY3__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O1_CY2 = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O1_CY2__c;  
            objMainWrapper.Sch_D_Capital_gainslosses_O1_CY1 = lstQuick_Cash_Flow[0].Sch_D_Capital_gainslosses_O1_CY1__c;  
            objMainWrapper.Sales_CY = lstQuick_Cash_Flow[0].Sales_CY__c;  
            objMainWrapper.Sales_CY3 = lstQuick_Cash_Flow[0].Sales_CY3__c;  
            objMainWrapper.Sales_CY2 = lstQuick_Cash_Flow[0].Sales_CY2__c;  
            objMainWrapper.Sales_CY1 = lstQuick_Cash_Flow[0].Sales_CY1__c;  
            objMainWrapper.Salary_Wages_Spouse_O5_CY = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O5_CY__c;  
            objMainWrapper.Salary_Wages_Spouse_O5_CY3 = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O5_CY3__c;  
            objMainWrapper.Salary_Wages_Spouse_O5_CY2 = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O5_CY2__c;  
            objMainWrapper.Salary_Wages_Spouse_O5_CY1 = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O5_CY1__c;  
            objMainWrapper.Salary_Wages_Spouse_O4_CY = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O4_CY__c;  
            objMainWrapper.Salary_Wages_Spouse_O4_CY3 = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O4_CY3__c;  
            objMainWrapper.Salary_Wages_Spouse_O4_CY2 = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O4_CY2__c;  
            objMainWrapper.Salary_Wages_Spouse_O4_CY1 = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O4_CY1__c;  
            objMainWrapper.Salary_Wages_Spouse_O3_CY = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O3_CY__c;  
            objMainWrapper.Salary_Wages_Spouse_O3_CY3 = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O3_CY3__c;  
            objMainWrapper.Salary_Wages_Spouse_O3_CY2 = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O3_CY2__c;  
            objMainWrapper.Salary_Wages_Spouse_O3_CY1 = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O3_CY1__c;  
            objMainWrapper.Salary_Wages_Spouse_O2_CY = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O2_CY__c;  
            objMainWrapper.Salary_Wages_Spouse_O2_CY3 = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O2_CY3__c;  
            objMainWrapper.Salary_Wages_Spouse_O2_CY2 = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O2_CY2__c;  
            objMainWrapper.Salary_Wages_Spouse_O2_CY1 = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O2_CY1__c;  
            objMainWrapper.Salary_Wages_Spouse_O1_CY = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O1_CY__c;  
            objMainWrapper.Salary_Wages_Spouse_O1_CY3 = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O1_CY3__c;  
            objMainWrapper.Salary_Wages_Spouse_O1_CY2 = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O1_CY2__c;  
            objMainWrapper.Salary_Wages_Spouse_O1_CY1 = lstQuick_Cash_Flow[0].Salary_Wages_Spouse_O1_CY1__c;  
            objMainWrapper.Salary_Wages_Borrower_O5_CY = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O5_CY__c;  
            objMainWrapper.Salary_Wages_Borrower_O5_CY3 = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O5_CY3__c;  
            objMainWrapper.Salary_Wages_Borrower_O5_CY2 = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O5_CY2__c;  
            objMainWrapper.Salary_Wages_Borrower_O5_CY1 = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O5_CY1__c;  
            objMainWrapper.Salary_Wages_Borrower_O4_CY = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O4_CY__c;  
            objMainWrapper.Salary_Wages_Borrower_O4_CY3 = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O4_CY3__c;  
            objMainWrapper.Salary_Wages_Borrower_O4_CY2 = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O4_CY2__c;  
            objMainWrapper.Salary_Wages_Borrower_O4_CY1 = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O4_CY1__c;  
            objMainWrapper.Salary_Wages_Borrower_O3_CY = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O3_CY__c;  
            objMainWrapper.Salary_Wages_Borrower_O3_CY3 = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O3_CY3__c;  
            objMainWrapper.Salary_Wages_Borrower_O3_CY2 = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O3_CY2__c;  
            objMainWrapper.Salary_Wages_Borrower_O3_CY1 = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O3_CY1__c;  
            objMainWrapper.Salary_Wages_Borrower_O2_CY = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O2_CY__c;  
            objMainWrapper.Salary_Wages_Borrower_O2_CY3 = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O2_CY3__c;  
            objMainWrapper.Salary_Wages_Borrower_O2_CY2 = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O2_CY2__c;  
            objMainWrapper.Salary_Wages_Borrower_O2_CY1 = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O2_CY1__c;  
            objMainWrapper.Salary_Wages_Borrower_O1_CY = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O1_CY__c;  
            objMainWrapper.Salary_Wages_Borrower_O1_CY3 = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O1_CY3__c;  
            objMainWrapper.Salary_Wages_Borrower_O1_CY2 = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O1_CY2__c;  
            objMainWrapper.Salary_Wages_Borrower_O1_CY1 = lstQuick_Cash_Flow[0].Salary_Wages_Borrower_O1_CY1__c;  
            objMainWrapper.Proposed_P_I_CY = lstQuick_Cash_Flow[0].Proposed_P_I_CY__c;  
            objMainWrapper.Proposed_P_I_CY3 = lstQuick_Cash_Flow[0].Proposed_P_I_CY3__c;  
            objMainWrapper.Proposed_P_I_CY2 = lstQuick_Cash_Flow[0].Proposed_P_I_CY2__c;  
            objMainWrapper.Proposed_P_I_CY1 = lstQuick_Cash_Flow[0].Proposed_P_I_CY1__c;  
            objMainWrapper.Projected_Weekly_Payment = lstQuick_Cash_Flow[0].Projected_Weekly_Payment__c;  
            objMainWrapper.Projected_SemiMonthly_Payment = lstQuick_Cash_Flow[0].Projected_SemiMonthly_Payment__c;  
            objMainWrapper.Projected_Monthly_Payment = lstQuick_Cash_Flow[0].Projected_Monthly_Payment__c;  
            objMainWrapper.Projected_Daily_Payment = lstQuick_Cash_Flow[0].Projected_Daily_Payment__c;  
            objMainWrapper.Projected_BiWeekly_Payment = lstQuick_Cash_Flow[0].Projected_BiWeekly_Payment__c;  
            objMainWrapper.Projected_Annual_Payment = lstQuick_Cash_Flow[0].Projected_Annual_Payment__c;  
            objMainWrapper.PensionIRA_Distributions_O5_CY = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O5_CY__c;  
            objMainWrapper.PensionIRA_Distributions_O5_CY3 = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O5_CY3__c;  
            objMainWrapper.PensionIRA_Distributions_O5_CY2 = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O5_CY2__c;  
            objMainWrapper.PensionIRA_Distributions_O5_CY1 = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O5_CY1__c;  
            objMainWrapper.PensionIRA_Distributions_O4_CY = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O4_CY__c;  
            objMainWrapper.PensionIRA_Distributions_O4_CY3 = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O4_CY3__c;  
            objMainWrapper.PensionIRA_Distributions_O4_CY2 = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O4_CY2__c;  
            objMainWrapper.PensionIRA_Distributions_O4_CY1 = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O4_CY1__c;  
            objMainWrapper.PensionIRA_Distributions_O3_CY = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O3_CY__c;  
            objMainWrapper.PensionIRA_Distributions_O3_CY3 = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O3_CY3__c;  
            objMainWrapper.PensionIRA_Distributions_O3_CY2 = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O3_CY2__c;  
            objMainWrapper.PensionIRA_Distributions_O3_CY1 = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O3_CY1__c;  
            objMainWrapper.PensionIRA_Distributions_O2_CY = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O2_CY__c;  
            objMainWrapper.PensionIRA_Distributions_O2_CY3 = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O2_CY3__c;  
            objMainWrapper.PensionIRA_Distributions_O2_CY2 = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O2_CY2__c;  
            objMainWrapper.PensionIRA_Distributions_O2_CY1 = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O2_CY1__c;  
            objMainWrapper.PensionIRA_Distributions_O1_CY = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O1_CY__c;  
            objMainWrapper.PensionIRA_Distributions_O1_CY3 = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O1_CY3__c;  
            objMainWrapper.PensionIRA_Distributions_O1_CY2 = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O1_CY2__c;  
            objMainWrapper.PensionIRA_Distributions_O1_CY1 = lstQuick_Cash_Flow[0].PensionIRA_Distributions_O1_CY1__c;  
            objMainWrapper.Owner_4_Personal_Disc_SD_CY = lstQuick_Cash_Flow[0].Owner_4_Personal_Disc_SD_CY__c;  
            objMainWrapper.Owner_4_Personal_Disc_SD_CY3 = lstQuick_Cash_Flow[0].Owner_4_Personal_Disc_SD_CY3__c;  
            objMainWrapper.Owner_4_Personal_Disc_SD_CY2 = lstQuick_Cash_Flow[0].Owner_4_Personal_Disc_SD_CY2__c;  
            objMainWrapper.Owner_4_Personal_Disc_SD_CY1 = lstQuick_Cash_Flow[0].Owner_4_Personal_Disc_SD_CY1__c;  
            objMainWrapper.Owner_3_Personal_Disc_SD_CY = lstQuick_Cash_Flow[0].Owner_3_Personal_Disc_SD_CY__c;  
            objMainWrapper.Owner_3_Personal_Disc_SD_CY3 = lstQuick_Cash_Flow[0].Owner_3_Personal_Disc_SD_CY3__c;  
            objMainWrapper.Owner_3_Personal_Disc_SD_CY2 = lstQuick_Cash_Flow[0].Owner_3_Personal_Disc_SD_CY2__c;  
            objMainWrapper.Owner_3_Personal_Disc_SD_CY1 = lstQuick_Cash_Flow[0].Owner_3_Personal_Disc_SD_CY1__c;  
            objMainWrapper.Owner_2_Personal_Disc_SD_CY = lstQuick_Cash_Flow[0].Owner_2_Personal_Disc_SD_CY__c;  
            objMainWrapper.Owner_2_Personal_Disc_SD_CY3 = lstQuick_Cash_Flow[0].Owner_2_Personal_Disc_SD_CY3__c;  
            objMainWrapper.Owner_2_Personal_Disc_SD_CY2 = lstQuick_Cash_Flow[0].Owner_2_Personal_Disc_SD_CY2__c;  
            objMainWrapper.Owner_2_Personal_Disc_SD_CY1 = lstQuick_Cash_Flow[0].Owner_2_Personal_Disc_SD_CY1__c;  
            objMainWrapper.Owner_1_Personal_Disc_SD_CY = lstQuick_Cash_Flow[0].Owner_1_Personal_Disc_SD_CY__c;  
            objMainWrapper.Owner_1_Personal_Disc_SD_CY3 = lstQuick_Cash_Flow[0].Owner_1_Personal_Disc_SD_CY3__c;  
            objMainWrapper.Owner_1_Personal_Disc_SD_CY2 = lstQuick_Cash_Flow[0].Owner_1_Personal_Disc_SD_CY2__c;  
            objMainWrapper.Owner_1_Personal_Disc_SD_CY1 = lstQuick_Cash_Flow[0].Owner_1_Personal_Disc_SD_CY1__c;  
            
            objMainWrapper.Other_Income_O5_CY = lstQuick_Cash_Flow[0].Other_Income_O5_CY__c;  
            objMainWrapper.Other_Income_O5_CY3 = lstQuick_Cash_Flow[0].Other_Income_O5_CY3__c;  
            objMainWrapper.Other_Income_O5_CY2 = lstQuick_Cash_Flow[0].Other_Income_O5_CY2__c;  
            objMainWrapper.Other_Income_O5_CY1 = lstQuick_Cash_Flow[0].Other_Income_O5_CY1__c;  
            objMainWrapper.Other_Income_O4_CY = lstQuick_Cash_Flow[0].Other_Income_O4_CY__c;  
            objMainWrapper.Other_Income_O4_CY3 = lstQuick_Cash_Flow[0].Other_Income_O4_CY3__c;  
            objMainWrapper.Other_Income_O4_CY2 = lstQuick_Cash_Flow[0].Other_Income_O4_CY2__c;  
            objMainWrapper.Other_Income_O4_CY1 = lstQuick_Cash_Flow[0].Other_Income_O4_CY1__c;  
            objMainWrapper.Other_Income_O3_CY2 = lstQuick_Cash_Flow[0].Other_Income_O3_CY2__c; 
            objMainWrapper.Other_Income_O3_CY = lstQuick_Cash_Flow[0].Other_Income_O3_CY__c;  
            objMainWrapper.Other_Income_O3_CY3 = lstQuick_Cash_Flow[0].Other_Income_O3_CY3__c;  
            objMainWrapper.Other_Income_O3_CY1 = lstQuick_Cash_Flow[0].Other_Income_O3_CY1__c;  
            objMainWrapper.Other_Income_O2_CY = lstQuick_Cash_Flow[0].Other_Income_O2_CY__c;  
            objMainWrapper.Other_Income_O2_CY3 = lstQuick_Cash_Flow[0].Other_Income_O2_CY3__c;  
            objMainWrapper.Other_Income_O2_CY2 = lstQuick_Cash_Flow[0].Other_Income_O2_CY2__c;  
            objMainWrapper.Other_Income_O2_CY1 = lstQuick_Cash_Flow[0].Other_Income_O2_CY1__c;  
            objMainWrapper.Other_Income_O1_CY = lstQuick_Cash_Flow[0].Other_Income_O1_CY__c;  
            objMainWrapper.Other_Income_O1_CY3 = lstQuick_Cash_Flow[0].Other_Income_O1_CY3__c;  
            objMainWrapper.Other_Income_O1_CY2 = lstQuick_Cash_Flow[0].Other_Income_O1_CY2__c;  
            objMainWrapper.Other_Income_O1_CY1 = lstQuick_Cash_Flow[0].Other_Income_O1_CY1__c;  
            objMainWrapper.Other_Income_O1_CY3 = lstQuick_Cash_Flow[0].Other_Income_O1_CY3__c;  
            
           
        
            objMainWrapper.Other_GuaranteedwagesaffiliatesO5CY3 = lstQuick_Cash_Flow[0].Other_GuaranteedwagesaffiliatesO5CY3__c;  
            objMainWrapper.Other_GuaranteedwagesaffiliatesO5CY2 = lstQuick_Cash_Flow[0].Other_GuaranteedwagesaffiliatesO5CY2__c;  
            objMainWrapper.Other_GuaranteedwagesaffiliatesO5CY1 = lstQuick_Cash_Flow[0].Other_GuaranteedwagesaffiliatesO5CY1__c;  
            objMainWrapper.Other_GuaranteedwagesaffiliatesO4CY3 = lstQuick_Cash_Flow[0].Other_GuaranteedwagesaffiliatesO4CY3__c;  
            objMainWrapper.Other_GuaranteedwagesaffiliatesO4CY2 = lstQuick_Cash_Flow[0].Other_GuaranteedwagesaffiliatesO4CY2__c;  
            objMainWrapper.Other_GuaranteedwagesaffiliatesO4CY1 = lstQuick_Cash_Flow[0].Other_GuaranteedwagesaffiliatesO4CY1__c;  
            objMainWrapper.Other_GuaranteedwagesaffiliatesO3CY3 = lstQuick_Cash_Flow[0].Other_GuaranteedwagesaffiliatesO3CY3__c;  
            objMainWrapper.Other_GuaranteedwagesaffiliatesO3CY2 = lstQuick_Cash_Flow[0].Other_GuaranteedwagesaffiliatesO3CY2__c;  
            objMainWrapper.Other_GuaranteedwagesaffiliatesO3CY1 = lstQuick_Cash_Flow[0].Other_GuaranteedwagesaffiliatesO3CY1__c;  
            objMainWrapper.Other_GuaranteedwagesaffiliatesO2CY3 = lstQuick_Cash_Flow[0].Other_GuaranteedwagesaffiliatesO2CY3__c;  
            objMainWrapper.Other_GuaranteedwagesaffiliatesO2CY2 = lstQuick_Cash_Flow[0].Other_GuaranteedwagesaffiliatesO2CY2__c;  
            objMainWrapper.Other_GuaranteedwagesaffiliatesO2CY1 = lstQuick_Cash_Flow[0].Other_GuaranteedwagesaffiliatesO2CY1__c;  
            objMainWrapper.Other_GuaranteedwagesaffiliatesO1CY3 = lstQuick_Cash_Flow[0].Other_GuaranteedwagesaffiliatesO1CY3__c;  
            objMainWrapper.Other_GuaranteedwagesaffiliatesO1CY2 = lstQuick_Cash_Flow[0].Other_GuaranteedwagesaffiliatesO1CY2__c;  
            objMainWrapper.Other_GuaranteedwagesaffiliatesO1CY1 = lstQuick_Cash_Flow[0].Other_GuaranteedwagesaffiliatesO1CY1__c;  
            objMainWrapper.Other_Guaranteed_wages_affiliates_O5_CY = lstQuick_Cash_Flow[0].Other_Guaranteed_wages_affiliates_O5_CY__c;  
            objMainWrapper.Other_Guaranteed_wages_affiliates_O4_CY = lstQuick_Cash_Flow[0].Other_Guaranteed_wages_affiliates_O4_CY__c;  
            objMainWrapper.Other_Guaranteed_wages_affiliates_O3_CY = lstQuick_Cash_Flow[0].Other_Guaranteed_wages_affiliates_O3_CY__c;  
            objMainWrapper.Other_Guaranteed_wages_affiliates_O2_CY = lstQuick_Cash_Flow[0].Other_Guaranteed_wages_affiliates_O2_CY__c;  
            objMainWrapper.Other_Guaranteed_wages_affiliates_O1_CY = lstQuick_Cash_Flow[0].Other_Guaranteed_wages_affiliates_O1_CY__c;  
            objMainWrapper.Non_Recurring_Expenses_CY = lstQuick_Cash_Flow[0].Non_Recurring_Expenses_CY__c;  
            objMainWrapper.Non_Recurring_Expenses_CY3 = lstQuick_Cash_Flow[0].Non_Recurring_Expenses_CY3__c;  
            objMainWrapper.Non_Recurring_Expenses_CY2 = lstQuick_Cash_Flow[0].Non_Recurring_Expenses_CY2__c;  
            objMainWrapper.Non_Recurring_Expenses_CY1 = lstQuick_Cash_Flow[0].Non_Recurring_Expenses_CY1__c;  
            objMainWrapper.New_Rents_CY = lstQuick_Cash_Flow[0].New_Rents_CY__c;  
            objMainWrapper.New_Rents_CY3 = lstQuick_Cash_Flow[0].New_Rents_CY3__c;  
            objMainWrapper.New_Rents_CY2 = lstQuick_Cash_Flow[0].New_Rents_CY2__c;  
            objMainWrapper.New_Rents_CY1 = lstQuick_Cash_Flow[0].New_Rents_CY1__c;  
            objMainWrapper.Net_Profit_CY = lstQuick_Cash_Flow[0].Net_Profit_CY__c;  
            objMainWrapper.Net_Profit_CY3 = lstQuick_Cash_Flow[0].Net_Profit_CY3__c;  
            objMainWrapper.Net_Profit_CY2 = lstQuick_Cash_Flow[0].Net_Profit_CY2__c;  
            objMainWrapper.Net_Profit_CY1 = lstQuick_Cash_Flow[0].Net_Profit_CY1__c;   
            objMainWrapper.Months_CY = lstQuick_Cash_Flow[0].Months_CY__c;  
            objMainWrapper.Months_CY3 = lstQuick_Cash_Flow[0].Months_CY3__c;  
            objMainWrapper.Months_CY2 = lstQuick_Cash_Flow[0].Months_CY2__c;  
            objMainWrapper.Months_CY1 = lstQuick_Cash_Flow[0].Months_CY1__c;  
            objMainWrapper.Monthly_Existing_Installment_Debt_CY = lstQuick_Cash_Flow[0].Monthly_Existing_Installment_Debt_CY__c;  
            objMainWrapper.Monthly_Existing_Installment_Debt_CY3 = lstQuick_Cash_Flow[0].Monthly_Existing_Installment_Debt_CY3__c;  
            objMainWrapper.Monthly_Existing_Installment_Debt_CY2 = lstQuick_Cash_Flow[0].Monthly_Existing_Installment_Debt_CY2__c;  
            objMainWrapper.Monthly_Existing_Installment_Debt_CY1 = lstQuick_Cash_Flow[0].Monthly_Existing_Installment_Debt_CY1__c;  
             
            objMainWrapper.Loan_Amount_Adjusted = lstQuick_Cash_Flow[0].Loan_Amount_Adjusted__c;  
           
            objMainWrapper.Loan_Amount_Actual = lstQuick_Cash_Flow[0].Loan_Amount_Actual__c;  
            //objMainWrapper.Lead = String.valueof(leadID);  
            
            
            objMainWrapper.K1_Distributions_O5_CY = lstQuick_Cash_Flow[0].K1_Distributions_O5_CY__c;  
            objMainWrapper.K1_Distributions_O5_CY3 = lstQuick_Cash_Flow[0].K1_Distributions_O5_CY3__c;  
            objMainWrapper.K1_Distributions_O5_CY2 = lstQuick_Cash_Flow[0].K1_Distributions_O5_CY2__c;  
            objMainWrapper.K1_Distributions_O5_CY1 = lstQuick_Cash_Flow[0].K1_Distributions_O5_CY1__c;  
            objMainWrapper.K1_Distributions_O4_CY = lstQuick_Cash_Flow[0].K1_Distributions_O4_CY__c;  
            objMainWrapper.K1_Distributions_O4_CY3 = lstQuick_Cash_Flow[0].K1_Distributions_O4_CY3__c;  
            objMainWrapper.K1_Distributions_O4_CY2 = lstQuick_Cash_Flow[0].K1_Distributions_O4_CY2__c;  
            objMainWrapper.K1_Distributions_O4_CY1 = lstQuick_Cash_Flow[0].K1_Distributions_O4_CY1__c;  
            objMainWrapper.K1_Distributions_O3_CY = lstQuick_Cash_Flow[0].K1_Distributions_O3_CY__c;  
            objMainWrapper.K1_Distributions_O3_CY3 = lstQuick_Cash_Flow[0].K1_Distributions_O3_CY3__c;  
            objMainWrapper.K1_Distributions_O3_CY2 = lstQuick_Cash_Flow[0].K1_Distributions_O3_CY2__c;  
            objMainWrapper.K1_Distributions_O3_CY1 = lstQuick_Cash_Flow[0].K1_Distributions_O3_CY1__c;  
            objMainWrapper.K1_Distributions_O2_CY = lstQuick_Cash_Flow[0].K1_Distributions_O2_CY__c;  
            objMainWrapper.K1_Distributions_O2_CY3 = lstQuick_Cash_Flow[0].K1_Distributions_O2_CY3__c;  
            objMainWrapper.K1_Distributions_O2_CY2 = lstQuick_Cash_Flow[0].K1_Distributions_O2_CY2__c;  
            objMainWrapper.K1_Distributions_O2_CY1 = lstQuick_Cash_Flow[0].K1_Distributions_O2_CY1__c;  
            objMainWrapper.K1_Distributions_O1_CY = lstQuick_Cash_Flow[0].K1_Distributions_O1_CY__c;  
            objMainWrapper.K1_Distributions_O1_CY3 = lstQuick_Cash_Flow[0].K1_Distributions_O1_CY3__c;  
            objMainWrapper.K1_Distributions_O1_CY2 = lstQuick_Cash_Flow[0].K1_Distributions_O1_CY2__c;  
            objMainWrapper.K1_Distributions_O1_CY1 = lstQuick_Cash_Flow[0].K1_Distributions_O1_CY1__c;  
            
            objMainWrapper.Interestdividend_Income_O5_CY = lstQuick_Cash_Flow[0].Interestdividend_Income_O5_CY__c;  
            objMainWrapper.Interestdividend_Income_O5_CY3 = lstQuick_Cash_Flow[0].Interestdividend_Income_O5_CY3__c;  
            objMainWrapper.Interestdividend_Income_O5_CY2 = lstQuick_Cash_Flow[0].Interestdividend_Income_O5_CY2__c;  
            objMainWrapper.Interestdividend_Income_O5_CY1 = lstQuick_Cash_Flow[0].Interestdividend_Income_O5_CY1__c;  
            objMainWrapper.Interestdividend_Income_O4_CY = lstQuick_Cash_Flow[0].Interestdividend_Income_O4_CY__c;  
            objMainWrapper.Interestdividend_Income_O4_CY3 = lstQuick_Cash_Flow[0].Interestdividend_Income_O4_CY3__c;  
            objMainWrapper.Interestdividend_Income_O4_CY2 = lstQuick_Cash_Flow[0].Interestdividend_Income_O4_CY2__c;  
            objMainWrapper.Interestdividend_Income_O4_CY1 = lstQuick_Cash_Flow[0].Interestdividend_Income_O4_CY1__c;  
            objMainWrapper.Interestdividend_Income_O3_CY = lstQuick_Cash_Flow[0].Interestdividend_Income_O3_CY__c;  
            objMainWrapper.Interestdividend_Income_O3_CY3 = lstQuick_Cash_Flow[0].Interestdividend_Income_O3_CY3__c;  
            objMainWrapper.Interestdividend_Income_O3_CY2 = lstQuick_Cash_Flow[0].Interestdividend_Income_O3_CY2__c;  
            objMainWrapper.Interestdividend_Income_O3_CY1 = lstQuick_Cash_Flow[0].Interestdividend_Income_O3_CY1__c;  
            objMainWrapper.Interestdividend_Income_O2_CY = lstQuick_Cash_Flow[0].Interestdividend_Income_O2_CY__c;  
            objMainWrapper.Interestdividend_Income_O2_CY3 = lstQuick_Cash_Flow[0].Interestdividend_Income_O2_CY3__c;  
            objMainWrapper.Interestdividend_Income_O2_CY2 = lstQuick_Cash_Flow[0].Interestdividend_Income_O2_CY2__c;  
            objMainWrapper.Interestdividend_Income_O2_CY1 = lstQuick_Cash_Flow[0].Interestdividend_Income_O2_CY1__c;  
            objMainWrapper.Interestdividend_Income_O1_CY = lstQuick_Cash_Flow[0].Interestdividend_Income_O1_CY__c;  
            objMainWrapper.Interestdividend_Income_O1_CY3 = lstQuick_Cash_Flow[0].Interestdividend_Income_CY3__c;  
            objMainWrapper.Interestdividend_Income_O1_CY2 = lstQuick_Cash_Flow[0].Interestdividend_Income_CY2__c;  
            objMainWrapper.Interestdividend_Income_O1_CY1 = lstQuick_Cash_Flow[0].Interestdividend_Income_CY1__c;  
              
            objMainWrapper.Interest_Rate_Adjusted = lstQuick_Cash_Flow[0].Interest_Rate_Adjusted__c;  
            objMainWrapper.Interest_Rate_Actual = lstQuick_Cash_Flow[0].Interest_Rate_Actual__c;  
            objMainWrapper.Interest_Exp_CY = lstQuick_Cash_Flow[0].Interest_Exp_CY__c;  
            objMainWrapper.Interest_Exp_CY3 = lstQuick_Cash_Flow[0].Interest_Exp_CY3__c;  
            objMainWrapper.Interest_Exp_CY2 = lstQuick_Cash_Flow[0].Interest_Exp_CY2__c;  
            objMainWrapper.Interest_Exp_CY1 = lstQuick_Cash_Flow[0].Interest_Exp_CY1__c;  
            objMainWrapper.Industry_High_Risk = lstQuick_Cash_Flow[0].Industry_High_Risk__c;  
            //objMainWrapper.Id = lstQuick_Cash_Flow[0].Id__c;  
           
            objMainWrapper.Global_Coverage_Ratio_CY = lstQuick_Cash_Flow[0].Global_Coverage_Ratio_CY__c;  
            objMainWrapper.Global_Coverage_Ratio_CY3 = lstQuick_Cash_Flow[0].Global_Coverage_Ratio_CY3__c;  
            objMainWrapper.Global_Coverage_Ratio_CY2 = lstQuick_Cash_Flow[0].Global_Coverage_Ratio_CY2__c;  
            objMainWrapper.Global_Coverage_Ratio_CY1 = lstQuick_Cash_Flow[0].Global_Coverage_Ratio_CY1__c;  
            objMainWrapper.Estimated_CCR = lstQuick_Cash_Flow[0].Estimated_CCR__c;  
             
            objMainWrapper.DueIn_Months_Adjusted = lstQuick_Cash_Flow[0].DueIn_Months_Adjusted__c;  
            objMainWrapper.DueIn_Months_Actual = lstQuick_Cash_Flow[0].DueIn_Months_Actual__c;  
            objMainWrapper.Discretionary_Coverage_Ratio_CY = lstQuick_Cash_Flow[0].Discretionary_Coverage_Ratio_CY__c;  
            objMainWrapper.Discretionary_Coverage_Ratio_CY3 = lstQuick_Cash_Flow[0].Discretionary_Coverage_Ratio_CY3__c;  
            objMainWrapper.Discretionary_Coverage_Ratio_CY2 = lstQuick_Cash_Flow[0].Discretionary_Coverage_Ratio_CY2__c;  
            objMainWrapper.Discretionary_Coverage_Ratio_CY1 = lstQuick_Cash_Flow[0].Discretionary_Coverage_Ratio_CY1__c;  
            
            objMainWrapper.Business_Coverage_Ratio_CY = lstQuick_Cash_Flow[0].Business_Coverage_Ratio_CY__c;  
            objMainWrapper.Business_Coverage_Ratio_CY3 = lstQuick_Cash_Flow[0].Business_Coverage_Ratio_CY3__c;  
            objMainWrapper.Business_Coverage_Ratio_CY2 = lstQuick_Cash_Flow[0].Business_Coverage_Ratio_CY2__c;  
            objMainWrapper.Business_Coverage_Ratio_CY1 = lstQuick_Cash_Flow[0].Business_Coverage_Ratio_CY1__c;  
            objMainWrapper.Annual_Existing_P_I_CY = lstQuick_Cash_Flow[0].Annual_Existing_P_I_CY__c;  
            objMainWrapper.Annual_Existing_P_I_CY3 = lstQuick_Cash_Flow[0].Annual_Existing_P_I_CY3__c;  
            objMainWrapper.Annual_Existing_P_I_CY2 = lstQuick_Cash_Flow[0].Annual_Existing_P_I_CY2__c;  
            objMainWrapper.Annual_Existing_P_I_CY1 = lstQuick_Cash_Flow[0].Annual_Existing_P_I_CY1__c;  
            objMainWrapper.Affilliate_Income_CY = lstQuick_Cash_Flow[0].Affilliate_Income_CY__c;  
            objMainWrapper.Affilliate_Income_CY3 = lstQuick_Cash_Flow[0].Affilliate_Income_CY3__c;  
            objMainWrapper.Affilliate_Income_CY2 = lstQuick_Cash_Flow[0].Affilliate_Income_CY2__c;  
            objMainWrapper.Affilliate_Income_CY1 = lstQuick_Cash_Flow[0].Affilliate_Income_CY1__c;
            
        }
        
        
        return objMainWrapper;
    }
    @AuraEnabled
    public static mainWrapper saveQCFData( mainWrapper ObjWrapperData, string leadID) {
       list<Quick_Cash_Flow__c> lstQuick_Cash_Flow = new list<Quick_Cash_Flow__c>();
       
       Quick_Cash_Flow__c objQCF ;
       lead objLeadData ;
        if( leadID != null && leadID != '')
        {
        objLeadData = new lead(id=leadID);
        objLeadData.Loan_Type__c = ObjWrapperData.loanType;
        
         lstQuick_Cash_Flow = [select id, name from Quick_Cash_Flow__c where Lead__r.Id=:leadID limit 1];
        
        if( lstQuick_Cash_Flow != null && lstQuick_Cash_Flow.size() > 0 )
        {    
            objQCF = new Quick_Cash_Flow__c(id=lstQuick_Cash_Flow[0].id);
        }
        else
        objQCF = new Quick_Cash_Flow__c();
        //objQCF.id=quickCashFlowdata.id;
        system.debug('objQCF----->> '+objQCF);
        system.debug('leadID----->> '+leadID);
        system.debug('ObjWrapperData----->> '+ObjWrapperData);
        //ObjQCF.Year_CY_3__c = ObjWrapperData.Year_CY_3 ;  
        //ObjQCF.Year_CY_2__c = ObjWrapperData.Year_CY_2 ;  
        //ObjQCF.Year_CY_1__c = ObjWrapperData.Year_CY_1 ;  
        if(ObjWrapperData != null && leadID != null  )
        {
            ObjQCF.Taxes_O1_CY__c  =  ObjWrapperData.Taxes_O1_CY;
        ObjQCF.Taxes_O2_CY__c  =  ObjWrapperData.Taxes_O2_CY;
        ObjQCF.Taxes_O3_CY__c  =  ObjWrapperData.Taxes_O3_CY;
        ObjQCF.Taxes_O4_CY__c  =  ObjWrapperData.Taxes_O4_CY;
        ObjQCF.Taxes_O5_CY__c  =  ObjWrapperData.Taxes_O5_CY;
        ObjQCF.Taxes_O1_CY1__c  =  ObjWrapperData.Taxes_O1_CY1;
        ObjQCF.Taxes_O2_CY1__c  =  ObjWrapperData.Taxes_O2_CY1;
        ObjQCF.Taxes_O3_CY1__c  =  ObjWrapperData.Taxes_O3_CY1;
        ObjQCF.Taxes_O4_CY1__c  =  ObjWrapperData.Taxes_O4_CY1;
        ObjQCF.Taxes_O5_CY1__c  =  ObjWrapperData.Taxes_O5_CY1;
        ObjQCF.Taxes_O1_CY2__c  =  ObjWrapperData.Taxes_O1_CY2;
        ObjQCF.Taxes_O2_CY2__c  =  ObjWrapperData.Taxes_O2_CY2;
        ObjQCF.Taxes_O3_CY2__c  =  ObjWrapperData.Taxes_O3_CY2;
        ObjQCF.Taxes_O4_CY2__c  =  ObjWrapperData.Taxes_O4_CY2;
        ObjQCF.Taxes_O5_CY2__c  =  ObjWrapperData.Taxes_O5_CY2;
        ObjQCF.Taxes_O1_CY3__c  =  ObjWrapperData.Taxes_O1_CY3;
        ObjQCF.Taxes_O2_CY3__c  =  ObjWrapperData.Taxes_O2_CY3;
        ObjQCF.Taxes_O3_CY3__c  =  ObjWrapperData.Taxes_O3_CY3;
        ObjQCF.Taxes_O4_CY3__c  =  ObjWrapperData.Taxes_O4_CY3;
        ObjQCF.Taxes_O5_CY3__c  =  ObjWrapperData.Taxes_O5_CY3;
        
        ObjQCF.RETaxes_O1_CY__c  =  ObjWrapperData.RETaxes_O1_CY;
        ObjQCF.RETaxes_O2_CY__c  =  ObjWrapperData.RETaxes_O2_CY;
        ObjQCF.RETaxes_O3_CY__c  =  ObjWrapperData.RETaxes_O3_CY;
        ObjQCF.RETaxes_O4_CY__c  =  ObjWrapperData.RETaxes_O4_CY;
        ObjQCF.RETaxes_O5_CY__c  =  ObjWrapperData.RETaxes_O5_CY;
        ObjQCF.RETaxes_O1_CY1__c  =  ObjWrapperData.RETaxes_O1_CY1;
        ObjQCF.RETaxes_O2_CY1__c  =  ObjWrapperData.RETaxes_O2_CY1;
        ObjQCF.RETaxes_O3_CY1__c  =  ObjWrapperData.RETaxes_O3_CY1;
        ObjQCF.RETaxes_O4_CY1__c  =  ObjWrapperData.RETaxes_O4_CY1;
        ObjQCF.RETaxes_O5_CY1__c  =  ObjWrapperData.RETaxes_O5_CY1;
        ObjQCF.RETaxes_O1_CY2__c  =  ObjWrapperData.RETaxes_O1_CY2;
        ObjQCF.RETaxes_O2_CY2__c  =  ObjWrapperData.RETaxes_O2_CY2;
        ObjQCF.RETaxes_O3_CY2__c  =  ObjWrapperData.RETaxes_O3_CY2;
        ObjQCF.RETaxes_O4_CY2__c  =  ObjWrapperData.RETaxes_O4_CY2;
        ObjQCF.RETaxes_O5_CY2__c  =  ObjWrapperData.RETaxes_O5_CY2;
        ObjQCF.RETaxes_O1_CY3__c  =  ObjWrapperData.RETaxes_O1_CY3;
        ObjQCF.RETaxes_O2_CY3__c  =  ObjWrapperData.RETaxes_O2_CY3;
        ObjQCF.RETaxes_O3_CY3__c  =  ObjWrapperData.RETaxes_O3_CY3;
        ObjQCF.RETaxes_O4_CY3__c  =  ObjWrapperData.RETaxes_O4_CY3;
        ObjQCF.RETaxes_O5_CY3__c  =  ObjWrapperData.RETaxes_O5_CY3;
        
        ObjQCF.Living_Expenses_O1_CY__c  =  ObjWrapperData.Living_Expenses_O1_CY;
        ObjQCF.Living_Expenses_O2_CY__c  =  ObjWrapperData.Living_Expenses_O2_CY;
        ObjQCF.Living_Expenses_O3_CY__c  =  ObjWrapperData.Living_Expenses_O3_CY;
        ObjQCF.Living_Expenses_O4_CY__c  =  ObjWrapperData.Living_Expenses_O4_CY;
        ObjQCF.Living_Expenses_O5_CY__c  =  ObjWrapperData.Living_Expenses_O5_CY;
        ObjQCF.Living_Expenses_O1_CY1__c  =  ObjWrapperData.Living_Expenses_O1_CY1;
        ObjQCF.Living_Expenses_O2_CY1__c  =  ObjWrapperData.Living_Expenses_O2_CY1;
        ObjQCF.Living_Expenses_O3_CY1__c  =  ObjWrapperData.Living_Expenses_O3_CY1;
        ObjQCF.Living_Expenses_O4_CY1__c  =  ObjWrapperData.Living_Expenses_O4_CY1;
        ObjQCF.Living_Expenses_O5_CY1__c  =  ObjWrapperData.Living_Expenses_O5_CY1;
        ObjQCF.Living_Expenses_O1_CY2__c  =  ObjWrapperData.Living_Expenses_O1_CY2;
        ObjQCF.Living_Expenses_O2_CY2__c  =  ObjWrapperData.Living_Expenses_O2_CY2;
        ObjQCF.Living_Expenses_O3_CY2__c  =  ObjWrapperData.Living_Expenses_O3_CY2;
        ObjQCF.Living_Expenses_O4_CY2__c  =  ObjWrapperData.Living_Expenses_O4_CY2;
        ObjQCF.Living_Expenses_O5_CY2__c  =  ObjWrapperData.Living_Expenses_O5_CY2;
        ObjQCF.Living_Expenses_O1_CY3__c  =  ObjWrapperData.Living_Expenses_O1_CY3;
        ObjQCF.Living_Expenses_O2_CY3__c  =  ObjWrapperData.Living_Expenses_O2_CY3;
        ObjQCF.Living_Expenses_O3_CY3__c  =  ObjWrapperData.Living_Expenses_O3_CY3;
        ObjQCF.Living_Expenses_O4_CY3__c  =  ObjWrapperData.Living_Expenses_O4_CY3;
        ObjQCF.Living_Expenses_O5_CY3__c  =  ObjWrapperData.Living_Expenses_O5_CY3;
        
        ObjQCF.Total_Taxes_O1_CY__c  =  ObjWrapperData.Total_Taxes_O1_CY;
        ObjQCF.Total_Taxes_O2_CY__c  =  ObjWrapperData.Total_Taxes_O2_CY;
        ObjQCF.Total_Taxes_O3_CY__c  =  ObjWrapperData.Total_Taxes_O3_CY;
        ObjQCF.Total_Taxes_O4_CY__c  =  ObjWrapperData.Total_Taxes_O4_CY;
        ObjQCF.Total_Taxes_O5_CY__c  =  ObjWrapperData.Total_Taxes_O5_CY;
        ObjQCF.Total_Taxes_O1_CY1__c  =  ObjWrapperData.Total_Taxes_O1_CY1;
        ObjQCF.Total_Taxes_O2_CY1__c  =  ObjWrapperData.Total_Taxes_O2_CY1;
        ObjQCF.Total_Taxes_O3_CY1__c  =  ObjWrapperData.Total_Taxes_O3_CY1;
        ObjQCF.Total_Taxes_O4_CY1__c  =  ObjWrapperData.Total_Taxes_O4_CY1;
        ObjQCF.Total_Taxes_O5_CY1__c  =  ObjWrapperData.Total_Taxes_O5_CY1;
        ObjQCF.Total_Taxes_O1_CY2__c  =  ObjWrapperData.Total_Taxes_O1_CY2;
        ObjQCF.Total_Taxes_O2_CY2__c  =  ObjWrapperData.Total_Taxes_O2_CY2;
        ObjQCF.Total_Taxes_O3_CY2__c  =  ObjWrapperData.Total_Taxes_O3_CY2;
        ObjQCF.Total_Taxes_O4_CY2__c  =  ObjWrapperData.Total_Taxes_O4_CY2;
        ObjQCF.Total_Taxes_O5_CY2__c  =  ObjWrapperData.Total_Taxes_O5_CY2;
        ObjQCF.Total_Taxes_O1_CY3__c  =  ObjWrapperData.Total_Taxes_O1_CY3;
        ObjQCF.Total_Taxes_O2_CY3__c  =  ObjWrapperData.Total_Taxes_O2_CY3;
        ObjQCF.Total_Taxes_O3_CY3__c  =  ObjWrapperData.Total_Taxes_O3_CY3;
        ObjQCF.Total_Taxes_O4_CY3__c  =  ObjWrapperData.Total_Taxes_O4_CY3;
        ObjQCF.Total_Taxes_O5_CY3__c  =  ObjWrapperData.Total_Taxes_O5_CY3;
           
            
            ObjQCF.Total_Estimated_Personal_O5_CY3__c = ObjWrapperData.Total_Estimated_Personal_O5_CY3;
            ObjQCF.Total_Estimated_Personal_O5_CY2__c = ObjWrapperData.Total_Estimated_Personal_O5_CY2;
            ObjQCF.Total_Estimated_Personal_O5_CY1__c = ObjWrapperData.Total_Estimated_Personal_O5_CY1;
            ObjQCF.Total_Estimated_Personal_O5_CY__c = ObjWrapperData.Total_Estimated_Personal_O5_CY;
            ObjQCF.Total_Estimated_Personal_O4_CY3__c = ObjWrapperData.Total_Estimated_Personal_O4_CY3;
            ObjQCF.Total_Estimated_Personal_O4_CY2__c = ObjWrapperData.Total_Estimated_Personal_O4_CY2;
            ObjQCF.Total_Estimated_Personal_O4_CY1__c = ObjWrapperData.Total_Estimated_Personal_O4_CY1;
            ObjQCF.Total_Estimated_Personal_O4_CY__c =  ObjWrapperData.Total_Estimated_Personal_O4_CY;
            ObjQCF.Total_Estimated_Personal_O3_CY3__c = ObjWrapperData.Total_Estimated_Personal_O3_CY3;
            ObjQCF.Total_Estimated_Personal_O3_CY2__c = ObjWrapperData.Total_Estimated_Personal_O3_CY2;
            ObjQCF.Total_Estimated_Personal_O3_CY1__c = ObjWrapperData.Total_Estimated_Personal_O3_CY1;
            ObjQCF.Total_Estimated_Personal_O3_CY__c = ObjWrapperData.Total_Estimated_Personal_O3_CY;
            ObjQCF.Total_Estimated_Personal_O2_CY3__c = ObjWrapperData.Total_Estimated_Personal_O2_CY3;
            ObjQCF.Total_Estimated_Personal_O2_CY2__c = ObjWrapperData.Total_Estimated_Personal_O2_CY2;
            ObjQCF.Total_Estimated_Personal_O2_CY1__c = ObjWrapperData.Total_Estimated_Personal_O2_CY1;
            ObjQCF.Total_Estimated_Personal_O2_CY__c = ObjWrapperData.Total_Estimated_Personal_O2_CY;
            ObjQCF.Total_Estimated_Personal_O1_CY3__c = ObjWrapperData.Total_Estimated_Personal_O1_CY3;
            ObjQCF.Total_Estimated_Personal_O1_CY2__c = ObjWrapperData.Total_Estimated_Personal_O1_CY2;
            ObjQCF.Total_Estimated_Personal_O1_CY1__c = ObjWrapperData.Total_Estimated_Personal_O1_CY1;
            ObjQCF.Total_Estimated_Personal_O1_CY__c = ObjWrapperData.Total_Estimated_Personal_O1_CY;

            
            ObjQCF.Owner1_Adult__c = ObjWrapperData.Adult_Owner1; 
            ObjQCF.Owner2_Adult__c = ObjWrapperData.Adult_Owner2; 
            ObjQCF.Owner3_Adult__c = ObjWrapperData.Adult_Owner3; 
            ObjQCF.Owner4_Adult__c = ObjWrapperData.Adult_Owner4; 
            ObjQCF.Owner5_Adult__c = ObjWrapperData.Adult_Owner5; 
            ObjQCF.Owner1_Adult_Currency__c = ObjWrapperData.AdultCurrency_Owner1;  
            ObjQCF.Owner2_Adult_Currency__c = ObjWrapperData.AdultCurrency_Owner2;  
            ObjQCF.Owner3_Adult_Currency__c =  ObjWrapperData.AdultCurrency_Owner3; 
            ObjQCF.Owner4_Adult_Currency__c =  ObjWrapperData.AdultCurrency_Owner4; 
            ObjQCF.Owner5_Adult_Currency__c = ObjWrapperData.AdultCurrency_Owner5;  
            ObjQCF.Owner1_Kid__c =  ObjWrapperData.Kid_Owner1 ; 
            ObjQCF.Owner2_Kid__c =  ObjWrapperData.Kid_Owner2 ; 
            ObjQCF.Owner3_Kid__c = ObjWrapperData.Kid_Owner3 ;
            ObjQCF.Owner4_Kid__c = ObjWrapperData.Kid_Owner4 ;
            ObjQCF.Owner5_Kid__c = ObjWrapperData.Kid_Owner5 ;
             ObjQCF.Owner1_Kid__c =  ObjWrapperData.Kid_Owner1 ;
             ObjQCF.Owner1_Kid__c = ObjWrapperData.Kid_Owner1 ;
            ObjQCF.Owner1_Kid_Currency__c = ObjWrapperData.KidCurrency_Owner1; 
            ObjQCF.Owner2_Kid_Currency__c = ObjWrapperData.KidCurrency_Owner2;  
           ObjQCF.Owner3_Kid_Currency__c = ObjWrapperData.KidCurrency_Owner3;  
           ObjQCF.Owner4_Kid_Currency__c = ObjWrapperData.KidCurrency_Owner4;  
             ObjQCF.Owner5_Kid_Currency__c = ObjWrapperData.KidCurrency_Owner5;
            
            ObjQCF.Residence_Mortgage_Owner_1__c = ObjWrapperData.Residence_Mortgage_Owner_1 ;
            ObjQCF.Residence_Mortgage_Owner_2__c = ObjWrapperData.Residence_Mortgage_Owner_2 ;
            ObjQCF.Residence_Mortgage_Owner_3__c = ObjWrapperData.Residence_Mortgage_Owner_3 ;
            ObjQCF.Residence_Mortgage_Owner_4__c = ObjWrapperData.Residence_Mortgage_Owner_4 ;
            ObjQCF.Residence_Mortgage_Owner_5__c = ObjWrapperData.Residence_Mortgage_Owner_5 ;
            ObjQCF.Rental_Payment_Owner_1__c = ObjWrapperData.Rental_Payment_Owner_1 ;
            ObjQCF.Rental_Payment_Owner_2__c = ObjWrapperData.Rental_Payment_Owner_2 ;
            ObjQCF.Rental_Payment_Owner_3__c = ObjWrapperData.Rental_Payment_Owner_3 ;
            ObjQCF.Rental_Payment_Owner_4__c = ObjWrapperData.Rental_Payment_Owner_4 ;
            ObjQCF.Rental_Payment_Owner_5__c = ObjWrapperData.Rental_Payment_Owner_5 ;
            ObjQCF.HELOC_Owner_1__c = ObjWrapperData.HELOC_Owner_1 ;    
            ObjQCF.HELOC_Owner_2__c = ObjWrapperData.HELOC_Owner_2 ;    
            ObjQCF.HELOC_Owner_3__c = ObjWrapperData.HELOC_Owner_3 ;    
            ObjQCF.HELOC_Owner_4__c = ObjWrapperData.HELOC_Owner_3 ;    
            ObjQCF.HELOC_Owner_5__c = ObjWrapperData.HELOC_Owner_4 ;    
            ObjQCF.Installment_Debt_Owner_1__c = ObjWrapperData.Installment_Debt_Owner_1 ;
            ObjQCF.Installment_Debt_Owner_2__c = ObjWrapperData.Installment_Debt_Owner_2 ;  
            ObjQCF.Installment_Debt_Owner_3__c = ObjWrapperData.Installment_Debt_Owner_3 ;  
            ObjQCF.Installment_Debt_Owner_4__c = ObjWrapperData.Installment_Debt_Owner_4 ;  
            ObjQCF.Installment_Debt_Owner_5__c = ObjWrapperData.Installment_Debt_Owner_5 ;  
            ObjQCF.Credit_Card_Debt_Owner_1__c = ObjWrapperData.Credit_Card_Debt_Owner_1 ;
            ObjQCF.Credit_Card_Debt_Owner_2__c = ObjWrapperData.Credit_Card_Debt_Owner_2 ;
            ObjQCF.Credit_Card_Debt_Owner_3__c = ObjWrapperData.Credit_Card_Debt_Owner_3 ;
            ObjQCF.Credit_Card_Debt_Owner_4__c = ObjWrapperData.Credit_Card_Debt_Owner_4 ;
            ObjQCF.Credit_Card_Debt_Owner_5__c = ObjWrapperData.Credit_Card_Debt_Owner_5 ;
            ObjQCF.Other_debt_Owner_1__c = ObjWrapperData.Other_debt_Owner_1 ;
            ObjQCF.Other_debt_Owner_2__c = ObjWrapperData.Other_debt_Owner_2 ;
            ObjQCF.Other_debt_Owner_3__c = ObjWrapperData.Other_debt_Owner_3 ;
            ObjQCF.Other_debt_Owner_4__c = ObjWrapperData.Other_debt_Owner_4 ;
            ObjQCF.Other_debt_Owner_5__c = ObjWrapperData.Other_debt_Owner_5 ;
          //  objQCF.Total_Annual_Debt_O1_CY__c = ObjWrapperData.Total_Annual_Debt_O1_CY ;
            ObjQCF.Total_Annual_Debt_Service_Owner_1__c = ObjWrapperData.Total_Annual_Debt_Service_Owner_1 ;
            ObjQCF.Total_Annual_Debt_Service_Owner_2__c = ObjWrapperData.Total_Annual_Debt_Service_Owner_2 ;
            ObjQCF.Total_Annual_Debt_Service_Owner_3__c = ObjWrapperData.Total_Annual_Debt_Service_Owner_3 ;
            ObjQCF.Total_Annual_Debt_Service_Owner_4__c = ObjWrapperData.Total_Annual_Debt_Service_Owner_4 ;
            ObjQCF.Total_Annual_Debt_Service_Owner_5__c = ObjWrapperData.Total_Annual_Debt_Service_Owner_5 ;
            
            ObjQCF.Total_Second_CY__c = ObjWrapperData.Total_Second_CY ;  
            ObjQCF.Total_Second_CY3__c = ObjWrapperData.Total_Second_CY3 ;  
            ObjQCF.Total_Second_CY2__c = ObjWrapperData.Total_Second_CY2 ;  
            ObjQCF.Total_Second_CY1__c = ObjWrapperData.Total_Second_CY1 ;  
            ObjQCF.Total_First_CY__c = ObjWrapperData.Total_First_CY ;  
            ObjQCF.Total_First_CY3__c = ObjWrapperData.Total_First_CY3 ;  
            ObjQCF.Total_First_CY2__c = ObjWrapperData.Total_First_CY2 ;  
            ObjQCF.Total_First_CY1__c = ObjWrapperData.Total_First_CY1 ;  
            ObjQCF.Time_in_Business_Months__c = ObjWrapperData.Time_in_Business_Months ;  
            ObjQCF.Test__c = ObjWrapperData.Test ;  
             
            ObjQCF.Term_Months_Adjusted__c = ObjWrapperData.Term_Months_Adjusted ;  
            ObjQCF.Term_Months_Actual__c = ObjWrapperData.Term_Months_Actual ; 
            ObjQCF.Schedule_E_Rental_O5_CY__c = ObjWrapperData.Schedule_E_Rental_O5_CY ;  
            ObjQCF.Schedule_E_Rental_O5_CY3__c = ObjWrapperData.Schedule_E_Rental_O5_CY3 ;  
            ObjQCF.Schedule_E_Rental_O5_CY2__c = ObjWrapperData.Schedule_E_Rental_O5_CY2 ;  
            ObjQCF.Schedule_E_Rental_O5_CY1__c = ObjWrapperData.Schedule_E_Rental_O5_CY1 ;  
            ObjQCF.Schedule_E_Rental_O4_CY__c = ObjWrapperData.Schedule_E_Rental_O4_CY ;  
            ObjQCF.Schedule_E_Rental_O4_CY3__c = ObjWrapperData.Schedule_E_Rental_O4_CY3 ;  
            ObjQCF.Schedule_E_Rental_O4_CY2__c = ObjWrapperData.Schedule_E_Rental_O4_CY2 ;  
            ObjQCF.Schedule_E_Rental_O4_CY1__c = ObjWrapperData.Schedule_E_Rental_O4_CY1 ;  
            ObjQCF.Schedule_E_Rental_O3_CY__c = ObjWrapperData.Schedule_E_Rental_O3_CY ;  
            ObjQCF.Schedule_E_Rental_O3_CY3__c = ObjWrapperData.Schedule_E_Rental_O3_CY3 ;  
            ObjQCF.Schedule_E_Rental_O3_CY2__c = ObjWrapperData.Schedule_E_Rental_O3_CY2 ;  
            ObjQCF.Schedule_E_Rental_O3_CY1__c = ObjWrapperData.Schedule_E_Rental_O3_CY1 ;  
            ObjQCF.Schedule_E_Rental_O2_CY__c = ObjWrapperData.Schedule_E_Rental_O2_CY ;  
            ObjQCF.Schedule_E_Rental_O2_CY3__c = ObjWrapperData.Schedule_E_Rental_O2_CY3 ;  
            ObjQCF.Schedule_E_Rental_O2_CY2__c = ObjWrapperData.Schedule_E_Rental_O2_CY2 ;  
            ObjQCF.Schedule_E_Rental_O2_CY1__c = ObjWrapperData.Schedule_E_Rental_O2_CY1 ;  
            ObjQCF.Schedule_E_Rental_O1_CY__c = ObjWrapperData.Schedule_E_Rental_O1_CY ;  
            ObjQCF.Schedule_E_Rental_O1_CY3__c = ObjWrapperData.Schedule_E_Rental_O1_CY3 ;  
            ObjQCF.Schedule_E_Rental_O1_CY2__c = ObjWrapperData.Schedule_E_Rental_O1_CY2 ;  
            ObjQCF.Schedule_E_Rental_O1_CY1__c = ObjWrapperData.Schedule_E_Rental_O1_CY1 ;  
            ObjQCF.Schedule_C_Income_O5_CY__c = ObjWrapperData.Schedule_C_Income_O5_CY ;  
            ObjQCF.Schedule_C_Income_O5_CY3__c = ObjWrapperData.Schedule_C_Income_O5_CY3 ;  
            ObjQCF.Schedule_C_Income_O5_CY2__c = ObjWrapperData.Schedule_C_Income_O5_CY2 ;  
            ObjQCF.Schedule_C_Income_O5_CY1__c = ObjWrapperData.Schedule_C_Income_O5_CY1 ;  
            ObjQCF.Schedule_C_Income_O4_CY__c = ObjWrapperData.Schedule_C_Income_O4_CY ;  
            ObjQCF.Schedule_C_Income_O4_CY3__c = ObjWrapperData.Schedule_C_Income_O4_CY3 ;  
            ObjQCF.Schedule_C_Income_O4_CY2__c = ObjWrapperData.Schedule_C_Income_O4_CY2 ;  
            ObjQCF.Schedule_C_Income_O4_CY1__c = ObjWrapperData.Schedule_C_Income_O4_CY1 ;  
            ObjQCF.Schedule_C_Income_O3_CY__c = ObjWrapperData.Schedule_C_Income_O3_CY ;  
            ObjQCF.Schedule_C_Income_O3_CY3__c = ObjWrapperData.Schedule_C_Income_O3_CY3 ;  
            ObjQCF.Schedule_C_Income_O3_CY2__c = ObjWrapperData.Schedule_C_Income_O3_CY2 ;  
            ObjQCF.Schedule_C_Income_O3_CY1__c = ObjWrapperData.Schedule_C_Income_O3_CY1 ;  
            ObjQCF.Schedule_C_Income_O2_CY__c = ObjWrapperData.Schedule_C_Income_O2_CY ;  
            ObjQCF.Schedule_C_Income_O2_CY3__c = ObjWrapperData.Schedule_C_Income_O2_CY3 ;  
            ObjQCF.Schedule_C_Income_O2_CY2__c = ObjWrapperData.Schedule_C_Income_O2_CY2 ;  
            ObjQCF.Schedule_C_Income_O2_CY1__c = ObjWrapperData.Schedule_C_Income_O2_CY1 ;  
            ObjQCF.Schedule_C_Income_O1_CY__c = ObjWrapperData.Schedule_C_Income_O1_CY ;  
            ObjQCF.Schedule_C_Income_O1_CY3__c = ObjWrapperData.Schedule_C_Income_O1_CY3 ;  
            ObjQCF.Schedule_C_Income_O1_CY2__c = ObjWrapperData.Schedule_C_Income_O1_CY2 ;  
            ObjQCF.Schedule_C_Income_O1_CY1__c = ObjWrapperData.Schedule_C_Income_O1_CY1 ;  
            ObjQCF.Sch_D_Capital_gainslosses_O5_CY__c = ObjWrapperData.Sch_D_Capital_gainslosses_O5_CY ;  
            ObjQCF.Sch_D_Capital_gainslosses_O5_CY3__c = ObjWrapperData.Sch_D_Capital_gainslosses_O5_CY3 ;  
            ObjQCF.Sch_D_Capital_gainslosses_O5_CY2__c = ObjWrapperData.Sch_D_Capital_gainslosses_O5_CY2 ;  
            ObjQCF.Sch_D_Capital_gainslosses_O5_CY1__c = ObjWrapperData.Sch_D_Capital_gainslosses_O5_CY1 ;  
            ObjQCF.Sch_D_Capital_gainslosses_O4_CY__c = ObjWrapperData.Sch_D_Capital_gainslosses_O4_CY ;  
            ObjQCF.Sch_D_Capital_gainslosses_O4_CY3__c = ObjWrapperData.Sch_D_Capital_gainslosses_O4_CY3 ;  
            ObjQCF.Sch_D_Capital_gainslosses_O4_CY2__c = ObjWrapperData.Sch_D_Capital_gainslosses_O4_CY2 ;  
            ObjQCF.Sch_D_Capital_gainslosses_O4_CY1__c = ObjWrapperData.Sch_D_Capital_gainslosses_O4_CY1 ;  
            ObjQCF.Sch_D_Capital_gainslosses_O3_CY__c = ObjWrapperData.Sch_D_Capital_gainslosses_O3_CY ;  
            ObjQCF.Sch_D_Capital_gainslosses_O3_CY3__c = ObjWrapperData.Sch_D_Capital_gainslosses_O3_CY3 ;  
            ObjQCF.Sch_D_Capital_gainslosses_O3_CY2__c = ObjWrapperData.Sch_D_Capital_gainslosses_O3_CY2 ;  
            ObjQCF.Sch_D_Capital_gainslosses_O3_CY1__c = ObjWrapperData.Sch_D_Capital_gainslosses_O3_CY1 ;  
            ObjQCF.Sch_D_Capital_gainslosses_O2_CY__c = ObjWrapperData.Sch_D_Capital_gainslosses_O2_CY ;  
            ObjQCF.Sch_D_Capital_gainslosses_O2_CY3__c = ObjWrapperData.Sch_D_Capital_gainslosses_O2_CY3 ;  
            ObjQCF.Sch_D_Capital_gainslosses_O2_CY2__c = ObjWrapperData.Sch_D_Capital_gainslosses_O2_CY2 ;  
            ObjQCF.Sch_D_Capital_gainslosses_O2_CY1__c = ObjWrapperData.Sch_D_Capital_gainslosses_O2_CY1 ;  
            ObjQCF.Sch_D_Capital_gainslosses_O1_CY__c = ObjWrapperData.Sch_D_Capital_gainslosses_O1_CY ;  
            ObjQCF.Sch_D_Capital_gainslosses_O1_CY3__c = ObjWrapperData.Sch_D_Capital_gainslosses_O1_CY3 ;  
            ObjQCF.Sch_D_Capital_gainslosses_O1_CY2__c = ObjWrapperData.Sch_D_Capital_gainslosses_O1_CY2 ;  
            ObjQCF.Sch_D_Capital_gainslosses_O1_CY1__c = ObjWrapperData.Sch_D_Capital_gainslosses_O1_CY1 ;  
            ObjQCF.Sales_CY__c = ObjWrapperData.Sales_CY ;  
            ObjQCF.Sales_CY3__c = ObjWrapperData.Sales_CY3 ;  
            ObjQCF.Sales_CY2__c = ObjWrapperData.Sales_CY2 ;  
            ObjQCF.Sales_CY1__c = ObjWrapperData.Sales_CY1 ;  
            ObjQCF.Salary_Wages_Spouse_O5_CY__c = ObjWrapperData.Salary_Wages_Spouse_O5_CY ;  
            ObjQCF.Salary_Wages_Spouse_O5_CY3__c = ObjWrapperData.Salary_Wages_Spouse_O5_CY3 ;  
            ObjQCF.Salary_Wages_Spouse_O5_CY2__c = ObjWrapperData.Salary_Wages_Spouse_O5_CY2 ;  
            ObjQCF.Salary_Wages_Spouse_O5_CY1__c = ObjWrapperData.Salary_Wages_Spouse_O5_CY1 ;  
            ObjQCF.Salary_Wages_Spouse_O4_CY__c = ObjWrapperData.Salary_Wages_Spouse_O4_CY ;  
            ObjQCF.Salary_Wages_Spouse_O4_CY3__c = ObjWrapperData.Salary_Wages_Spouse_O4_CY3 ;  
            ObjQCF.Salary_Wages_Spouse_O4_CY2__c = ObjWrapperData.Salary_Wages_Spouse_O4_CY2 ;  
            ObjQCF.Salary_Wages_Spouse_O4_CY1__c = ObjWrapperData.Salary_Wages_Spouse_O4_CY1 ;  
            ObjQCF.Salary_Wages_Spouse_O3_CY__c = ObjWrapperData.Salary_Wages_Spouse_O3_CY ;  
            ObjQCF.Salary_Wages_Spouse_O3_CY3__c = ObjWrapperData.Salary_Wages_Spouse_O3_CY3 ;  
            ObjQCF.Salary_Wages_Spouse_O3_CY2__c = ObjWrapperData.Salary_Wages_Spouse_O3_CY2 ;  
            ObjQCF.Salary_Wages_Spouse_O3_CY1__c = ObjWrapperData.Salary_Wages_Spouse_O3_CY1 ;  
            ObjQCF.Salary_Wages_Spouse_O2_CY__c = ObjWrapperData.Salary_Wages_Spouse_O2_CY ;  
            ObjQCF.Salary_Wages_Spouse_O2_CY3__c = ObjWrapperData.Salary_Wages_Spouse_O2_CY3 ;  
            ObjQCF.Salary_Wages_Spouse_O2_CY2__c = ObjWrapperData.Salary_Wages_Spouse_O2_CY2 ;  
            ObjQCF.Salary_Wages_Spouse_O2_CY1__c = ObjWrapperData.Salary_Wages_Spouse_O2_CY1 ;  
            ObjQCF.Salary_Wages_Spouse_O1_CY__c = ObjWrapperData.Salary_Wages_Spouse_O1_CY ;  
            ObjQCF.Salary_Wages_Spouse_O1_CY3__c = ObjWrapperData.Salary_Wages_Spouse_O1_CY3 ;  
            ObjQCF.Salary_Wages_Spouse_O1_CY2__c = ObjWrapperData.Salary_Wages_Spouse_O1_CY2 ;  
            ObjQCF.Salary_Wages_Spouse_O1_CY1__c = ObjWrapperData.Salary_Wages_Spouse_O1_CY1 ;  
            ObjQCF.Salary_Wages_Borrower_O5_CY__c = ObjWrapperData.Salary_Wages_Borrower_O5_CY ;  
            ObjQCF.Salary_Wages_Borrower_O5_CY3__c = ObjWrapperData.Salary_Wages_Borrower_O5_CY3 ;  
            ObjQCF.Salary_Wages_Borrower_O5_CY2__c = ObjWrapperData.Salary_Wages_Borrower_O5_CY2 ;  
            ObjQCF.Salary_Wages_Borrower_O5_CY1__c = ObjWrapperData.Salary_Wages_Borrower_O5_CY1 ;  
            ObjQCF.Salary_Wages_Borrower_O4_CY__c = ObjWrapperData.Salary_Wages_Borrower_O4_CY ;  
            ObjQCF.Salary_Wages_Borrower_O4_CY3__c = ObjWrapperData.Salary_Wages_Borrower_O4_CY3 ;  
            ObjQCF.Salary_Wages_Borrower_O4_CY2__c = ObjWrapperData.Salary_Wages_Borrower_O4_CY2 ;  
            ObjQCF.Salary_Wages_Borrower_O4_CY1__c = ObjWrapperData.Salary_Wages_Borrower_O4_CY1 ;  
            ObjQCF.Salary_Wages_Borrower_O3_CY__c = ObjWrapperData.Salary_Wages_Borrower_O3_CY ;  
            ObjQCF.Salary_Wages_Borrower_O3_CY3__c = ObjWrapperData.Salary_Wages_Borrower_O3_CY3 ;  
            ObjQCF.Salary_Wages_Borrower_O3_CY2__c = ObjWrapperData.Salary_Wages_Borrower_O3_CY2 ;  
            ObjQCF.Salary_Wages_Borrower_O3_CY1__c = ObjWrapperData.Salary_Wages_Borrower_O3_CY1 ;  
            ObjQCF.Salary_Wages_Borrower_O2_CY__c = ObjWrapperData.Salary_Wages_Borrower_O2_CY ;  
            ObjQCF.Salary_Wages_Borrower_O2_CY3__c = ObjWrapperData.Salary_Wages_Borrower_O2_CY3 ;  
            ObjQCF.Salary_Wages_Borrower_O2_CY2__c = ObjWrapperData.Salary_Wages_Borrower_O2_CY2 ;  
            ObjQCF.Salary_Wages_Borrower_O2_CY1__c = ObjWrapperData.Salary_Wages_Borrower_O2_CY1 ;  
            ObjQCF.Salary_Wages_Borrower_O1_CY__c = ObjWrapperData.Salary_Wages_Borrower_O1_CY ;  
            ObjQCF.Salary_Wages_Borrower_O1_CY3__c = ObjWrapperData.Salary_Wages_Borrower_O1_CY3 ;  
            ObjQCF.Salary_Wages_Borrower_O1_CY2__c = ObjWrapperData.Salary_Wages_Borrower_O1_CY2 ;  
            ObjQCF.Salary_Wages_Borrower_O1_CY1__c = ObjWrapperData.Salary_Wages_Borrower_O1_CY1 ;  
            ObjQCF.Proposed_P_I_CY__c = ObjWrapperData.Proposed_P_I_CY ;  
            ObjQCF.Proposed_P_I_CY3__c = ObjWrapperData.Proposed_P_I_CY3 ;  
            ObjQCF.Proposed_P_I_CY2__c = ObjWrapperData.Proposed_P_I_CY2 ;  
            ObjQCF.Proposed_P_I_CY1__c = ObjWrapperData.Proposed_P_I_CY1 ;  
            ObjQCF.Projected_Weekly_Payment__c = ObjWrapperData.Projected_Weekly_Payment ;  
            ObjQCF.Projected_SemiMonthly_Payment__c = ObjWrapperData.Projected_SemiMonthly_Payment ;  
            ObjQCF.Projected_Monthly_Payment__c = ObjWrapperData.Projected_Monthly_Payment ;  
            ObjQCF.Projected_Daily_Payment__c = ObjWrapperData.Projected_Daily_Payment ;  
            ObjQCF.Projected_BiWeekly_Payment__c = ObjWrapperData.Projected_BiWeekly_Payment ;  
            ObjQCF.Projected_Annual_Payment__c = ObjWrapperData.Projected_Annual_Payment ;  
            ObjQCF.PensionIRA_Distributions_O5_CY__c = ObjWrapperData.PensionIRA_Distributions_O5_CY ;  
            ObjQCF.PensionIRA_Distributions_O5_CY3__c = ObjWrapperData.PensionIRA_Distributions_O5_CY3 ;  
            ObjQCF.PensionIRA_Distributions_O5_CY2__c = ObjWrapperData.PensionIRA_Distributions_O5_CY2 ;  
            ObjQCF.PensionIRA_Distributions_O5_CY1__c = ObjWrapperData.PensionIRA_Distributions_O5_CY1 ;  
            ObjQCF.PensionIRA_Distributions_O4_CY__c = ObjWrapperData.PensionIRA_Distributions_O4_CY ;  
            ObjQCF.PensionIRA_Distributions_O4_CY3__c = ObjWrapperData.PensionIRA_Distributions_O4_CY3 ;  
            ObjQCF.PensionIRA_Distributions_O4_CY2__c = ObjWrapperData.PensionIRA_Distributions_O4_CY2 ;  
            ObjQCF.PensionIRA_Distributions_O4_CY1__c = ObjWrapperData.PensionIRA_Distributions_O4_CY1 ;  
            ObjQCF.PensionIRA_Distributions_O3_CY__c = ObjWrapperData.PensionIRA_Distributions_O3_CY ;  
            ObjQCF.PensionIRA_Distributions_O3_CY3__c = ObjWrapperData.PensionIRA_Distributions_O3_CY3 ;  
            ObjQCF.PensionIRA_Distributions_O3_CY2__c = ObjWrapperData.PensionIRA_Distributions_O3_CY2 ;  
            ObjQCF.PensionIRA_Distributions_O3_CY1__c = ObjWrapperData.PensionIRA_Distributions_O3_CY1 ;  
            ObjQCF.PensionIRA_Distributions_O2_CY__c = ObjWrapperData.PensionIRA_Distributions_O2_CY ;  
            ObjQCF.PensionIRA_Distributions_O2_CY3__c = ObjWrapperData.PensionIRA_Distributions_O2_CY3 ;  
            ObjQCF.PensionIRA_Distributions_O2_CY2__c = ObjWrapperData.PensionIRA_Distributions_O2_CY2 ;  
            ObjQCF.PensionIRA_Distributions_O2_CY1__c = ObjWrapperData.PensionIRA_Distributions_O2_CY1 ;  
            ObjQCF.PensionIRA_Distributions_O1_CY__c = ObjWrapperData.PensionIRA_Distributions_O1_CY ;  
            ObjQCF.PensionIRA_Distributions_O1_CY3__c = ObjWrapperData.PensionIRA_Distributions_O1_CY3 ;  
            ObjQCF.PensionIRA_Distributions_O1_CY2__c = ObjWrapperData.PensionIRA_Distributions_O1_CY2 ;  
            ObjQCF.PensionIRA_Distributions_O1_CY1__c = ObjWrapperData.PensionIRA_Distributions_O1_CY1 ;  
            ObjQCF.Owner_4_Personal_Disc_SD_CY__c = ObjWrapperData.Owner_4_Personal_Disc_SD_CY ;  
            ObjQCF.Owner_4_Personal_Disc_SD_CY3__c = ObjWrapperData.Owner_4_Personal_Disc_SD_CY3 ;  
            ObjQCF.Owner_4_Personal_Disc_SD_CY2__c = ObjWrapperData.Owner_4_Personal_Disc_SD_CY2 ;  
            ObjQCF.Owner_4_Personal_Disc_SD_CY1__c = ObjWrapperData.Owner_4_Personal_Disc_SD_CY1 ;  
            ObjQCF.Owner_3_Personal_Disc_SD_CY__c = ObjWrapperData.Owner_3_Personal_Disc_SD_CY ;  
            ObjQCF.Owner_3_Personal_Disc_SD_CY3__c = ObjWrapperData.Owner_3_Personal_Disc_SD_CY3 ;  
            ObjQCF.Owner_3_Personal_Disc_SD_CY2__c = ObjWrapperData.Owner_3_Personal_Disc_SD_CY2 ;  
            ObjQCF.Owner_3_Personal_Disc_SD_CY1__c = ObjWrapperData.Owner_3_Personal_Disc_SD_CY1 ;  
            ObjQCF.Owner_2_Personal_Disc_SD_CY__c = ObjWrapperData.Owner_2_Personal_Disc_SD_CY ;  
            ObjQCF.Owner_2_Personal_Disc_SD_CY3__c = ObjWrapperData.Owner_2_Personal_Disc_SD_CY3 ;  
            ObjQCF.Owner_2_Personal_Disc_SD_CY2__c = ObjWrapperData.Owner_2_Personal_Disc_SD_CY2 ;  
            ObjQCF.Owner_2_Personal_Disc_SD_CY1__c = ObjWrapperData.Owner_2_Personal_Disc_SD_CY1 ;  
            ObjQCF.Owner_1_Personal_Disc_SD_CY__c = ObjWrapperData.Owner_1_Personal_Disc_SD_CY ;  
            ObjQCF.Owner_1_Personal_Disc_SD_CY3__c = ObjWrapperData.Owner_1_Personal_Disc_SD_CY3 ;  
            ObjQCF.Owner_1_Personal_Disc_SD_CY2__c = ObjWrapperData.Owner_1_Personal_Disc_SD_CY2 ;  
            ObjQCF.Owner_1_Personal_Disc_SD_CY1__c = ObjWrapperData.Owner_1_Personal_Disc_SD_CY1 ;  
            
            ObjQCF.Other_Income_O5_CY__c = ObjWrapperData.Other_Income_O5_CY ;  
            ObjQCF.Other_Income_O5_CY3__c = ObjWrapperData.Other_Income_O5_CY3 ;  
            ObjQCF.Other_Income_O5_CY2__c = ObjWrapperData.Other_Income_O5_CY2 ;  
            ObjQCF.Other_Income_O5_CY1__c = ObjWrapperData.Other_Income_O5_CY1 ;  
            ObjQCF.Other_Income_O4_CY__c = ObjWrapperData.Other_Income_O4_CY ;  
            ObjQCF.Other_Income_O4_CY3__c = ObjWrapperData.Other_Income_O4_CY3 ;  
            ObjQCF.Other_Income_O4_CY2__c = ObjWrapperData.Other_Income_O4_CY2 ;  
            ObjQCF.Other_Income_O4_CY1__c = ObjWrapperData.Other_Income_O4_CY1 ; 
            ObjQCF.Other_Income_O3_CY2__c = ObjWrapperData.Other_Income_O3_CY2;
            ObjQCF.Other_Income_O3_CY__c = ObjWrapperData.Other_Income_O3_CY ;  
            ObjQCF.Other_Income_O3_CY3__c = ObjWrapperData.Other_Income_O3_CY3 ;  
            ObjQCF.Other_Income_O3_CY1__c = ObjWrapperData.Other_Income_O3_CY1 ;  
            ObjQCF.Other_Income_O2_CY__c = ObjWrapperData.Other_Income_O2_CY ;  
            ObjQCF.Other_Income_O2_CY3__c = ObjWrapperData.Other_Income_O2_CY3 ;  
            ObjQCF.Other_Income_O2_CY2__c = ObjWrapperData.Other_Income_O2_CY2 ;  
            ObjQCF.Other_Income_O2_CY1__c = ObjWrapperData.Other_Income_O2_CY1 ;  
            ObjQCF.Other_Income_O1_CY__c = ObjWrapperData.Other_Income_O1_CY ;  
            ObjQCF.Other_Income_O1_CY3__c = ObjWrapperData.Other_Income_O1_CY3 ;  
            ObjQCF.Other_Income_O1_CY2__c = ObjWrapperData.Other_Income_O1_CY2 ;  
            ObjQCF.Other_Income_O1_CY1__c = ObjWrapperData.Other_Income_O1_CY1 ;  
            //ObjQCF.Other_Income_O1CY3__c = ObjWrapperData.Other_Income_O1CY3 ;  
            ObjQCF.Other_GuaranteedwagesaffiliatesO5CY3__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO5CY3 ;  
            ObjQCF.Other_GuaranteedwagesaffiliatesO5CY2__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO5CY2 ;  
            ObjQCF.Other_GuaranteedwagesaffiliatesO5CY1__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO5CY1 ;  
            ObjQCF.Other_GuaranteedwagesaffiliatesO4CY3__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO4CY3 ;  
            ObjQCF.Other_GuaranteedwagesaffiliatesO4CY2__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO4CY2 ;  
            ObjQCF.Other_GuaranteedwagesaffiliatesO4CY1__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO4CY1 ;  
            ObjQCF.Other_GuaranteedwagesaffiliatesO3CY3__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO3CY3 ;  
            ObjQCF.Other_GuaranteedwagesaffiliatesO3CY2__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO3CY2 ;  
            ObjQCF.Other_GuaranteedwagesaffiliatesO3CY1__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO3CY1 ;  
            ObjQCF.Other_GuaranteedwagesaffiliatesO2CY3__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO2CY3 ;  
            ObjQCF.Other_GuaranteedwagesaffiliatesO2CY2__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO2CY2 ;  
            ObjQCF.Other_GuaranteedwagesaffiliatesO2CY1__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO2CY1 ;  
            ObjQCF.Other_GuaranteedwagesaffiliatesO1CY3__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO1CY3 ;  
            ObjQCF.Other_GuaranteedwagesaffiliatesO1CY2__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO1CY2 ;  
            ObjQCF.Other_GuaranteedwagesaffiliatesO1CY1__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO1CY1 ;  
            ObjQCF.Other_Guaranteed_wages_affiliates_O5_CY__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO5CY ;  
            ObjQCF.Other_Guaranteed_wages_affiliates_O4_CY__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO4CY ;  
            ObjQCF.Other_Guaranteed_wages_affiliates_O3_CY__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO3CY ;  
            ObjQCF.Other_Guaranteed_wages_affiliates_O2_CY__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO2CY ;  
            ObjQCF.Other_Guaranteed_wages_affiliates_O1_CY__c = ObjWrapperData.Other_GuaranteedwagesaffiliatesO1CY ;  
            ObjQCF.Non_Recurring_Expenses_CY__c = ObjWrapperData.Non_Recurring_Expenses_CY ;  
            ObjQCF.Non_Recurring_Expenses_CY3__c = ObjWrapperData.Non_Recurring_Expenses_CY3 ;  
            ObjQCF.Non_Recurring_Expenses_CY2__c = ObjWrapperData.Non_Recurring_Expenses_CY2 ;  
            ObjQCF.Non_Recurring_Expenses_CY1__c = ObjWrapperData.Non_Recurring_Expenses_CY1 ;  
            ObjQCF.New_Rents_CY__c = ObjWrapperData.New_Rents_CY ;  
            ObjQCF.New_Rents_CY3__c = ObjWrapperData.New_Rents_CY3 ;  
            ObjQCF.New_Rents_CY2__c = ObjWrapperData.New_Rents_CY2 ;  
            ObjQCF.New_Rents_CY1__c = ObjWrapperData.New_Rents_CY1 ;  
            ObjQCF.Net_Profit_CY__c = ObjWrapperData.Net_Profit_CY ;  
            ObjQCF.Net_Profit_CY3__c = ObjWrapperData.Net_Profit_CY3 ;  
            ObjQCF.Net_Profit_CY2__c = ObjWrapperData.Net_Profit_CY2 ;  
            ObjQCF.Net_Profit_CY1__c = ObjWrapperData.Net_Profit_CY1 ;   
            ObjQCF.Months_CY__c = ObjWrapperData.Months_CY ;  
            ObjQCF.Months_CY3__c = ObjWrapperData.Months_CY3 ;  
            ObjQCF.Months_CY2__c = ObjWrapperData.Months_CY2 ;  
            ObjQCF.Months_CY1__c = ObjWrapperData.Months_CY1 ;  
            ObjQCF.Monthly_Existing_Installment_Debt_CY__c = ObjWrapperData.Monthly_Existing_Installment_Debt_CY ;  
            ObjQCF.Monthly_Existing_Installment_Debt_CY3__c = ObjWrapperData.Monthly_Existing_Installment_Debt_CY3 ;  
            ObjQCF.Monthly_Existing_Installment_Debt_CY2__c = ObjWrapperData.Monthly_Existing_Installment_Debt_CY2 ;  
            ObjQCF.Monthly_Existing_Installment_Debt_CY1__c = ObjWrapperData.Monthly_Existing_Installment_Debt_CY1 ;  
            
            ObjQCF.Loan_Amount_Adjusted__c = ObjWrapperData.Loan_Amount_Adjusted ;  
            ObjQCF.Loan_Amount_Actual__c = ObjWrapperData.Loan_Amount_Actual ;  
            ObjQCF.Lead__c = String.valueof(leadID) ;  
            
            
            ObjQCF.K1_Distributions_O5_CY__c = ObjWrapperData.K1_Distributions_O5_CY ;  
            ObjQCF.K1_Distributions_O5_CY3__c = ObjWrapperData.K1_Distributions_O5_CY3 ;  
            ObjQCF.K1_Distributions_O5_CY2__c = ObjWrapperData.K1_Distributions_O5_CY2 ;  
            ObjQCF.K1_Distributions_O5_CY1__c = ObjWrapperData.K1_Distributions_O5_CY1 ;  
            ObjQCF.K1_Distributions_O4_CY__c = ObjWrapperData.K1_Distributions_O4_CY ;  
            ObjQCF.K1_Distributions_O4_CY3__c = ObjWrapperData.K1_Distributions_O4_CY3 ;  
            ObjQCF.K1_Distributions_O4_CY2__c = ObjWrapperData.K1_Distributions_O4_CY2 ;  
            ObjQCF.K1_Distributions_O4_CY1__c = ObjWrapperData.K1_Distributions_O4_CY1 ;  
            ObjQCF.K1_Distributions_O3_CY__c = ObjWrapperData.K1_Distributions_O3_CY ;  
            ObjQCF.K1_Distributions_O3_CY3__c = ObjWrapperData.K1_Distributions_O3_CY3 ;  
            ObjQCF.K1_Distributions_O3_CY2__c = ObjWrapperData.K1_Distributions_O3_CY2 ;  
            ObjQCF.K1_Distributions_O3_CY1__c = ObjWrapperData.K1_Distributions_O3_CY1 ;  
            ObjQCF.K1_Distributions_O2_CY__c = ObjWrapperData.K1_Distributions_O2_CY ;  
            ObjQCF.K1_Distributions_O2_CY3__c = ObjWrapperData.K1_Distributions_O2_CY3 ;  
            ObjQCF.K1_Distributions_O2_CY2__c = ObjWrapperData.K1_Distributions_O2_CY2 ;  
            ObjQCF.K1_Distributions_O2_CY1__c = ObjWrapperData.K1_Distributions_O2_CY1 ;  
            ObjQCF.K1_Distributions_O1_CY__c = ObjWrapperData.K1_Distributions_O1_CY ;  
            ObjQCF.K1_Distributions_O1_CY3__c = ObjWrapperData.K1_Distributions_O1_CY3 ;  
            ObjQCF.K1_Distributions_O1_CY2__c = ObjWrapperData.K1_Distributions_O1_CY2 ;  
            ObjQCF.K1_Distributions_O1_CY1__c = ObjWrapperData.K1_Distributions_O1_CY1 ;  
            
            ObjQCF.Interestdividend_Income_O5_CY__c = ObjWrapperData.Interestdividend_Income_O5_CY ;  
            ObjQCF.Interestdividend_Income_O5_CY3__c = ObjWrapperData.Interestdividend_Income_O5_CY3 ;  
            ObjQCF.Interestdividend_Income_O5_CY2__c = ObjWrapperData.Interestdividend_Income_O5_CY2 ;  
            ObjQCF.Interestdividend_Income_O5_CY1__c = ObjWrapperData.Interestdividend_Income_O5_CY1 ;  
            ObjQCF.Interestdividend_Income_O4_CY__c = ObjWrapperData.Interestdividend_Income_O4_CY ;  
            ObjQCF.Interestdividend_Income_O4_CY3__c = ObjWrapperData.Interestdividend_Income_O4_CY3 ;  
            ObjQCF.Interestdividend_Income_O4_CY2__c = ObjWrapperData.Interestdividend_Income_O4_CY2 ;  
            ObjQCF.Interestdividend_Income_O4_CY1__c = ObjWrapperData.Interestdividend_Income_O4_CY1 ;  
            ObjQCF.Interestdividend_Income_O3_CY__c = ObjWrapperData.Interestdividend_Income_O3_CY ;  
            ObjQCF.Interestdividend_Income_O3_CY3__c = ObjWrapperData.Interestdividend_Income_O3_CY3 ;  
            ObjQCF.Interestdividend_Income_O3_CY2__c = ObjWrapperData.Interestdividend_Income_O3_CY2 ;  
            ObjQCF.Interestdividend_Income_O3_CY1__c = ObjWrapperData.Interestdividend_Income_O3_CY1 ;  
            ObjQCF.Interestdividend_Income_O2_CY__c = ObjWrapperData.Interestdividend_Income_O2_CY ;  
            ObjQCF.Interestdividend_Income_O2_CY3__c = ObjWrapperData.Interestdividend_Income_O2_CY3 ;  
            ObjQCF.Interestdividend_Income_O2_CY2__c = ObjWrapperData.Interestdividend_Income_O2_CY2 ;  
            ObjQCF.Interestdividend_Income_O2_CY1__c = ObjWrapperData.Interestdividend_Income_O2_CY1 ;  
            ObjQCF.Interestdividend_Income_O1_CY__c = ObjWrapperData.Interestdividend_Income_O1_CY ;  
            ObjQCF.Interestdividend_Income_CY3__c = ObjWrapperData.Interestdividend_Income_O1_CY3 ;  
            ObjQCF.Interestdividend_Income_CY2__c = ObjWrapperData.Interestdividend_Income_O1_CY2 ;  
            ObjQCF.Interestdividend_Income_CY1__c = ObjWrapperData.Interestdividend_Income_O1_CY1 ;  
            
            ObjQCF.Interest_Rate_Adjusted__c = ObjWrapperData.Interest_Rate_Adjusted ;  
            ObjQCF.Interest_Rate_Actual__c = ObjWrapperData.Interest_Rate_Actual ;  
            ObjQCF.Interest_Exp_CY__c = ObjWrapperData.Interest_Exp_CY ;  
            ObjQCF.Interest_Exp_CY3__c = ObjWrapperData.Interest_Exp_CY3 ;  
            ObjQCF.Interest_Exp_CY2__c = ObjWrapperData.Interest_Exp_CY2 ;  
            ObjQCF.Interest_Exp_CY1__c = ObjWrapperData.Interest_Exp_CY1 ; 
            
            ObjQCF.Industry_High_Risk__c = Boolean.valueof(ObjWrapperData.Industry_High_Risk) ;  
            
            ObjQCF.Highest_Credit_Score__c = ObjWrapperData.Highest_Credit_Score ;  
            ObjQCF.Global_Coverage_Ratio_CY__c = ObjWrapperData.Global_Coverage_Ratio_CY ;  
            ObjQCF.Global_Coverage_Ratio_CY3__c = ObjWrapperData.Global_Coverage_Ratio_CY3 ;  
            ObjQCF.Global_Coverage_Ratio_CY2__c = ObjWrapperData.Global_Coverage_Ratio_CY2 ;  
            ObjQCF.Global_Coverage_Ratio_CY1__c = ObjWrapperData.Global_Coverage_Ratio_CY1 ;  
            ObjQCF.Estimated_CCR__c = ObjWrapperData.Estimated_CCR ;  
             
            ObjQCF.DueIn_Months_Adjusted__c = ObjWrapperData.DueIn_Months_Adjusted ;  
            ObjQCF.DueIn_Months_Actual__c = ObjWrapperData.DueIn_Months_Actual ;  
            ObjQCF.Discretionary_Coverage_Ratio_CY__c = ObjWrapperData.Discretionary_Coverage_Ratio_CY ;  
            ObjQCF.Discretionary_Coverage_Ratio_CY3__c = ObjWrapperData.Discretionary_Coverage_Ratio_CY3 ;  
            ObjQCF.Discretionary_Coverage_Ratio_CY2__c = ObjWrapperData.Discretionary_Coverage_Ratio_CY2 ;  
            ObjQCF.Discretionary_Coverage_Ratio_CY1__c = ObjWrapperData.Discretionary_Coverage_Ratio_CY1 ;  
            
            ObjQCF.Business_Coverage_Ratio_CY__c = ObjWrapperData.Business_Coverage_Ratio_CY ;  
            ObjQCF.Business_Coverage_Ratio_CY3__c = ObjWrapperData.Business_Coverage_Ratio_CY3 ;  
            ObjQCF.Business_Coverage_Ratio_CY2__c = ObjWrapperData.Business_Coverage_Ratio_CY2 ;  
            ObjQCF.Business_Coverage_Ratio_CY1__c = ObjWrapperData.Business_Coverage_Ratio_CY1 ;  
            ObjQCF.Annual_Existing_P_I_CY__c = ObjWrapperData.Annual_Existing_P_I_CY ;  
            ObjQCF.Annual_Existing_P_I_CY3__c = ObjWrapperData.Annual_Existing_P_I_CY3 ;  
            ObjQCF.Annual_Existing_P_I_CY2__c = ObjWrapperData.Annual_Existing_P_I_CY2 ;  
            ObjQCF.Annual_Existing_P_I_CY1__c = ObjWrapperData.Annual_Existing_P_I_CY1 ;  
            ObjQCF.Affilliate_Income_CY__c = ObjWrapperData.Affilliate_Income_CY ;  
            ObjQCF.Affilliate_Income_CY3__c = ObjWrapperData.Affilliate_Income_CY3 ;  
            ObjQCF.Affilliate_Income_CY2__c = ObjWrapperData.Affilliate_Income_CY2 ;  
            ObjQCF.Affilliate_Income_CY1__c = ObjWrapperData.Affilliate_Income_CY1 ;
            
        }
        
        system.debug('objQCF- before---->> '+objQCF);
        upsert objQCF;
        upsert objLeadData;
        }
        return ObjWrapperData;
    }
    
    @AuraEnabled
    public static mainWrapper runQuickCashFlow( mainWrapper mainWrapperData, string leadID) {
        String PortalBaseURL;
        mainWrapper objMainWrapper = new mainWrapper();
        objMainWrapper= mainWrapperData;
        list<Quick_Cash_Flow__c> lstQuick_Cash_Flow = new list<Quick_Cash_Flow__c>();
        WrapperQCFJavaJSON objWrapper = new WrapperQCFJavaJSON(); 
        JSON2ApexQCF QCFResponse = new JSON2ApexQCF();
        
        Integer CY = Date.Today().Year();
        Integer CY_1 = (CY-1);
        Integer CY_2 = (CY-2);
        Integer CY_3 = (CY-3);
        
        list<JSON2ApexQCF.personal>  ListOfpersonalOwnerOne = new list<JSON2ApexQCF.personal>();
        list<JSON2ApexQCF.personal>  ListOfpersonalOwnerTwo = new list<JSON2ApexQCF.personal>();
        list<JSON2ApexQCF.personal>  ListOfpersonalOwnerThree = new list<JSON2ApexQCF.personal>();
        list<JSON2ApexQCF.personal>  ListOfpersonalOwnerFour = new list<JSON2ApexQCF.personal>();
        list<JSON2ApexQCF.personal>  ListOfpersonalOwnerFive = new list<JSON2ApexQCF.personal>();
        
        system.debug('--------Apex------mainWrapperData-------->>'+mainWrapperData);
        //string leadID = '00Qq000000AXoZvEAL';
        list<Portal_Integration_Response_Code__c > lstOfExceptions = new list< Portal_Integration_Response_Code__c >();
        list<QuickCashFlowDetailsDtos> lstQuickCashFlowDetailsDtos = new list<QuickCashFlowDetailsDtos>();
        list<personalOwnerAnalysis> lstOfOwnerOne = new list<personalOwnerAnalysis>();
        list<personalOwnerAnalysis> lstOfOwnerTwo = new list<personalOwnerAnalysis>();
        list<personalOwnerAnalysis> lstOfOwnerThree = new list<personalOwnerAnalysis>();
        list<personalOwnerAnalysis> lstOfOwnerFour = new list<personalOwnerAnalysis>();
        list<personalOwnerAnalysis> lstOfOwnerFive = new list<personalOwnerAnalysis>();
        map<string,list< personalOwnerAnalysis>> objOwnerMap = new map<string,list< personalOwnerAnalysis>>();
        list<personalOwnerAnalysis> lstOfpersonalOwnerAnalysis = new list<personalOwnerAnalysis>();
        system.debug('leadID---->>'+leadID);
        lead objlead =[select id, name, PortalAPIEndPoint__c,Loan_Type__c,BusinessId__c,SSN1__c,SSN2__c,SSN_3rd_Owner__c, SSN_4th_Owner__c,Requested_Amount__c,SSN_5th_Owner__c, Business_Start_Date__c from lead where id=:leadID];
        lstQuick_Cash_Flow = [SELECT Id, Total_Estimated_Personal_O5_CY3__c, Total_Estimated_Personal_O5_CY2__c, Total_Estimated_Personal_O5_CY1__c, Total_Estimated_Personal_O5_CY__c, Total_Estimated_Personal_O4_CY3__c, Total_Estimated_Personal_O4_CY2__c, Total_Estimated_Personal_O4_CY1__c, Total_Estimated_Personal_O4_CY__c, Total_Estimated_Personal_O3_CY3__c, Total_Estimated_Personal_O3_CY2__c, Total_Estimated_Personal_O3_CY1__c, Total_Estimated_Personal_O3_CY__c,Total_Estimated_Personal_O2_CY3__c, Total_Estimated_Personal_O2_CY2__c, Total_Estimated_Personal_O2_CY1__c, Total_Estimated_Personal_O2_CY__c,  Total_Estimated_Personal_O1_CY3__c, Total_Estimated_Personal_O1_CY2__c, Total_Estimated_Personal_O1_CY1__c, Total_Estimated_Personal_O1_CY__c,  OwnerId,Residence_Mortgage_Owner_1__c, Residence_Mortgage_Owner_2__c, Residence_Mortgage_Owner_3__c, Residence_Mortgage_Owner_4__c, Residence_Mortgage_Owner_5__c, Rental_Payment_Owner_1__c, Rental_Payment_Owner_2__c, Rental_Payment_Owner_3__c, Rental_Payment_Owner_4__c, Rental_Payment_Owner_5__c, HELOC_Owner_1__c , HELOC_Owner_2__c  , HELOC_Owner_3__c  , HELOC_Owner_4__c  , HELOC_Owner_5__c  , Installment_Debt_Owner_1__c, Installment_Debt_Owner_2__c  , Installment_Debt_Owner_3__c   , Installment_Debt_Owner_4__c   , Installment_Debt_Owner_5__c   , Credit_Card_Debt_Owner_1__c, Credit_Card_Debt_Owner_2__c, Credit_Card_Debt_Owner_3__c, Credit_Card_Debt_Owner_4__c, Credit_Card_Debt_Owner_5__c, Other_debt_Owner_1__c, Other_debt_Owner_2__c, Other_debt_Owner_3__c, Other_debt_Owner_4__c, Other_debt_Owner_5__c, Total_Annual_Debt_Service_Owner_1__c, Total_Annual_Debt_Service_Owner_2__c, Total_Annual_Debt_Service_Owner_3__c, Total_Annual_Debt_Service_Owner_4__c, Total_Annual_Debt_Service_Owner_5__c,  IsDeleted, Name, CreatedDate,  CreatedById, Test__c, Months_CY1__c, Months_CY__c, Months_CY2__c, Months_CY3__c, Sales_CY__c, Sales_CY1__c, Sales_CY2__c, Sales_CY3__c, Net_Profit_CY__c, Net_Profit_CY1__c, Net_Profit_CY2__c, Net_Profit_CY3__c, New_Rents_CY__c, New_Rents_CY1__c, New_Rents_CY2__c, New_Rents_CY3__c, Interest_Exp_CY__c, Interest_Exp_CY1__c, Interest_Exp_CY2__c, Interest_Exp_CY3__c, Non_Recurring_Expenses_CY__c, Non_Recurring_Expenses_CY1__c, Non_Recurring_Expenses_CY2__c, Non_Recurring_Expenses_CY3__c, Affilliate_Income_CY__c, Affilliate_Income_CY1__c, Affilliate_Income_CY2__c, Affilliate_Income_CY3__c, Owner_1_Personal_Disc_SD_CY1__c, Owner_1_Personal_Disc_SD_CY2__c, Owner_1_Personal_Disc_SD_CY__c, Owner_1_Personal_Disc_SD_CY3__c, Owner_2_Personal_Disc_SD_CY__c, Owner_2_Personal_Disc_SD_CY1__c, Owner_2_Personal_Disc_SD_CY2__c, Owner_2_Personal_Disc_SD_CY3__c, Owner_3_Personal_Disc_SD_CY__c, Owner_3_Personal_Disc_SD_CY1__c, Owner_3_Personal_Disc_SD_CY2__c, Owner_3_Personal_Disc_SD_CY3__c, Owner_4_Personal_Disc_SD_CY__c, Owner_4_Personal_Disc_SD_CY1__c, Owner_4_Personal_Disc_SD_CY2__c, Owner_4_Personal_Disc_SD_CY3__c, Total_First_CY__c, Total_First_CY1__c, Total_First_CY2__c, Monthly_Existing_Installment_Debt_CY__c, Total_First_CY3__c, Monthly_Existing_Installment_Debt_CY1__c, Monthly_Existing_Installment_Debt_CY2__c, Monthly_Existing_Installment_Debt_CY3__c, Annual_Existing_P_I_CY__c, Annual_Existing_P_I_CY1__c, Annual_Existing_P_I_CY2__c, Annual_Existing_P_I_CY3__c, Proposed_P_I_CY__c, Proposed_P_I_CY1__c, Proposed_P_I_CY2__c, Proposed_P_I_CY3__c, Total_Second_CY__c, Total_Second_CY2__c, Total_Second_CY1__c, Total_Second_CY3__c, Global_Coverage_Ratio_CY__c, Global_Coverage_Ratio_CY1__c, Global_Coverage_Ratio_CY2__c, Global_Coverage_Ratio_CY3__c, Business_Coverage_Ratio_CY__c, Business_Coverage_Ratio_CY1__c, Business_Coverage_Ratio_CY2__c, Business_Coverage_Ratio_CY3__c, Discretionary_Coverage_Ratio_CY__c, Discretionary_Coverage_Ratio_CY1__c, Discretionary_Coverage_Ratio_CY2__c, Discretionary_Coverage_Ratio_CY3__c, Highest_Credit_Score__c, Time_in_Business_Months__c, Estimated_CCR__c, Industry_High_Risk__c, Loan_Amount_Actual__c, Loan_Amount_Adjusted__c,  Interest_Rate_Actual__c, Interest_Rate_Adjusted__c,  Term_Months_Actual__c, Term_Months_Adjusted__c,  DueIn_Months_Actual__c, DueIn_Months_Adjusted__c,  Projected_Daily_Payment__c, Projected_Monthly_Payment__c, Projected_Weekly_Payment__c, Projected_Annual_Payment__c, Projected_BiWeekly_Payment__c, Projected_SemiMonthly_Payment__c, Interestdividend_Income_O1_CY__c, Interestdividend_Income_O2_CY__c, Interestdividend_Income_O3_CY__c, Interestdividend_Income_O4_CY__c, Interestdividend_Income_O5_CY__c, Interestdividend_Income_CY1__c, Interestdividend_Income_O2_CY1__c, Interestdividend_Income_O3_CY1__c, Interestdividend_Income_O4_CY1__c, Interestdividend_Income_O5_CY1__c, Interestdividend_Income_CY2__c, Interestdividend_Income_O2_CY2__c, Interestdividend_Income_O3_CY2__c, Interestdividend_Income_O4_CY2__c, Interestdividend_Income_O5_CY2__c, Interestdividend_Income_CY3__c, Interestdividend_Income_O2_CY3__c, Interestdividend_Income_O3_CY3__c, Interestdividend_Income_O4_CY3__c, Interestdividend_Income_O5_CY3__c, K1_Distributions_O1_CY__c, K1_Distributions_O2_CY__c, K1_Distributions_O3_CY__c, K1_Distributions_O4_CY__c, K1_Distributions_O5_CY__c, K1_Distributions_O1_CY1__c, K1_Distributions_O2_CY1__c, K1_Distributions_O3_CY1__c, K1_Distributions_O4_CY1__c, K1_Distributions_O5_CY1__c, K1_Distributions_O1_CY2__c, K1_Distributions_O2_CY2__c, K1_Distributions_O3_CY2__c, K1_Distributions_O4_CY2__c, K1_Distributions_O5_CY2__c, K1_Distributions_O1_CY3__c, K1_Distributions_O2_CY3__c, K1_Distributions_O3_CY3__c, K1_Distributions_O4_CY3__c, K1_Distributions_O5_CY3__c, Other_Guaranteed_wages_affiliates_O1_CY__c, Other_Guaranteed_wages_affiliates_O2_CY__c, Other_Guaranteed_wages_affiliates_O3_CY__c, Other_Guaranteed_wages_affiliates_O4_CY__c, Other_Guaranteed_wages_affiliates_O5_CY__c, Other_Income_O1_CY__c, Other_Income_O2_CY__c, Other_Income_O3_CY__c, Other_Income_O4_CY__c, Other_Income_O5_CY__c, Other_Income_O1_CY1__c, Other_Income_O2_CY1__c, Other_Income_O3_CY1__c, Other_Income_O4_CY1__c, Other_Income_O5_CY1__c, Other_Income_O1_CY2__c, Other_Income_O2_CY2__c, Other_Income_O1_CY3__c, Other_Income_O4_CY2__c, Other_Income_O5_CY2__c, Other_Income_O3_CY3__c, Other_Income_O4_CY3__c, Other_Income_O5_CY3__c, PensionIRA_Distributions_O1_CY__c, PensionIRA_Distributions_O2_CY__c, PensionIRA_Distributions_O3_CY__c, PensionIRA_Distributions_O4_CY__c, PensionIRA_Distributions_O5_CY__c, PensionIRA_Distributions_O1_CY1__c, PensionIRA_Distributions_O2_CY1__c, PensionIRA_Distributions_O3_CY1__c, PensionIRA_Distributions_O4_CY1__c, PensionIRA_Distributions_O5_CY1__c, PensionIRA_Distributions_O1_CY2__c, PensionIRA_Distributions_O2_CY2__c, PensionIRA_Distributions_O3_CY2__c, PensionIRA_Distributions_O4_CY2__c, PensionIRA_Distributions_O5_CY2__c, PensionIRA_Distributions_O1_CY3__c, PensionIRA_Distributions_O2_CY3__c, PensionIRA_Distributions_O3_CY3__c, PensionIRA_Distributions_O4_CY3__c, PensionIRA_Distributions_O5_CY3__c, Salary_Wages_Borrower_O1_CY__c, Salary_Wages_Borrower_O2_CY__c, Salary_Wages_Borrower_O3_CY__c, Salary_Wages_Borrower_O4_CY__c, Salary_Wages_Borrower_O5_CY__c, Salary_Wages_Borrower_O2_CY1__c, Salary_Wages_Borrower_O3_CY1__c, Salary_Wages_Borrower_O1_CY1__c, Salary_Wages_Borrower_O4_CY1__c, Salary_Wages_Borrower_O5_CY1__c, Salary_Wages_Borrower_O1_CY2__c, Salary_Wages_Borrower_O2_CY2__c, Salary_Wages_Borrower_O3_CY2__c, Salary_Wages_Borrower_O4_CY2__c, Salary_Wages_Borrower_O5_CY2__c, Salary_Wages_Borrower_O1_CY3__c, Salary_Wages_Borrower_O2_CY3__c, Salary_Wages_Borrower_O3_CY3__c, Salary_Wages_Borrower_O4_CY3__c, Salary_Wages_Borrower_O5_CY3__c, Salary_Wages_Spouse_O1_CY__c, Salary_Wages_Spouse_O2_CY__c, Salary_Wages_Spouse_O3_CY__c, Salary_Wages_Spouse_O4_CY__c, Salary_Wages_Spouse_O5_CY__c, Salary_Wages_Spouse_O1_CY1__c, Salary_Wages_Spouse_O2_CY1__c, Salary_Wages_Spouse_O3_CY1__c, Salary_Wages_Spouse_O4_CY1__c, Salary_Wages_Spouse_O5_CY1__c, Salary_Wages_Spouse_O1_CY2__c, Salary_Wages_Spouse_O2_CY2__c, Salary_Wages_Spouse_O3_CY2__c, Salary_Wages_Spouse_O4_CY2__c, Salary_Wages_Spouse_O5_CY2__c, Salary_Wages_Spouse_O1_CY3__c, Salary_Wages_Spouse_O2_CY3__c, Salary_Wages_Spouse_O3_CY3__c, Salary_Wages_Spouse_O4_CY3__c, Salary_Wages_Spouse_O5_CY3__c, Sch_D_Capital_gainslosses_O1_CY__c, Sch_D_Capital_gainslosses_O2_CY__c, Sch_D_Capital_gainslosses_O3_CY__c, Sch_D_Capital_gainslosses_O4_CY__c, Sch_D_Capital_gainslosses_O5_CY__c, Sch_D_Capital_gainslosses_O1_CY1__c, Sch_D_Capital_gainslosses_O2_CY1__c, Sch_D_Capital_gainslosses_O3_CY1__c, Sch_D_Capital_gainslosses_O4_CY1__c, Sch_D_Capital_gainslosses_O5_CY1__c, Sch_D_Capital_gainslosses_O1_CY2__c, Sch_D_Capital_gainslosses_O2_CY2__c, Sch_D_Capital_gainslosses_O3_CY2__c, Sch_D_Capital_gainslosses_O4_CY2__c, Sch_D_Capital_gainslosses_O5_CY2__c, Sch_D_Capital_gainslosses_O1_CY3__c, Sch_D_Capital_gainslosses_O2_CY3__c, Sch_D_Capital_gainslosses_O3_CY3__c, Sch_D_Capital_gainslosses_O4_CY3__c, Schedule_C_Income_O1_CY__c, Schedule_C_Income_O2_CY__c, Sch_D_Capital_gainslosses_O5_CY3__c, Schedule_C_Income_O3_CY__c, Schedule_C_Income_O4_CY__c, Schedule_C_Income_O5_CY__c, Schedule_C_Income_O1_CY1__c, Schedule_C_Income_O2_CY1__c, Schedule_C_Income_O3_CY1__c, Schedule_C_Income_O4_CY1__c, Schedule_C_Income_O5_CY1__c, Schedule_C_Income_O1_CY2__c, Schedule_C_Income_O2_CY2__c, Schedule_C_Income_O3_CY2__c, Schedule_C_Income_O4_CY2__c, Schedule_C_Income_O5_CY2__c, Schedule_C_Income_O1_CY3__c, Schedule_C_Income_O2_CY3__c, Schedule_C_Income_O3_CY3__c, Schedule_C_Income_O4_CY3__c, Schedule_C_Income_O5_CY3__c, Schedule_E_Rental_O1_CY__c, Schedule_E_Rental_O2_CY__c, Schedule_E_Rental_O3_CY__c, Schedule_E_Rental_O4_CY__c, Schedule_E_Rental_O5_CY__c, Schedule_E_Rental_O1_CY1__c, Schedule_E_Rental_O2_CY1__c, Schedule_E_Rental_O3_CY1__c, Schedule_E_Rental_O4_CY1__c, Schedule_E_Rental_O5_CY1__c, Schedule_E_Rental_O1_CY2__c, Schedule_E_Rental_O2_CY2__c, Schedule_E_Rental_O3_CY2__c, Schedule_E_Rental_O4_CY2__c, Schedule_E_Rental_O5_CY2__c, Schedule_E_Rental_O1_CY3__c, Schedule_E_Rental_O2_CY3__c, Schedule_E_Rental_O3_CY3__c, Schedule_E_Rental_O4_CY3__c, Schedule_E_Rental_O5_CY3__c, Other_Income_O2_CY3__c, Other_Income_O1CY3__c, Other_GuaranteedwagesaffiliatesO1CY1__c, Other_GuaranteedwagesaffiliatesO2CY1__c, Other_GuaranteedwagesaffiliatesO3CY1__c, Other_GuaranteedwagesaffiliatesO4CY1__c, Other_GuaranteedwagesaffiliatesO5CY1__c, Other_GuaranteedwagesaffiliatesO1CY2__c, Other_GuaranteedwagesaffiliatesO2CY2__c, Other_GuaranteedwagesaffiliatesO3CY2__c, Other_GuaranteedwagesaffiliatesO4CY2__c, Other_GuaranteedwagesaffiliatesO5CY2__c, Other_GuaranteedwagesaffiliatesO1CY3__c, Other_GuaranteedwagesaffiliatesO2CY3__c, Other_GuaranteedwagesaffiliatesO3CY3__c, Other_GuaranteedwagesaffiliatesO4CY3__c, Other_GuaranteedwagesaffiliatesO5CY3__c, Lead__c FROM Quick_Cash_Flow__c where lead__r.id=:leadID ];
        
        if( objlead.PortalAPIEndPoint__c != null)
            PortalBaseURL = string.valueof(objlead.PortalAPIEndPoint__c);
                              
        if( mainWrapperData.loanType != null )
        {
            
            if( objlead.Business_Start_Date__c != null )
            {
                Date d = objlead.Business_Start_Date__c;
                String dt = DateTime.newInstance(d.year(),d.month(),d.day()).format('MM/dd/yyyy'); 
                objWrapper.businessStartDate = dt;
                
            }
            
            if(CY != null)
            {
                QuickCashFlowDetailsDtos objFirstYear = new QuickCashFlowDetailsDtos();
                objFirstYear.year = Integer.valueOf(CY);
                objFirstYear.months = Integer.valueOf(mainWrapperData.Months_CY);
                objFirstYear.sales = mainWrapperData.Sales_CY;
                objFirstYear.netProfit = mainWrapperData.Net_Profit_CY;
                objFirstYear.depreciationAmortizationDepletion = mainWrapperData.New_Rents_CY;
                objFirstYear.interestExpense = mainWrapperData.Interest_Exp_CY;
                objFirstYear.nonRecurringExpense = mainWrapperData.Non_Recurring_Expenses_CY;
                objFirstYear.affilliateIncome = mainWrapperData.Affilliate_Income_CY;
                objFirstYear.existingInstallmentDebtMonthly = mainWrapperData.Monthly_Existing_Installment_Debt_CY;
                lstQuickCashFlowDetailsDtos.add(objFirstYear);
                
            }
            if(CY_1 != null)
            {
                QuickCashFlowDetailsDtos objSecondYear = new QuickCashFlowDetailsDtos();
                objSecondYear.year = Integer.valueOf(CY_1);
                objSecondYear.months = Integer.valueOf(mainWrapperData.Months_CY1);
                objSecondYear.sales = mainWrapperData.Sales_CY1;
                objSecondYear.netProfit = mainWrapperData.Net_Profit_CY1;
                objSecondYear.depreciationAmortizationDepletion = mainWrapperData.New_Rents_CY1;
                objSecondYear.interestExpense = mainWrapperData.Interest_Exp_CY1;
                objSecondYear.nonRecurringExpense = mainWrapperData.Non_Recurring_Expenses_CY1;
                objSecondYear.affilliateIncome = mainWrapperData.Affilliate_Income_CY1;
                objSecondYear.existingInstallmentDebtMonthly = mainWrapperData.Monthly_Existing_Installment_Debt_CY1;
                lstQuickCashFlowDetailsDtos.add(objSecondYear);
            }
            if(CY_2 != null)
            {
                QuickCashFlowDetailsDtos objThirdYear = new QuickCashFlowDetailsDtos();
                objThirdYear.year = Integer.valueOf(CY_2);
                objThirdYear.months = Integer.valueOf(mainWrapperData.Months_CY2);
                objThirdYear.sales = mainWrapperData.Sales_CY2;
                objThirdYear.netProfit = mainWrapperData.Net_Profit_CY2;
                objThirdYear.depreciationAmortizationDepletion = mainWrapperData.New_Rents_CY2;
                objThirdYear.interestExpense = mainWrapperData.Interest_Exp_CY2;
                objThirdYear.nonRecurringExpense = mainWrapperData.Non_Recurring_Expenses_CY2;
                objThirdYear.affilliateIncome = mainWrapperData.Affilliate_Income_CY2;
                objThirdYear.existingInstallmentDebtMonthly = mainWrapperData.Monthly_Existing_Installment_Debt_CY2;
                lstQuickCashFlowDetailsDtos.add(objThirdYear);
            }
            if(CY_3 != null)
            {
                QuickCashFlowDetailsDtos objFourthYear = new QuickCashFlowDetailsDtos();
                objFourthYear.year = Integer.valueOf(CY_3);
                objFourthYear.months = Integer.valueOf(mainWrapperData.Months_CY3);
                objFourthYear.sales = mainWrapperData.Sales_CY3;
                objFourthYear.netProfit = mainWrapperData.Net_Profit_CY3;
                objFourthYear.depreciationAmortizationDepletion = mainWrapperData.New_Rents_CY3;
                objFourthYear.interestExpense = mainWrapperData.Interest_Exp_CY3;
                objFourthYear.nonRecurringExpense = mainWrapperData.Non_Recurring_Expenses_CY3;
                objFourthYear.affilliateIncome = mainWrapperData.Affilliate_Income_CY3;
                objFourthYear.existingInstallmentDebtMonthly = mainWrapperData.Monthly_Existing_Installment_Debt_CY3;
                lstQuickCashFlowDetailsDtos.add(objFourthYear);
            }
            //========================Owner One Start Block===========================================
            if(objlead.SSN1__c != null)
            {
                personalOwnerAnalysis objFirstYear = new personalOwnerAnalysis();
                objFirstYear.personalAnalysisId = null;
                objFirstYear.year =Integer.valueOf(CY);
                objFirstYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O1_CY;
                objFirstYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O1_CY;
                objFirstYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO1CY;
                objFirstYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_O1_CY;
                objFirstYear.otherIncome = mainWrapperData.Other_Income_O1_CY;
                objFirstYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O1_CY;
                objFirstYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O1_CY;
                objFirstYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O1_CY;
                objFirstYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O1_CY;
                objFirstYear.k1Distribution = mainWrapperData.K1_Distributions_O1_CY;
                objFirstYear.lessAlimonyPaid = null;
                
                objFirstYear.stateTaxes = null;
                objFirstYear.annualRent = null;
                objFirstYear.noOfAdults = mainWrapperData.Adult_Owner1;
                objFirstYear.noOfKids = mainWrapperData.Kid_Owner1;
                objFirstYear.totalAnnualDebt = mainWrapperData.Total_Annual_Debt_Service_Owner_1;
                //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objFirstYear.taxes = mainWrapperData.Taxes_O1_CY;
                objFirstYear.reTaxes = mainWrapperData.RETaxes_O1_CY;
                
                lstOfOwnerOne.add(objFirstYear);
                //objOwnerMap.put('3', lstOfpersonalOwnerAnalysis);
            }
            if(objlead.SSN1__c != null)
            {
                personalOwnerAnalysis objSecondYear = new personalOwnerAnalysis();
                objSecondYear.personalAnalysisId = null;
                objSecondYear.year =Integer.valueOf(CY_1);
                objSecondYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O1_CY1;
                objSecondYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O1_CY1;
                objSecondYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO1CY1;
                objSecondYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_o1_CY1;
                objSecondYear.otherIncome = mainWrapperData.Other_Income_O1_CY1;
                objSecondYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O1_CY1;
                objSecondYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O1_CY1;
                objSecondYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O1_CY1;
                objSecondYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O1_CY1;
                objSecondYear.k1Distribution = mainWrapperData.K1_Distributions_O1_CY1;
                objSecondYear.lessAlimonyPaid = null;
                objSecondYear.stateTaxes = null;
                objSecondYear.annualRent = null;
                objSecondYear.noOfAdults = mainWrapperData.Adult_Owner1;
                objSecondYear.noOfKids = mainWrapperData.Kid_Owner1;
                objSecondYear.totalAnnualDebt = mainWrapperData.Total_Annual_Debt_Service_Owner_1;
                 //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objSecondYear.taxes = mainWrapperData.Taxes_O1_CY1;
                objSecondYear.reTaxes = mainWrapperData.RETaxes_O1_CY1;
                
                lstOfOwnerOne.add(objSecondYear);
                //objOwnerMap.put('2', lstOfpersonalOwnerAnalysis);
            }
            if(objlead.SSN1__c != null)
            {
                personalOwnerAnalysis objthirdYear = new personalOwnerAnalysis();
                objthirdYear.personalAnalysisId = null;
                objthirdYear.year =Integer.valueOf(CY_2);
                objthirdYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O1_CY2;
                objthirdYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O1_CY2;
                objthirdYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO1CY2;
                objthirdYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_o1_CY2;
                objthirdYear.otherIncome = mainWrapperData.Other_Income_O1_CY2;
                objthirdYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O1_CY2;
                objthirdYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O1_CY2;
                objthirdYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O1_CY2;
                objthirdYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O1_CY2;
                objthirdYear.k1Distribution = mainWrapperData.K1_Distributions_O1_CY2;
                objthirdYear.lessAlimonyPaid = null;
               
                objthirdYear.stateTaxes = null;
                objthirdYear.annualRent = null;
                objthirdYear.noOfAdults = mainWrapperData.Adult_Owner1;
                objthirdYear.noOfKids = mainWrapperData.Kid_Owner1;
                objthirdYear.totalAnnualDebt = mainWrapperData.Total_Annual_Debt_Service_Owner_1;
                //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objthirdYear.taxes = mainWrapperData.Taxes_O1_CY2;
                objthirdYear.reTaxes = mainWrapperData.RETaxes_O1_CY2;
                
                lstOfOwnerOne.add(objthirdYear);
                //objOwnerMap.put('1', lstOfpersonalOwnerAnalysis);
            }
            if(objlead.SSN1__c != null)
            {
                personalOwnerAnalysis objFourthYear = new personalOwnerAnalysis();
                objFourthYear.personalAnalysisId = null;
                objFourthYear.year =Integer.valueOf(CY_3);
                objFourthYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O1_CY3;
                objFourthYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O1_CY3;
                objFourthYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO1CY3;
                objFourthYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_O1_CY3;
                objFourthYear.otherIncome = mainWrapperData.Other_Income_O1_CY3;
                objFourthYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O1_CY3;
                objFourthYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O1_CY3;
                objFourthYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O1_CY3;
                objFourthYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O1_CY3;
                objFourthYear.k1Distribution = mainWrapperData.K1_Distributions_O1_CY3;
                objFourthYear.lessAlimonyPaid = null;
                
                objFourthYear.stateTaxes = null;
                objFourthYear.annualRent = null;
                objFourthYear.noOfAdults = mainWrapperData.Adult_Owner1;
                objFourthYear.noOfKids = mainWrapperData.Kid_Owner1;
                objFourthYear.totalAnnualDebt = mainWrapperData.Total_Annual_Debt_Service_Owner_1;
                //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objFourthYear.taxes = mainWrapperData.Taxes_O1_CY3;
                objFourthYear.reTaxes = mainWrapperData.RETaxes_O1_CY3;
                
                lstOfOwnerOne.add(objFourthYear);
                objOwnerMap.put('0', lstOfOwnerOne);
            }
            //======================= Owner One End Block==============================
            
            //========================Owner Two Start Block===========================================
            if(objlead.SSN2__c != null)
            {
                personalOwnerAnalysis objFirstYear = new personalOwnerAnalysis();
                objFirstYear.personalAnalysisId = null;
                objFirstYear.year =Integer.valueOf(CY);
                objFirstYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O2_CY;
                objFirstYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O2_CY;
                objFirstYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO2CY;
                objFirstYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_O2_CY;
                objFirstYear.otherIncome = mainWrapperData.Other_Income_O2_CY;
                objFirstYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O2_CY;
                objFirstYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O2_CY;
                objFirstYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O2_CY;
                objFirstYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O2_CY;
                objFirstYear.k1Distribution = mainWrapperData.K1_Distributions_O2_CY;
                objFirstYear.lessAlimonyPaid = null;
                
                objFirstYear.stateTaxes = null;
                objFirstYear.annualRent = null;
                objFirstYear.noOfAdults = mainWrapperData.Adult_Owner2;
                objFirstYear.noOfKids = mainWrapperData.Kid_Owner2;
                objFirstYear.totalAnnualDebt = mainWrapperData.Total_Annual_Debt_Service_Owner_2;
                //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objFirstYear.taxes = mainWrapperData.Taxes_O2_CY;
                objFirstYear.reTaxes = mainWrapperData.RETaxes_O2_CY;
                lstOfOwnerTwo.add(objFirstYear);
                //objOwnerMap.put('3', lstOfpersonalOwnerAnalysis);
            }
            if(objlead.SSN2__c != null)
            {
                personalOwnerAnalysis objSecondYear = new personalOwnerAnalysis();
                objSecondYear.personalAnalysisId = null;
                objSecondYear.year =Integer.valueOf(CY_1);
                objSecondYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O2_CY1;
                objSecondYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O2_CY1;
                objSecondYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO2CY1;
                objSecondYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_O2_CY1;
                objSecondYear.otherIncome = mainWrapperData.Other_Income_O2_CY1;
                objSecondYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O2_CY1;
                objSecondYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O2_CY1;
                objSecondYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O2_CY1;
                objSecondYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O2_CY1;
                objSecondYear.k1Distribution = mainWrapperData.K1_Distributions_O2_CY1;
                objSecondYear.lessAlimonyPaid = null;
                
                objSecondYear.stateTaxes = null;
                objSecondYear.annualRent = null;
                objSecondYear.noOfAdults = mainWrapperData.Adult_Owner2;
                objSecondYear.noOfKids = mainWrapperData.Kid_Owner2;
                objSecondYear.totalAnnualDebt = mainWrapperData.Total_Annual_Debt_Service_Owner_2;
                //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objSecondYear.taxes = mainWrapperData.Taxes_O2_CY1;
                objSecondYear.reTaxes = mainWrapperData.RETaxes_O2_CY1;
                lstOfOwnerTwo.add(objSecondYear);
                //objOwnerMap.put('2', lstOfpersonalOwnerAnalysis);
            }
            if(objlead.SSN2__c != null)
            {
                personalOwnerAnalysis objthirdYear = new personalOwnerAnalysis();
                objthirdYear.personalAnalysisId = null;
                objthirdYear.year =Integer.valueOf(CY_2);
                objthirdYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O2_CY2;
                objthirdYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O2_CY2;
                objthirdYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO2CY2;
                objthirdYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_O2_CY2;
                objthirdYear.otherIncome = mainWrapperData.Other_Income_O2_CY2;
                objthirdYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O2_CY2;
                objthirdYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O2_CY2;
                objthirdYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O2_CY2;
                objthirdYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O2_CY2;
                objthirdYear.k1Distribution = mainWrapperData.K1_Distributions_O2_CY2;
                objthirdYear.lessAlimonyPaid = null;
                
                objthirdYear.stateTaxes = null;
                objthirdYear.annualRent = null;
                objthirdYear.noOfAdults = mainWrapperData.Adult_Owner2;
                objthirdYear.noOfKids = mainWrapperData.Kid_Owner2;
                objthirdYear.totalAnnualDebt = mainWrapperData.Total_Annual_Debt_Service_Owner_2;
                //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objthirdYear.taxes = mainWrapperData.Taxes_O2_CY2;
                objthirdYear.reTaxes = mainWrapperData.RETaxes_O2_CY2;
                lstOfOwnerTwo.add(objthirdYear);
                //objOwnerMap.put('1', lstOfpersonalOwnerAnalysis);
            }
            if(objlead.SSN2__c != null)
            {
                personalOwnerAnalysis objFourthYear = new personalOwnerAnalysis();
                objFourthYear.personalAnalysisId = null;
                objFourthYear.year =Integer.valueOf(CY_3);
                objFourthYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O2_CY3;
                objFourthYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O2_CY3;
                objFourthYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO2CY3;
                objFourthYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_O2_CY3;
                objFourthYear.otherIncome = mainWrapperData.Other_Income_O2_CY3;
                objFourthYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O2_CY3;
                objFourthYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O2_CY3;
                objFourthYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O2_CY3;
                objFourthYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O2_CY3;
                objFourthYear.k1Distribution = mainWrapperData.K1_Distributions_O2_CY3;
                objFourthYear.lessAlimonyPaid = null;
                
                objFourthYear.stateTaxes = null;
                objFourthYear.annualRent = null;
                objFourthYear.noOfAdults = mainWrapperData.Adult_Owner2;
                objFourthYear.noOfKids = mainWrapperData.Kid_Owner2;
                objFourthYear.totalAnnualDebt = mainWrapperData.Total_Annual_Debt_Service_Owner_2;
                //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objFourthYear.taxes = mainWrapperData.Taxes_O2_CY3;
                objFourthYear.reTaxes = mainWrapperData.RETaxes_O2_CY3;
                lstOfOwnerTwo.add(objFourthYear);
                objOwnerMap.put('1', lstOfOwnerTwo);
            }
            //======================= Owner Two End Block==============================
            //========================Owner Three Start Block===========================================
            if(objlead.SSN_3rd_Owner__c != null)
            {
                personalOwnerAnalysis objFirstYear = new personalOwnerAnalysis();
                objFirstYear.personalAnalysisId = null;
                objFirstYear.year =Integer.valueOf(CY);
                objFirstYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O3_CY;
                objFirstYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O3_CY;
                objFirstYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO3CY;
                objFirstYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_O3_CY;
                objFirstYear.otherIncome = mainWrapperData.Other_Income_O3_CY;
                objFirstYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O3_CY;
                objFirstYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O3_CY;
                objFirstYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O3_CY;
                objFirstYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O3_CY;
                objFirstYear.k1Distribution = mainWrapperData.K1_Distributions_O3_CY;
                objFirstYear.lessAlimonyPaid = null;
                
                objFirstYear.stateTaxes = null;
                objFirstYear.annualRent = null;
                objFirstYear.noOfAdults = mainWrapperData.Adult_Owner3;
                objFirstYear.noOfKids = mainWrapperData.Kid_Owner3;
                objFirstYear.totalAnnualDebt = null;
                //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objFirstYear.taxes = mainWrapperData.Taxes_O3_CY;
                objFirstYear.reTaxes = mainWrapperData.RETaxes_O3_CY;
                
                lstOfOwnerThree.add(objFirstYear);
                //objOwnerMap.put('3', lstOfpersonalOwnerAnalysis);
            }
            if(objlead.SSN_3rd_Owner__c != null)
            {
                personalOwnerAnalysis objSecondYear = new personalOwnerAnalysis();
                objSecondYear.personalAnalysisId = null;
                objSecondYear.year =Integer.valueOf(CY_1);
                objSecondYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O3_CY1;
                objSecondYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O3_CY1;
                objSecondYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO3CY1;
                objSecondYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_O3_CY1;
                objSecondYear.otherIncome = mainWrapperData.Other_Income_O3_CY1;
                objSecondYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O3_CY1;
                objSecondYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O3_CY1;
                objSecondYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O3_CY1;
                objSecondYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O3_CY1;
                objSecondYear.k1Distribution = mainWrapperData.K1_Distributions_O3_CY1;
                objSecondYear.lessAlimonyPaid = null;
                
                objSecondYear.stateTaxes = null;
                objSecondYear.annualRent = null;
                objSecondYear.noOfAdults = mainWrapperData.Adult_Owner3;
                objSecondYear.noOfKids = mainWrapperData.Kid_Owner3;
                objSecondYear.totalAnnualDebt = mainWrapperData.Total_Annual_Debt_Service_Owner_3;
                //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objSecondYear.taxes = mainWrapperData.Taxes_O3_CY1;
                objSecondYear.reTaxes = mainWrapperData.RETaxes_O3_CY1;
                lstOfOwnerThree.add(objSecondYear);
                //objOwnerMap.put('2', lstOfpersonalOwnerAnalysis);
            }
            if(objlead.SSN_3rd_Owner__c != null)
            {
                personalOwnerAnalysis objthirdYear = new personalOwnerAnalysis();
                objthirdYear.personalAnalysisId = null;
                objthirdYear.year =Integer.valueOf(CY_2);
                objthirdYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O3_CY2;
                objthirdYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O3_CY2;
                objthirdYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO3CY2;
                objthirdYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_O3_CY2;
                objthirdYear.otherIncome = mainWrapperData.Other_Income_O3_CY2;
                objthirdYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O3_CY2;
                objthirdYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O3_CY2;
                objthirdYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O3_CY2;
                objthirdYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O3_CY2;
                objthirdYear.k1Distribution = mainWrapperData.K1_Distributions_O3_CY2;
                objthirdYear.lessAlimonyPaid = null;
               
                objthirdYear.stateTaxes = null;
                objthirdYear.annualRent = null;
                objthirdYear.noOfAdults = mainWrapperData.Adult_Owner3;
                objthirdYear.noOfKids = mainWrapperData.Kid_Owner3;
                objthirdYear.totalAnnualDebt = mainWrapperData.Total_Annual_Debt_Service_Owner_3;
                 //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objthirdYear.taxes = mainWrapperData.Taxes_O3_CY2;
                objthirdYear.reTaxes = mainWrapperData.RETaxes_O3_CY2;
                lstOfOwnerThree.add(objthirdYear);
                //objOwnerMap.put('1', lstOfpersonalOwnerAnalysis);
            }
            if(objlead.SSN_3rd_Owner__c != null)
            {
                personalOwnerAnalysis objFourthYear = new personalOwnerAnalysis();
                objFourthYear.personalAnalysisId = null;
                objFourthYear.year =Integer.valueOf(CY_3);
                objFourthYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O3_CY3;
                objFourthYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O3_CY3;
                objFourthYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO3CY3;
                objFourthYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_O3_CY3;
                objFourthYear.otherIncome = mainWrapperData.Other_Income_O3_CY3;
                objFourthYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O3_CY3;
                objFourthYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O3_CY3;
                objFourthYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O3_CY3;
                objFourthYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O3_CY3;
                objFourthYear.k1Distribution = mainWrapperData.K1_Distributions_O3_CY3;
                objFourthYear.lessAlimonyPaid = null;
                
                objFourthYear.stateTaxes = null;
                objFourthYear.annualRent = null;
                objFourthYear.noOfAdults = mainWrapperData.Adult_Owner3;
                objFourthYear.noOfKids = mainWrapperData.Kid_Owner3;
                objFourthYear.totalAnnualDebt = mainWrapperData.Total_Annual_Debt_Service_Owner_3;
                //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objFourthYear.taxes = mainWrapperData.Taxes_O3_CY3;
                objFourthYear.reTaxes = mainWrapperData.RETaxes_O3_CY3;
                lstOfOwnerThree.add(objFourthYear);
                objOwnerMap.put('2', lstOfOwnerThree);
            }
            //======================= Owner Three End Block==============================
            //========================Owner Four Start Block===========================================
            if(objlead.SSN_4th_Owner__c != null)
            {
                personalOwnerAnalysis objFirstYear = new personalOwnerAnalysis();
                objFirstYear.personalAnalysisId = null;
                objFirstYear.year =Integer.valueOf(CY);
                objFirstYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O4_CY;
                objFirstYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O4_CY;
                objFirstYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO4CY;
                objFirstYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_O4_CY;
                objFirstYear.otherIncome = mainWrapperData.Other_Income_O4_CY;
                objFirstYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O4_CY;
                objFirstYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O4_CY;
                objFirstYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O4_CY;
                objFirstYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O4_CY;
                objFirstYear.k1Distribution = mainWrapperData.K1_Distributions_O4_CY;
                objFirstYear.lessAlimonyPaid = null;

                objFirstYear.stateTaxes = null;
                objFirstYear.annualRent = null;
                objFirstYear.noOfAdults = mainWrapperData.Adult_Owner4;
                objFirstYear.noOfKids = mainWrapperData.Kid_Owner4;
                objFirstYear.totalAnnualDebt = mainWrapperData.Total_Annual_Debt_Service_Owner_4;
                //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objFirstYear.taxes = mainWrapperData.Taxes_O4_CY;
                objFirstYear.reTaxes = mainWrapperData.RETaxes_O4_CY;
                lstOfOwnerFour.add(objFirstYear);
                //objOwnerMap.put('3', lstOfpersonalOwnerAnalysis);
            }
            if(objlead.SSN_4th_Owner__c != null)
            {
                personalOwnerAnalysis objSecondYear = new personalOwnerAnalysis();
                objSecondYear.personalAnalysisId = null;
                objSecondYear.year =Integer.valueOf(CY_1);
                objSecondYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O4_CY1;
                objSecondYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O4_CY1;
                objSecondYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO4CY1;
                objSecondYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_O4_CY1;
                objSecondYear.otherIncome = mainWrapperData.Other_Income_O4_CY1;
                objSecondYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O4_CY1;
                objSecondYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O4_CY1;
                objSecondYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O4_CY1;
                objSecondYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O4_CY1;
                objSecondYear.k1Distribution = mainWrapperData.K1_Distributions_O4_CY1;
                objSecondYear.lessAlimonyPaid = null;
                
                objSecondYear.stateTaxes = null;
                objSecondYear.annualRent = null;
                objSecondYear.noOfAdults = mainWrapperData.Adult_Owner4;
                objSecondYear.noOfKids = mainWrapperData.Kid_Owner4;
                objSecondYear.totalAnnualDebt = mainWrapperData.Total_Annual_Debt_Service_Owner_4;
                //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objSecondYear.taxes = mainWrapperData.Taxes_O4_CY1;
                objSecondYear.reTaxes = mainWrapperData.RETaxes_O4_CY1;
                lstOfOwnerFour.add(objSecondYear);
                //objOwnerMap.put('2', lstOfpersonalOwnerAnalysis);
            }
            if(objlead.SSN_4th_Owner__c != null)
            {
                personalOwnerAnalysis objthirdYear = new personalOwnerAnalysis();
                objthirdYear.personalAnalysisId = null;
                objthirdYear.year =Integer.valueOf(CY_2);
                objthirdYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O4_CY2;
                objthirdYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O4_CY2;
                objthirdYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO4CY2;
                objthirdYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_O4_CY2;
                objthirdYear.otherIncome = mainWrapperData.Other_Income_O4_CY2;
                objthirdYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O4_CY2;
                objthirdYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O4_CY2;
                objthirdYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O4_CY2;
                objthirdYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O4_CY2;
                objthirdYear.k1Distribution = mainWrapperData.K1_Distributions_O4_CY2;
                objthirdYear.lessAlimonyPaid = null;
               
                objthirdYear.stateTaxes = null;
                objthirdYear.annualRent = null;
                objthirdYear.noOfAdults = mainWrapperData.Adult_Owner4;
                objthirdYear.noOfKids = mainWrapperData.Kid_Owner4;
                objthirdYear.totalAnnualDebt = mainWrapperData.Total_Annual_Debt_Service_Owner_4;
                //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objthirdYear.taxes = mainWrapperData.Taxes_O4_CY2;
                objthirdYear.reTaxes = mainWrapperData.RETaxes_O4_CY2;
                lstOfOwnerFour.add(objthirdYear);
                //objOwnerMap.put('1', lstOfpersonalOwnerAnalysis);
            }
            if(objlead.SSN_4th_Owner__c != null)
            {
                personalOwnerAnalysis objFourthYear = new personalOwnerAnalysis();
                objFourthYear.personalAnalysisId = null;
                objFourthYear.year =Integer.valueOf(CY_3);
                objFourthYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O4_CY3;
                objFourthYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O4_CY3;
                objFourthYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO4CY3;
                objFourthYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_O4_CY3;
                objFourthYear.otherIncome = mainWrapperData.Other_Income_O4_CY3;
                objFourthYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O4_CY3;
                objFourthYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O4_CY3;
                objFourthYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O4_CY3;
                objFourthYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O4_CY3;
                objFourthYear.k1Distribution = mainWrapperData.K1_Distributions_O4_CY3;
                objFourthYear.lessAlimonyPaid = null;
               
                objFourthYear.stateTaxes = null;
                objFourthYear.annualRent = null;
                objFourthYear.noOfAdults = mainWrapperData.Adult_Owner4;
                objFourthYear.noOfKids = mainWrapperData.Kid_Owner4;
                objFourthYear.totalAnnualDebt = mainWrapperData.Total_Annual_Debt_Service_Owner_4;
                //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objFourthYear.taxes = mainWrapperData.Taxes_O4_CY3;
                objFourthYear.reTaxes = mainWrapperData.RETaxes_O4_CY3;
                lstOfOwnerFour.add(objFourthYear);
                objOwnerMap.put('3', lstOfOwnerFour);
            }
            //======================= Owner Four End Block==============================
            //========================Owner Five Start Block===========================================
            if(objlead.SSN_5th_Owner__c != null)
            {
                personalOwnerAnalysis objFirstYear = new personalOwnerAnalysis();
                objFirstYear.personalAnalysisId = null;
                objFirstYear.year =Integer.valueOf(CY);
                objFirstYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O5_CY;
                objFirstYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O5_CY;
                objFirstYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO5CY;
                objFirstYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_O5_CY;
                objFirstYear.otherIncome = mainWrapperData.Other_Income_O5_CY;
                objFirstYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O5_CY;
                objFirstYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O5_CY;
                objFirstYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O5_CY;
                objFirstYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O5_CY;
                objFirstYear.k1Distribution = mainWrapperData.K1_Distributions_O5_CY;
                objFirstYear.lessAlimonyPaid = null;
               
                objFirstYear.stateTaxes = null;
                objFirstYear.annualRent = null;
                objFirstYear.noOfAdults = mainWrapperData.Adult_Owner5;
                objFirstYear.noOfKids = mainWrapperData.Kid_Owner5;
                objFirstYear.totalAnnualDebt = mainWrapperData.Total_Annual_Debt_Service_Owner_5;
                //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objFirstYear.taxes = mainWrapperData.Taxes_O5_CY;
                objFirstYear.reTaxes = mainWrapperData.RETaxes_O5_CY;
                lstOfOwnerFive.add(objFirstYear);
                //objOwnerMap.put('3', lstOfpersonalOwnerAnalysis);
            }
            if(objlead.SSN_5th_Owner__c != null)
            {
                personalOwnerAnalysis objSecondYear = new personalOwnerAnalysis();
                objSecondYear.personalAnalysisId = null;
                objSecondYear.year =Integer.valueOf(CY_1);
                objSecondYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O5_CY1;
                objSecondYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O5_CY1;
                objSecondYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO5CY1;
                objSecondYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_O5_CY1;
                objSecondYear.otherIncome = mainWrapperData.Other_Income_O5_CY1;
                objSecondYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O5_CY1;
                objSecondYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O5_CY1;
                objSecondYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O5_CY1;
                objSecondYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O5_CY1;
                objSecondYear.k1Distribution = mainWrapperData.K1_Distributions_O5_CY1;
                objSecondYear.lessAlimonyPaid = null;
                
                objSecondYear.stateTaxes = null;
                objSecondYear.annualRent = null;
                objSecondYear.noOfAdults = mainWrapperData.Adult_Owner5;
                objSecondYear.noOfKids = mainWrapperData.Kid_Owner5;
                objSecondYear.totalAnnualDebt = mainWrapperData.Total_Annual_Debt_Service_Owner_5;
                //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objSecondYear.taxes = mainWrapperData.Taxes_O5_CY1;
                objSecondYear.reTaxes = mainWrapperData.RETaxes_O5_CY1;
                lstOfOwnerFive.add(objSecondYear);
                //objOwnerMap.put('2', lstOfpersonalOwnerAnalysis);
            }
            if(objlead.SSN_5th_Owner__c != null)
            {
                personalOwnerAnalysis objthirdYear = new personalOwnerAnalysis();
                objthirdYear.personalAnalysisId = null;
                objthirdYear.year =Integer.valueOf(CY_2);
                objthirdYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O5_CY2;
                objthirdYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O5_CY2;
                objthirdYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO5CY2;
                objthirdYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_O5_CY2;
                objthirdYear.otherIncome = mainWrapperData.Other_Income_O5_CY2;
                objthirdYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O5_CY2;
                objthirdYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O5_CY2;
                objthirdYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O5_CY2;
                objthirdYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O5_CY2;
                objthirdYear.k1Distribution = mainWrapperData.K1_Distributions_O5_CY2;
                objthirdYear.lessAlimonyPaid = null;
               
                objthirdYear.stateTaxes = null;
                objthirdYear.annualRent = null;
                objthirdYear.noOfAdults = mainWrapperData.Adult_Owner5;
                objthirdYear.noOfKids = mainWrapperData.Kid_Owner5;
                objthirdYear.totalAnnualDebt = mainWrapperData.Total_Annual_Debt_Service_Owner_5;
                //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objthirdYear.taxes = mainWrapperData.Taxes_O5_CY2;
                objthirdYear.reTaxes = mainWrapperData.RETaxes_O5_CY2;
                lstOfOwnerFive.add(objthirdYear);
                //objOwnerMap.put('1', lstOfpersonalOwnerAnalysis);
            }
            if(objlead.SSN_5th_Owner__c != null)
            {
                personalOwnerAnalysis objFourthYear = new personalOwnerAnalysis();
                objFourthYear.personalAnalysisId = null;
                objFourthYear.year =Integer.valueOf(CY_3);
                objFourthYear.salaryWagesBorrower = mainWrapperData.Salary_Wages_Borrower_O5_CY3;
                objFourthYear.salaryWagesSpouse = mainWrapperData.Salary_Wages_Spouse_O5_CY3;
                objFourthYear.otherWagesAffillliate = mainWrapperData.Other_GuaranteedwagesaffiliatesO5CY3;
                objFourthYear.interestDividendIncome = mainWrapperData.Interestdividend_Income_O5_CY3;
                objFourthYear.otherIncome = mainWrapperData.Other_Income_O5_CY3;
                objFourthYear.pension_IRA_distribution = mainWrapperData.PensionIRA_Distributions_O5_CY3;
                objFourthYear.schDCapitalGain = mainWrapperData.Sch_D_Capital_gainslosses_O5_CY3;
                objFourthYear.scheduleCIncome = mainWrapperData.Schedule_C_Income_O5_CY3;
                objFourthYear.scheduleERental = mainWrapperData.Schedule_E_Rental_O5_CY3;
                objFourthYear.k1Distribution = mainWrapperData.K1_Distributions_O5_CY3;
                objFourthYear.lessAlimonyPaid = null;
                
                objFourthYear.stateTaxes = null;
                objFourthYear.annualRent = null;
                objFourthYear.noOfAdults = mainWrapperData.Adult_Owner5;
                objFourthYear.noOfKids = mainWrapperData.Kid_Owner5;
                objFourthYear.totalAnnualDebt = mainWrapperData.Total_Annual_Debt_Service_Owner_5;
                //============Tax, Re-Taxes, Living Expenses, Total Taxes========Block ========================
                objFourthYear.taxes = mainWrapperData.Taxes_O5_CY3;
                objFourthYear.reTaxes = mainWrapperData.RETaxes_O5_CY3;
                lstOfOwnerFive.add(objFourthYear);
                objOwnerMap.put('4', lstOfOwnerFive);
            }
            //======================= Owner Five End Block==============================
            
            objWrapper.quickCashFlowDetailsDtos = lstQuickCashFlowDetailsDtos;
            objWrapper.personalAnalysis = objOwnerMap;
            objWrapper.loanType = mainWrapperData.loanType;
            objWrapper.leadId = objlead.id;
            objWrapper.businessId = objlead.BusinessId__c;
            objWrapper.amountRequest = mainWrapperData.Loan_Amount_Actual;
            //====== commented tp test Interest ------  objWrapper.interestRateAdjusted = String.valueof(mainWrapperData.Interest_Rate_Adjusted);//'8.75';
            if( mainWrapperData.Interest_Rate_Actual != null )
            objWrapper.interestRateActual = Decimal.valueof(mainWrapperData.Interest_Rate_Actual);
            if( mainWrapperData.Term_Months_Actual != null )
            objWrapper.termInMonthAdjusted = mainWrapperData.Term_Months_Actual;
            
            
        }
        
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        string endPointURL = PortalBaseURL+System.Label.JavaPortalEndPointUrl;
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
        Portalobj.Success_Error_Code__c = String.valueOf(response.getStatusCode());
        integer statusCodeAuth = response.getStatusCode();
        System.debug('----------statusCodeAuth----->>'+statusCodeAuth);
        lstOfExceptions.add(Portalobj);
        
        
        if (response.getStatusCode() == 200 || Test.isRunningTest()) {
            JSONParser parser = JSON.createParser(response.getBody()); 
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() =='accessToken' || Test.isRunningTest())){
                    parser.nextToken();
                    accessToken= parser.getText();
                }
            }
        }
        
        
        
        //*********************** Calling Java API *************************************
        if( accessToken != null && accessToken != '' || Test.isRunningTest())
        {
            Http http1 = new Http();
            HttpRequest request1 = new HttpRequest();
            request1.setHeader('Authorization', accessToken);
            request1.setHeader('Content-Type', 'application/json');
            string endPointURL1 = PortalBaseURL+System.Label.JavaPortalRunQCFAPIUrl;
            request1.setEndpoint(endPointURL1);
            request1.setMethod('POST');
            system.debug('------JSON.serialize(objWrapper, true)------>>'+JSON.serialize(objWrapper, true));
            request1.setBody( JSON.serialize(objWrapper, true) );
            HttpResponse response1 = http1.send(request1);
            //Inserting Request, Response and Response code into the custom object for error handling
            QCFResponse = JSON2ApexQCF.parse(response1.getBody());
            objMainWrapper.Highest_Credit_Score = highestCreditScore;
            // Check if response of quickCashFlowDetailInfoList is not null 
            if(QCFResponse.quickCashFlowDetailInfoList != null && QCFResponse.quickCashFlowDetailInfoList.size() > 0){
                
                for( JSON2ApexQCF.quickCashFlowDetailInfoList eachResponse : QCFResponse.quickCashFlowDetailInfoList){
                    // When Year in Response is Current year
                    if(eachResponse.year == CY){
                        objMainWrapper.Total_First_CY =  eachResponse.projectionTotal;
                        objMainWrapper.Business_Coverage_Ratio_CY = eachResponse.businessCoverageRatio;
                        objMainWrapper.Monthly_Existing_Installment_Debt_CY = eachResponse.existingInstallmentDebtMonthly;
                        objMainWrapper.Annual_Existing_P_I_CY = eachResponse.existing_PI_annual;
                        objMainWrapper.Global_Coverage_Ratio_CY = eachResponse.globalCoverageRatio;
                        objMainWrapper.Total_Second_CY = eachResponse.lessTotal;
                        objMainWrapper.Owner_1_Personal_Disc_SD_CY = eachResponse.owner1Surplus;
                        objMainWrapper.Owner_2_Personal_Disc_SD_CY = eachResponse.owner2Surplus;
                        objMainWrapper.Owner_3_Personal_Disc_SD_CY = eachResponse.owner3Surplus;
                        objMainWrapper.Owner_4_Personal_Disc_SD_CY = eachResponse.owner4Surplus;
                        objMainWrapper.Proposed_P_I_CY = eachResponse.proposed_PI;
                    }
                    
                    // When Year in Response is Current year -1
                    if(eachResponse.year == CY_1){
                        objMainWrapper.Total_First_CY1 =  eachResponse.projectionTotal;
                        objMainWrapper.Business_Coverage_Ratio_CY1 = eachResponse.businessCoverageRatio;
                        objMainWrapper.Monthly_Existing_Installment_Debt_CY1 = eachResponse.existingInstallmentDebtMonthly;
                        objMainWrapper.Annual_Existing_P_I_CY1 = eachResponse.existing_PI_annual;
                        objMainWrapper.Global_Coverage_Ratio_CY1 = eachResponse.globalCoverageRatio;
                        objMainWrapper.Total_Second_CY1 = eachResponse.lessTotal;
                        objMainWrapper.Owner_1_Personal_Disc_SD_CY1 = eachResponse.owner1Surplus;
                        objMainWrapper.Owner_2_Personal_Disc_SD_CY1 = eachResponse.owner2Surplus;
                        objMainWrapper.Owner_3_Personal_Disc_SD_CY1 = eachResponse.owner3Surplus;
                        objMainWrapper.Owner_4_Personal_Disc_SD_CY1 = eachResponse.owner4Surplus;
                        objMainWrapper.Proposed_P_I_CY1 = eachResponse.proposed_PI;
                    }
                    
                    // When Year in Response is Current year -2
                    if(eachResponse.year == CY_2){
                        objMainWrapper.Total_First_CY2 =  eachResponse.projectionTotal;
                        objMainWrapper.Business_Coverage_Ratio_CY2 = eachResponse.businessCoverageRatio;
                        objMainWrapper.Monthly_Existing_Installment_Debt_CY2 = eachResponse.existingInstallmentDebtMonthly;
                        objMainWrapper.Annual_Existing_P_I_CY2 = eachResponse.existing_PI_annual;
                        objMainWrapper.Global_Coverage_Ratio_CY2 = eachResponse.globalCoverageRatio;
                        objMainWrapper.Total_Second_CY2 = eachResponse.lessTotal;
                        objMainWrapper.Owner_1_Personal_Disc_SD_CY2 = eachResponse.owner1Surplus;
                        objMainWrapper.Owner_2_Personal_Disc_SD_CY2 = eachResponse.owner2Surplus;
                        objMainWrapper.Owner_3_Personal_Disc_SD_CY2 = eachResponse.owner3Surplus;
                        objMainWrapper.Owner_4_Personal_Disc_SD_CY2 = eachResponse.owner4Surplus;
                        objMainWrapper.Proposed_P_I_CY2 = eachResponse.proposed_PI;
                    }
                    
                    // When Year in Response is Current year -3
                    if(eachResponse.year == CY_3){
                        objMainWrapper.Total_First_CY3 =  eachResponse.projectionTotal;
                        objMainWrapper.Business_Coverage_Ratio_CY3 = eachResponse.businessCoverageRatio;
                        objMainWrapper.Monthly_Existing_Installment_Debt_CY3 = eachResponse.existingInstallmentDebtMonthly;
                        objMainWrapper.Annual_Existing_P_I_CY3 = eachResponse.existing_PI_annual;
                        objMainWrapper.Global_Coverage_Ratio_CY3 = eachResponse.globalCoverageRatio;
                        objMainWrapper.Total_Second_CY3 = eachResponse.lessTotal;
                        objMainWrapper.Owner_1_Personal_Disc_SD_CY3 = eachResponse.owner1Surplus;
                        objMainWrapper.Owner_2_Personal_Disc_SD_CY3 = eachResponse.owner2Surplus;
                        objMainWrapper.Owner_3_Personal_Disc_SD_CY3 = eachResponse.owner3Surplus;
                        objMainWrapper.Owner_4_Personal_Disc_SD_CY3 = eachResponse.owner4Surplus;
                        objMainWrapper.Proposed_P_I_CY3 = eachResponse.proposed_PI;
                    }
                    
                    
                }
            }
            
            
            system.debug('-----------QCFResponse.personalAnalysis------------->>'+QCFResponse.personalAnalysis);
            if(QCFResponse.personalAnalysis !=null && QCFResponse.personalAnalysis.keySet() != null )
            {
                for (integer key : QCFResponse.personalAnalysis.keySet())
                {
                    if( key == 0)
                        ListOfpersonalOwnerOne = QCFResponse.personalAnalysis.get(key);
                    if( key == 1)
                        ListOfpersonalOwnerTwo  = QCFResponse.personalAnalysis.get(key);
                    if( key == 2)
                        ListOfpersonalOwnerThree  = QCFResponse.personalAnalysis.get(key);
                    if( key == 3)
                        ListOfpersonalOwnerFour  = QCFResponse.personalAnalysis.get(key);
                    if( key == 4)
                        ListOfpersonalOwnerFive  = QCFResponse.personalAnalysis.get(key);
                    
                    
                }
                // For Owner One
                if( ListOfpersonalOwnerOne != null && ListOfpersonalOwnerOne.size() > 0 )
                {
                    for( JSON2ApexQCF.personal  each : ListOfpersonalOwnerOne)
                    {
                        // When Year in Response is Current year
                        if( each.year == CY)
                        {
                            objMainWrapper.Total_Estimated_Personal_O1_CY = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_1 = each.totalAnnualDebt;
                            objMainWrapper.Adult_Owner1 = each.noOfAdults;
                            objMainWrapper.Kid_Owner1 = each.noOfKids;
                            objMainWrapper.Living_Expenses_O1_CY = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O1_CY = each.totalTaxes;

                        }
                        // When Year in Response is Current year-1
                        if( each.year == CY_1)
                        {
                            objMainWrapper.Total_Estimated_Personal_O1_CY1 = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_1 = each.totalAnnualDebt;
                            objMainWrapper.Living_Expenses_O1_CY1 = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O1_CY1 = each.totalTaxes;
                        }
                        // When Year in Response is Current year-2
                        if( each.year == CY_2)
                        {
                            objMainWrapper.Total_Estimated_Personal_O1_CY2 = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_2 = each.totalAnnualDebt;
                            objMainWrapper.Living_Expenses_O1_CY2 = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O1_CY2 = each.totalTaxes;
                        }
                        // When Year in Response is Current year-3
                        if( each.year == CY_3)
                        {
                            objMainWrapper.Total_Estimated_Personal_O1_CY3 = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_3 = each.totalAnnualDebt;
                            objMainWrapper.Living_Expenses_O1_CY3 = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O1_CY3 = each.totalTaxes;
                        }
                    }
                }
                
                // For Owner Two
                if( ListOfpersonalOwnerTwo != null && ListOfpersonalOwnerTwo.size() > 0 )
                {
                    for( JSON2ApexQCF.personal  each : ListOfpersonalOwnerTwo)
                    {
                        // When Year in Response is Current year
                        if( each.year == CY)
                        {
                            objMainWrapper.Total_Estimated_Personal_O2_CY = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_2 = each.totalAnnualDebt;
                            objMainWrapper.Adult_Owner2 = each.noOfAdults;
                            objMainWrapper.Kid_Owner2 = each.noOfKids;
                            objMainWrapper.Living_Expenses_O2_CY = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O2_CY = each.totalTaxes;
                        }
                        // When Year in Response is Current year-1
                        if( each.year == CY_1)
                        {
                            objMainWrapper.Total_Estimated_Personal_O2_CY1 = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_2 = each.totalAnnualDebt;
                            objMainWrapper.Living_Expenses_O2_CY1 = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O2_CY1 = each.totalTaxes;
                        }
                        // When Year in Response is Current year-2
                        if( each.year == CY_2)
                        {
                            objMainWrapper.Total_Estimated_Personal_O2_CY2 = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_2 = each.totalAnnualDebt;
                            objMainWrapper.Living_Expenses_O2_CY2 = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O2_CY2 = each.totalTaxes;
                        }
                        // When Year in Response is Current year-3
                        if( each.year == CY_3)
                        {
                            objMainWrapper.Total_Estimated_Personal_O2_CY3 = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_2 = each.totalAnnualDebt;
                            objMainWrapper.Living_Expenses_O2_CY3 = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O2_CY3 = each.totalTaxes;
                        }
                    }
                    
                }
                
                // For Owner Three
                if( ListOfpersonalOwnerThree != null && ListOfpersonalOwnerThree.size() > 0 )
                {
                    for( JSON2ApexQCF.personal  each : ListOfpersonalOwnerThree)
                    {
                        // When Year in Response is Current year
                        if( each.year == CY)
                        {
                            objMainWrapper.Total_Estimated_Personal_O3_CY = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_3 = each.totalAnnualDebt;
                            objMainWrapper.Adult_Owner3 = each.noOfAdults;
                            objMainWrapper.Kid_Owner3 = each.noOfKids;
                            objMainWrapper.Living_Expenses_O3_CY = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O3_CY = each.totalTaxes;
                        }
                        // When Year in Response is Current year-1
                        if( each.year == CY_1)
                        {
                            objMainWrapper.Total_Estimated_Personal_O3_CY1 = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_3 = each.totalAnnualDebt;
                            objMainWrapper.Living_Expenses_O3_CY1 = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O3_CY1 = each.totalTaxes;
                        }
                        // When Year in Response is Current year-2
                        if( each.year == CY_2)
                        {
                            objMainWrapper.Total_Estimated_Personal_O3_CY2 = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_3 = each.totalAnnualDebt;
                            objMainWrapper.Living_Expenses_O3_CY2 = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O3_CY2 = each.totalTaxes;
                        }
                        // When Year in Response is Current year-3
                        if( each.year == CY_3)
                        {
                            objMainWrapper.Total_Estimated_Personal_O3_CY3 = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_3 = each.totalAnnualDebt;
                            objMainWrapper.Living_Expenses_O3_CY3 = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O3_CY3 = each.totalTaxes;
                        }
                    }
                    
                }
                
                // For Owner Four
                if( ListOfpersonalOwnerFour != null && ListOfpersonalOwnerFour.size() > 0 )
                {
                    for( JSON2ApexQCF.personal  each : ListOfpersonalOwnerFour)
                    {
                        // When Year in Response is Current year
                        if( each.year == CY)
                        {
                            objMainWrapper.Total_Estimated_Personal_O4_CY = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_4 = each.totalAnnualDebt;
                            objMainWrapper.Adult_Owner4 = each.noOfAdults;
                            objMainWrapper.Kid_Owner4 = each.noOfKids;
                            objMainWrapper.Living_Expenses_O4_CY = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O4_CY = each.totalTaxes;
                        }
                        // When Year in Response is Current year-1
                        if( each.year == CY_1)
                        {
                            objMainWrapper.Total_Estimated_Personal_O4_CY1 = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_4 = each.totalAnnualDebt;
                            objMainWrapper.Living_Expenses_O4_CY1 = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O4_CY1 = each.totalTaxes;
                        }
                        // When Year in Response is Current year-2
                        if( each.year == CY_2)
                        {
                            objMainWrapper.Total_Estimated_Personal_O4_CY2 = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_4 = each.totalAnnualDebt;
                            objMainWrapper.Living_Expenses_O4_CY2 = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O4_CY2 = each.totalTaxes;
                            
                        }
                        // When Year in Response is Current year-3
                        if( each.year == CY_3)
                        {
                            objMainWrapper.Total_Estimated_Personal_O4_CY3 = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_4 = each.totalAnnualDebt;
                            objMainWrapper.Living_Expenses_O4_CY3 = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O4_CY3 = each.totalTaxes;
                        }
                    }
                    
                }
                
                // For Owner Five
                if( ListOfpersonalOwnerFive != null && ListOfpersonalOwnerFive.size() > 0 )
                {
                    for( JSON2ApexQCF.personal  each : ListOfpersonalOwnerFive)
                    {
                        // When Year in Response is Current year
                        if( each.year == CY)
                        {
                            objMainWrapper.Total_Estimated_Personal_O5_CY = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_5 = each.totalAnnualDebt;
                            objMainWrapper.Adult_Owner5 = each.noOfAdults;
                            objMainWrapper.Kid_Owner5 = each.noOfKids;
                            objMainWrapper.Living_Expenses_O5_CY = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O5_CY = each.totalTaxes;
                        }
                        // When Year in Response is Current year-1
                        if( each.year == CY_1)
                        {
                            objMainWrapper.Total_Estimated_Personal_O5_CY1 = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_5 = each.totalAnnualDebt;
                            objMainWrapper.Living_Expenses_O5_CY1 = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O5_CY1 = each.totalTaxes;
                        }
                        // When Year in Response is Current year-2
                        if( each.year == CY_2)
                        {
                            objMainWrapper.Total_Estimated_Personal_O5_CY2 = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_5 = each.totalAnnualDebt;
                            objMainWrapper.Living_Expenses_O5_CY2 = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O5_CY2 = each.totalTaxes;
                        }
                        // When Year in Response is Current year-3
                        if( each.year == CY_3)
                        {
                            objMainWrapper.Total_Estimated_Personal_O5_CY3 = each.totalEstimatedPersonalCash;
                            objMainWrapper.Total_Annual_Debt_Service_Owner_5 = each.totalAnnualDebt;
                            objMainWrapper.Living_Expenses_O5_CY3 = each.livingExpenses;
                            objMainWrapper.Total_Taxes_O5_CY3 = each.totalTaxes;
                        }
                    }
                    
                }
            }
            // Mapping of Response of quickCashFlowInfo 
            if(QCFResponse.quickCashFlowInfo != null){
                objMainWrapper.Projected_Weekly_Payment = QCFResponse.quickCashFlowInfo.projectedWeeklyPayment;
                objMainWrapper.Projected_Monthly_Payment = QCFResponse.quickCashFlowInfo.projectedMonthlyPayment;
                objMainWrapper.Projected_Annual_Payment = QCFResponse.quickCashFlowInfo.projectedAnnualPayment;
                objMainWrapper.Projected_Daily_Payment = QCFResponse.quickCashFlowInfo.projectedDailyPayment;
                objMainWrapper.Projected_SemiMonthly_Payment = QCFResponse.quickCashFlowInfo.projectedSemiMonthlyPayment;
                objMainWrapper.Projected_BiWeekly_Payment = QCFResponse.quickCashFlowInfo.projectedBiweeklyPayment;
                
                objMainWrapper.Time_in_Business_Months = QCFResponse.quickCashFlowInfo.timeInBusimess;
                objMainWrapper.Highest_Credit_Score = QCFResponse.quickCashFlowInfo.highestCreditScore;
                objMainWrapper.Estimated_CCR = QCFResponse.quickCashFlowInfo.estmated_CCR;
                objMainWrapper.Industry_High_Risk = QCFResponse.quickCashFlowInfo.isIndustryHighRisk;
                
                objMainWrapper.Loan_Amount_Actual = QCFResponse.quickCashFlowInfo.loanAmountActual;
                objMainWrapper.Loan_Amount_Adjusted = QCFResponse.quickCashFlowInfo.loanAmountAdjusted;
                //objMainWrapper.Loan_Amount_Status = QCFResponse.quickCashFlowInfo.loanAmountStatus;
                
                objMainWrapper.Interest_Rate_Actual = QCFResponse.quickCashFlowInfo.interestRateActual;
                objMainWrapper.Interest_Rate_Adjusted = QCFResponse.quickCashFlowInfo.interestRateAdjusted;
                //objMainWrapper.Interest_Rate_Status = QCFResponse.quickCashFlowInfo.interestRateStatus;
                
                objMainWrapper.Term_Months_Actual = QCFResponse.quickCashFlowInfo.termInMonthActual;
                objMainWrapper.Term_Months_Adjusted = QCFResponse.quickCashFlowInfo.termInMonthAdjusted;
                //objMainWrapper.Term_Months_Status = QCFResponse.quickCashFlowInfo.termInMonthStatus; 
                
                objMainWrapper.DueIn_Months_Actual = QCFResponse.quickCashFlowInfo.dueInMonthActual;
                objMainWrapper.DueIn_Months_Adjusted = QCFResponse.quickCashFlowInfo.dueInMonthAdjusted;
                //objMainWrapper.DueIn_Months_Status = QCFResponse.quickCashFlowInfo.dueInMonthStatus; 
                
            }
            
            Portal_Integration_Response_Code__c  Portalobj1 = new  Portal_Integration_Response_Code__c ();
            Portalobj1.Request__c = request1.getBody();
            Portalobj1.Response__c = response1.getBody();
            Portalobj1.Success_Error_Code__c = String.valueOf(response1.getStatusCode());
            //Portalobj1.Record need to discuss with JD
            lstOfExceptions.add(Portalobj1);
            
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
        
        
        
        
        return objMainWrapper;
    }
    
    
    public class personalOwnerAnalysis {
        public String personalAnalysisId;
        public Integer year;
        public Double salaryWagesBorrower;
        public Double salaryWagesSpouse;
        public Double otherWagesAffillliate;
        public Double interestDividendIncome;
        public Double otherIncome;
        public Double pension_IRA_distribution;
        public Double schDCapitalGain;
        public Double scheduleCIncome;
        public Double scheduleERental;
        public Double k1Distribution;
        public Double lessAlimonyPaid; 
        public Double taxes;
        public Double reTaxes;
        public Double stateTaxes;
        public Double annualRent;
        public Double noOfAdults;
        public Double noOfKids;
        public Double totalAnnualDebt;
    }
    public class QuickCashFlowDetailsDtos {
        public Integer detailInfoId;
        public Integer year;
        public Integer months ;
        public Double sales;
        public Double netProfit;
        public Double depreciationAmortizationDepletion;
        public Double interestExpense;
        public Double nonRecurringExpense;
        public Double affilliateIncome;
        public Double existingInstallmentDebtMonthly;
    }
    
    public class QuickCashFlowDetailsDtos1 
    {
        public Integer detailInfoIdYear1;
        public Integer Year_CY;
        public Integer Months_CY ;
        public Double Sales_CY;
        public Double Net_Profit_CY;
        public Double depreciationAmortizationDepletionY1;
        public Double Interest_Exp_CY;
        public Double Non_Recurring_Expenses_CY;
        public Double Affilliate_Income_CY;
        public Double Monthly_Existing_Installment_Debt_CY;
        
        
        
        public Integer detailInfoIdYear2;
        public Integer Year_CY_1      ;
        public Integer Months_CY1 ;
        public Double Sales_CY1;
        public Double Net_Profit_CY1;
        public Double depreciationAmortizationDepletionY2;
        public Double Interest_Exp_CY1        ;
        public Double Non_Recurring_Expenses_CY1;
        public Double Affilliate_Income_CY1;
        public Double Monthly_Existing_Installment_Debt_CY1;
        
        
        
        public Integer detailInfoIdYear3;
        public Integer Year_CY_2;
        public Integer Months_CY2 ;
        public Double Sales_CY2;
        public Double Net_Profit_CY2;
        public Double depreciationAmortizationDepletionY3;
        public Double Interest_Exp_CY2;
        public Double Non_Recurring_Expenses_CY2;
        public Double Affilliate_Income_CY2;
        public Double Monthly_Existing_Installment_Debt_CY2;
        
        
        
        public Integer detailInfoIdYear4;
        public Integer Year_CY_3      ;
        public Integer    Months_CY3 ;
        public Double Sales_CY3        ;
        public Double Net_Profit_CY3;
        public Double depreciationAmortizationDepletionY4;
        public Double Interest_Exp_CY3;
        public Double Non_Recurring_Expenses_CY3;
        public Double Affilliate_Income_CY3;
        public Double Monthly_Existing_Installment_Debt_CY3;
    }
    public class WrapperQCFJavaJSON
    {
        public String loanType;
        public String leadId;
        public String businessId;
        public Double amountRequest;
        public String businessStartDate;
        public string interestRateAdjusted;
        public Double interestRateActual;
        public Double termInMonthAdjusted;
        public List<QuickCashFlowDetailsDtos> quickCashFlowDetailsDtos;
        Public map<string,list< personalOwnerAnalysis>> personalAnalysis;
    }
    //=======================MainWrapper=====================================
    public class mainWrapper
    {
        //================================Start Block For Owner Records==========================
        @AuraEnabled
        public boolean IsFirstOwner {get;set;}
        @AuraEnabled
        public string FirstOwnerName {get;set;}
        @AuraEnabled
        public boolean IsSecondOwner {get;set;}
        @AuraEnabled
        public string SecondOwnerName {get;set;}
        @AuraEnabled
        public boolean IsThirdOwner {get;set;}
        @AuraEnabled
        public string ThirdOwnerName {get;set;}
        @AuraEnabled
        public boolean IsFourthOwner {get;set;}
        @AuraEnabled
        public string FourthOwnerName {get;set;}
        @AuraEnabled
        public boolean IsFifthOwner {get;set;}
        @AuraEnabled
        public string FifthOwnerName {get;set;}
        @AuraEnabled
        public Integer CurrentYear { get ; set ;}
        @AuraEnabled
        public Integer CurrentYear_1 { get ; set ;}
        @AuraEnabled
        public Integer CurrentYear_2 { get ; set ; }
        @AuraEnabled
        public Integer CurrentYear_3 {get;set;}
        //================================End BLock For Owner Records=============================
        @AuraEnabled public  String  Id{ get ; set ; }
        @AuraEnabled public  String   Name{ get ; set ; }
        @AuraEnabled public  double   CreatedDate{ get ; set ; }
        @AuraEnabled public  double   CreatedById{ get ; set ; }
        @AuraEnabled public  double   LastModifiedDate{ get ; set ; }
        @AuraEnabled public  double   LastModifiedById{ get ; set ; }
        @AuraEnabled public  double   SystemModstamp{ get ; set ; }
        @AuraEnabled public  double   LastActivityDate{ get ; set ; }
        @AuraEnabled public  double   LastViewedDate{ get ; set ; }
        @AuraEnabled public  double   LastReferencedDate{ get ; set ; }
        @AuraEnabled public  double   Test{ get ; set ; }
        @AuraEnabled public  double   Months_CY1{ get ; set ; }
        @AuraEnabled public  double   Months_CY{ get ; set ; }
        @AuraEnabled public  double   Months_CY2{ get ; set ; }
        @AuraEnabled public  double   Months_CY3{ get ; set ; }
        @AuraEnabled public  double   Sales_CY{ get ; set ; }
        @AuraEnabled public  double   Sales_CY1{ get ; set ; }
        @AuraEnabled public  double   Sales_CY2{ get ; set ; }
        @AuraEnabled public  double   Sales_CY3{ get ; set ; }
        @AuraEnabled public  double   Net_Profit_CY{ get ; set ; }
        @AuraEnabled public  double   Net_Profit_CY1{ get ; set ; }
        @AuraEnabled public  double   Net_Profit_CY2{ get ; set ; }
        @AuraEnabled public  double   Net_Profit_CY3{ get ; set ; }
        @AuraEnabled public  double   New_Rents_CY{ get ; set ; }
        @AuraEnabled public  double   New_Rents_CY1{ get ; set ; }
        @AuraEnabled public  double   New_Rents_CY2{ get ; set ; }
        @AuraEnabled public  double   New_Rents_CY3{ get ; set ; }
        @AuraEnabled public  double   Interest_Exp_CY{ get ; set ; }
        @AuraEnabled public  double   Interest_Exp_CY1{ get ; set ; }
        @AuraEnabled public  double   Interest_Exp_CY2{ get ; set ; }
        @AuraEnabled public  double   Interest_Exp_CY3{ get ; set ; }
        @AuraEnabled public  double   Non_Recurring_Expenses_CY{ get ; set ; }
        @AuraEnabled public  double   Non_Recurring_Expenses_CY1{ get ; set ; }
        @AuraEnabled public  double   Non_Recurring_Expenses_CY2{ get ; set ; }
        @AuraEnabled public  double   Non_Recurring_Expenses_CY3{ get ; set ; }
        @AuraEnabled public  double   Affilliate_Income_CY{ get ; set ; }
        @AuraEnabled public  double   Affilliate_Income_CY1{ get ; set ; }
        @AuraEnabled public  double   Affilliate_Income_CY2{ get ; set ; }
        @AuraEnabled public  double   Affilliate_Income_CY3{ get ; set ; }
        @AuraEnabled public  double   Owner_1_Personal_Disc_SD_CY1{ get ; set ; }
        @AuraEnabled public  double   Owner_1_Personal_Disc_SD_CY2{ get ; set ; }
        @AuraEnabled public  double   Owner_1_Personal_Disc_SD_CY{ get ; set ; }
        @AuraEnabled public  double   Owner_1_Personal_Disc_SD_CY3{ get ; set ; }
        @AuraEnabled public  double   Owner_2_Personal_Disc_SD_CY{ get ; set ; }
        @AuraEnabled public  double   Owner_2_Personal_Disc_SD_CY1{ get ; set ; }
        @AuraEnabled public  double   Owner_2_Personal_Disc_SD_CY2{ get ; set ; }
        @AuraEnabled public  double   Owner_2_Personal_Disc_SD_CY3{ get ; set ; }
        @AuraEnabled public  double   Owner_3_Personal_Disc_SD_CY{ get ; set ; }
        @AuraEnabled public  double   Owner_3_Personal_Disc_SD_CY1{ get ; set ; }
        @AuraEnabled public  double   Owner_3_Personal_Disc_SD_CY2{ get ; set ; }
        @AuraEnabled public  double   Owner_3_Personal_Disc_SD_CY3{ get ; set ; }
        @AuraEnabled public  double   Owner_4_Personal_Disc_SD_CY{ get ; set ; }
        @AuraEnabled public  double   Owner_4_Personal_Disc_SD_CY1{ get ; set ; }
        @AuraEnabled public  double   Owner_4_Personal_Disc_SD_CY2{ get ; set ; }
        @AuraEnabled public  double   Owner_4_Personal_Disc_SD_CY3{ get ; set ; }
        @AuraEnabled public  double   Total_First_CY{ get ; set ; }
        @AuraEnabled public  double   Total_First_CY1{ get ; set ; }
        @AuraEnabled public  double   Total_First_CY2{ get ; set ; }
        @AuraEnabled public  double   Monthly_Existing_Installment_Debt_CY{ get ; set ; }
        @AuraEnabled public  double   Total_First_CY3{ get ; set ; }
        @AuraEnabled public  double   Monthly_Existing_Installment_Debt_CY1{ get ; set ; }
        @AuraEnabled public  double   Monthly_Existing_Installment_Debt_CY2{ get ; set ; }
        @AuraEnabled public  double   Monthly_Existing_Installment_Debt_CY3{ get ; set ; }
        @AuraEnabled public  double   Annual_Existing_P_I_CY{ get ; set ; }
        @AuraEnabled public  double   Annual_Existing_P_I_CY1{ get ; set ; }
        @AuraEnabled public  double   Annual_Existing_P_I_CY2{ get ; set ; }
        @AuraEnabled public  double   Annual_Existing_P_I_CY3{ get ; set ; }
        @AuraEnabled public  double   Proposed_P_I_CY{ get ; set ; }
        @AuraEnabled public  double   Proposed_P_I_CY1{ get ; set ; }
        @AuraEnabled public  double   Proposed_P_I_CY2{ get ; set ; }
        @AuraEnabled public  double   Proposed_P_I_CY3{ get ; set ; }
        @AuraEnabled public  double   Total_Second_CY{ get ; set ; }
        @AuraEnabled public  double   Total_Second_CY2{ get ; set ; }
        @AuraEnabled public  double   Total_Second_CY1{ get ; set ; }
        @AuraEnabled public  double   Total_Second_CY3{ get ; set ; }
        @AuraEnabled public  double   Global_Coverage_Ratio_CY{ get ; set ; }
        @AuraEnabled public  double   Global_Coverage_Ratio_CY1{ get ; set ; }
        @AuraEnabled public  double   Global_Coverage_Ratio_CY2{ get ; set ; }
        @AuraEnabled public  double   Global_Coverage_Ratio_CY3{ get ; set ; }
        @AuraEnabled public  double   Business_Coverage_Ratio_CY{ get ; set ; }
        @AuraEnabled public  double   Business_Coverage_Ratio_CY1{ get ; set ; }
        @AuraEnabled public  double   Business_Coverage_Ratio_CY2{ get ; set ; }
        @AuraEnabled public  double   Business_Coverage_Ratio_CY3{ get ; set ; }
        @AuraEnabled public  double   Discretionary_Coverage_Ratio_CY{ get ; set ; }
        @AuraEnabled public  double   Discretionary_Coverage_Ratio_CY1{ get ; set ; }
        @AuraEnabled public  double   Discretionary_Coverage_Ratio_CY2{ get ; set ; }
        @AuraEnabled public  double   Discretionary_Coverage_Ratio_CY3{ get ; set ; }
        @AuraEnabled public  double   Highest_Credit_Score{ get ; set ; }
        @AuraEnabled public  double   Time_in_Business_Months{ get ; set ; }
        @AuraEnabled public  double   Estimated_CCR{ get ; set ; }
        @AuraEnabled public  Boolean  Industry_High_Risk{ get ; set ; }
        @AuraEnabled public  Boolean  Industry_High_Risk1{ get ; set ; }
        
        @AuraEnabled public  double   Loan_Amount_Actual{ get ; set ; }
        @AuraEnabled public  double   Loan_Amount_Adjusted{ get ; set ; }
        @AuraEnabled public  double   Loan_Amount_Status{ get ; set ; }
        @AuraEnabled public  double   Interest_Rate_Actual{ get ; set ; }
        @AuraEnabled public  double   Interest_Rate_Adjusted{ get ; set ; }
        @AuraEnabled public  double   Interest_Rate_Status{ get ; set ; }
        @AuraEnabled public  double   Term_Months_Actual{ get ; set ; }
        @AuraEnabled public  double   Term_Months_Adjusted{ get ; set ; }
        @AuraEnabled public  double   Term_Months_Status{ get ; set ; }
        @AuraEnabled public  double   DueIn_Months_Actual{ get ; set ; }
        @AuraEnabled public  double   DueIn_Months_Adjusted{ get ; set ; }
        @AuraEnabled public  double   DueIn_Months_Status{ get ; set ; }
        @AuraEnabled public  double   Projected_Daily_Payment{ get ; set ; }
        @AuraEnabled public  double   Projected_Monthly_Payment{ get ; set ; }
        @AuraEnabled public  double   Projected_Weekly_Payment{ get ; set ; }
        @AuraEnabled public  double   Projected_Annual_Payment{ get ; set ; }
        @AuraEnabled public  double   Projected_BiWeekly_Payment{ get ; set ; }
        @AuraEnabled public  double   Projected_SemiMonthly_Payment{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O1_CY{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O2_CY{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O3_CY{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O4_CY{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O5_CY{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O1_CY1{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O2_CY1{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O3_CY1{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O4_CY1{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O5_CY1{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O1_CY2{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O2_CY2{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O3_CY2{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O4_CY2{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O5_CY2{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O1_CY3{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O2_CY3{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O3_CY3{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O4_CY3{ get ; set ; }
        @AuraEnabled public  double   Interestdividend_Income_O5_CY3{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O1_CY{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O2_CY{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O3_CY{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O4_CY{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O5_CY{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O1_CY1{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O2_CY1{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O3_CY1{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O4_CY1{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O5_CY1{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O1_CY2{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O2_CY2{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O3_CY2{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O4_CY2{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O5_CY2{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O1_CY3{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O2_CY3{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O3_CY3{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O4_CY3{ get ; set ; }
        @AuraEnabled public  double   K1_Distributions_O5_CY3{ get ; set ; }
        @AuraEnabled public  double   Other_Guaranteed_wages_affiliates_O1_CY{ get ; set ; }
        @AuraEnabled public  double   Other_Guaranteed_wages_affiliates_O2_CY{ get ; set ; }
        @AuraEnabled public  double   Other_Guaranteed_wages_affiliates_O3_CY{ get ; set ; }
        @AuraEnabled public  double   Other_Guaranteed_wages_affiliates_O4_CY{ get ; set ; }
        @AuraEnabled public  double   Other_Guaranteed_wages_affiliates_O5_CY{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O1_CY{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O2_CY{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O3_CY{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O4_CY{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O5_CY{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O1_CY1{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O2_CY1{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O3_CY1{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O4_CY1{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O5_CY1{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O1_CY2{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O2_CY2{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O1_CY3{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O3_CY2{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O4_CY2{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O5_CY2{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O3_CY3{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O4_CY3{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O5_CY3{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O1_CY{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O2_CY{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O3_CY{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O4_CY{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O5_CY{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O1_CY1{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O2_CY1{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O3_CY1{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O4_CY1{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O5_CY1{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O1_CY2{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O2_CY2{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O3_CY2{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O4_CY2{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O5_CY2{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O1_CY3{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O2_CY3{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O3_CY3{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O4_CY3{ get ; set ; }
        @AuraEnabled public  double   PensionIRA_Distributions_O5_CY3{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O1_CY{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O2_CY{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O3_CY{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O4_CY{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O5_CY{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O2_CY1{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O3_CY1{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O1_CY1{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O4_CY1{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O5_CY1{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O1_CY2{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O2_CY2{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O3_CY2{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O4_CY2{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O5_CY2{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O1_CY3{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O2_CY3{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O3_CY3{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O4_CY3{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Borrower_O5_CY3{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O1_CY{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O2_CY{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O3_CY{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O4_CY{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O5_CY{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O1_CY1{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O2_CY1{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O3_CY1{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O4_CY1{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O5_CY1{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O1_CY2{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O2_CY2{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O3_CY2{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O4_CY2{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O5_CY2{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O1_CY3{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O2_CY3{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O3_CY3{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O4_CY3{ get ; set ; }
        @AuraEnabled public  double   Salary_Wages_Spouse_O5_CY3{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O1_CY{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O2_CY{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O3_CY{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O4_CY{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O5_CY{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O1_CY1{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O2_CY1{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O3_CY1{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O4_CY1{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O5_CY1{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O1_CY2{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O2_CY2{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O3_CY2{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O4_CY2{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O5_CY2{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O1_CY3{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O2_CY3{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O3_CY3{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O4_CY3{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O1_CY{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O2_CY{ get ; set ; }
        @AuraEnabled public  double   Sch_D_Capital_gainslosses_O5_CY3{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O3_CY{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O4_CY{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O5_CY{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O1_CY1{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O2_CY1{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O3_CY1{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O4_CY1{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O5_CY1{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O1_CY2{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O2_CY2{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O3_CY2{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O4_CY2{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O5_CY2{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O1_CY3{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O2_CY3{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O3_CY3{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O4_CY3{ get ; set ; }
        @AuraEnabled public  double   Schedule_C_Income_O5_CY3{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O1_CY{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O2_CY{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O3_CY{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O4_CY{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O5_CY{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O1_CY1{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O2_CY1{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O3_CY1{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O4_CY1{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O5_CY1{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O1_CY2{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O2_CY2{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O3_CY2{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O4_CY2{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O5_CY2{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O1_CY3{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O2_CY3{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O3_CY3{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O4_CY3{ get ; set ; }
        @AuraEnabled public  double   Schedule_E_Rental_O5_CY3{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O2_CY3{ get ; set ; }
        @AuraEnabled public  double   Other_Income_O1CY3{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO1CY1{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO2CY1{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO3CY1{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO4CY1{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO5CY1{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO1CY2{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO2CY2{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO3CY2{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO4CY2{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO5CY2{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO1CY3{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO2CY3{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO3CY3{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO4CY3{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO5CY3{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO1CY{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO2CY{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO3CY{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO4CY{ get ; set ; }
        @AuraEnabled public  double   Other_GuaranteedwagesaffiliatesO5CY{ get ; set ; }
        @AuraEnabled public  double   Lead{ get ; set ; }
        @AuraEnabled public  double   Year_CY{ get ; set ; }
        @AuraEnabled public  double   Year_CY_1{ get ; set ; }
        @AuraEnabled public  double   Year_CY_2{ get ; set ; }
        @AuraEnabled public  double   Year_CY_3{ get ; set ; } 
        @AuraEnabled public  double  Total_Annual_Debt_O1_CY{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_O1_CY1{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_O1_CY2{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_O1_CY3{ get ; set ; }
        
        @AuraEnabled public  double  Total_Annual_Debt_O2_CY{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_O2_CY1{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_O2_CY2{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_O2_CY3{ get ; set ; }
        
        @AuraEnabled public  double  Total_Annual_Debt_O3_CY{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_O3_CY1{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_O3_CY2{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_O3_CY3{ get ; set ; }
        
        @AuraEnabled public  double  Total_Annual_Debt_O4_CY{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_O4_CY1{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_O4_CY2{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_O4_CY3{ get ; set ; }
        
        @AuraEnabled public  double  Total_Annual_Debt_O5_CY{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_O5_CY1{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_O5_CY2{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_O5_CY3{ get ; set ; }
        
        @AuraEnabled public  Integer  Adult_Owner1{ get ; set ; }
        @AuraEnabled public  Integer  AdultCurrency_Owner1{ get ; set ; }
        @AuraEnabled public  Integer  Adult_Owner2{ get ; set ; }
        @AuraEnabled public  Integer  AdultCurrency_Owner2{ get ; set ; }
        @AuraEnabled public  Integer  Adult_Owner3{ get ; set ; }
        @AuraEnabled public  Integer  AdultCurrency_Owner3{ get ; set ; }
        @AuraEnabled public  Integer  Adult_Owner4{ get ; set ; }
        @AuraEnabled public  Integer  AdultCurrency_Owner4{ get ; set ; }
        @AuraEnabled public  Integer  Adult_Owner5{ get ; set ; }
        @AuraEnabled public  Integer  AdultCurrency_Owner5{ get ; set ; }
        
        @AuraEnabled public  Integer  Kid_Owner1{ get ; set ; }
        @AuraEnabled public  Integer  KidCurrency_Owner1{ get ; set ; }
        @AuraEnabled public  Integer  Kid_Owner2{ get ; set ; }
        @AuraEnabled public  Integer  KidCurrency_Owner2{ get ; set ; }
        @AuraEnabled public  Integer  Kid_Owner3{ get ; set ; }
        @AuraEnabled public  Integer  KidCurrency_Owner3{ get ; set ; }
        @AuraEnabled public  Integer  Kid_Owner4{ get ; set ; }
        @AuraEnabled public  Integer  KidCurrency_Owner4{ get ; set ; }
        @AuraEnabled public  Integer  Kid_Owner5{ get ; set ; }
        @AuraEnabled public  Integer  KidCurrency_Owner5{ get ; set ; }
        
        
        @AuraEnabled public  double  Residence_Mortgage_Owner_1{ get ; set ; }
        @AuraEnabled public  double  Residence_Mortgage_Owner_2{ get ; set ; }
        @AuraEnabled public  double  Residence_Mortgage_Owner_3{ get ; set ; }
        @AuraEnabled public  double  Residence_Mortgage_Owner_4{ get ; set ; }
        @AuraEnabled public  double  Residence_Mortgage_Owner_5{ get ; set ; }
        @AuraEnabled public  double  Rental_Payment_Owner_1{ get ; set ; }
        @AuraEnabled public  double  Rental_Payment_Owner_2{ get ; set ; }
        @AuraEnabled public  double  Rental_Payment_Owner_3{ get ; set ; }
        @AuraEnabled public  double  Rental_Payment_Owner_4{ get ; set ; }
        @AuraEnabled public  double  Rental_Payment_Owner_5{ get ; set ; }
        @AuraEnabled public  double  HELOC_Owner_1{ get ; set ; }   
        @AuraEnabled public  double  HELOC_Owner_2{ get ; set ; }   
        @AuraEnabled public  double  HELOC_Owner_3{ get ; set ; }   
        @AuraEnabled public  double  HELOC_Owner_4{ get ; set ; }   
        @AuraEnabled public  double  HELOC_Owner_5{ get ; set ; }   
        @AuraEnabled public  double  Installment_Debt_Owner_1{ get ; set ; }
        @AuraEnabled public  double  Installment_Debt_Owner_2{ get ; set ; }    
        @AuraEnabled public  double  Installment_Debt_Owner_3{ get ; set ; }    
        @AuraEnabled public  double  Installment_Debt_Owner_4{ get ; set ; }    
        @AuraEnabled public  double  Installment_Debt_Owner_5{ get ; set ; }    
        @AuraEnabled public  double  Credit_Card_Debt_Owner_1{ get ; set ; }
        @AuraEnabled public  double  Credit_Card_Debt_Owner_2{ get ; set ; }
        @AuraEnabled public  double  Credit_Card_Debt_Owner_3{ get ; set ; }
        @AuraEnabled public  double  Credit_Card_Debt_Owner_4{ get ; set ; }
        @AuraEnabled public  double  Credit_Card_Debt_Owner_5{ get ; set ; }
        @AuraEnabled public  double  Other_debt_Owner_1{ get ; set ; }
        @AuraEnabled public  double  Other_debt_Owner_2{ get ; set ; }
        @AuraEnabled public  double  Other_debt_Owner_3{ get ; set ; }
        @AuraEnabled public  double  Other_debt_Owner_4{ get ; set ; }
        @AuraEnabled public  double  Other_debt_Owner_5{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_Service_Owner_1{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_Service_Owner_2{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_Service_Owner_3{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_Service_Owner_4{ get ; set ; }
        @AuraEnabled public  double  Total_Annual_Debt_Service_Owner_5{ get ; set ; }

        @AuraEnabled public  double   Total_Estimated_Personal_O5_CY3{get ; set ;}
        @AuraEnabled public  double   Total_Estimated_Personal_O5_CY2{get ; set ;}
        @AuraEnabled public  double   Total_Estimated_Personal_O5_CY1{get ; set ;}
        @AuraEnabled public  double   Total_Estimated_Personal_O5_CY{get ; set ;}
        @AuraEnabled public  double   Total_Estimated_Personal_O4_CY3{get ; set ;}
        @AuraEnabled public  double   Total_Estimated_Personal_O4_CY2{get ; set ;}
        @AuraEnabled public  double   Total_Estimated_Personal_O4_CY1{get ; set ;}
        @AuraEnabled public  double   Total_Estimated_Personal_O4_CY{get ; set ;}
        @AuraEnabled public  double   Total_Estimated_Personal_O3_CY3{get ; set ;}
        @AuraEnabled public  double   Total_Estimated_Personal_O3_CY2{get ; set ;}
        @AuraEnabled public  double   Total_Estimated_Personal_O3_CY1{get ; set ;}
        @AuraEnabled public  double   Total_Estimated_Personal_O3_CY{get ; set ;}
        @AuraEnabled public  double   Total_Estimated_Personal_O2_CY3{get ; set ;}
        @AuraEnabled public  double   Total_Estimated_Personal_O2_CY2{get ; set ;}
        @AuraEnabled public  double   Total_Estimated_Personal_O2_CY1{get ; set ;}
        @AuraEnabled public  double   Total_Estimated_Personal_O2_CY{get ; set ;}
        @AuraEnabled public  double   Total_Estimated_Personal_O1_CY3{get ; set ;}
        @AuraEnabled public  double   Total_Estimated_Personal_O1_CY2{get ; set ;}
        @AuraEnabled public  double   Total_Estimated_Personal_O1_CY1{get ; set ;}
        @AuraEnabled public  double   Total_Estimated_Personal_O1_CY{get ; set ;}
        
        //=====================Taxes, e-Taxes , TotalTaxes =====block===================
        @AuraEnabled public  double   Taxes_O1_CY {get ; set ;}
        @AuraEnabled public  double   Taxes_O2_CY {get ; set ;}
        @AuraEnabled public  double   Taxes_O3_CY {get ; set ;}
        @AuraEnabled public  double   Taxes_O4_CY {get ; set ;}
        @AuraEnabled public  double   Taxes_O5_CY {get ; set ;}
        @AuraEnabled public  double   Taxes_O1_CY1 {get ; set ;}
        @AuraEnabled public  double   Taxes_O2_CY1 {get ; set ;}
        @AuraEnabled public  double   Taxes_O3_CY1 {get ; set ;}
        @AuraEnabled public  double   Taxes_O4_CY1 {get ; set ;}
        @AuraEnabled public  double   Taxes_O5_CY1 {get ; set ;}
        @AuraEnabled public  double   Taxes_O1_CY2 {get ; set ;}
        @AuraEnabled public  double   Taxes_O2_CY2 {get ; set ;}
        @AuraEnabled public  double   Taxes_O3_CY2 {get ; set ;}
        @AuraEnabled public  double   Taxes_O4_CY2 {get ; set ;}
        @AuraEnabled public  double   Taxes_O5_CY2 {get ; set ;}
        @AuraEnabled public  double   Taxes_O1_CY3 {get ; set ;}
        @AuraEnabled public  double   Taxes_O2_CY3 {get ; set ;}
        @AuraEnabled public  double   Taxes_O3_CY3 {get ; set ;}
        @AuraEnabled public  double   Taxes_O4_CY3 {get ; set ;}
        @AuraEnabled public  double   Taxes_O5_CY3 {get ; set ;}
        
        @AuraEnabled public  double   RETaxes_O1_CY {get ; set ;}
        @AuraEnabled public  double   RETaxes_O2_CY {get ; set ;}
        @AuraEnabled public  double   RETaxes_O3_CY {get ; set ;}
        @AuraEnabled public  double   RETaxes_O4_CY {get ; set ;}
        @AuraEnabled public  double   RETaxes_O5_CY {get ; set ;}
        @AuraEnabled public  double   RETaxes_O1_CY1 {get ; set ;}
        @AuraEnabled public  double   RETaxes_O2_CY1 {get ; set ;}
        @AuraEnabled public  double   RETaxes_O3_CY1 {get ; set ;}
        @AuraEnabled public  double   RETaxes_O4_CY1 {get ; set ;}
        @AuraEnabled public  double   RETaxes_O5_CY1 {get ; set ;}
        @AuraEnabled public  double   RETaxes_O1_CY2 {get ; set ;}
        @AuraEnabled public  double   RETaxes_O2_CY2 {get ; set ;}
        @AuraEnabled public  double   RETaxes_O3_CY2 {get ; set ;}
        @AuraEnabled public  double   RETaxes_O4_CY2 {get ; set ;}
        @AuraEnabled public  double   RETaxes_O5_CY2 {get ; set ;}
        @AuraEnabled public  double   RETaxes_O1_CY3 {get ; set ;}
        @AuraEnabled public  double   RETaxes_O2_CY3 {get ; set ;}
        @AuraEnabled public  double   RETaxes_O3_CY3 {get ; set ;}
        @AuraEnabled public  double   RETaxes_O4_CY3 {get ; set ;}
        @AuraEnabled public  double   RETaxes_O5_CY3 {get ; set ;}
        
        @AuraEnabled public  double   Living_Expenses_O1_CY {get ; set ;}
        @AuraEnabled public  double   Living_Expenses_O2_CY {get ; set ;}
        @AuraEnabled public  double   Living_Expenses_O3_CY {get ; set ;}
        @AuraEnabled public  double   Living_Expenses_O4_CY {get ; set ;}
        @AuraEnabled public  double   Living_Expenses_O5_CY {get ; set ;}
        @AuraEnabled public  double   Living_Expenses_O1_CY1 {get ; set ;}
        @AuraEnabled public  double   Living_Expenses_O2_CY1 {get ; set ;}
        @AuraEnabled public  double   Living_Expenses_O3_CY1 {get ; set ;}
        @AuraEnabled public  double   Living_Expenses_O4_CY1 {get ; set ;}
        @AuraEnabled public  double   Living_Expenses_O5_CY1 {get ; set ;}
        @AuraEnabled public  double   Living_Expenses_O1_CY2 {get ; set ;}
        @AuraEnabled public  double   Living_Expenses_O2_CY2 {get ; set ;}
        @AuraEnabled public  double   Living_Expenses_O3_CY2 {get ; set ;}
        @AuraEnabled public  double   Living_Expenses_O4_CY2 {get ; set ;}
        @AuraEnabled public  double   Living_Expenses_O5_CY2 {get ; set ;}
        @AuraEnabled public  double   Living_Expenses_O1_CY3 {get ; set ;}
        @AuraEnabled public  double   Living_Expenses_O2_CY3 {get ; set ;}
        @AuraEnabled public  double   Living_Expenses_O3_CY3 {get ; set ;}
        @AuraEnabled public  double   Living_Expenses_O4_CY3 {get ; set ;}
        @AuraEnabled public  double   Living_Expenses_O5_CY3 {get ; set ;}
        
        @AuraEnabled public  double   Total_Taxes_O1_CY {get ; set ;}
        @AuraEnabled public  double   Total_Taxes_O2_CY {get ; set ;}
        @AuraEnabled public  double   Total_Taxes_O3_CY {get ; set ;}
        @AuraEnabled public  double   Total_Taxes_O4_CY {get ; set ;}
        @AuraEnabled public  double   Total_Taxes_O5_CY {get ; set ;}
        @AuraEnabled public  double   Total_Taxes_O1_CY1 {get ; set ;}
        @AuraEnabled public  double   Total_Taxes_O2_CY1 {get ; set ;}
        @AuraEnabled public  double   Total_Taxes_O3_CY1 {get ; set ;}
        @AuraEnabled public  double   Total_Taxes_O4_CY1 {get ; set ;}
        @AuraEnabled public  double   Total_Taxes_O5_CY1 {get ; set ;}
        @AuraEnabled public  double   Total_Taxes_O1_CY2 {get ; set ;}
        @AuraEnabled public  double   Total_Taxes_O2_CY2 {get ; set ;}
        @AuraEnabled public  double   Total_Taxes_O3_CY2 {get ; set ;}
        @AuraEnabled public  double   Total_Taxes_O4_CY2 {get ; set ;}
        @AuraEnabled public  double   Total_Taxes_O5_CY2 {get ; set ;}
        @AuraEnabled public  double   Total_Taxes_O1_CY3 {get ; set ;}
        @AuraEnabled public  double   Total_Taxes_O2_CY3 {get ; set ;}
        @AuraEnabled public  double   Total_Taxes_O3_CY3 {get ; set ;}
        @AuraEnabled public  double   Total_Taxes_O4_CY3 {get ; set ;}
        @AuraEnabled public  double   Total_Taxes_O5_CY3 {get ; set ;}
        
         
         
         

        
        //=========================Lead Records===============================================
        @AuraEnabled public string loanType{ get ; set ; } 
        @AuraEnabled public String leadId{ get ; set ; }
        @AuraEnabled public String businessId{ get ; set ; }
        @AuraEnabled public Double Requested_Amount{ get ; set ; }
        @AuraEnabled public String Business_Start_Date{ get ; set ; }
        @AuraEnabled public Double termInMonthAdjusted{ get ; set ; }
        @AuraEnabled public String Application_ID {get ; set ;}
        @AuraEnabled public String Referral_Partner {get ; set ;}
        @AuraEnabled public String Lendistry_Sales_Rep {get ; set ;}
        //============================Response Data============================================
        @AuraEnabled public Double totalCY{ get ; set ; }
    }  
    
}