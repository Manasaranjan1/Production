public class AdditionalDocumentController {
    
   
    @AuraEnabled
    public static List<wrapper> fetchContentDocument( string leadRecordId ){
        System.debug('---leadRecordId- upload AWS3  try--->'+leadRecordId);
        set<string> setContentDucumetIds = new set<string>();
        list<wrapper> lstWrapper = new list<wrapper>();
        map<string, string> mapOfExternalIds = new map<string, string>();
        list<ContentDocumentLink> listOfCDLink = new list<ContentDocumentLink>();
        list<Multiple_Files_Upload__c>  lstOfMultipleFiles = new list<Multiple_Files_Upload__c>();
        if( leadRecordId != null && leadRecordId != '' )
            listOfCDLink = [ select id, LinkedEntityId,ContentDocumentId from ContentDocumentLink where LinkedEntityId =:leadRecordId ];
        lstOfMultipleFiles = [ Select id, Lead__c,IsAdditionalDocument__c,External_Id__c,Attachment_Url__c from Multiple_Files_Upload__c Where Lead__c=:leadRecordId ];
        
        if( lstOfMultipleFiles != null && lstOfMultipleFiles.size() > 0 )
                    {
                        for( Multiple_Files_Upload__c eachMulDocs : lstOfMultipleFiles)
                        {
                            mapOfExternalIds.put(eachMulDocs.External_Id__c, eachMulDocs.External_Id__c);
                        }
                    }
        if( listOfCDLink != null && listOfCDLink.size() > 0 )
        {
            for(ContentDocumentLink each : listOfCDLink)
                setContentDucumetIds.add(each.ContentDocumentId);
        }
        if( setContentDucumetIds != null && setContentDucumetIds.size() > 0 )
        {
            list<ContentDocument>  lsitContentDocument= [Select id,Title, FileExtension, FileType, Owner.Name , ContentSize From ContentDocument Where Id IN:setContentDucumetIds];
            
            if( lsitContentDocument != null && lsitContentDocument.size() > 0)   
            {
                for( ContentDocument each:  lsitContentDocument)
                {
                    
                            if( mapOfExternalIds.get(each.id) == each.id )
                            {
                                wrapper objWrap = new wrapper();
                                objWrap.Title= each.title;
                                objWrap.Id= each.id;
                                objWrap.FileType = each.FileType;
                                objWrap.IsDisableBtn = true;
                                objWrap.Status = 'Successfully Uploaded';
                                lstWrapper.add(objWrap); 
                            }
                            else
                            {
                                wrapper objWrap = new wrapper();
                                objWrap.Title= each.title;
                                objWrap.Id= each.id;
                                objWrap.FileType = each.FileType;
                                objWrap.IsDisableBtn = false;
                                objWrap.Status = 'Not Uploaded';
                                lstWrapper.add(objWrap);  
                            }
                            
                            
                        }
                    }
              
        }
        System.debug('---lstWrapper- lstWrapper  try--->'+lstWrapper);
        return lstWrapper;
    }
    
    @AuraEnabled  
    public static boolean uploadToAWSServier( string leadRecordId , string contentDocumentId ) {
       
        uploadToAWSServierFuture(leadRecordId, contentDocumentId );
        return true;
        
    }
    @future(callout=true) 
    public static void uploadToAWSServierFuture( string leadRecordId , string contentDocumentId ) {
        boolean IsFileUploaded = false;
        System.debug('---leadRecordId- upload AWS3  try--->'+leadRecordId);
        System.debug('---contentDocumentId- upload AWS3  try--->'+contentDocumentId);
        ContentDocument objAtt= [ Select id, Title, FileExtension, FileType, Owner.Name , ContentSize From ContentDocument Where Id=:contentDocumentId];
        ContentVersion objContentVersion=[SELECT VersionData FROM ContentVersion WHERE ContentDocumentId =:contentDocumentId];
        
        system.debug('-ContentVersion-->'+objContentVersion);
        system.debug('-objAtt-->'+objAtt.FileExtension);
        string  newBody = EncodingUtil.base64Encode(objContentVersion.VersionData);
        system.debug('------attachmentId------->>'+newBody);
        //string leadRecordId = '00Q3J000001AecB';
        
        
        
        
        Multiple_Files_Upload__c objAWS = new Multiple_Files_Upload__c();
        
        if (objAtt.Title != null && objAtt.Title != '') {
            
            string fileName =  objAtt.Title.replaceAll('[^a-zA-Z0-9\\s+]', '');
            string fileName1 = fileName.deleteWhitespace();
            try {
                System.debug('---newBody- upload AWS3  try');
                HttpRequest reqHTTP = new HttpRequest();
                reqHTTP.setEndpoint('callout:AWS3/' + getHTMLEncodedVals( 'salesforceupload/'+  +leadRecordId+ '/'+ 'Supporting_Documents/'+ fileName1+'.'+objAtt.FileExtension));
                reqHTTP.setMethod('PUT');
                Blob blobFileContent = EncodingUtil.base64Decode(newBody);
                reqHTTP.setBodyAsBlob(blobFileContent);
                Http http = new Http();
                HTTPResponse res = http.send(reqHTTP);
                
                if (res.getStatusCode() == 200 || res.getStatusCode() == 201 || Test.isRunningTest()) {
                    system.debug('Success');
                    Schema.SObjectField ftoken = Multiple_Files_Upload__c.Fields.External_Id__c;
                    
                    IsFileUploaded =true;
                    objAWS.Lead__c = leadRecordId;
                    objAWS.IsAdditionalDocument__c = true;
                    objAWS.External_Id__c = objAtt.id;
                    objAWS.Attachment_Url__c = System.Label.AWS_Url+leadRecordId+ '/'+ 'Supporting_Documents/'+ fileName1+'.'+objAtt.FileExtension;
                    Database.UpsertResult srList = Database.upsert(objAWS,ftoken,false);
                } else {
                    system.debug('Failure');
                    IsFileUploaded =false;
                }
            } catch (Exception ex) {
                system.debug('AWS Service Callout Exception on ' + 'ERROR: ' + ex.getMessage());
            }
        }
        
      //  return IsFileUploaded;
        
    }
    
    public class wrapper
    {
        @AuraEnabled
        public string Id;
        @AuraEnabled
        public boolean IsDisableBtn;
        @AuraEnabled
        public string Title;
        @AuraEnabled
        public string FileType;
        @AuraEnabled
        public string Status;
        
    }
    public static string getHTMLEncodedVals (String strInput) {
        strInput = strInput.replace(' ', '%20');
        strInput = strInput.replace('\'', '%27');
        return strInput;
    }
    
}