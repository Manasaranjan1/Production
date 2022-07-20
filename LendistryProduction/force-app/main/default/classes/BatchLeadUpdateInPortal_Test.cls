@isTest(seeAlldata=true)
public class BatchLeadUpdateInPortal_Test{
    static testMethod void BatchLeadUpdateInPortal_UnitTest1() {
        Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());
        
        Lead objLead = Testutility.createdeaultLead();        
        insert objLead;
        Test.startTest();
            BatchLeadUpdateInPortal be = new BatchLeadUpdateInPortal();
            database.executeBatch(be,1);
        Test.stopTest();
    }
}