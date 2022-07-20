public class JSON2Apex {
    
    public class OwnerInfoWrap {
        public String owner_id;
        public String owner_dob;
        public String owner_title;
        public String owner_first_name;
        public String owner_last_name;
        public String ownerCellChone_no;
        public String owner_SSN;
        public String owner_home_address;
        public String ownerCity;
        public String owner_state_id;
        public String Owner_zipcode;
        public String Country;
        public String owner_email;
        public String owner_percentage;
        public String CreditScorefromWebform;
        public String RunCreditReport;
        public Decimal owner_rent;
        public string owner_home_phone_no;
        public String owner_Address2;
        public String owner_County;
    }
    public string TenantReferralPartnerName;
    public string PreferredLanguage;
    public string Annual_Gross_Receipts_for_2019;
    public string Was_Your_Business_Profitable_In_2019;
    public String LeadId;
    public String TIB;
    public String application_id;
    public String federal_taxId;
    public String State_incorporation;
    public String owner_rent;
    public String Ethnicity;
    public String business_start_date;
    public string CampaignSource;
    public String Referral_Id;
    public String FirstName;
    public String LastName;
    public String MobilePhone;
    public String Email;
    public String Company;
    public String BusinessId;
    public String Title;
    public String Description;
    public String Phone;
    public String LeadSource;
    public String Status;
    public String Industry;
    public String Rating;
    public String AnnualRevenue;
    public String NumberOfEmployees;
    public String Website;
    public String Street;
    public String City;
    public String State;
    public String ZipCode;
    public String Country;
    public string is_home_owner;
    public Integer Requested_Amount;
    public String UseofFunds;
    public String ProfitableLast2Years;
    public String TIBMonths;
    public String SalesDecline;
    public String NotInterested;
    public String Homeowner;
    public String MonthlyRentMtg;
    public String BriefHistoryontheowner;
    public String Whatexactlydoesthebusinessdo;
    public String Whoisyourcustomerbase;
    public String DoYouCarryLifeInsurance;
    public String PlannedChangesInNext6Months;
    public String BriefHistoryonthebusiness;
    public String Whatarethetermsofyourcurrentlease;
    public String Whatisthepurposeofloan;
    public String AreyouCOD306090;
    public String Doyoupaychildsupportoralimony;
    public String ExplanationofanyBKsdefaultsetc;
    public string What_does_your_Business_do;
    public string What_type_of_Business_is_it;
    public string Tell_us_more;
    public String of_employees_added_in_next_12_months;
    public string of_customer_served_monthly;
    public String Race ;
    public Boolean Veteran;
    public Boolean Disabled;
    public Boolean Women_Owned ;
    public string net_worth;
    public string What_your_customer_base;
    
    public Integer TenantId;
    public string TenantName;
    public string LoanType;
    public String Address2;
    public String County;
    public Integer NumberofFullTimeEmployees;
    public Integer NumberofPartTimeEmployees;
    public Integer AnnualGrossRevenue;
    public Integer NumberofJobsRetained;
    public string PortalApplicationStatus;
    public Boolean SMSOptIn;
    public string NaicsCode;
    public string DBA;
    public string StateOfIncorporation;
    public string BusinessType;
    public string PurposeOfTheLoan;
    public string Other;
    public Boolean WillThisLoanCreateMoreJobs;
    public Integer NumberOfJobsCreated;
    public Boolean Rural;
    public Boolean Franchise;
    public boolean areYouDelinquentOnChildSupport;
    public boolean businesstaxliensfromIRSorState;
    public boolean convictedOfacrimeinPast6months;
    public string didYouTakeoutPPPoraEIDLLoan;
    public boolean doYouownaRealeState;
    public string crimeConvictionRange;
    public string SalesforceUserID;
    
    public String ScholarAlumini;
    public Boolean HaveYouEverDefaultedOnGovernmentLoan;
    public Boolean DoYouHaveTaxLien;
    public Boolean AreThereAnyLegalActionPendingAgainstYou;
    Public double whatIsTheValueOfYourPersonalAsset;
    Public String timeAtAddress;
    Public double Owner1RentAmount;
    Public double Owner2RentAmount;
    Public double Owner3RentAmount;
    Public double Owner4RentAmount;
    Public double Owner5RentAmount;
    Public Boolean ExhaustedPersonalAndNonSBAFinancing;
    Public Boolean DoestheBusinesshaveexistingSBADebt;
    Public Boolean Haveyoueverbeenconvictedofacrime;
    // added by saurabh kumar on 22 Jan 2021
    Public Boolean Have_you_had_a_25_revenue_drop_between;
    Public String  Who_originated_your_PPP_loan;
    Public Boolean Did_you_obtain_a_PPP_loan_in_2020;
    Public Boolean Did_you_receive_a_Shuttered_Venue_Operat;
    //END//
    // added by saurabh kumar on 25 Jan 2021
    public Decimal Period_2_Revenue;
    public String Last_Years_Period;
    public String Proof_of_25_revenue_drop_2020 ;
    public Decimal Period_1_Revenue;
    public String Refinance_of_Eligible_Economic_Injury_Di;
    public String Economic_Injury_Disaster_Loan_Number;
    //END//
    Public Double CurrentOutstandingBalanceForTaxLienOrTaxesDue;
    Public Double MonthlyPaymentForTaxLienOrTaxesDue;
    Public Double CurrentOutstandingBalanceForBusinessTaxLienOrTaxesDue;
    Public Double MonthlyPaymentForBusinessTaxLienOrTaxesDue;
    
    public String BusinessNonProfitStatus;
    public String BusinessTopFourPriorities;
    public String networkSelection;
    
    // Lendistry Lending New Keys----
    public double eidlAmountRcvd;
    public double pppAmountRcvd;
    public string isPPPLoanForgiven;
    public string isOutstandingLiens;
    public string  isBankruptsyFiled;
    
    public List<OwnerInfoWrap> ownerInfoList;
    public String  howDidYouHearAboutUs;
    public String  businessStageName;
    public String  businessBoroughName;
    public String  locationTypeName;
    public Integer  numberOfTempFullTimeEmployees;
    public Integer  numberOfTempPartTimeEmployees;
    public Boolean Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins;
    //public String DoestheBusinesshaveexistingSBADebt;
    
    public static JSON2Apex parse(String json) {
        return (JSON2Apex) System.JSON.deserialize(json, JSON2Apex.class);
    }
}