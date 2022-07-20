@IsTest
public class JSON2ApexSBAPPP_Test {
	
	static testMethod void testParse() {
		String json = '{'+
		'\"RecordTypeID\" : \"abc\",'+
		'\"ApplicationID\" : \"DIR12345\",'+
		'\"BusinessID\" : \"9821\",'+
		'\"ReferralPartner\" : \"ICICI\",'+
		'\"Company\" : \"Test Company\",'+
		'\"DBA\" : \"DBA\",'+
		'\"BusinessEIN\" : 123456,'+
		'\"BusinessPhone\" : \"9876543210\",'+
		'\"BusinessType\" : \"Corporation\",'+
		'\"StateOfIncorporation\" : \"MO\",'+
		'\"BusinessStreet\" : \"220 Locust Ave\",'+
		'\"BusinessCity\" : \"Anthill\",'+
		'\"BusinessState\" : \"MO\",'+
		'\"BusinessZipCode\" : \"65488\",'+
		'\"BusinessCountry\" : \"USA\",'+
		'\"BusinessStartDate\" : \"\",'+
		'\"BusinessWebsite\" : \"www.test.com\",'+
		'\"DoYouRentOwnBusinessSpace\" : true,'+
		'\"MonthlyRentMtg\" : 15000,'+
		'\"WhoIsYourCustomerBase\" : \"B2B\",'+
		'\"WhatDoesYourBusinessDo\" : \"Service Business\",'+
		'\"WhatTypeOfBusinessIsIt\" : \"Insurance/Real Estate\",'+
		'\"TellUsMore\" : \"Independent Insurance Carriers\",'+
		'\"NAICSCode\" : \"123456\",'+
		'\"PurposeOfTheLoan\" : \"Other\",'+
		'\"Other\" : \"Test Other\",'+
		'\"RequestedAmount\" : 50000,'+
		'\"WillThisLoanCreateMoreJobs\" : true,'+
		'\"NoOfCurrentEmployees\" : 10,'+
		'\"NoOfJobsCreated\" : 20,'+
		'\"NoOfJobsRetained\" : 30,'+
		'\"AverageMonthlyPayroll\" : 40,'+
		'\"WomenOwned\" : true,'+
		'\"Veteran\" : true,'+
		'\"Disabled\" : true,'+
		'\"Race\" : \"American Indian\",'+
		'\"Ethnicity\" : \"Hispanic or Latino\",'+
		'\"Franchise\" : false,'+
		'\"CurrentSBAEconomicDisasterInjuryLoanBalance\" : 22000,'+
		'\"Rural\" : \"Yes\",'+
		'\"ScholarAlumini\" : \"Yes\",'+
		'\"DoFiftyPercentEmployeeEarnLessThan\" : \"Yes\",'+
		'\"HaveYouEverBeenConvictedOfCrime\" : true,'+
		'\"AreThereAnyLegalActionPendingAgainstYou\" : false,'+
		'\"DoYouHaveTaxLien\" : true,'+
		'\"HaveYouExhausedAllPersonalFinancingOption\" : false,'+
		'\"HaveYouEverDefaultedOnGovernmentLoan\" : true,'+
		'\"IsTheUSPrincipalPlaceOfResidenceOfAllEmployees\" : false,'+
		'\"DoesBusinessHaveExistingSBADebt\" : true,'+
		'\"HaveYouSubmittedLoanRequestInConnectionWithCOVID19\" : false,'+
		''+
		'\"OwnerInfoWrap\" : ['+
		'{'+
		'\"OwnerNumber\" : \"SBA - PPP\",'+
		'\"OwnerFirstName\" : \"Marisol\",'+
		'\"OwnerLastName\" : \"Testcase\",'+
		'\"OwnerEmail\" : \"Marisol@Yopmail.com\",'+
		'\"OwnerPhone\" : \"9999999999\",'+
		'\"OwnerStreet\" : \"220 Locust Ave\",'+
		'\"OwnerCity\" : \"Anthill\",'+
		'\"OwnerState\" : \"MO\",'+
		'\"OwnerZipcode\" : \"65488\",'+
		'\"OwnerCountry\" : \"USA\",'+
		'\"OwnerSSN\" : \"000000001\"'+
		'}'+
		']'+
		'}';
		JSON2ApexSBAPPP obj = JSON2ApexSBAPPP.parse(json);
		System.assert(obj != null);
	}
}