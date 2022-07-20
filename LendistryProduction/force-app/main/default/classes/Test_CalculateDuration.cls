@isTest(seeAllData = false)
private class Test_CalculateDuration {
    
    @isTest
    public static void myTest() {
        
        Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Client').getRecordTypeId();        
        Account acc = new Account();
        acc.name= 'Test Account';
        acc.RecordTypeId = devRecordTypeId;
        insert acc;
        
        opportunity opp1 = new opportunity();
        opp1.AccountId = acc.Id;
        opp1.Name = 'Test 123';
        opp1.CloseDate = date.today();
        opp1.StageName = 'Sales Review';
        opp1.Origination_Fee__c= '5.00';
        opp1.Partner_Referral_Fee__c = '3.00';
        opp1.Projected_Close_Date__c = date.today();
        insert opp1;
        
        Opportunity_Field_History__c opphist = new Opportunity_Field_History__c();
        opphist.Opportunity__c = opp1.Id;
        opphist.Stage_New__c = 'Sales Review';
        opphist.Stage_Start_Date__c = date.today() -45;
        opphist.Stage_Close_Date__c = date.today() -2;
        insert opphist;
        
        Opportunity_Field_History__c opphist2 = new Opportunity_Field_History__c();
        opphist2.Opportunity__c = opp1.Id;
        opphist2.Stage_New__c = 'Sales Review';
        opphist2.Stage_Start_Date__c = date.today() -35;
        opphist2.Stage_Close_Date__c = date.today() +5;
        insert opphist2;
        
        opportunity Opp = new opportunity();
        Opp.ID = opp1.Id;
        opp.StageName = 'PreQual Out';
        OPP_CALCULATE_DURATION.isexecuting = False;
        update opp;
    }
}