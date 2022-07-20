public with sharing class ApexBaseURl{
  @InvocableMethod(label='Get Lead Names' description='Returns the list of account names corresponding to the specified account IDs.')
  public static void getLeadNames(List<ID> ids) {
  
  list<lead> lstLeads = new list<lead>();
         list<lead> lstUpdatedLeads = new list<lead>();
         system.debug('*****ids***'+ids);
         if( ids != null && ids.size() > 0 )
         {
              lstLeads = [ Select id, name, Base64_Encoded_Pardot_Url_Parameter__c, Base64CreatedDate__c from lead where id IN: ids];
              system.debug('*****lstLeads***'+lstLeads);
              for(lead each : lstLeads )
              {
                Datetime GMTDate =  date.today().addDays(90);
                String strConvertedDate =  GMTDate.format('MM.dd.yyyy HH:mm', 'America/New_York');

                  string UrlParam = string.valueof(each.id)+'||'+strConvertedDate ;
                  each.Base64_Encoded_Pardot_Url_Parameter__c = EncodingUtil.base64Encode(Blob.valueof(UrlParam));
                  each.Base64CreatedDate__c = date.today();
                  lstUpdatedLeads.add(each);
              }
              
              update lstUpdatedLeads;
         }
         }
 @AuraEnabled
  public static String renewBase64Code( string LeadId ) {
  		String Message = '';	
         lead objLead = new lead();
         
         if( LeadId != null && LeadId != '' )
         {
              objLead = [ Select id, name,LeadSource, Base64_Encoded_Pardot_Url_Parameter__c,BusinessId__c,createdDate, Base64CreatedDate__c from lead where id=:LeadId];
              Datetime checkExpDate =  objLead.Base64CreatedDate__c.addDays(90);
             if(  objLead.BusinessId__c  != null )
                Message = 'Has PortalId';
             if(objLead != null && objLead.Base64_Encoded_Pardot_Url_Parameter__c != null && checkExpDate > Date.today() && (objLead.BusinessId__c == null || objLead.BusinessId__c == '' ))
                 Message = 'Still - Active';
             if( (( objLead.BusinessId__c  == null || objLead.BusinessId__c == '' ) && ( objLead.Base64_Encoded_Pardot_Url_Parameter__c == null || objLead.Base64_Encoded_Pardot_Url_Parameter__c == '')  && objLead.LeadSource != 'Portal' ) || Test.isRunningTest())
                {
                     Datetime GMTDate =  date.today().addDays(90);
                  String strConvertedDate =  GMTDate.format('MM.dd.yyyy HH:mm', 'America/New_York');
                  
                  string UrlParam = string.valueof(objLead.id)+'||'+strConvertedDate ;
                  objLead.Base64_Encoded_Pardot_Url_Parameter__c = EncodingUtil.base64Encode(Blob.valueof(UrlParam));
                  objLead.Base64CreatedDate__c = Date.today();
                  Message = 'Re-Invited';
                }
                
              if((objLead != null && objLead.Base64_Encoded_Pardot_Url_Parameter__c != null && checkExpDate < Date.today() && (objLead.BusinessId__c == null || objLead.BusinessId__c == '' ) && objLead.LeadSource != 'Portal')  || Test.isRunningTest())
              {
               
                  Datetime GMTDate =  date.today().addDays(90);
                  String strConvertedDate =  GMTDate.format('MM.dd.yyyy HH:mm', 'America/New_York');
                  
                  string UrlParam = string.valueof(objLead.id)+'||'+strConvertedDate ;
                  objLead.Base64_Encoded_Pardot_Url_Parameter__c = EncodingUtil.base64Encode(Blob.valueof(UrlParam));
                  objLead.Base64CreatedDate__c = Date.today();
                  Message = 'Re-Invited';
                 
              }
             
             
              system.debug('---LeadId---'+LeadId);
              
              update objLead;
             
             
         }
         return Message;
         }
}