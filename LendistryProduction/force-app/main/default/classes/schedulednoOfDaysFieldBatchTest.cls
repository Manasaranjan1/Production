@istest(seeAlldata=true)
public class schedulednoOfDaysFieldBatchTest {
     public static testMethod void method1(){
            Test.startTest();
         Opportunity opp = new Opportunity();
         opp.Name = 'Testname';
         opp.CloseDate = date.today();
         opp.BusinessId__c = 'name';
         opp.StageName = 'Sales Review';
         opp.isUpdateNo_OfDays__c = true;
         opp.Loan_Type__c = 'SBA-PPP';
         insert opp;
         schedulednoOfDaysFieldBatch abc = new schedulednoOfDaysFieldBatch();
         
          String cronExpr = '0 0 23 * * ?';
               String jobId = System.schedule('myJobTestJobName', cronExpr, abc);
       //  DataBase.executebatch(abc, cronExpr);
               abc.execute(null);
            Test.stopTest();    
         
     }
}