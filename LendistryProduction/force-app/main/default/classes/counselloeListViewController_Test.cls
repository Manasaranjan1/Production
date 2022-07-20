@isTest(SeeAllData=true)
public class counselloeListViewController_Test {
    static testMethod void counselingSessionTriggerHandlerMethod(){
        // System.Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());   
          //User PrtUser =  [Select Username, LastName, Email, Alias, TimeZoneSidKey, LocaleSidKey, EmailEncodingKey, ProfileId, LanguageLocaleKey from User where LastName in ('Dr. Jorge Chavarin') Limit 1];
         //User PrtUser =  [Select Username, LastName, Email, Alias, TimeZoneSidKey, LocaleSidKey, EmailEncodingKey, ProfileId, LanguageLocaleKey from User where Alias in ('dr.') Limit 1];
  
        lead l = [select id, FirstName from Lead where recordType.Name='Center Leads' limit 1];
         Feeditem test = new Feeditem();
        test.Body = 'test';
        test.ParentId = l.Id;
        insert test;
        
        Counseling_Session__c counselingSessionObj = new Counseling_Session__c();
        //counselingSessionObj.Counsellor__c = 'Aja Beard';
        counselingSessionObj.is_intrested_in_financing__c = True;
        counselingSessionObj.Note__c = 'TestNote';
        counselingSessionObj.Subject__c = 'Food & Beverage';
       // counselingSessionObj.Counselor = PrtUser.id;
       //counselingSessionObj.Counsellor1__c = PrtUser.id;
        counselingSessionObj.Cumulative_Time2__c = 10.12;
        counselingSessionObj.Lead__c = l.id;
        insert counselingSessionObj; 
 
        counselloeListViewController.saveTimeTracking('test', counselingSessionObj.Id);
        counselloeListViewController.getFiles(counselingSessionObj.Id);
        counselloeListViewController.deleteSalesforceFile(test.Id);
        counselloeListViewController.getLeadField(counselingSessionObj.Id);
        counselloeListViewController.getConfigurationData();
        //counselloeListViewController.getDateFilter(date.today());
       // counselloeListViewController.getPickListValuesCommon('counselingSessionObj', counselingSessionObj.Counsellor__c);
        counselloeListViewController.getDateFilter('2020-10-22');
       // counselloeListViewController.getPickListValuesCommon('counselingSessionObj', 'counselingSessionObj.Subject__c');
        
    }
}