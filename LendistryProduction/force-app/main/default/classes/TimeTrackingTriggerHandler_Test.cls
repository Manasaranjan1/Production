@isTest
public class TimeTrackingTriggerHandler_Test {
    public TimeTrackingTriggerHandler_Test(){
        CumulativeTimeFlag.flag= true;
    }
    static testMethod void TimeTrackingTriggerHandler_TestMethod(){
        //User PrtUser =  [Select Username, LastName, Email, Alias, TimeZoneSidKey, LocaleSidKey, EmailEncodingKey, ProfileId, LanguageLocaleKey from User where Alias in ('Dr.') Limit 1];
        Counseling_Session__c counselingSessionObj = new Counseling_Session__c();
        //counselingSessionObj.Counsellor__c = PrtUser.id;
        counselingSessionObj.is_intrested_in_financing__c = True;
        counselingSessionObj.Note__c = 'TestNote';
        counselingSessionObj.Subject__c = 'Food & Beverage';
        //counselingSessionObj.Counsellor1__c= PrtUser.id;
        insert counselingSessionObj;  
        
        Time_Tracker__c testtime1 = new Time_Tracker__c();
        testtime1.Tracking_Date__c = date.today();
        testtime1.Tracking_Time__c = 1.10;
        testtime1.Counseling_Session__c = counselingSessionObj.Id;
        insert testtime1;
        
        List<Time_Tracker__c> trackerList = new List<Time_Tracker__c>();
        trackerList.add(testtime1);
        
        TimeTrackingTriggerHandler testing = new TimeTrackingTriggerHandler();
        testing.updateCounselingSession(trackerList, True);
    }
    
}