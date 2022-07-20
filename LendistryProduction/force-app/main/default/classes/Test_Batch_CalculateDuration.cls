@IsTest
public class Test_Batch_CalculateDuration {
    
    @isTest
    Public static void mymethod(){
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
        insert opp1;
        
        Test.startTest();
        Batch_CalculateDuration obj = new Batch_CalculateDuration();
        DataBase.executeBatch(obj); 
        Test.stopTest();
    }
    
}