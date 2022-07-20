public class JSON2ApexSBAPPP {

    public class OwnerInfoWrap {
        public String OwnerNumber;
        public String OwnerID;
        public String OwnerFirstName;
        public String OwnerLastName;
        public String OwnerEmail;
        public String OwnerPhone;
        public String OwnerStreet;
        public String OwnerCity;
        public String OwnerState;
        public String OwnerZipcode;
        public String OwnerCountry;
        public String OwnerSSN;
        
    }
	
	public String RecordTypeID;
	public String ApplicationID;
	public String BusinessID;
	public String ReferralPartner;
	public String Company;
	public String DBA;
	public Integer BusinessEIN;
	public String BusinessPhone;
	public String BusinessType;
	public String StateOfIncorporation;
	public String BusinessStreet;
	public String BusinessCity;
	public String BusinessState;
	public String BusinessZipCode;
	public String BusinessCountry;
	public String BusinessStartDate;
	public String BusinessWebsite;
	public Boolean DoYouRentOwnBusinessSpace;
	public Decimal MonthlyRentMtg;
	public String WhoIsYourCustomerBase;
	public String WhatDoesYourBusinessDo;
	public String WhatTypeOfBusinessIsIt;
	public String TellUsMore;
	public String NAICSCode;
	public String PurposeOfTheLoan;
	public String Other;
	public decimal RequestedAmount;
	public Boolean WillThisLoanCreateMoreJobs;
	public decimal NoOfCurrentEmployees;
	public decimal NoOfJobsCreated;
	public decimal NoOfJobsRetained;
	public decimal AverageMonthlyPayroll;
	public Boolean WomenOwned;
	public Boolean Veteran;
	public Boolean Disabled;
	public String Race;
	public String Ethnicity;
	public Boolean Franchise;
	public decimal CurrentSBAEconomicDisasterInjuryLoanBalance;
	public String Rural;
	public String ScholarAlumini;
	public String DoFiftyPercentEmployeeEarnLessThan;
	public Boolean HaveYouEverBeenConvictedOfCrime;
	public Boolean AreThereAnyLegalActionPendingAgainstYou;
	public Boolean DoYouHaveTaxLien;
	public Boolean HaveYouExhausedAllPersonalFinancingOption;
	public Boolean HaveYouEverDefaultedOnGovernmentLoan;
	public Boolean IsTheUSPrincipalPlaceOfResidenceOfAllEmployees;
	public Boolean DoesBusinessHaveExistingSBADebt;
	public Boolean HaveYouSubmittedLoanRequestInConnectionWithCOVID19;
    
	public List<OwnerInfoWrap> ownerInfoList;

    
    public static JSON2ApexSBAPPP parse(String json) 
	{
        return (JSON2ApexSBAPPP) System.JSON.deserialize(json, JSON2ApexSBAPPP.class);
    }
}