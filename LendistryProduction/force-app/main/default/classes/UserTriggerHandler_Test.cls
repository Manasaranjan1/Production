@isTest(seeAllData=true)
public class UserTriggerHandler_Test {
    
    @isTest
    Public static void Insertuser(){
         Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());
         Profile p = [SELECT Id FROM Profile WHERE Name='Lendistry BDO Team']; 
        user userObj = new user();
        userObj.Alias = 'standt';
        userObj.Email='standarduser@testorg.com'; 
        userObj.EmailEncodingKey='UTF-8';
        userObj.LastName='Testing';
        userObj.LanguageLocaleKey='en_US';
        userObj.LocaleSidKey='en_US';
        userObj.ProfileId = p.Id;
        userObj.TimeZoneSidKey='America/Los_Angeles';
        userObj.UserName='alphaCharlie@betaalphaCharlie.com';
        userObj.Is_Call_Center_User__c = false;
        
        Test.startTest();
            insert userObj;
            Profile p1 = [SELECT Id FROM Profile WHERE Name='Lendistry Call Center'];
            userObj.ProfileId = p1.Id;
            userObj.LastName = 'Testing1';
            //userObj.Is_Call_Center_User__c = false;
            //update userObj;
            userObj.Is_Call_Center_User__c = true;
            update userObj;
        Test.stopTest();
        
       
    }
    
    @isTest
    Public static void Insertuser2(){
        Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());
        Profile p = [SELECT Id FROM Profile WHERE Name='Lendistry Call Center']; 
        user userObj = new user();
        userObj.Alias = 'standt';
        userObj.Email='standarduser@testorg.com'; 
        userObj.EmailEncodingKey='UTF-8';
        userObj.LastName='Testing';
        userObj.LanguageLocaleKey='en_US';
        userObj.LocaleSidKey='en_US';
        userObj.ProfileId = p.Id;
        userObj.IsActive=true;
        userObj.TimeZoneSidKey='America/Los_Angeles';
        userObj.UserName='alphaCharlie@betaalphaCharlie.com';
        userObj.Is_Call_Center_User__c = true;
        
        Test.startTest();
            insert userObj;
            Profile p1 = [SELECT Id FROM Profile WHERE Name='Lendistry BDO Team'];
            userObj.ProfileId = p1.Id;
            userObj.LastName = 'Testing1';
            //userObj.Is_Call_Center_User__c = false;
            //update userObj;
            userObj.Is_Call_Center_User__c = false;
            update userObj;
        Test.stopTest();
        
       
    }

}