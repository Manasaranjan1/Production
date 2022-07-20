@isTest
public class customLookUpController_Test {
    static testMethod void callgetResult(){
        Counseling_Session__c counselingSessionObj = new Counseling_Session__c();
        counselingSessionObj.is_intrested_in_financing__c = True;
        counselingSessionObj.Note__c = 'TestNote';
        counselingSessionObj.Subject__c = 'Food & Beverage';
        counselingSessionObj.Cumulative_Time2__c = 10.12;
        insert counselingSessionObj; 
        String ObjectName= 'Counseling_Session__c';
        String fieldName= 'Subject__c'; 
        String value='Food & Beverage';
        customLookUpController.getResults(ObjectName, fieldName, value);  
    }

}