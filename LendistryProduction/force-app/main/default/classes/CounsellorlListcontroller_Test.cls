/*
*@Author- Rahul Singh
*@Date - 14 May 2021
*@Description - This class contains all the methods of CounsellorlListcontroller class
* Modified History
*
******Author****************Date****************Descriptions*********
******Rahul singh**********14 May 2021**********Initial Version******
******Saradhi B**********19 Oct 2021********** V1.0 ******
*/
@isTest(SeeAllData=true)
public class CounsellorlListcontroller_Test {
    static testMethod void CounsellorlListcontrollerMethod(){
        System.Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());  
        //User PrtUser =  [Select Id, Username, LastName, Email, Alias, TimeZoneSidKey, LocaleSidKey, EmailEncodingKey, ProfileId, LanguageLocaleKey from User Limit 1];
        Profile P = [SELECT Id FROM Profile WHERE Name='System Administrator'/*Counsellor Partner Profile'*/]; 
        Profile counsellorProfile = [SELECT Id FROM Profile WHERE Name='Counsellor Partner Profile']; 
        User u = new User(Alias = 'freddda', Email='yogita.chauhansdfsfsfds@rsystems.com', 
                          EmailEncodingKey='UTF-8', LastName='Aja Beard', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id,
                          TimeZoneSidKey='America/Los_Angeles', UserName='rahul234reew.singh1@rsystems.com.partneruser'); 
        insert u;
        User PrtUser =  [Select Username, LastName, Email, Alias, TimeZoneSidKey, LocaleSidKey, EmailEncodingKey, 
                         ProfileId, LanguageLocaleKey from User where contactid!=null and profileId =:counsellorProfile.id
                         and isactive=true Limit 1]; 
        

        system.runas(u){   
            lead l = [select id, FirstName from Lead limit 1];
            Counseling_Session__c counselingSessionObj = new Counseling_Session__c();
            counselingSessionObj.is_intrested_in_financing__c = True;
            counselingSessionObj.Note__c = 'TestNote';
            counselingSessionObj.Subject__c = 'Food & Beverage';
            counselingSessionObj.Counsellor1__c = PrtUser.id;
            counselingSessionObj.Cumulative_Time2__c = 10.12;
            //counselingSessionObj.Lead__c = newLead.id;
            counselingSessionObj.Lead__c = l.id;
            insert counselingSessionObj;  
            Counselor_Login_Hours__c Counselor = new Counselor_Login_Hours__c(Counselor__c = Userinfo.getUserId());
            insert Counselor;
            Time_Tracker__c testtime1 = new Time_Tracker__c();
            testtime1.Tracking_Date__c = date.today();
            testtime1.Tracking_Time__c = 1.10;
            testtime1.Counseling_Session__c = counselingSessionObj.Id;
            insert testtime1;
            
            //String.valueOf(date.today())
            CounsellorlListcontroller.fetchCounsellorList();
            CounsellorlListcontroller.saveTimeTracking1('2:10:15', counselingSessionObj.Id);
            CounsellorlListcontroller.saveTimeTracking3('7', '20', counselingSessionObj.Id);
            CounsellorlListcontroller.trackRecordedTime('02','10','15', counselingSessionObj.Id); 
            CounsellorlListcontroller.stopSessionTemp(PrtUser.id);
            //CounsellorlListcontroller.getCounsellor(counselingSessionObj.Counsellor1__r.id);
            CounsellorlListcontroller.getCounsellor(counselingSessionObj.Id);
            CounsellorlListcontroller.UpdateCounselor(counselingSessionObj.Counsellor1__c, counselingSessionObj.Id);
            CounsellorlListcontroller.sessionStopTime(u.id);
            CounsellorlListcontroller.returnSessionStartTime(u.id);
            
            
        }
        
    }
}