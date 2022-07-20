/*
*@Author- Rahul Singh
*@Date - 14 May 2021
*@Description - This class contains all the methods of CounsellorlListcontroller class
* Modified History
*
******Author****************Date****************Descriptions*********
******Rahul singh**********14 May 2021**********Initial Version******
*/

@isTest(SeeAllData=true)
public class GetCounselingSessions_Test {
    static testMethod void GetCounselingSessionsMethod(){
         lead l = [select id, FirstName from Lead limit 1];
        Counseling_Session__c counselingSessionObj = new Counseling_Session__c();
        counselingSessionObj.is_intrested_in_financing__c = True;
        counselingSessionObj.Note__c = 'TestNote';
        counselingSessionObj.Subject__c = 'Food & Beverage';
      //    counselingSessionObj.Counsellor1__c = PrtUser.id;
        counselingSessionObj.Cumulative_Time2__c = 10.12;
        //counselingSessionObj.Lead__c = newLead.id;
        counselingSessionObj.Lead__c = l.id;
        insert counselingSessionObj;  
        List<Counseling_Session__c> CSC = new List<Counseling_Session__c>();
        GetCounselingSessions GCS = new GetCounselingSessions();
        GCS.getCSSnames();
       // GCS.findTotalCTime(CSC);
    }
}