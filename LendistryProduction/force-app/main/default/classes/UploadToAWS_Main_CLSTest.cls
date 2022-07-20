@isTest
public class UploadToAWS_Main_CLSTest{
    public static testMethod void method(){
       Lead objLead = new Lead();
        objLead.LastName = 'Test name';
        objLead.COmpany = 'Test Company';
        insert objLead;
        
        Blob b = Blob.valueOf('Test Data');
        
        Attachment attachment = new Attachment();
        attachment.ParentId = objLead.Id;
        attachment.Name = 'Test Attachment for Parent';
        attachment.Body = b;
        
        insert attachment;
        
        UploadToAWS_Main_CLS  objClass = new UploadToAWS_Main_CLS ();
        ApexPages.currentPage().getParameters().put('Id',objLead.id);
        objClass.getmyfile();
        objClass.getmyfile1();
        objClass.getmyfile2();
        objClass.getmyfile3();
        objClass.myfile = attachment;
        objClass.myfile1 =attachment;
        objClass.myfile2 =attachment;
        objClass.myfile3 =attachment;
        
        objClass.upload();
        objClass.upload2();
        objClass.upload3();
        objClass.upload4();
    }
}