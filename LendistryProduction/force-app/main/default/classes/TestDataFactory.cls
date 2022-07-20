/**
* @File Name          : TestDataFactory.cls
* @Description        : This test class is utility test class for Lendistry Org.
* @Author             : Boddh Prakash
* @Group              : 
* @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
* @Last Modified On   : 01/07/2021, 12:45:36 PM
* @Modification Log   : 
* Ver       Date            Author                 Modification
* 1.0    4/13/2020   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
@isTest
public with sharing class TestDataFactory 
{
    /** 
* ********************************************************
* This method is test data for create Lead
* ********************************************************
*/
    
    public static Lead createGrantLead(Boolean doInsert)
    {
        Id recTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('GRANT').getRecordTypeId();
        //  Tenant_Details__c objTenant =[ Select id,Tenant_ID__c,PortalAPIEndPoint__c, Name from Tenant_Details__c Where Tenant_ID__c=1 limit 1];
        Trigger_ON_OFF_Setting__c TOOFS = new Trigger_ON_OFF_Setting__c();
        TOOFS.Name = 'LeadTrigger_Switch1';
        TOOFS.Lead_NonSBA_Method_1__c = true;
        TOOFS.Lead_NonSBA_Method_2__c = true;
        TOOFS.Lead_NonSBA_Method_3__c = true;
        TOOFS.Lead_NonSBA_Method_4__c = true;
        TOOFS.Lead_NonSBA_Method_5__c = true;
        TOOFS.Lead_NonSBA_Method_6__c = true;
        TOOFS.Lead_SBA_Method_1__c = true;
        TOOFS.LeadSBAMethod2__c = true;
        TOOFS.LeadSBAMethod3__c = true;
        TOOFS.LeadSBAMethod4__c = true;
        TOOFS.LeadSBAMethod5__c = true;
        TOOFS.LeadSBAMethod6__c = true;
        TOOFS.LeadTrigger_ON_OFF__c = true;
        
        insert TOOFS;
        
        IntegratioinExecutionOrder__c IEO = new IntegratioinExecutionOrder__c();
        IEO.Name = 'test';
        IEO.B2BMAUSER__c = 'UserId';
        IEO.DevOps1__c = 'UserId';
        IEO.DevOps2__c = 'UserId';
        IEO.DevOps3__c = 'UserId';
        IEO.DevOps4__c = 'UserId';
       // IEO.User_Id_s__c = 'UserId';
        
        insert IEO;
        
        Tenant_Details__c objTenant = new Tenant_Details__c();
        objTenant.PortalAPIEndPoint__c = 'https://stagereplicaapi.mylendistry.com';
        objTenant.Portal_Login_URL__c = 'https://stagereplica.mylendistry.com/login';
        objTenant.Tenant_ID__c =67;
        objTenant.Tenant_URL__c = 'womenopportstage-replica.pacdfinetwork.mylendistry.com';
        objTenant.Tenant_Name__c ='Women’s Opportunity Resource Center';
        objTenant.Referral_Partner__c = 'test';
        insert objTenant;
        
        Lead newLead = new Lead();
        
        newLead.RecordTypeId = recTypeId;
        newLead.Loan_Type__c = 'PA CARES';
        newLead.Tenant_Details__c = objTenant.id;
        newLead.Title = 'Mr.';
        newLead.FirstName = 'FirstName';
        newLead.LastName = 'test';
        newLead.Company = 'Test';
        newLead.DBA__c = 'TestDevOps';
        newLead.Business_EIN__c = '1234567876';
        newLead.Base64_Encoded_Pardot_Url_Parameter__c = 'MDBRMmEwMDAwMDVPbkxGRUEwfHwwMi4wMi4yMDIwIDE5OjAw';
        newLead.Entity_Type__c = 'Corporation';
        newLead.DoNotCall = false;
        newLead.Of_Documents__c = 78;
        newLead.Consideration_Round__c = 'Round 1';
        newLead.Network_Selection__c = 'Declined';
        newLead.Application_ID__c = 'DIR20009322';
        newLead.HasOptedOutOfFax = false;
        newLead.Phone = '(963) 258-7410';
        newLead.pi__Needs_Score_Synced__c = false;
        newLead.pi__pardot_hard_bounced__c = false;
        newLead.Run_Credit_Report__c = false;
        newLead.Run_Owner2_Credit_Report__c = false;
        newLead.Run_Owner3_Credit_Report__c = false;
        newLead.Run_Owner4_Credit_Report__c = false;
        newLead.Run_Owner5_Credit_Report__c = false;
        newLead.Status = 'New';
        newLead.Status_Detail__c = 'New';
        newLead.Unqualified_Reason__c = 'Duplicate';
        newLead.MobilePhone = '9874563210';
        newLead.SMS_Opt_In__c = true;
        newLead.CountyId_Owner__c = 'TestUSA';
        newLead.State_of_incopration__c = 'testCO';
        newLead.Address2_Business__c = 'testbusiness';
        newLead.County__c = 'testcounty';
        newLead.Business_Start_Date__c  = Date.valueof(System.now());
        newLead.Website = 'test.salesforce.com';
        newLead.Purpose_of_Grant__c = 'Group Healthcare';
        newLead.Will_this_grant_create_new_jobs__c = 'Yes';
        newLead.Other__c = 'hjbujvuv';  
        newLead.Number_of_Full_Time_Employees__c = 78;
        newLead.Requested_Amount__c = 78964;
        newLead.of_Jobs_Created__c = 7;
        newLead.Number_of_Part_Time_Employees__c = 8;
        newLead.of_Jobs_Retained__c = 78;
        newLead.Women_Owned__c  = 'Yes';
        newLead.Who_is_Your_Customer_Base1__c = 'B2C';
        newLead.What_does_your_Business_do__c = 'Transportation/Communication';
        newLead.What_type_of_Business_is_it__c = 'Communications';
        newLead.Tell_us_more__c = 'Cable';
        newLead.Franchise__c = 'Yes';
        newLead.Disabled__c = 'No';
        newLead.Ethnicity__c = 'Hispanic or Latino';
        newLead.Rural__c = 'No';
        newLead.Veteran__c = 'No';
        newLead.Race__c = 'Hawaiian Native';
        newLead.Application_ID_SBAPPP__c = 'testsba';
        newLead.Business_ID_SBAPPP__c = 'testbusin';
        newLead.Requested_Application_Edits__c = 'Pending';
        newLead.Portal_Application_Status__c = 'Finished';
        newLead.Business_Phone__c = '7412589630';
        newLead.AnnualRevenue = 12355;
        newLead.Are_you_COD_30_60_90__c = 'tesfg';
        newLead.Brief_History_on_the_business__c = 'tesdgbdavh';
        newLead.Brief_History_on_the_owner_manager__c = 'tevxvvc';
        newLead.Do_You_Carry_Life_Insurance__c = 'Yes';
        newLead.Do_you_have_a_tax_lien_of_taxes_due__c = 'Yes';
        newLead.Do_you_own_a_real_estate__c = 'Yes';
        newLead.Do_you_pay_child_support_or_alimony__c = 'Yes';
        newLead.Do_you_rent_own_business_space__c = 'Yes';
        newLead.Explanation_of_any_BKs_defaults_etc__c = 'hbudcbjhdbc';
        newLead.Homeowner__c = 'Yes';
        newLead.Monthly_Rent_Mtg__c = 7852;
        newLead.Net_Worth__c = 741158;
        newLead.Planned_Changes_In_Next_6_Months__c = 'no change';
        newLead.Use_of_Funds__c = 'Working Capital';
        newLead.What_are_the_terms_of_your_current_lease__c = 'tegtev';
        newLead.What_does_your_Business_do__c = 'Manufacturer';
        newLead.What_exactly_does_the_business_do__c = 'Developer';
        newLead.What_is_the_purpose_of_loan__c = 'testsloan';
        newLead.Who_is_Your_Customer_Base__c = 'tsetsb';
        newLead.Who_is_Your_Customer_Base1__c = 'B2B';
        newLead.Referral_type__c = 'BANK';
                newLead.NACIS_CODE__c = true;

        
        //First Owner Details
        newLead.SSN1__c = '000-00-0001';
        newLead.Street_Owner_1__c='220 Locust Ave';
        newLead.City_Owner_1__c = 'Anthill';
        newLead.State_Owner_1__c='MO';
        newLead.Zip_Code_Owner_1__c='65488';
        newLead.Country_Owner_1__c='US';
        newLead.Email = 'first@gmail.com';
        newLead.Adddress2_Owner__c = 'test';
        newLead.State_of_incopration__c = 'CO';
        
        newLead.of_Ownership_Owner__c = 30;
        newLead.Credit_Score__c = 'under 600'; 
        newLead.Run_Credit_Report__c= true;
        newLead.Owner_ID_Owner_1__c = '123';
        newLead.Credit_Score_5th_Owner_from_Webform__c = 'Over 700';
        newLead.DOB_Owner_1__c = Date.valueof(System.now());
        
        
        if(doInsert){
            insert newLead;
           // System.debug('---------Lead-------->'+newLead);
        }
        return newLead;
    }
    public static Lead createNonGrantLead(Boolean doInsert)
    {
        Id recTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Lendistry Default').getRecordTypeId();
        // Tenant_Details__c objTenant =[ Select id,Tenant_ID__c,PortalAPIEndPoint__c, Name from Tenant_Details__c Where Tenant_ID__c=1 limit 1];
        
        Tenant_Details__c objTenant = new Tenant_Details__c();
        objTenant.PortalAPIEndPoint__c = 'https://stagereplicaapi.mylendistry.com';
        objTenant.Portal_Login_URL__c = 'https://stagereplica.mylendistry.com/login';
        objTenant.Tenant_ID__c =67;
        objTenant.Tenant_URL__c = //'womenopportstage-replica.pacdfinetwork.mylendistry.com';
            objTenant.Tenant_Name__c ='Women’s Opportunity Resource Center';
        objTenant.Referral_Partner__c = 'test';
        insert objTenant;
        
        /**   Trigger_ON_OFF_Setting__c TOOFS = new Trigger_ON_OFF_Setting__c();
TOOFS.Name = 'LeadTrigger_Switch';
TOOFS.Lead_NonSBA_Method_1__c = true;
TOOFS.Lead_NonSBA_Method_2__c = true;
TOOFS.Lead_NonSBA_Method_3__c = true;
TOOFS.Lead_NonSBA_Method_4__c = true;
TOOFS.Lead_NonSBA_Method_5__c = true;
TOOFS.Lead_NonSBA_Method_6__c = true;
TOOFS.Lead_SBA_Method_1__c = true;
TOOFS.LeadSBAMethod2__c = true;
TOOFS.LeadSBAMethod3__c = true;
TOOFS.LeadSBAMethod4__c = true;
TOOFS.LeadSBAMethod5__c = true;
TOOFS.LeadSBAMethod6__c = true;
TOOFS.LeadTrigger_ON_OFF__c = true;

insert TOOFS; **/
        
        IntegratioinExecutionOrder__c IEO = new IntegratioinExecutionOrder__c();
        IEO.Name = 'test';
        IEO.B2BMAUSER__c = 'UserId';
        IEO.DevOps1__c = 'UserId';
        IEO.DevOps2__c = 'UserId';
        IEO.DevOps3__c = 'UserId';
        IEO.DevOps4__c = 'UserId';
        IEO.User_Id_s__c = 'UserId';
        
        insert IEO;
        
        Lead newLead = new Lead() ;
        
        newLead.RecordTypeId = recTypeId;
        newLead.Loan_Type__c = 'PA CARES';
        newLead.Tenant_Details__c = objTenant.id;
        newLead.Title = 'Mr.';
        newLead.FirstName = 'FirstName';
        newLead.LastName = 'test';
        newLead.Company = 'Test';
        newLead.DBA__c = 'TestDevOps';
        newLead.Business_EIN__c = '1234567876';
        newLead.Base64_Encoded_Pardot_Url_Parameter__c = 'MDBRMmEwMDAwMDVPbkxGRUEwfHwwMi4wMi4yMDIwIDE5OjAw';
        newLead.Entity_Type__c = 'Corporation';
        newLead.DoNotCall = false;
        newLead.Of_Documents__c = 78;
        newLead.Consideration_Round__c = 'Round 1';
        newLead.Network_Selection__c = 'Declined';
        newLead.Application_ID__c = 'DIR20009322';
        newLead.HasOptedOutOfFax = false;
        newLead.Phone = '(963) 258-7410';
        newLead.pi__Needs_Score_Synced__c = false;
        newLead.pi__pardot_hard_bounced__c = false;
        newLead.Run_Credit_Report__c = false;
        newLead.Run_Owner2_Credit_Report__c = false;
        newLead.Run_Owner3_Credit_Report__c = false;
        newLead.Run_Owner4_Credit_Report__c = false;
        newLead.Run_Owner5_Credit_Report__c = false;
        newLead.Status = 'New';
        newLead.Status_Detail__c = 'New';
        newLead.Unqualified_Reason__c = 'Duplicate';
        newLead.MobilePhone = '9874563210';
        newLead.SMS_Opt_In__c = true;
        newLead.CountyId_Owner__c = 'TestUSA';
        newLead.State_of_incopration__c = 'testCO';
        newLead.Address2_Business__c = 'testbusiness';
        newLead.County__c = 'testcounty';
        newLead.Business_Start_Date__c  = Date.valueof(System.now());
        newLead.Website = 'test.salesforce.com';
        newLead.Purpose_of_Grant__c = 'Group Healthcare';
        newLead.Will_this_grant_create_new_jobs__c = 'Yes';
        newLead.Other__c = 'hjbujvuv';  
        newLead.Number_of_Full_Time_Employees__c = 78;
        newLead.Requested_Amount__c = 78964;
        newLead.of_Jobs_Created__c = 7;
        newLead.Number_of_Part_Time_Employees__c = 8;
        newLead.of_Jobs_Retained__c = 78;
        newLead.Women_Owned__c  = 'Yes';
        newLead.Who_is_Your_Customer_Base1__c = 'B2C';
        newLead.What_does_your_Business_do__c = 'Transportation/Communication';
        newLead.What_type_of_Business_is_it__c = 'Communications';
        newLead.Tell_us_more__c = 'Cable';
        newLead.Franchise__c = 'Yes';
        newLead.Disabled__c = 'No';
        newLead.Ethnicity__c = 'Hispanic or Latino';
        newLead.Rural__c = 'No';
        newLead.Veteran__c = 'No';
        newLead.Race__c = 'Hawaiian Native';
        newLead.Application_ID_SBAPPP__c = 'testsba';
        newLead.Business_ID_SBAPPP__c = 'testbusin';
        newLead.AnnualRevenue = 12355;
        newLead.Are_you_COD_30_60_90__c = 'tesfg';
        newLead.Brief_History_on_the_business__c = 'tesdgbdavh';
        newLead.Brief_History_on_the_owner_manager__c = 'tevxvvc';
        newLead.Do_You_Carry_Life_Insurance__c = 'Yes';
        newLead.Do_you_have_a_tax_lien_of_taxes_due__c = 'Yes';
        newLead.Do_you_own_a_real_estate__c = 'Yes';
        newLead.Do_you_pay_child_support_or_alimony__c = 'Yes';
        newLead.Do_you_rent_own_business_space__c = 'Yes';
        newLead.Explanation_of_any_BKs_defaults_etc__c = 'hbudcbjhdbc';
        newLead.Homeowner__c = 'Yes';
        newLead.Monthly_Rent_Mtg__c = 7852;
        newLead.Net_Worth__c = 741158;
        newLead.Planned_Changes_In_Next_6_Months__c = 'no change';
        newLead.Use_of_Funds__c = 'Working Capital';
        newLead.What_are_the_terms_of_your_current_lease__c = 'tegbd';
        newLead.What_does_your_Business_do__c = 'Manufacturer';
        newLead.What_exactly_does_the_business_do__c = 'Developer';
        newLead.What_is_the_purpose_of_loan__c = 'testsloan';
        newLead.Who_is_Your_Customer_Base__c = 'tsetsb';
        newLead.Who_is_Your_Customer_Base1__c = 'B2B';
        newLead.Referral_type__c = 'BANK';
        newLead.NACIS_CODE__c = true;
        
        
        //First Owner Details
        newLead.SSN1__c = '000-00-0001';
        newLead.Street_Owner_1__c='220 Locust Ave';
        newLead.City_Owner_1__c = 'Anthill';
        newLead.State_Owner_1__c='MO';
        newLead.Zip_Code_Owner_1__c='65488';
        newLead.Country_Owner_1__c='US';
        newLead.Email = 'first@gmail.com';
        newLead.Adddress2_Owner__c = 'test';
        
        newLead.of_Ownership_Owner__c = 30;
        newLead.Credit_Score__c = 'under 600'; 
        newLead.Run_Credit_Report__c= true;
        newLead.Owner_ID_Owner_1__c = '123';
        newLead.Credit_Score_5th_Owner_from_Webform__c = 'Over 700';
        newLead.DOB_Owner_1__c = Date.valueof(System.now());
        
        //Second Owner Details
        newLead.Title_2nd_Owner__c = 'Ms';
        newLead.First_Name_2nd_Owner__c = 'SecondName';
        newLead.Last_Name_2nd_Owner__c = 'LastName';
        newLead.SSN2__c = '000-00-0001';
        newLead.Street_Owner_2__c = '220 Locust Ave';
        newLead.State_Owner_2__c = 'MO';
        newLead.Zip_Code_Owner_2__c = '65488';
        newLead.Country_Owner_2__c = 'US';
        newLead.Email_2nd_Owner__c = 'second@gmail.com';
        newLead.Phone_2nd_Owner__c = '8947523713';
        newLead.of_Ownership_Second_Owner__c = 30;
        newLead.City_Owner_2__c = 'Anthill';
        newLead.Credit_Score_2nd_Owner__c = '600 to 650';
        newLead.Run_Owner2_Credit_Report__c =true;
        newLead.Owner_ID_Owner_2__c = '124';
        newlead.DOB_Owner_2__c = Date.valueof(System.now());
        
        //Third Owner Details
        newLead.First_Name_3rd_Owner__c = 'ThirdName';
        newLead.Last_Name_3rd_Owner__c = 'LastName';
        newLead.SSN_3rd_Owner__c = '000-00-0001';
        newLead.of_Ownership_3rd_Owner__c = 40;
        newLead.City_Owner_3__c = 'Anthill';
        newLead.Email_3rd_Owner__c = 'third@gmail.com';
        newLead.Street_Owner_3__c = '220 Locust Ave';
        newLead.State_Owner_3__c = 'MO';
        newLead.Title_3rd_Owner__c = 'Ms';
        newLead.Zip_Code_Owner_3__c ='65488';
        newLead.Country_Owner_3__c = 'US';
        newLead.Credit_Score_3rd_Owner_from_Webform__c = '600 to 650';
        newLead.Phone_3rd_Owner__c = '8947523713';
        newLead.Run_Owner3_Credit_Report__c =true;
        newLead.Owner_ID_Owner_3__c = '125';
        newlead.DOB_Owner_3__c = Date.valueof(System.now());
        //Fourth Owner details
        newLead.First_Name_4th_Owner__c = 'FourthName';
        newLead.Last_Name_4th_Owner__c = 'LastName';
        newLead.SSN_4th_Owner__c = '000-00-0001';
        newLead.of_Ownership_4th_Owner__c = 50;
        newLead.City_Owner_4__c = 'Anthill';
        newLead.Email_4th_Owner__c = 'fourth@gmail.com';
        newLead.Street_Owner_4__c = '220 Locust Ave';
        newLead.State_Owner_4__c = 'MO';
        newLead.Title_4th_Owner__c = 'Ms';
        newLead.Zip_Code_Owner_4__c = '65488';
        newLead.Country_Owner_4__c = 'US';
        newLead.Credit_Score_4th_Owner_from_Webform__c = '600 to 650';
        newLead.Phone_4th_Owner__c = '8947523713';
        newLead.Run_Owner4_Credit_Report__c=true;
        newLead.Owner_ID_Owner_4__c = '126';
        newlead.DOB_Owner_4__c = Date.valueof(System.now());
        //Fifth Owner Details
        newLead.First_Name_5th_Owner__c = 'FifthName';
        newLead.Last_Name_5th_Owner__c = 'LastName';
        newLead.SSN_5th_Owner__c = '000-00-0001';
        newLead.of_Ownership_5th_Owner__c = 60;
        newLead.City_Owner_5__c = 'Anthill';
        newLead.Email_5th_Owner__c   = 'fifth@gmail.com';
        newLead.Street_Owner_5__c = '220 Locust Ave';
        newLead.State_Owner_5__c = 'MO';
        newLead.Title_5th_Owner__c = 'Ms';
        newLead.Zip_Code_Owner_5__c = '65488';
        newLead.Country_Owner_5__c = 'US';
        newLead.Credit_Score_5th_Owner_from_Webform__c = '600 to 650';
        newLead.Phone_5th_Owner__c = '8947523713';
        newLead.Run_Owner5_Credit_Report__c =true;
        newLead.Owner_ID_Owner_5__c = '127';
        newlead.DOB_Owner_5__c = Date.valueof(System.now());
        
        if(doInsert)
            insert newLead;
        
        return newLead;
    }
    
    public static Void convertLead(Lead newLead )
    {
        database.leadConvert lc = new database.leadConvert();
        lc.setLeadId(newLead.id);
        leadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);
        
        Database.LeadConvertResult lcr = Database.convertLead(lc);
        System.assert(lcr.isSuccess());
        lc.setOpportunityName('Cole Swain');
        
    }
    
    /** 
* ******************************************************
* This method is test data for create Account
* ******************************************************
*/
    
    public static Account createAccount(Boolean doInsert)
    {
        Account acc = new Account();
        acc.Name = 'Test Account';
        if(doInsert){
            insert acc;
        }
        return acc;
    }
    
    /**
* *******************************************************
* This method is test data for create contact object
* *******************************************************
*/
    public static Contact createContact(Boolean doInsert)
    {
        return createContact(doInsert, createAccount(true).Id);
    }
    
    public static Contact createContact(Boolean doInsert, Id accId)
    {
        Contact con = new Contact();
        con.AccountId = accId;
        con.FirstName = 'FirstName';
        con.LastName = 'LastName';
        con.Email = 'FirstName@test.com' + Math.floor(Math.random() * 1000);
        if(doInsert)
        {
            insert con;
        }
        return con;
    }
    
    /**
* ***********************************************************
* This method is test data for create Opportunity object
* ***********************************************************
*/
    
    public static Opportunity createOpportunity(Boolean doInsert, Id accId)
    {
        
        Tenant_Details__c objTenant = new Tenant_Details__c();
        objTenant.PortalAPIEndPoint__c = 'https://stagereplicaapi.mylendistry.com';
        objTenant.Portal_Login_URL__c = 'https://stagereplica.mylendistry.com/login';
        objTenant.Tenant_ID__c =67;
        objTenant.Tenant_URL__c = 'womenopportstage-replica.pacdfinetwork.mylendistry.com';
        objTenant.Tenant_Name__c ='Women’s Opportunity Resource Center';
        insert objTenant;
        
        Opportunity ObjOpp = new Opportunity();
        {
            objOpp.Name= 'TestOpp';
            objOpp.StageName = 'Sales Review';
            ObjOpp.AccountId = accId;
            ObjOpp.CloseDate = system.today()+5;
            ObjOpp.Days_in_UW_Sub__c = 0;
            ObjOpp.Projected_Close_Date__c = system.today() +10;
            ObjOpp.Loan_Type__c = 'CRG';
            ObjOpp.Tenant_Details__c = objTenant.id;
            ObjOpp.DBA__c = 'TestDevOps';
            ObjOpp.Business_EIN__c = '1234567876';
            ObjOpp.Entity_Type__c = 'Corporation';
            ObjOpp.Of_Documents__c = 78;
            ObjOpp.Consideration_Round__c = 'Round 1';
            ObjOpp.Network_Selection__c = 'Declined';
            ObjOpp.Application_ID__c = 'DIR20009322';
            ObjOpp.Run_Owner2_Credit_Report__c = false;
            ObjOpp.Run_Owner3_Credit_Report__c = false;
            ObjOpp.Run_Owner4_Credit_Report__c = false;
            ObjOpp.Run_Owner5_Credit_Report__c = false;
            ObjOpp.SMS_Opt_In__c = true;
            ObjOpp.State_of_incopration__c = 'testCO';
            ObjOpp.Address2_Business__c = 'testbusiness';
            ObjOpp.County__c = 'testcounty';
            ObjOpp.Business_Start_Date__c   = Date.valueof(System.now());
            ObjOpp.Purpose_of_Grant__c = 'Group Healthcare';
            ObjOpp.Will_this_grant_create_new_jobs__c = 'Yes';
            ObjOpp.Other__c = 'hjbujvuv';  
            ObjOpp.Number_of_Full_Time_Employees__c = 78;
            ObjOpp.Requested_Amount__c = 78964;
            ObjOpp.of_Jobs_Created__c = 7;
            ObjOpp.Number_of_Part_Time_Employees__c = 8;
            ObjOpp.of_Jobs_Retained__c = 78;
            ObjOpp.Women_Owned__c   = 'Yes';
            ObjOpp.Who_is_Your_Customer_Base1__c = 'B2C';
            ObjOpp.What_does_your_Business_do__c = 'Transportation/Communication';
            ObjOpp.What_type_of_Business_is_it__c = 'Communications';
            ObjOpp.Tell_us_more__c = 'Cable';
            ObjOpp.Franchise__c = 'Yes';
            ObjOpp.Disabled__c = 'No';
            ObjOpp.Ethnicity__c = 'Hispanic or Latino';
            ObjOpp.Rural__c = 'No';
            ObjOpp.Veteran__c = 'No';
            ObjOpp.Race__c = 'Hawaiian Native';
            
            insert objOpp;
        }
        if(doInsert)
        {
            insert ObjOpp;
        }
        return ObjOpp;
    }   
    
    /**
* ************************************************************
* This method is test data for create Case object
* ************************************************************
*/
    
    public static Case  createCase(Boolean doInsert )
    {
        Case cas = new Case(Status ='New', Priority = 'Medium', Origin = 'Email');
        if(doInsert)
        {
            insert cas ;
        }
        return cas ;
    }   
    Public Static Quick_Cash_Flow__c QuestionCashFlow(){
        
        Quick_Cash_Flow__c quickCashFlow = new Quick_Cash_Flow__c ();
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
        quickCashFlow.Loan_Amount_Status__c = false;
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
        // quickCashFlow.Lead__c = newLead.Id;
        //insert quickCashFlow;
        return quickCashFlow; 
    }
    Public Static creditchecker__Credit_Report__c CreditcheckerCreditReport(){
        
      //  Lead ObjLead = [Select id,Name,LastName, Phone,Company From Lead];
          
        creditchecker__Credit_Report__c oRecord4 = new creditchecker__Credit_Report__c();
        oRecord4.creditchecker__Applicants_First_Name__c = 'Marisol L';
        oRecord4.creditchecker__Applicants_Last_Name__c = 'TestCase';
        oRecord4.creditchecker__Applicants_SSN__c = '000000001';
        oRecord4.creditchecker__Current_Line__c = '220 Locust Ave';
        oRecord4.creditchecker__Current_City__c = 'Anthill';
        oRecord4.creditchecker__Current_Zip_Code__c = '65488';
        oRecord4.creditchecker__Current_StateCode__c = 'MO';
        oRecord4.creditchecker__Current_Country__c = 'US';
        oRecord4.creditchecker__Applicants_Residency_Type__c = 'Unknown';
       // oRecord4.creditchecker__Parent_Record_Id__c = ObjLead.Id;
        oRecord4.Owner_Type__c = 'Owner 1';
        oRecord4.Owner_ID__c = '001';
        insert oRecord4;
        Return oRecord4;
        
        
    }
    Public Static creditchecker__Credit_Report__c CreditcheckerCreditReport1(Boolean doInsert){
        
          Lead ObjLead = [Select id,Name,LastName, Phone,Company From Lead];
        
        creditchecker__Credit_Report__c oRecord4 = new creditchecker__Credit_Report__c();
        oRecord4.creditchecker__Applicants_First_Name__c = 'Marisol L';
        oRecord4.creditchecker__Applicants_Last_Name__c = 'TestCase';
        oRecord4.creditchecker__Applicants_SSN__c = '000000001';
        oRecord4.creditchecker__Current_Line__c = '220 Locust Ave';
        oRecord4.creditchecker__Current_City__c = 'Anthill';
        oRecord4.creditchecker__Current_Zip_Code__c = '65488';
        oRecord4.creditchecker__Current_StateCode__c = 'MO';
        oRecord4.creditchecker__Current_Country__c = 'US';
        oRecord4.creditchecker__Applicants_Residency_Type__c = 'Unknown';
        oRecord4.creditchecker__Parent_Record_Id__c = ObjLead.Id;
        oRecord4.Owner_Type__c = 'Owner 1';
        oRecord4.Owner_ID__c = '001';
        insert oRecord4;
        Return oRecord4;
        
    }
}