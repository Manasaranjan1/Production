public without sharing class UploadToAWS_Main_CLS {
    
    
    public static string fileUrl1;
    public static string fileUrl2;
    public static string fileUrl3;
    public static string fileUrl4;
    
    public blob file { get; set; }
    public string fileName { get; set; }
    Public Attachment myfile;
    Public Attachment myfile1;
    Public Attachment myfile2;
    Public Attachment myfile3;
    string leadRecordId ;
    Amazon_AWS_S3__c objAWS = new Amazon_AWS_S3__c(); 
    
    
    public UploadToAWS_Main_CLS()
    {
        leadRecordId = ApexPages.currentPage().getParameters().get('id');
       
        
    }
    
    
    
    Public Attachment getmyfile()
    {
        myfile = new Attachment();
        return myfile;
    }
    
    Public Attachment getmyfile1()
    {
        myfile1 = new Attachment();
        return myfile1;
    }
    
    Public Attachment getmyfile2()
    {
        myfile2 = new Attachment();
        return myfile2;
    }
    
    Public Attachment getmyfile3()
    {
        myfile3= new Attachment();
        return myfile3;
    }
    
    
    public PageReference upload() {
        Multiple_Files_Upload__c objAWS = new Multiple_Files_Upload__c();
        String BaseURL = system.URL.getSalesforceBaseUrl().toExternalForm();
        PageReference objPage = new PageReference(BaseURL+'/apex/Lendistry_Lead_FileUpload?id='+leadRecordId);
        if( myfile.Body != null && myfile.Name != null )
        {
            string fileExtension = myfile.Name.substringAfterLast('.');
            string fileName =  myfile.Name.substringBeforeLast('.');
            
            string strTemp =  fileName.replaceAll('[^a-zA-Z0-9\\s+]', '');
            string fileName1 = strTemp.deleteWhitespace()+'.'+fileExtension;
            
            System.debug('---fileExtension- fileExtension---> '+fileExtension);
            System.debug('---fileName Before--> '+fileName);
            System.debug('---strTemp- Replace-- Sf---> '+strTemp);
            System.debug('---fileName1--> '+fileName1);
            
            string  newBody = EncodingUtil.base64Encode(myfile.Body);
            System.debug('---newBody- upload Sf ');
            objAWS.Attachment_Url__c = System.Label.AWS_Url+leadRecordId+ '/'+ 'SBA_APPLICATION/'+ fileName1;
            objAWS.Type__c='SBA PPP';
            UploadDocument2(fileName1, newBody, leadRecordId);
            
        }
        else
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.WARNING, 'Oops! It seems, You have not selected the file to upload. Please select the file and try again.'));
            return null;
        }
        
        
        if( leadRecordId != null && leadRecordId != '' && myfile.Body != null && myfile.Name != null )
        {
            objAWS.Lead__c = string.valueof(leadRecordId);
        
        insert objAWS;
        }
            
        // Return statement Added by Rahul. Also return type of method changed from void to PageReference
        return objPage;
        
    }
    
    public PageReference upload2() {
        Multiple_Files_Upload__c objAWS = new Multiple_Files_Upload__c();
        String BaseURL = system.URL.getSalesforceBaseUrl().toExternalForm();
        PageReference objPage = new PageReference(BaseURL+'/apex/Lendistry_Lead_FileUpload?id='+leadRecordId);
        
        if( myfile1.Body != null && myfile1.Name != null )
        {
            string fileExtension = myfile1.Name.substringAfterLast('.');
            string fileName =  myfile1.Name.substringBeforeLast('.');
            
            string strTemp =  fileName.replaceAll('[^a-zA-Z0-9\\s+]', '');
            string fileName2 = strTemp.deleteWhitespace()+'.'+fileExtension;
            
            string  newBody1 = EncodingUtil.base64Encode(myfile1.Body);
            System.debug('---newBody- upload Sf ');
            objAWS.Attachment_Url__c =System.Label.AWS_Url+leadRecordId+ '/'+ 'Corporate_Documents/'+fileName2;
            objAWS.Type__c='Corporate Documentation';
            UploadDocument1(fileName2, newBody1, leadRecordId);
        }
        else
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.WARNING, 'Oops! It seems, You have not selected the file to upload. Please select the file and try again.'));
            return null;
        }
        
        
        if( leadRecordId != null && leadRecordId != '' && myfile1.Body != null && myfile1.Name != null )
        {
            objAWS.Lead__c = string.valueof(leadRecordId);
        
        insert objAWS;
        }
        return objPage;
        
    }
    
    public PageReference upload3() {
        Multiple_Files_Upload__c objAWS = new Multiple_Files_Upload__c();
        String BaseURL = system.URL.getSalesforceBaseUrl().toExternalForm();
        PageReference objPage = new PageReference(BaseURL+'/apex/Lendistry_Lead_FileUpload?id='+leadRecordId);
        
        
        if( myfile2.Body != null && myfile2.Name != null )
        {
            string fileExtension = myfile2.Name.substringAfterLast('.');
            string fileName =  myfile2.Name.substringBeforeLast('.');
            
            string strTemp =  fileName.replaceAll('[^a-zA-Z0-9\\s+]', '');
            string fileName3 = strTemp.deleteWhitespace()+'.'+fileExtension;
            
            string  newBody2 = EncodingUtil.base64Encode(myfile2.Body);
            objAWS.Attachment_Url__c = System.Label.AWS_Url+leadRecordId+ '/'+ 'LAST_YEAR_PAYROLL/'+ fileName3;
            objAWS.Type__c='Payroll Documentation';
            UploadDocument(fileName3, newBody2, leadRecordId);
        }
        else
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.WARNING, 'Oops! It seems, You have not selected the file to upload. Please select the file and try again.'));
            return null;
        }
        
        
        if( leadRecordId != null && leadRecordId != '' && myfile2.Body != null && myfile2.Name != null )
        {
            objAWS.Lead__c = string.valueof(leadRecordId);
        
        insert objAWS;
        }
        return objPage;
    }
    
    public PageReference upload4() {
        Multiple_Files_Upload__c objAWS = new Multiple_Files_Upload__c();
        String BaseURL = system.URL.getSalesforceBaseUrl().toExternalForm();
        PageReference objPage = new PageReference(BaseURL+'/apex/Lendistry_Lead_FileUpload?id='+leadRecordId);
        
        if( myfile3.Body != null && myfile3.Name != null )
        {
            string fileExtension = myfile3.Name.substringAfterLast('.');
            string fileName =  myfile3.Name.substringBeforeLast('.');
            
            string strTemp =  fileName.replaceAll('[^a-zA-Z0-9\\s+]', '');
            string fileName4 = strTemp.deleteWhitespace()+'.'+fileExtension;
            
            string  newBody3 = EncodingUtil.base64Encode(myfile3.Body);
            objAWS.Attachment_Url__c = System.Label.AWS_Url+leadRecordId+ '/'+ 'Tax_Return/'+ fileName4;
            objAWS.Type__c='Tax Documentation';
            UploadDocument3(fileName4, newBody3, leadRecordId);
        }
       else
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.WARNING, 'Oops! It seems, You have not selected the file to upload. Please select the file and try again.'));
            return null;
        }
        
        
        if( leadRecordId != null && leadRecordId != '' && myfile3.Body != null && myfile3.Name != null )
        {
            objAWS.Lead__c = string.valueof(leadRecordId);
        
        insert objAWS;
        }
        return objPage;
    }
    
    
    
    @future(callout=true)  // LAST_YEAR_PAYROLL
    public static void UploadDocument (String strFileKey, String strBase64Content, string leadRecordId ) {
        System.debug('---newBody- upload AWS3 ');
        
        if (strFileKey != null && strFileKey != '') {
            try {
                System.debug('---newBody- upload AWS3  try');
                HttpRequest reqHTTP = new HttpRequest();
                reqHTTP.setEndpoint('callout:AWS3/' + getHTMLEncodedVals( 'salesforceupload/'+  +leadRecordId+ '/'+ 'LAST_YEAR_PAYROLL/'+ strFileKey));
                reqHTTP.setMethod('PUT');
                Blob blobFileContent = EncodingUtil.base64Decode(strBase64Content);
                reqHTTP.setBodyAsBlob(blobFileContent);
                Http http = new Http();
                HTTPResponse res = http.send(reqHTTP);
                
                if (res.getStatusCode() == 200 || res.getStatusCode() == 201) {
                    system.debug('Success');
                } else {
                    system.debug('Failure');
                }
            } catch (Exception ex) {
                system.debug('AWS Service Callout Exception on ' + 'ERROR: ' + ex.getMessage());
            }
        }
    }
    
    public static string getHTMLEncodedVals (String strInput) {
        strInput = strInput.replace(' ', '%20');
        strInput = strInput.replace('\'', '%27');
        return strInput;
    }
    @future(callout=true)
    public static void UploadDocument1 (String strFileKey, String strBase64Content, string leadRecordId ) {
        System.debug('---newBody- upload AWS3 ');
        
        if (strFileKey != null && strFileKey != '') {
            try {
                System.debug('---newBody- upload AWS3  try');
                HttpRequest reqHTTP = new HttpRequest();
                reqHTTP.setEndpoint('callout:AWS3/' + getHTMLEncodedVals1( 'salesforceupload/'+leadRecordId+ '/'+ 'Corporate_Documents/'+strFileKey));
                reqHTTP.setMethod('PUT');
                Blob blobFileContent = EncodingUtil.base64Decode(strBase64Content);
                reqHTTP.setBodyAsBlob(blobFileContent);
                Http http = new Http();
                HTTPResponse res = http.send(reqHTTP);
                
                if (res.getStatusCode() == 200 || res.getStatusCode() == 201) {
                    system.debug('Success');
                    
                } else {
                    system.debug('Failure');
                }
            } catch (Exception ex) {
                system.debug('AWS Service Callout Exception on ' + 'ERROR: ' + ex.getMessage());
            }
        }
    }
    
    public static string getHTMLEncodedVals1 (String strInput) {
        strInput = strInput.replace(' ', '%20');
        strInput = strInput.replace('\'', '%27');
        return strInput;
    }
    
    @future(callout=true) // SBA_APPLICATION
    public static void UploadDocument2 (String strFileKey, String strBase64Content,  string leadRecordId ) {
        System.debug('---newBody- upload AWS3 ');
        
        if (strFileKey != null && strFileKey != '') {
            try {
                System.debug('---newBody- upload AWS3  try');
                HttpRequest reqHTTP = new HttpRequest();
                reqHTTP.setEndpoint('callout:AWS3/' + getHTMLEncodedVals2( 'salesforceupload/'+leadRecordId+ '/'+ 'SBA_APPLICATION/'+strFileKey));
                reqHTTP.setMethod('PUT');
                Blob blobFileContent = EncodingUtil.base64Decode(strBase64Content);
                reqHTTP.setBodyAsBlob(blobFileContent);
                Http http = new Http();
                HTTPResponse res = http.send(reqHTTP);
                
                if (res.getStatusCode() == 200 || res.getStatusCode() == 201) {
                    system.debug('Success');
                    
                } else {
                    system.debug('Failure');
                }
            } catch (Exception ex) {
                system.debug('AWS Service Callout Exception on ' + 'ERROR: ' + ex.getMessage());
            }
        }
    }
    
    public static string getHTMLEncodedVals2 (String strInput) {
        strInput = strInput.replace(' ', '%20');
        strInput = strInput.replace('\'', '%27');
        return strInput;
    }
    
    
    @future(callout=true)
    public static void UploadDocument3 (String strFileKey, String strBase64Content , string leadRecordId ) {
        System.debug('---newBody- upload AWS3 ');
        
        if (strFileKey != null && strFileKey != '') {
            try {
                System.debug('---newBody- upload AWS3  try');
                HttpRequest reqHTTP = new HttpRequest();
                reqHTTP.setEndpoint('callout:AWS3/' + getHTMLEncodedVals3( 'salesforceupload/'+leadRecordId+ '/'+ 'Tax_Return/'+strFileKey));
                reqHTTP.setMethod('PUT');
                Blob blobFileContent = EncodingUtil.base64Decode(strBase64Content);
                reqHTTP.setBodyAsBlob(blobFileContent);
                Http http = new Http();
                HTTPResponse res = http.send(reqHTTP);
                
                if (res.getStatusCode() == 200 || res.getStatusCode() == 201) {
                    system.debug('Success');
                    
                } else {
                    system.debug('Failure');
                }
            } catch (Exception ex) {
                system.debug('AWS Service Callout Exception on ' + 'ERROR: ' + ex.getMessage());
            }
        }
    }
    
    public static string getHTMLEncodedVals3 (String strInput) {
        strInput = strInput.replace(' ', '%20');
        strInput = strInput.replace('\'', '%27');
        return strInput;
    }
    
    
    public PageReference FinishMethod() {
        String BaseURL = system.URL.getSalesforceBaseUrl().toExternalForm();
        PageReference retURL = new PageReference(BaseURL+'/Lendistry_ThankYouPage');
        retURL.setRedirect(true);
		return   retURL;          
    }
    
}