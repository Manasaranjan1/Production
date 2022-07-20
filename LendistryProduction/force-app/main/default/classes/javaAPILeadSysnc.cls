public class javaAPILeadSysnc{
    public class MainWrapper{
        public List<LeadWrapper> listOfLeadData;
        public MainWrapper(){
            listOfLeadData = new List<LeadWrapper>();
        }
    }
    
    public class LeadWrapper{
        public double eidlAmountRcvd;
        public double pppAmountRcvd;
        public string isPPPLoanForgiven;
        public string isOutstandingLiens;
        public string  isBankruptsyFiled;
        //======================NYG====================
        public string TenantReferralPartnerName;
        public string PreferredLanguage;
        public string Annual_Gross_Receipts_for_2019;
        public string Was_Your_Business_Profitable_In_2019;
        //======================PA CARES Fields==============================================        
        public string businessAddress2;
        public string countyBusiness;
        public integer numberOfFullTimeEmployees ;
        public integer numberOfPartTimeEmployees ;
        //public long annualGrossRevenue ;
        public integer numberOfJobRetained ;
        public boolean isSmsAllowed ;
        public integer NAICSCode;
        public string businessTypeName ;
        public string businessStateAbbreviation ;
        public boolean isCreateJobs;
        public integer noofJobsCreated ;
        
        // public string Purposeofloan;
        //public string Other;
        //public string  Rural;
        //public string  Franchise;
        public string LoanType;
        
        //======================PA CARES Block End===========================================
        public  String Application_Id;
        public Integer of_Current_Employees;
        public String Business_Id;//BusinessId__c
        public String LeadStatus;
        public String salesforceUserId ;
        public String referredBySalesUserId;
        public String referredBy; 
        public Boolean WomenOwnedBusiness;
        public Boolean Willthisloancreatemorejobs;
        public String Whoisyourcustomerbase;        
        public String WhattypeofBusinessisit;
        public String Whatdoesyourbusinessdo;
        public Boolean Veteran;
        public String rangeValue;
        public String useOfFunding; //Use_of_Funds__c
        public String TellusMore;
        public String Stateofincopration;//State_of_incopration__c      
        public  long SBALoanNumber;//SBSS_SCORE__c
        public long SBAApplicationNumber; //SBA_Application_Approval__c
        public String ReferralPartner;//Referral_Partner1__c
        public String Race;
        public String Purposeofloan;
        public String PhonrNumber;     
        public decimal personalCashBalance;
        public String ownerEmailAddress;
        public String Other;
        public integer ofemployeesasof2_15_2020; //of_employees_as_of_2_15_2020__c
        public decimal ofemployeesasof12_31_19;
        public Integer of_Jobs_Retained;//State_of_incopration__c
        public Integer of_Jobs_Created_30th_June;       
        public  double netWorth;
        public String LeadId;
        public String LastName;
        public Boolean IsTheUnitedStatesThePrincipalPlaceOfResidenceForAllEmployees;//Is_the_US_Principal_place_of_residence__c
        public Boolean arethemajorityownesofthebusinessUSCitizensorLegalPermanentResidents;
        public String isBusinessDebtSettled;
        public Boolean HaveyousubmittedaloanrequersttoSBAoranyotheragencyorfinancialinstutiontinconnectionwithCovid_19;  //Submit_loan_req_SBAfinancial_COVID19__c   
        public  Boolean Haveyouexhuautedallpersonalnon_SBAfinanciangoptoins; //exhausted_personal_nonSBA_financing__c
        public Boolean Haveyoueverdefaultedonagovernmentloan_includedSBAloan_Studentloan_etc;//Have_you_ever_defaulted_on_a_govt_loan__c
        public Boolean Haveyoueverbeenconvictedofacrime; //Have_you_ever_been_convicted_of_a_crime__c
        public Boolean Franchise; 
        public String FirstName;
        public String federalTaxId;     
        public  String Ethnicity;
        public String Email; //
        public Boolean DoyourentORownbusinessspace;//
        public Boolean Doyouhaveataxlienoftaxesdue;
        public Boolean DoestheBusinesshaveexistingSBADebt;
        // added by saurabh kumar on 22 Jan 2021
        Public String Have_you_had_a_25_revenue_drop_between;
        Public String  Who_originated_your_PPP_loan;
        Public String Did_you_obtain_a_PPP_loan_in_2020;
        Public String  Did_you_receive_a_Shuttered_Venue_Operat;
        public String PPP_First_Draw_SBA_Loan_Number;
        public Decimal PPP_First_Draw_Loan_Amount;
        public Decimal Period_2_Revenue;
        public String Last_Years_Period;
        public String Proof_of_25_revenue_drop_2020 ;
        public Decimal Period_1_Revenue;
        public String Refinance_of_Eligible_Economic_Injury_Di;
        public String Economic_Injury_Disaster_Loan_Number;
        //END//
        public Boolean Disabled;        
        public String  dbaName;
        public decimal CurrentSBAEconomicDisasterInjuryLoanBalance;//Curr_SBA_Econ_Disaster_Injury_Loan_Bal__c
        public String County;
        public  String  corporateName; //of_employees_as_of_2_15_2020__c
        public String  contactPosition;
        public decimal contactPhone;//State_of_incopration__c
        public String  contactLastName;     
        public  String contactFirstName;
        public String contactEmail;//BusinessId__c
        public String BusinessWebAdress;
        public String BusinessType;
        
        public String BusinessStartDate;      
        public  String BusinessName;
        public String BusinessEIN;
        public String BuinessZip;
        public String BuinessState; //Use_of_Funds__c
        public String BuinessCity;
        public String BuinessAddress;//State_of_incopration__c      
        public Integer Average_Monthly_Payroll;//SBSS_SCORE__c
        public Boolean Arethereanylegalactionspendingagainstyou_oryourspouse; //Legal_action_pending_against_youspouse__c
        public Integer AnnualPayrollCost;//X2019_Annual_Payroll_Cost__c
        public decimal AnnualGrossRevenue;//X2019_Annual_Gross_Revenue__c
        public double AmountRequested; // Requested_Amount__c
        public decimal AmountofrentORmtg; //Monthly_Rent_Mtg__c 
        public String Rural;  
        public String ScholarAlumini;       
        public String DoFiftyPercentEmployeeEarnLessThan; 
        //====================================New fields Added By Boddh SFDC====================================
        public boolean areYouDelinquentOnChildSupport;
        public boolean businesstaxliensfromIRSorState;
        public boolean convictedOfacrimeinPast6months;
        public string didYouTakeoutPPPoraEIDLLoan;
        public boolean doYouownaRealeState;
        public string crimeConvictionRange;
        //public string SalesforceUserID;
        
        //public String ScholarAlumini;
        public Boolean HaveYouEverDefaultedOnGovernmentLoan;
        public Boolean DoYouHaveTaxLien;
        public Boolean AreThereAnyLegalActionPendingAgainstYou;
        public double whatIsTheValueOfYourPersonalAsset;
        public string timeAtAddress;
        
        Public double Owner1RentAmount;
        Public double Owner2RentAmount;
        Public double Owner3RentAmount;
        Public double Owner4RentAmount;
        Public double Owner5RentAmount;
        Public Boolean ExhaustedPersonalAndNonSBAFinancing;
        Public Double CurrentOutstandingBalanceForTaxLienOrTaxesDue;
        Public Double MonthlyPaymentForTaxLienOrTaxesDue;
        Public Double CurrentOutstandingBalanceForBusinessTaxLienOrTaxesDue;
        Public Double MonthlyPaymentForBusinessTaxLienOrTaxesDue ;
        
        public String NumberOfEmployees;
        public String of_employees_added_in_next_12_months;
        public string of_customer_served_monthly;
        public Boolean is_home_owner;
        public string net_worth;
        public string referralPartnerEmail;
        public string leadType;
        public String networkSelection;
        
        // fields added by Saurabh
        public String BusinessNonProfitStatus;
        public String BusinessTopFourPriorities;
        public String SBA_PPP_Loan_Application_Form;
        public String Tax_Year_Used;
        //END
        //====================================New fields Added By Boddh SFDC====================================
        public List<ownerWrapper> listOfOwnersData;
        public String  howDidYouHearAboutUs;
        public String  businessStageName;
        public String  businessBoroughName;
        public String  locationTypeName;
        public Integer  numberOfTempFullTimeEmployees;
        public Integer  numberOfTempPartTimeEmployees;
        public LeadWrapper(){
            listOfOwnersData = new List<ownerWrapper>();
        }
        
    }
    public class ownerWrapper{
        public string ownerHomeAddress2;
        public string owner_home_address2;
        public string ownerCounty;
        public Boolean RunCreditReport;//BusinessId__c
        public String ownerCity;
        public String ownerCellChone_no;
        public String Owner_zipcode;
        public String owner_title;      
        public  String owner_state;
        public String owner_SSN;
        
        public String Owner_Rent;//Owner_Rent_1__c
        public String Owner_Phone;
        public decimal owner_percentage;
        public String owner_last_name;
        public String owner_home_address;       
        public  String owner_first_name;
        public String owner_email;
        
        public String owner_dob;//Owner_Rent_1__c
        public String Owner_Country;
        public String Owner_Id;
        public String LeadId;
        public String PrimaryOwnerId;       
        public  boolean isPrimaryContact;
        public String CreditScorefromWebform; //Credit_Score__c
       
    }
}