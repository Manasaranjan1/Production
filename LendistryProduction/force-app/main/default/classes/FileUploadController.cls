public with sharing class FileUploadController {
     
    /* 1. Save file in Content document : Used in FileUploadComp.cmp */
    @AuraEnabled
    public static id saveChunk(Id parentId,String DocCategory, String fileName, String base64Data, String contentType, String fileId) {
       //Id
        // check if fileId id ''(Always blank in first chunk), then call the saveTheFile method,
        //  which is save the check data and return the attachemnt Id after insert, 
        //  next time (in else) we are call the appentTOFile() method
        //   for update the attachment with reamins chunks   
        if (fileId == '') {
            fileId = saveTheFile(parentId, DocCategory, fileName, base64Data, contentType);
        } else {
            appendToFile(fileId, base64Data);
        }
 
        return Id.valueOf(fileId);
    }
 
    public static id saveTheFile(Id parentId, String DocCategory, String fileName, String base64Data, String contentType) {
        //id
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
 
    /*    Attachment oAttachment = new Attachment();
        oAttachment.parentId = parentId;
 
        oAttachment.Body = EncodingUtil.base64Decode(base64Data);
        oAttachment.Name = fileName;
        oAttachment.ContentType = contentType;
        //oAttachment.Doc_Category__c = 'Taxes';
 
        insert oAttachment;  */
 
       
        ContentVersion cv = new ContentVersion();
        cv.Title = fileName;  //'Test Document3';
        cv.PathOnClient = fileName;
        cv.VersionData =  EncodingUtil.base64Decode(base64Data); //Blob.valueOf('Data of Test Content3');
        cv.IsMajorVersion = false;
        cv.Doc_Category__c = DocCategory;
        Insert cv;

        //Id conDocId = [SELECT ContentDocumentId, Doc_Category__c FROM ContentVersion WHERE Id =:cv.Id].ContentDocumentId;
        ContentVersion contV = [SELECT ContentDocumentId, Doc_Category__c FROM ContentVersion WHERE Id =:cv.Id];
        
        Id conDocId = contV.ContentDocumentId;
        System.debug('Doc Category: '+contV.Doc_Category__c); 
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = parentId;
        cdl.ContentDocumentId = conDocId;
        cdl.ShareType = 'V';
        cdl.Visibility = 'AllUsers';
        Insert cdl;

        //return oAttachment.Id;
       return cv.Id;
    }
 
    private static void appendToFile(Id fileId, String base64Data) {
        System.debug('##fileId## '+fileId);
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        ContentVersion versionData = [
            SELECT Id, VersionData,ContentDocumentId
            FROM ContentVersion
            WHERE Id = :fileId
        ];

        String existingBody     = EncodingUtil.base64Encode(versionData.VersionData);
        versionData.VersionData = EncodingUtil.base64Decode(existingBody + base64Data); 

        update versionData;
        
       /* base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
 
        Attachment a = [
            SELECT Id, Body
            FROM Attachment
            WHERE Id =: fileId
        ];
 
        String existingBody = EncodingUtil.base64Encode(a.Body);
 
        a.Body = EncodingUtil.base64Decode(existingBody + base64Data);
 
        update a;*/
    }
    
    // Attachment wrapper class
    public class AttachmentWrapper{
        @AuraEnabled
        public String fName;
        @AuraEnabled
        public String fType;
        @AuraEnabled
        public Integer fsize;
        @Auraenabled
        public String recordId;
        @AuraEnabled
        public Blob fbody;
    }
    
     /* 2. Get all the Counselling Session Attachments: Used in FileUploadComp.cmp and FileDownloadComp.cmp */
    @AuraEnabled
    public static List<ContentVersion> getFiles(String CounsellingSessionId){
        List<ContentDocumentLink> contentDocumentList=[select ContentDocumentId,LinkedEntityId from ContentDocumentLink where LinkedEntityId=:CounsellingSessionId];
        Set<Id> contentDocumentId = new Set<Id>();
        for(ContentDocumentLink cd1 : contentDocumentList){
            contentDocumentId.add(cd1.ContentDocumentId);
        }
        List<ContentVersion> contentVersionList =[SELECT id,VersionData,FileType,Doc_Category__c,Title, FileExtension,ContentDocumentId,ContentDocument.FileType ,ContentDocument.ContentSize from ContentVersion where ContentDocumentId in : contentDocumentId];
        //return JSON.seralize(contentVersionList)
        System.debug('getFiles Called==========>>>');
        return contentVersionList;    
        
    }

    
    /* 3. Delete file from contentDocument : Used in FileDownloadComp.cmp   */
    @AuraEnabled
    public static Boolean deleteSalesforceFile(String ContentDocumentId){
        system.debug(':::::::::::::'+ContentDocumentId);
        delete [select id from ContentDocument where id =:ContentDocumentId];
        return true;
    }
    
       
    /* 4. To extract list of CounselingSessions of logged in Counseler : Used in DisplayTotalHours.cmp  */
    @AuraEnabled
    public static List<Counseling_Session__c> getCSessionList(String CSessionId){
        Counseling_Session__c cs = [select id, Counsellor1__c, Name,CS_Hours__c,CS_Minutes__c,Cumulative_Time2__c from Counseling_Session__c where id =:CSessionId limit 1];
        System.debug('cs----->'+cs);
        if(cs!=null){
          List<Counseling_Session__c> csList  = [select id, Counsellor1__c,Counsellor_Name__c, Name, CS_Hours__c,CS_Minutes__c, Cumulative_Time2__c from Counseling_Session__c where Counsellor1__c =:cs.Counsellor1__c and Cumulative_Time2__c!=null];
          System.debug('cslist----->'+cslist);
            return csList;
        } 
        else
          return null;          
    }
    
    /*  
    @AuraEnabled
    public static Counseling_Session__c getCSession(Id CounsellingSessionId){
        Counseling_Session__c cs = [select id, Name,CS_Hours__c,CS_Minutes__c,Cumulative_Time2__c from Counseling_Session__c where id =:CounsellingSessionId];
        return cs;
    } */

    
}