@istest
public class UpdateoppNoOFDaysBatch_Test {
    static testmethod void test() {
        Opportunity opp = new Opportunity();
        opp.Name = 'Testname';
        opp.CloseDate = date.today();
        opp.BusinessId__c = 'name';
        opp.Origination_Fee__c = '5.49';
        opp.Projected_Close_Date__c = date.today();
        opp.Referral_Partner_Fee__c = 151; 
        opp.StageName = 'Sales Review';
        opp.isUpdateNo_OfDays__c = true;
        opp.Loan_Type__c = 'SBA-PPP';
        insert opp;
        Test.startTest();
        String query ='Select Id,BusinessId__c, StageName, of_Days_in_Sales_Review__c, of_Days_in_PreQual_Out__c, of_Days_in_Processing_Sub__c, of_Days_in_UW_Sub__c, of_days_in_CON_APP_OUT__c, of_Days_in_Packaging__c, of_Days_in_UW__c, of_days_in_Sub_for_Review__c, of_Days_in_Sub_for_Approval__c, of_Days_in_CL_Out__c, of_Days_in_Docs_Out__c, of_Days_in_Pending_for_Closing__c, of_days_in_Suspended__c, of_days_in_Missed_Opp__c  From Opportunity where  Stagename!=\'New\' and stageName !=\'Funded\'';
        UpdateoppNoOFDaysBatch cnjn = new UpdateoppNoOFDaysBatch(query );
        Database.executeBatch(cnjn);
         System.enqueueJob(new sendNoOfDaysQueueable (new Set<String>{opp.Id}));
        Test.stopTest();
       // Opportunity[] accUpdatedList = [SELECT Id,Name FROM Opportunity];
        //System.assert(accUpdatedList[0].Name.Contains('Updated'));
        
    }
}