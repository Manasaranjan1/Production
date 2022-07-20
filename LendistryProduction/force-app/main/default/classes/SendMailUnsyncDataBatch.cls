// batch class 
/****************************************************************
Class Name : SendMailUnsyncDataBatch 
Team       : SF Team
description : This batch process Lead records of SBA-PP type
               an mail a csv file. 

*****************************************************************/
global class SendMailUnsyncDataBatch implements   Database.Batchable<sObject>{
    
    // instance member to retain state across transactions
     global final String Query;
     global SendMailUnsyncDataBatch (String q){
         query=q;
   }
    // start method here to get all records
    global Database.QueryLocator start(Database.BatchableContext bc) {      
        return Database.getQueryLocator(query);
    }
    
    // execute method perform all processing..
    global void execute(Database.BatchableContext bc, List<Lead> listOfLead){
        system.debug('????????????'+listOfLead.size());
        String emailId =  Label.Email;
        String[] emails;
        List<String> toAddress = new List<String>();
        if(emailId !=null && emailId.contains(',')){
            emails = emailId.split(',');
            for(String str : emails){
                toAddress.add(str);
            }
        }
        else
            toAddress.add(emailId);
        string header = 'Record Id, Name , IsSyncWithPortal, Is Batch Picked , Application ID SBA-PPP , Business ID SBA-PPP ,Owner ID , Business EIN , PostalCode , Zip Code (Owner 1)\n';
        string finalstr = header ;
        if(listOfLead !=null && listOfLead.size()>0){
            for(Lead ld: listOfLead){        
               string recordString = '';//ld.id+','+ld.Name+','+ld.IsSyncWithPortal__c+','+ld.IS_Batch_Picked__c+','+ld.Application_ID_SBAPPP__c+','+ld.Business_ID_SBAPPP__c+','+ld.Owner_ID_Owner_1__c+','+ld.Business_EIN__c.replaceall(',','')+','+ld.postalCode+','+ld.Zip_Code_Owner_1__c+'\n';        
               recordString += ld.Id+',';
               if(ld.name!=null && ld.name!='')
                   recordString += ld.name.replaceAll(',','')+',';
               else
                    recordString += ld.name+',';
               recordString += ld.IsSyncWithPortal__c+',';
               recordString += ld.IS_Batch_Picked__c+',';
               if(ld.Application_ID_SBAPPP__c!=null && ld.Application_ID_SBAPPP__c!='')               
                   recordString += ld.Application_ID_SBAPPP__c.replaceAll(',','')+',';
               else
                   recordString += ld.Application_ID_SBAPPP__c+',';
                   
               if(ld.Business_ID_SBAPPP__c!=null && ld.Business_ID_SBAPPP__c!='')               
                   recordString += ld.Business_ID_SBAPPP__c.replaceAll(',','')+',';
               else
                   recordString += ld.Business_ID_SBAPPP__c+',';
              
               if(ld.Owner_ID_Owner_1__c !=null && ld.Owner_ID_Owner_1__c!='')
                   recordString += ld.Owner_ID_Owner_1__c.replaceAll(',','')+',';
               else
                   recordString += ld.Owner_ID_Owner_1__c+',';
                   
               if(ld.Business_EIN__c!=null && ld.Business_EIN__c!='')               
                   recordString += ld.Business_EIN__c.replaceAll(',','')+',';
               else
                   recordString += ld.Business_EIN__c+',';
                   
              if(ld.postalCode!=null && ld.postalCode!='')               
                   recordString += ld.postalCode.replaceAll(',','')+',';
               else
                   recordString += ld.postalCode+',';
               
               if(ld.Zip_Code_Owner_1__c!=null && ld.Zip_Code_Owner_1__c!='')               
                   recordString += ld.Zip_Code_Owner_1__c.replaceAll(',','')+'\n';
               else
                   recordString += ld.Zip_Code_Owner_1__c+'\n';
               finalstr = finalstr +recordString;        
            }
    
            Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
            blob csvBlob = Blob.valueOf(finalstr);
            string csvname= 'Lead.csv';
            csvAttc.setFileName(csvname);
            csvAttc.setBody(csvBlob);
            Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
            String[] toAddresses = toAddress;
            String subject ='Lead CSV';
            email.setSubject(subject);
            email.setToAddresses( toAddresses );
            email.setPlainTextBody('Lead CSV');
            email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }
        
    }    
    global void finish(Database.BatchableContext bc){
         // callout future method
         
        
    }    
}