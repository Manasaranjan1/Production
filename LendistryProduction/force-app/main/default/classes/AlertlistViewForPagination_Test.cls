@isTest
public class AlertlistViewForPagination_Test {
    static testMethod void testMethod1() {
  
       Counseling_Session__c objcounsel = new Counseling_Session__c();
        //objcounsel.Counsellor__c =  'Aja Beard';
        objcounsel.is_intrested_in_financing__c = True;
        objcounsel.Note__c = 'TestNote';
        objcounsel.Subject__c = 'Food & Beverage';
               insert objcounsel;
        
        AlertlistViewForPagination.getCounselorData(7, 10);
      
    }
}