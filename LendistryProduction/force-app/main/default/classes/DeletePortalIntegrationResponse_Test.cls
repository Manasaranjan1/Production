@isTest
public class DeletePortalIntegrationResponse_Test {
    
    static testmethod void DeletePortalIntegration(){
        
        Portal_Integration_Response_Code__c TestPortal = new Portal_Integration_Response_Code__c ();
        TestPortal.API_Name__c = 'Test';
        TestPortal.Application_ID__c = '1928281992222';
        insert TestPortal;
         Datetime yesterday = Datetime.now().addDays(-100);
        Test.setCreatedDate(TestPortal.Id, yesterday); 
        system.debug('Insert record'+TestPortal.CreatedDate);
        //TestPortal.CreatedDate = Date.today().addMonths(-3);
        
        
        Test.startTest();
        
        DeletePortalIntegrationResponseCodeBatch schd = new DeletePortalIntegrationResponseCodeBatch();
        String sch = '0 0 2 * * ?';
        system.schedule('Test Territory Check', sch, schd); 
        database.executebatch(schd);
        Test.stopTest();      
    }
}