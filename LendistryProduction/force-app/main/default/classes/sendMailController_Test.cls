@istest
public class sendMailController_Test {
    static testMethod void method1(){
        
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
        email.subject = 'Lead to opportunity conversion failed at portal end.';
        email.plainTextBody = 'SF & Portal admins the application Id conversion has failed. Please find the request and JSON below';
        email.htmlBody = 'Thanx';
        email.fromAddress = 'noreply@salesforce.com';
        //email.toAddresses = testrsystems.com;
        Test.startTest();
        sendMailController.sendEmail(email.subject, email.htmlBody,'Test','Test');
        Test.stopTest();
    }
    
    
    
}