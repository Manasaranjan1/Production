public class JSON2ApexOppUpdateApi {


    //======================NYG====================
    public string TenantReferralPartnerName;
    public string PreferredLanguage;
    public string Annual_Gross_Receipts_for_2019;
    public string Was_Your_Business_Profitable_In_2019;
    //======================NYG====================
    //====================Lendistry Lending ==========
    public String number_of_employees;
    public double eidlAmountRcvd;
    public double pppAmountRcvd;
    public string isPPPLoanForgiven;
    public string isOutstandingLiens;
    public string isBankruptsyFiled;
    public boolean Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins;
    public boolean DoestheBusinesshaveexistingSBADebt;
    //====================Lendistry Lending ==========
    public String Projected_Close_Date {get;set;}
    public String previous_loan{get;set;} 
    public Double Origination_Fee {get;set;} 
    public Double Partner_Referral_Fee {get;set;} 
    public String of_customer_served_monthly {get;set;} 
    public String of_employees_added_in_next_12_months {get;set;} 
    public String Decline_Withdrawn_Reason {get;set;} 
    public String Status {get;set;} 
    public Integer Interest_Rate {get;set;} 
    public Integer Term {get;set;} 
    public Integer Final_Loan_Amount {get;set;} 
    public String OpportunityID {get;set;} 
    public String ApplicationID {get;set;} 
    public String Stage {get;set;} 
    public String SalesforceUserID {get;set;} 
    public String BusinessID {get;set;} 
    public String Owner_Address1 {get;set;} 
    public String Owner_Address2 {get;set;} 
    public String City_Owner_1 {get;set;} 
    public String State_Owner_1 {get;set;} 
    public String Zip_Code_Owner_1 {get;set;} 
    public String Owner_County {get;set;} 
    public String DOB_Owner_1 {get;set;} 
    public String per_of_Ownership {get;set;} 
    public String SSN1 {get;set;} 
    public String ownerFirstName {get;set;} 
    public String ownerLastName {get;set;} 
    public String ownerEmailAddress {get;set;} 
    public string howDidYouHearAboutUs{get;set;}
    public string businessStageName{get;set;}
    public string businessBoroughName{get;set;}
    public string locationTypeName{get;set;}
    public string numberOfTempFullTimeEmployees{get;set;}
    public string numberOfTempPartTimeEmployees{get;set;}
    public String ownerCellPhone {get;set;} 
    public String ownerAddress {get;set;} 
    public String business_name {get;set;} 
    public String DBA {get;set;} 
    public String BusinessEIN {get;set;} 
    public String BusinessPhone {get;set;} 
    public String Entity_Type {get;set;} 
    public String State_of_incopration {get;set;} 
    public String Address2_Business {get;set;} 
    public String Address_Business {get;set;} 
    public String business_PostalCode {get;set;} 
    public String business_county {get;set;} 
    public String businessState {get;set;} 
    public String businessCity {get;set;} 
    public String BusinessStartDate {get;set;} 
    public String Website {get;set;} 
    public String Purpose_of_Grant {get;set;}
    public String Purpose_of_Grant_other {get;set;} 
    public Double Requested_Amount {get;set;} 
    public String Will_this_Loan_create_more_Jobs {get;set;} 
    public Integer AnnualRevenue1 {get;set;} 
    public Integer Number_of_Full_Time_Employees {get;set;} 
    public Integer Number_of_Part_Time_Employees {get;set;} 
    public Integer of_Jobs_Created {get;set;} 
    public Integer of_Jobs_Retained {get;set;} 
    public String Who_is_Your_Customer_Base1 {get;set;} 
    public String What_does_your_Business_do {get;set;} 
    public String What_type_of_Business_is_it {get;set;} 
    public String Tell_us_more {get;set;} 
    public String NAICS_CODE {get;set;} 
    public String Women_Owned {get;set;} 
    public String Veteran {get;set;} 
    public String Disabled {get;set;} 
    public String Race {get;set;} 
    public String Ethnicity {get;set;} 
    public String Franchise {get;set;} 
    public String Rural {get;set;} 
    public string referralPartnerEmail {get;set;}
    public string leadType {get;set;}
    public String BusinessNonProfitStatus {get;set;}
    public String BusinessTopFourPriorities {get;set;}
 // added by saurabh kumar on 22 Jan 2021
    Public String Have_you_had_a_25_revenue_drop_between;
    Public String  Who_originated_your_PPP_loan;
    Public String Did_you_obtain_a_PPP_loan_in_2020;
    Public String  Did_you_receive_a_Shuttered_Venue_Operat;
    public String PPP_First_Draw_SBA_Loan_Number;
    public Decimal PPP_First_Draw_Loan_Amount;
    //END//
 // added b saurabh Kumar3 on 25 jan2021 
    public Decimal Period_2_Revenue;
    public String Last_Years_Period;
    public String Proof_of_25_revenue_drop_2020 ;
    public Decimal Period_1_Revenue;
    public String Refinance_of_Eligible_Economic_Injury_Di;
    public String Economic_Injury_Disaster_Loan_Number;
    public String SBA_PPP_Loan_Application_Form {get;set;}
    public String Tax_Year_Used {get;set;}
    public decimal CurrentSBAEconomicDisasterInjuryLoanBalance{get;set;}
    //END//

    public JSON2ApexOppUpdateApi(JSONParser parser) {
        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == 'Period_2_Revenue') {
                        Period_2_Revenue = parser.getDoubleValue();
                    } else if (text == 'Last_Years_Period') {
                        Last_Years_Period = parser.getText();
                    }else if (text == 'Proof_of_25_revenue_drop_2020') {
                        Proof_of_25_revenue_drop_2020  = parser.getText();
                    }else if (text == 'Period_1_Revenue') {
                        Period_1_Revenue = parser.getDoubleValue();
                    }else if (text == 'Refinance_of_Eligible_Economic_Injury_Di') {
                        Refinance_of_Eligible_Economic_Injury_Di = parser.getText();
                    }else if (text == 'Economic_Injury_Disaster_Loan_Number') {
                        Economic_Injury_Disaster_Loan_Number = parser.getText();
                    }
                    else if (text == 'number_of_employees') {
                        number_of_employees = parser.getText();
                    }
                    
                    else if (text == 'Origination_Fee') {
                        Origination_Fee = parser.getDoubleValue();
                    } else if (text == 'Partner_Referral_Fee') {
                        Partner_Referral_Fee = parser.getDoubleValue();
                    } else if (text == 'of_customer_served_monthly') {
                        of_customer_served_monthly = parser.getText();
                    } else if (text == 'of_employees_added_in_next_12_months') {
                        of_employees_added_in_next_12_months = parser.getText();
                    } else if (text == 'Decline_Withdrawn_Reason') {
                        Decline_Withdrawn_Reason = parser.getText();
                    } else if (text == 'Status') {
                        Status = parser.getText();
                    } else if (text == 'Interest_Rate') {
                        Interest_Rate = parser.getIntegerValue();
                    } else if (text == 'Term') {
                        Term = parser.getIntegerValue();
                    } else if (text == 'Final_Loan_Amount') {
                        Final_Loan_Amount = parser.getIntegerValue();
                    } else if (text == 'OpportunityID') {
                        OpportunityID = parser.getText();
                    } else if (text == 'ApplicationID') {
                        ApplicationID = parser.getText();
                    } else if (text == 'Stage') {
                        Stage = parser.getText();
                    } else if (text == 'SalesforceUserID') {
                        SalesforceUserID = parser.getText();
                    } else if (text == 'BusinessID') {
                        BusinessID = parser.getText();
                    } else if (text == 'Owner_Address1') {
                        Owner_Address1 = parser.getText();
                    } else if (text == 'Owner_Address2') {
                        Owner_Address2 = parser.getText();
                    } else if (text == 'City_Owner_1') {
                        City_Owner_1 = parser.getText();
                    } else if (text == 'State_Owner_1') {
                        State_Owner_1 = parser.getText();
                    } else if (text == 'Zip_Code_Owner_1') {
                        Zip_Code_Owner_1 = parser.getText();
                    } else if (text == 'Owner_County') {
                        Owner_County = parser.getText();
                    } else if (text == 'DOB_Owner_1') {
                        DOB_Owner_1 = parser.getText();
                    } else if (text == 'per_of_Ownership') {
                        per_of_Ownership = parser.getText();
                    } else if (text == 'SSN1') {
                        SSN1 = parser.getText();
                    } else if (text == 'ownerFirstName') {
                        ownerFirstName = parser.getText();
                    } else if (text == 'ownerLastName') {
                        ownerLastName = parser.getText();
                    } else if (text == 'ownerEmailAddress') {
                        ownerEmailAddress = parser.getText();
                    }else if (text == 'howDidYouHearAboutUs') {
                        howDidYouHearAboutUs = parser.getText();
                    }else if (text == 'businessStageName') {
                        businessStageName = parser.getText();
                    }else if (text == 'businessBoroughName') {
                        businessBoroughName = parser.getText();
                    }else if (text == 'locationTypeName') {
                        locationTypeName = parser.getText();
                    }else if (text == 'numberOfTempFullTimeEmployees') {
                        numberOfTempFullTimeEmployees = parser.getText();
                    }else if (text == 'numberOfTempPartTimeEmployees') {
                        numberOfTempPartTimeEmployees = parser.getText();
                    }
                     else if (text == 'ownerCellPhone') {
                        ownerCellPhone = parser.getText();
                    } else if (text == 'ownerAddress') {
                        ownerAddress = parser.getText();
                    } else if (text == 'business_name') {
                        business_name = parser.getText();
                    } else if (text == 'DBA') {
                        DBA = parser.getText();
                    } else if (text == 'BusinessEIN') {
                        BusinessEIN = parser.getText();
                    } else if (text == 'BusinessPhone') {
                        BusinessPhone = parser.getText();
                    } else if (text == 'Entity_Type') {
                        Entity_Type = parser.getText();
                    } else if (text == 'State_of_incopration') {
                        State_of_incopration = parser.getText();
                    } else if (text == 'Address2_Business') {
                        Address2_Business = parser.getText();
                    } else if (text == 'Address_Business') {
                        Address_Business = parser.getText();
                    } else if (text == 'business_county') {
                        business_county = parser.getText();
                    } else if (text == 'businessState') {
                        businessState = parser.getText();
                    } else if (text == 'businessCity') {
                        businessCity = parser.getText();
                    }
                    else if (text == 'business_PostalCode') {
                        business_PostalCode = parser.getText();
                    }
                    else if (text == 'BusinessStartDate') {
                        BusinessStartDate = parser.getText();
                    } 
                    else if (text == 'Projected_Close_Date') {
                        Projected_Close_Date = parser.getText();
                    } 
                    
                    else if (text == 'Website') {
                        Website = parser.getText();
                    } else if (text == 'Purpose_of_Grant') {
                        Purpose_of_Grant = parser.getText();
                    }
                    else if (text == 'Purpose_of_Grant_other') {
                        Purpose_of_Grant_other = parser.getText();
                    } else if (text == 'Requested_Amount') {
                        Requested_Amount = parser.getDoubleValue();
                    } else if (text == 'Will_this_Loan_create_more_Jobs') {
                        Will_this_Loan_create_more_Jobs = parser.getText();
                    } else if (text == 'AnnualRevenue1') {
                        AnnualRevenue1 = parser.getIntegerValue();
                    } else if (text == 'Number_of_Full_Time_Employees') {
                        Number_of_Full_Time_Employees = parser.getIntegerValue();
                    } else if (text == 'Number_of_Part_Time_Employees') {
                        Number_of_Part_Time_Employees = parser.getIntegerValue();
                    } else if (text == 'of_Jobs_Created') {
                        of_Jobs_Created = parser.getIntegerValue();
                    } else if (text == 'of_Jobs_Retained') {
                        of_Jobs_Retained = parser.getIntegerValue();
                    } else if (text == 'Who_is_Your_Customer_Base1') {
                        Who_is_Your_Customer_Base1 = parser.getText();
                    } else if (text == 'What_does_your_Business_do') {
                        What_does_your_Business_do = parser.getText();
                    } else if (text == 'What_type_of_Business_is_it') {
                        What_type_of_Business_is_it = parser.getText();
                    } else if (text == 'Tell_us_more') {
                        Tell_us_more = parser.getText();
                    } else if (text == 'NAICS_CODE') {
                        NAICS_CODE = parser.getText();
                    } else if (text == 'Women_Owned') {
                        Women_Owned = parser.getText();
                    } else if (text == 'Veteran') {
                        Veteran = parser.getText();
                    } else if (text == 'Disabled') {
                        Disabled = parser.getText();
                    } else if (text == 'Race') {
                        Race = parser.getText();
                    } else if (text == 'Ethnicity') {
                        Ethnicity = parser.getText();
                    } else if (text == 'Franchise') {
                        Franchise = parser.getText();
                    } else if (text == 'Rural') {
                        Rural = parser.getText();
                    } 
                    else if (text == 'referralPartnerEmail') {
                        referralPartnerEmail = parser.getText();
                    } else if (text == 'leadType') {
                        leadType = parser.getText();
                    } else if (text == 'BusinessNonProfitStatus') {
                        BusinessNonProfitStatus = parser.getText();
                    } else if (text == 'BusinessTopFourPriorities') {
                        BusinessTopFourPriorities = parser.getText();
                    }
                    else if (text == 'Have_you_had_a_25_revenue_drop_between') {
                        Have_you_had_a_25_revenue_drop_between = parser.getText();
                    }
                    else if (text == 'Who_originated_your_PPP_loan') {
                        Who_originated_your_PPP_loan = parser.getText();
                    }
                    else if (text == 'Did_you_obtain_a_PPP_loan_in_2020') {
                        Did_you_obtain_a_PPP_loan_in_2020 = parser.getText();
                    }
                    else if (text == 'previous_loan') {
                        previous_loan= parser.getText();
                    }
                    else if (text == 'Did_you_receive_a_Shuttered_Venue_Operat') {
                        Did_you_receive_a_Shuttered_Venue_Operat = parser.getText();
                    }
                    else if (text == 'PPP_First_Draw_SBA_Loan_Number') {
                        PPP_First_Draw_SBA_Loan_Number= parser.getText();
                    }
                    else if (text == 'PPP_First_Draw_Loan_Amount') {
                        PPP_First_Draw_Loan_Amount = Decimal.valueOf(parser.getText());
                    } else if (text == 'SBA_PPP_Loan_Application_Form') {
                        SBA_PPP_Loan_Application_Form = parser.getText();
                    } else if (text == 'Tax_Year_Used') {
                        Tax_Year_Used = parser.getText();
                    } else if (text == 'CurrentSBAEconomicDisasterInjuryLoanBalance') {
                        CurrentSBAEconomicDisasterInjuryLoanBalance = parser.getDoubleValue();
                    }
                    else if (text == 'TenantReferralPartnerName') {
                        TenantReferralPartnerName = parser.getText();
                    }
                    else if (text == 'PreferredLanguage') {
                        PreferredLanguage= parser.getText();
                    }
                    else if (text == 'isPPPLoanForgiven') {
                        isPPPLoanForgiven= parser.getText();
                    }
                    else if (text == 'isOutstandingLiens') {
                        isOutstandingLiens= parser.getText();
                    }
                    else if (text == 'Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins') {
                            Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins = Boolean.valueOf(parser.getText());  
                    }
                    else if (text == 'DoestheBusinesshaveexistingSBADebt') {
                        DoestheBusinesshaveexistingSBADebt = Boolean.valueOf(parser.getText());
                    }
                    else if (text == 'isBankruptsyFiled') {
                        isBankruptsyFiled= parser.getText();
                    }
                     else if (text == 'eidlAmountRcvd') {
                        eidlAmountRcvd = parser.getDoubleValue();
                    } 
                     else if (text == 'pppAmountRcvd') {
                        pppAmountRcvd = parser.getDoubleValue();
                    } 
                    else {
                        System.debug(LoggingLevel.WARN, 'JSON2ApexOppUpdateApi consuming unrecognized property: '+text);
                        consumeObject(parser);
                    }
                }
            }
        }
    }
    
    public static JSON2ApexOppUpdateApi parse(String json) {
        System.JSONParser parser = System.JSON.createParser(json);
        return new JSON2ApexOppUpdateApi(parser);
    }
    
    public static void consumeObject(System.JSONParser parser) {
        Integer depth = 0;
        do {
            System.JSONToken curr = parser.getCurrentToken();
            if (curr == System.JSONToken.START_OBJECT || 
                curr == System.JSONToken.START_ARRAY) {
                depth++;
            } else if (curr == System.JSONToken.END_OBJECT ||
                curr == System.JSONToken.END_ARRAY) {
                depth--;
            }
        } while (depth > 0 && parser.nextToken() != null);
    }
    
}