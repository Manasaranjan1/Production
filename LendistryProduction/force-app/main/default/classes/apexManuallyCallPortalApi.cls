public class apexManuallyCallPortalApi {
    
    public static void CallAllApi( string leadId, string loanType )
    {
        lead objLead = [ Select id,recordtypeid,PortalAPIEndPoint__c, Application_ID__c, ConvertedOpportunityId,Application_ID_SBAPPP__c,BusinessId__c,Owner_ID_Owner_1__c, Business_ID_SBAPPP__c from Lead where IsConverted = true AND id=:leadId ];
    
        if( loanType == 'SBA-PPP')
        {
           if(!System.isFuture() && !System.isBatch() )
{
               JavaAPICallOut.makeJavaPortalAPICall(objLead.PortalAPIEndPoint__c,  objLead.Business_ID_SBAPPP__c,  objLead.ConvertedOpportunityId,  objLead.Id, string.valueof( objLead.Application_ID_SBAPPP__c)  );
                ApexUtil.wait(2000);
            }
            if(!System.isFuture() && !System.isBatch() )
            {
                 LeadTriggerHandler.sendReportsAttachmentToJava(objLead.PortalAPIEndPoint__c,string.valueof( objLead.id), objLead.Business_ID_SBAPPP__c, string.valueof( objLead.Application_ID_SBAPPP__c) , objLead.Owner_ID_Owner_1__c);
                
                
            }
            
            if(!System.isFuture() && !System.isBatch() )
            {
                JavaAPICallOut.makeAdditionalDocumentsApiCall(objLead.PortalAPIEndPoint__c,string.valueof( objLead.id),  objLead.Business_ID_SBAPPP__c, string.valueof(objLead.ConvertedOpportunityId));
                
           }

        }
        if( ( loanType == 'PA CARES' || loanType == 'Non SBA'))
        {
            Id recTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('GRANT').getRecordTypeId();
            if(objLead.recordtypeid != recTypeId){
                if(!System.isFuture() && !System.isBatch() )
                {
                    JavaAPICallOut.sendLeadDataToJavaDB(objLead.PortalAPIEndPoint__c,string.valueof( objLead.BusinessId__c), string.valueof( objLead.id), string.valueof( objLead.ConvertedOpportunityId) , string.valueof( objLead.Application_ID__c));
                    ApexUtil.wait(2000);
                    
                } 
            }
            
            
            if(!System.isFuture() && !System.isBatch() )
            {
               JavaAPICallOut.makeJavaPortalAPICall(objLead.PortalAPIEndPoint__c,  objLead.BusinessId__c,  objLead.ConvertedOpportunityId,  objLead.Id, string.valueof( objLead.Application_ID__c)  );
                ApexUtil.wait(2000);
               
            }
            if(!System.isFuture() && !System.isBatch() )
            {
                LeadTriggerHandler.sendReportsAttachmentToJava(objLead.PortalAPIEndPoint__c,string.valueof( objLead.id),  objLead.BusinessId__c, string.valueof( objLead.Application_ID__c), null);
                
                
            }
        }
    }
}