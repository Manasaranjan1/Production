@isTest(SeeAllData=true)
public class counselingSessionTriggerHandler_Test {
    static testMethod void counselingSessionTriggerHandlerMethod(){
       
      //User PrtUser =  [Select Username, LastName, Email, Alias, TimeZoneSidKey, LocaleSidKey, EmailEncodingKey, ProfileId, LanguageLocaleKey from User where LastName in ('Dr. Jorge Chavarin') Limit 1];
      //User PrtUser =  [Select Username, LastName, Email, Alias, TimeZoneSidKey, LocaleSidKey, EmailEncodingKey, ProfileId, LanguageLocaleKey from User where Alias='dr.' Limit 1];  
        System.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        Lead newLead = new Lead() ;
        newLead.FirstName = 'Cole';
        newLead.LastName = 'Swain';
        newLead.Company = 'BlueWave';
        newLead.Status = 'New';
        newLead.IsConverted = False;
        //newLead.Cumulative_Time__c = 11.02;
        insert newLead;  
        Counseling_Session__c counselingSessionObj = new Counseling_Session__c();
        counselingSessionObj.is_intrested_in_financing__c = True;
        counselingSessionObj.Note__c = 'TestNote';
        counselingSessionObj.Subject__c = 'Food & Beverage';
        //counselingSessionObj.Counsellor1__c= PrtUser.id;
        counselingSessionObj.Cumulative_Time2__c = 10.12;
        counselingSessionObj.Lead__c = newLead.id;
        //counselingSessionObj.Lead__c = l.id;
        insert counselingSessionObj;  
        
                
        Set<Id> CSessionids = new Set<Id>();
        List<Counseling_Session__c> CSLST = new List<Counseling_Session__c>();
        CSessionids.add(counselingSessionObj.id);
        System.Test.startTest();
          counselingSessionTriggerHandler.updateCumulativeTimeOnLead(CSessionids, True);
        counselingSessionTriggerHandler.onBeforeInsert(CSLST);
        System.Test.stopTest();
    }
    
    static testMethod void SharingTriggerforcounselingsession(){
     User PrtUser =  [Select Username, LastName, Email, Alias, TimeZoneSidKey, LocaleSidKey, EmailEncodingKey, ProfileId, LanguageLocaleKey from User where LastName in ('Click') Limit 1]; 
        lead l = [select id, FirstName from Lead limit 1];
        Counseling_Session__c Cs = [Select id, name from Counseling_Session__c limit 1];
        Counseling_Session__c counselingSessionObj = new Counseling_Session__c();
        counselingSessionObj.is_intrested_in_financing__c = True;
        counselingSessionObj.Note__c = 'TestNote';
        counselingSessionObj.Subject__c = 'Food & Beverage';
        counselingSessionObj.Counsellor1__c = PrtUser.id;
        counselingSessionObj.Cumulative_Time2__c = 10.12;
        //counselingSessionObj.Lead__c = newLead.id;
        counselingSessionObj.Lead__c = l.id;
        insert counselingSessionObj;
}
     static testMethod void SharingTriggerforcounselingsession2(){
     User PrtUser =  [Select Username, LastName, Email, Alias, TimeZoneSidKey, LocaleSidKey, EmailEncodingKey, ProfileId, LanguageLocaleKey from User where LastName in ('Click') Limit 1]; 
        lead l = [select id, FirstName from Lead limit 1];
        Counseling_Session__c Cs = [Select id, name from Counseling_Session__c limit 1];
//Counseling_Session__c counselingSessionObj = new Counseling_Session__c();
        Cs.is_intrested_in_financing__c = True;
        //counselingSessionObj.Note__c = 'TestNote';
        Cs.Subject__c = 'Food & Beverage';
        Cs.Counsellor1__c = PrtUser.id;
        Cs.Cumulative_Time2__c = 10.12;
        //counselingSessionObj.Lead__c = newLead.id;
        Cs.Lead__c = l.id;
         CS.Note__c = 'hitu';
        update CS;
     }
}