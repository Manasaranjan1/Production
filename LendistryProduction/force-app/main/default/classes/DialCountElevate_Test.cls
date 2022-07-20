@isTest(SeeAllData = true)
public class DialCountElevate_Test {
    static string leadId;
    Static string AccountID;
    Static string ContactID;
    
    static testMethod void CreateLead(){
       List<Task> LstTask = new List<Task>();
        
        Lead objLead = new Lead();
        objLead.Title = 'Mr.';
        objLead.FirstName = 'FirstName';
        objLead.LastName = 'test';
        objLead.Company = 'Test';
        objlead.Base64_Encoded_Pardot_Url_Parameter__c = 'MDBRMmEwMDAwMDVPbkxGRUEwfHwwMi4wMi4yMDIwIDE5OjAw';
        objLead.Entity_Type__c = 'Corporation';
        objlead.DoNotCall = false;
        objlead.HasOptedOutOfFax = false;
        objlead.Phone = '(963) 258-7410';
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
        objlead.DOB_Owner_1__c = Date.valueof(System.now()-90);
        
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
        ObjLead.Phone_2nd_Owner__c = '8947523713';
        objLead.of_Ownership_Second_Owner__c = 30;
        objLead.City_Owner_2__c = 'Anthill';
        ObjLead.Credit_Score_2nd_Owner__c = '600 to 650';
        objLead.Run_Owner2_Credit_Report__c =true;
        objLead.Owner_ID_Owner_2__c = '124';
        objlead.DOB_Owner_2__c = Date.valueof(System.now()-90);
        //Third Owner Details
        objLead.First_Name_3rd_Owner__c = 'ThirdName';
        objLead.Last_Name_3rd_Owner__c = 'LastName';
        objLead.SSN_3rd_Owner__c = '000-00-0001';
        objLead.of_Ownership_3rd_Owner__c = 40;
        objLead.City_Owner_3__c = 'Anthill';
        objLead.Email_3rd_Owner__c = 'third@gmail.com';
        objLead.Street_Owner_3__c = '220 Locust Ave';
        objLead.State_Owner_3__c = 'MO';
        objLead.Title_3rd_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_3__c ='65488';
        objLead.Country_Owner_3__c = 'US';
        ObjLead.Credit_Score_3rd_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_3rd_Owner__c = '8947523713';
        objLead.Run_Owner3_Credit_Report__c =true;
        objLead.Owner_ID_Owner_3__c = '125';
        objlead.DOB_Owner_3__c = Date.valueof(System.now()-90);
        //Fourth Owner details
        objLead.First_Name_4th_Owner__c = 'FourthName';
        objLead.Last_Name_4th_Owner__c = 'LastName';
        objLead.SSN_4th_Owner__c = '000-00-0001';
        objLead.of_Ownership_4th_Owner__c = 50;
        objLead.City_Owner_4__c = 'Anthill';
        objLead.Email_4th_Owner__c = 'fourth@gmail.com';
        objLead.Street_Owner_4__c = '220 Locust Ave';
        objLead.State_Owner_4__c = 'MO';
        objLead.Title_4th_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_4__c = '65488';
        objLead.Country_Owner_4__c = 'US';
        ObjLead.Credit_Score_4th_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_4th_Owner__c = '8947523713';
        objLead.Run_Owner4_Credit_Report__c=true;
        objLead.Owner_ID_Owner_4__c = '126';
        objlead.DOB_Owner_4__c = Date.valueof(System.now()-90);
        //Fifth Owner Details
        objLead.First_Name_5th_Owner__c = 'FifthName';
        objLead.Last_Name_5th_Owner__c = 'LastName';
        objLead.SSN_5th_Owner__c = '000-00-0001';
        objLead.of_Ownership_5th_Owner__c = 60;
        objLead.City_Owner_5__c = 'Anthill';
        objLead.Email_5th_Owner__c   = 'fifth@gmail.com';
        objLead.Street_Owner_5__c = '220 Locust Ave';
        objLead.State_Owner_5__c = 'MO';
        objLead.Title_5th_Owner__c = 'Ms';
        objLead.Zip_Code_Owner_5__c = '65488';
        objLead.Country_Owner_5__c = 'US';
        ObjLead.Credit_Score_5th_Owner_from_Webform__c = '600 to 650';
        ObjLead.Phone_5th_Owner__c = '8947523713';
        ObjLead.Run_Owner5_Credit_Report__c =true;
        objLead.Owner_ID_Owner_5__c = '127';
 		objlead.DOB_Owner_5__c = Date.valueof(System.now()-90);
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
        objLead.Homeowner__c = 'Yes';
        objLead.Monthly_Rent_Mtg__c = 500;
        objLead.Net_Worth__c = 51000;        
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
        objLead.LeadSource = 'Portal';
        objLead.Campaign_Source__c = 'Finished';
		insert objLead;
        leadId = objLead.id;
        
       
        
        Opportunity op = new Opportunity();
        op.StageName = 'Sales Review';
        op.Name = 'Test';
        op.CloseDate = System.today();
        insert op;
        
        Task objTask = new Task();
        objTask.WhoId = objLead.id;
        objTask.TaskSubtype = 'Call';
        objTask.OwnerId = UserInfo.getUserId();
        objTask.Status = 'Completed';
       insert objTask;
        
        //Insert Task
      Task objTask1 = new Task();
        objTask1.WhatId = op.id;
        objTask1.TaskSubtype = 'Call';
        objTask1.Status = 'Completed';
        
        
        insert objTask1;
      
    }
    
    
}