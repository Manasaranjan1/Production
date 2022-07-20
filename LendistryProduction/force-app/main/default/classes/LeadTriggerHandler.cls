/**
* @File Name          : LeadTriggerHandler.cls
* @Description        : 
* @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
* @Group              : 
* @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
* @Last Modified On   : 4/13/2020, 5:34:46 PM
* @Modification Log   : 
* Ver       Date            Author                 Modification
* 1.0    4/13/2020   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
public with sharing class LeadTriggerHandler
{
    private boolean m_isExecuting = false;
    private integer BatchSize = 0;
    public static boolean IsFromBachJob ;
    public static boolean isFromUploadAPI=false;
    public static boolean IsLeadRecursive = false;
    public static boolean IsLeadRecursiveAtt = false;
    public static boolean IsSalesScreenDataApi = false;
    public static boolean IsLeadToOppDataApi = false;
    public static boolean IsLeadToOppFileDataApi = false;
    public static boolean IsLeadToOppSBA_Docs = false;
    Trigger_ON_OFF_Setting__c triggerONOFF = Trigger_ON_OFF_Setting__c.getInstance('LeadTrigger_Switch');
    // API method stop custom setting
    public static string JavaDefaultEndPoint = System.Label.JavaDefaultEndPoint;
    
    public LeadTriggerHandler(boolean isExecuting, integer size)
    {
        m_isExecuting = isExecuting;
        BatchSize = size;
    }
    
    public void onBeforeInsert(List<Lead> newLead, List<Lead> old, Map<ID, Lead> newLeadMap )
    {
        Id LeadGrantRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('GRANT').getRecordTypeId();
        for( lead each : newLead)
        {
            if( each.Custom_Last_Modified_By__c  == null )
                each.Custom_Last_Modified_By__c  = userinfo.getuserid(); //ID.valueof(loggedInUser.id);
            if( each.LastModifiedDate != null)   
                each.Custom_Last_Modified_Date__c = each.LastModifiedDate;
            if(each.RecordTypeId == LeadGrantRecordTypeId && each.Run_Credit_Report__c == true && each.Loan_Type__c == 'PA CARES BB'){
                each.PA_Cares_BB__c = true;
            }      
        }
        
        
    }
    
    // Added by ushank Khanna
    public void OnAfterInsert( List<Lead> newLead, Map<ID, Lead> oldLeadMap ) {
        String GQRecordTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('General Questions Contact Form').getRecordTypeId();
        String PCRecordTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Partnership Contact Form').getRecordTypeId();
          // call Lead history by saurabh
        insertLeadHistory.createHistory(newLead);
        createCreateReport(newLead, oldLeadMap);
        //Added by Cloud Maven, INC
        createCriminalCheckerReports(newLead,oldLeadMap);
        
        string convertedOppId = newLead[0].ConvertedOpportunityId;
        set<string> setofleads = new set<string>();
        if( newLead != null && newLead.size() > 0 )
        {
            for( lead each : newLead)
            {
                if(each.RecordTypeId != GQRecordTypeID && each.RecordTypeId != PCRecordTypeID){
                    setofleads.add(each.id);
                }
            }
            system.debug('**11***setofleads***'+setofleads);
            // if(!System.isFuture() && !System.isBatch())
            //  updateLeadRecords(setofleads);
        }
        
    }
    
    public void OnAfterUpdate( List<Lead> newLead, List<Lead> old, Map<ID, Lead> newLeadMap , Map<ID, Lead> oldLeadMap )
    {
        map<string, string> mapOfContactEmails = new map<string, string>();
        map<string, string> mapOfOwnersCreditScore = new map<string, string>();
        set<string> setOfOwnerIds = new set<string>();
        boolean isFutur =false;
        // added by saurabh kumar on 25 march 2021
        List<Lead> leadForHistory = new List<Lead>();
        Id LendistryDefaultRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Lendistry Default').getRecordTypeId();
        Id LendistryLendingRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Lendistry Lending').getRecordTypeId();
        Id GrantRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('GRANT').getRecordTypeId();
        Id GrantNyrrecTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('GRANT-NYR').getRecordTypeId();
        Id SBAPPRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('SBA - PPP').getRecordTypeId();
        Id GrantNYCTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Grant-NYC').getRecordTypeId();
        // get user id custom setting 
        // add ed by Saurabh Kumar on 31 december 2020
        
        String user1 = IntegratioinExecutionOrder__c.getValues('UserId') != null ? IntegratioinExecutionOrder__c.getValues('UserId').DevOps1__c : '';
        String user2 = IntegratioinExecutionOrder__c.getValues('UserId') != null ? IntegratioinExecutionOrder__c.getValues('UserId').DevOps2__c: '';
        String user3 = IntegratioinExecutionOrder__c.getValues('UserId') != null ? IntegratioinExecutionOrder__c.getValues('UserId').DevOps3__c: '';
        String user4 = IntegratioinExecutionOrder__c.getValues('UserId') != null ? IntegratioinExecutionOrder__c.getValues('UserId').DevOps4__c: '';
        String B2BMAUSER = IntegratioinExecutionOrder__c.getValues('UserId') != null ? IntegratioinExecutionOrder__c.getValues('UserId').B2BMAUSER__c : '';
        String GuestSiteUSER = IntegratioinExecutionOrder__c.getValues('UserId') != null ? IntegratioinExecutionOrder__c.getValues('UserId').GuestUser__c : '';
        String currentuserid = userInfo.getUserId();
        system.debug('Check--Points--1' +user1 );
        system.debug('*********************BatchSize***************>>'+BatchSize);
        if( newLead[0].IsConverted  && newLead[0].BusinessId__c != null && newLead[0].BusinessId__c != '' && ( (B2BMAUSER != null && !currentuserid.contains(B2BMAUSER )) && (user1!=null  && !currentuserid.contains(user1)) && (user2 !=null && !currentuserid.contains(user2)) && (user3 !=null && !currentuserid.contains(user3) ) && (user4 !=null && !currentuserid.contains(user4)) ))  
        {
            system.debug('Check--Points--2' );
            
            
            if(!System.isFuture() && !System.isBatch() && JavaAPICallOut.isRecursiveSalesScreen && IsSalesScreenDataApi == false && triggerONOFF.Lead_NonSBA_Method_1__c)
            {
                // custom setting for controlling API method call out
                if((newLead[0].PortalAPIEndPoint__c != null && newLead[0].PortalAPIEndPoint__c != '') && (newLead[0].RecordTypeId != GrantRecordTypeId || newLead[0].RecordTypeId != GrantNyrrecTypeId) && !Test.isRunningTest()){
                    JavaAPICallOut.sendLeadDataToJavaDB(JavaDefaultEndPoint,  newLead[0].BusinessId__c, newLead[0].Id, newLead[0].ConvertedOpportunityId,  string.valueof( newLead[0].Application_ID__c)  );
                    ApexUtil.wait(2000);
                    IsSalesScreenDataApi = true;                                           
                }                
            } 
            
            if(!System.isFuture() && !System.isBatch() && JavaAPICallOut.isRecursiveLeadToOppCall && IsLeadToOppDataApi==false && triggerONOFF.Lead_NonSBA_Method_2__c && !Test.isRunningTest())
            {
                // add logic here for setting portal server endpoint based on Tenant URL on Lead 
                if( newLead[0].PortalAPIEndPoint__c != null && newLead[0].PortalAPIEndPoint__c != '' && (newLead[0].RecordTypeid == GrantRecordTypeId || newLead[0].RecordTypeId == GrantNyrrecTypeId || newLead[0].RecordTypeId == GrantNYCTypeId)){
                    JavaAPICallOut.makeJavaPortalAPICall(newLead[0].PortalAPIEndPoint__c,  newLead[0].BusinessId__c,  newLead[0].ConvertedOpportunityId,  newLead[0].Id, string.valueof( newLead[0].Application_ID__c)  );
                    IsLeadToOppDataApi = true;
                }
                if( (newLead[0].PortalAPIEndPoint__c != null && newLead[0].PortalAPIEndPoint__c != '') && (newLead[0].RecordTypeid != GrantRecordTypeId && newLead[0].RecordTypeId != GrantNyrrecTypeId && newLead[0].RecordTypeId != GrantNYCTypeId)){
                    JavaAPICallOut.makeJavaPortalAPICall(JavaDefaultEndPoint,  newLead[0].BusinessId__c,  newLead[0].ConvertedOpportunityId,  newLead[0].Id, string.valueof( newLead[0].Application_ID__c)  );
                    IsLeadToOppDataApi = true;
                }
                ApexUtil.wait(2000);
                
                
            }
            if(!System.isFuture() && !System.isBatch() && JavaAPICallOut.isRecursiveCreditReports && IsLeadToOppFileDataApi == false && triggerONOFF.Lead_NonSBA_Method_3__c && !Test.isRunningTest())
            {
                if( newLead[0].PortalAPIEndPoint__c != null && newLead[0].PortalAPIEndPoint__c != '' && (newLead[0].RecordTypeid == GrantRecordTypeId || newLead[0].RecordTypeId == GrantNyrrecTypeId || newLead[0].RecordTypeId == GrantNYCTypeId))
                    sendReportsAttachmentToJava(newLead[0].PortalAPIEndPoint__c,string.valueof( newLead[0].id),  newLead[0].BusinessId__c, string.valueof( newLead[0].Application_ID__c), null);
                if( (newLead[0].PortalAPIEndPoint__c != null && newLead[0].PortalAPIEndPoint__c != '') && (newLead[0].RecordTypeid != GrantRecordTypeId || newLead[0].RecordTypeId != GrantNyrrecTypeId || newLead[0].RecordTypeId != GrantNYCTypeId))
                    sendReportsAttachmentToJava(JavaDefaultEndPoint,string.valueof( newLead[0].id),  newLead[0].BusinessId__c, string.valueof( newLead[0].Application_ID__c), null);
                    IsLeadToOppFileDataApi = true;
                
                sendReportsAttachmentToJava(string.valueof( newLead[0].id),  newLead[0].BusinessId__c, string.valueof( newLead[0].Application_ID__c), null, null);
                
                
            }  
        }
        // Whenever Lead is updated on salesforce calling API to Patch Lead data on Portal in case of SBA-PPP applications
        system.debug('*************before********if block***************>>');
        system.debug('Check--Points--1'+currentuserid);
        if( (Test.isRunningTest()) || (!System.isFuture() && !System.isBatch() && triggerONOFF.LeadSBAMethod5__c && newLead[0].IsConverted == false &&
                                       
                                       ( (GuestSiteUSER != null && !currentuserid.contains(GuestSiteUSER )) && (B2BMAUSER != null && !currentuserid.contains(B2BMAUSER )) && (user1!=null  && !currentuserid.contains(user1)) && (user2 !=null && !currentuserid.contains(user2)) && (user3 !=null && !currentuserid.contains(user3) ) && (user4 !=null && !currentuserid.contains(user4)) )))
        {
            system.debug('Check--Points--2'+currentuserid);
            for(Lead eachObj : newLead){
                set<id> setOfLeadId = new set<id>();                                                                                                                                                          
                setOfLeadId.add(eachObj.id);
                if( eachObj.PortalAPIEndPoint__c != null && eachObj.PortalAPIEndPoint__c != '' && ( eachObj.RecordTypeid == SBAPPRecordTypeId || eachObj.RecordTypeid == GrantRecordTypeId || eachObj.RecordTypeid == GrantNYCTypeId || eachObj.RecordTypeid == GrantNyrrecTypeId) && !Test.isRunningTest())
                    JavaAPICallOut2.updateLeadSFToPortal(setOfLeadId,eachObj.PortalAPIEndPoint__c );
                if((eachObj.PortalAPIEndPoint__c != null && eachObj.PortalAPIEndPoint__c !='') && ( eachObj.RecordTypeid != SBAPPRecordTypeId || eachObj.RecordTypeid != GrantRecordTypeId || eachObj.RecordTypeid != GrantNYCTypeId || eachObj.RecordTypeid == GrantNyrrecTypeId) && !Test.isRunningTest()){  
                    JavaAPICallOut2.updateLeadSFToPortal(setOfLeadId, JavaDefaultEndPoint);
                }                  
            } 
            
        }
        
        
        //=======================Adding these calls for SBA Application==============================================
        if( (system.Test.isRunningTest()) || ( newLead[0].IsConverted  &&  ( ( newLead[0].Business_ID_SBAPPP__c != null && newLead[0].Business_ID_SBAPPP__c != '' ) || ( newLead[0].BusinessId__c != null && newLead[0].BusinessId__c != '')) && ( (GuestSiteUSER != null && !currentuserid.contains(GuestSiteUSER )) && (B2BMAUSER != null && !currentuserid.contains(B2BMAUSER )) && (user1!=null  && !currentuserid.contains(user1)) && (user2 !=null && !currentuserid.contains(user2)) && (user3 !=null && !currentuserid.contains(user3) ) && (user4 !=null && !currentuserid.contains(user4)) ) )) 
        {
            
            /*  ----- Comented by Boddh As disscused with JD, That we are not going to hit this api in case of SBA-PPP---
            if(!System.isFuture() && !System.isBatch() && IsSalesScreenDataApi == false && triggerONOFF.Lead_SBA_Method_1__c)
            {
            JavaAPICallOut.sendLeadDataToJavaDB(string.valueof( newLead[0].Business_ID_SBAPPP__c), string.valueof( newLead[0].id), string.valueof( newLead[0].ConvertedOpportunityId) , string.valueof( newLead[0].Application_ID_SBAPPP__c));
            ApexUtil.wait(2000);
            IsSalesScreenDataApi = true;
            } 
            */
            
            if(!System.isFuture() && !System.isBatch() && IsLeadToOppDataApi == false  && triggerONOFF.LeadSBAMethod2__c && !Test.isRunningTest())
            {
                
                System.debug(' Testing SBA-PPP Conversion 1');
                if( newLead[0].PortalAPIEndPoint__c != null && newLead[0].PortalAPIEndPoint__c != '' && newLead[0].RecordTypeid == SBAPPRecordTypeId)
                    JavaAPICallOut.makeJavaPortalAPICall(newLead[0].PortalAPIEndPoint__c,  newLead[0].Business_ID_SBAPPP__c,  newLead[0].ConvertedOpportunityId,  newLead[0].Id, string.valueof( newLead[0].Application_ID_SBAPPP__c)  );
                //if( (newLead[0].PortalAPIEndPoint__c != null && newLead[0].PortalAPIEndPoint__c != '') && newLead[0].RecordTypeid  !=SBAPPRecordTypeId)
                   // JavaAPICallOut.makeJavaPortalAPICall(JavaDefaultEndPoint,  newLead[0].Business_ID_SBAPPP__c,  newLead[0].ConvertedOpportunityId,  newLead[0].Id, string.valueof( newLead[0].Application_ID_SBAPPP__c)  );
                ApexUtil.wait(2000);
                IsLeadToOppDataApi = true;
                System.debug(' Testing SBA-PPP Conversion 2');
            }
            if(!System.isFuture() && !System.isBatch() && IsLeadToOppFileDataApi == false && triggerONOFF.LeadSBAMethod3__c){
                if( newLead[0].PortalAPIEndPoint__c != null && newLead[0].PortalAPIEndPoint__c != '' && newLead[0].RecordTypeid ==SBAPPRecordTypeId)
                    sendReportsAttachmentToJava(newLead[0].PortalAPIEndPoint__c,string.valueof( newLead[0].id), newLead[0].Business_ID_SBAPPP__c, string.valueof( newLead[0].Application_ID_SBAPPP__c) , newLead[0].Owner_ID_Owner_1__c);
                if( (newLead[0].PortalAPIEndPoint__c != null && newLead[0].PortalAPIEndPoint__c != '') && newLead[0].RecordTypeid !=SBAPPRecordTypeId)
                    sendReportsAttachmentToJava(JavaDefaultEndPoint,string.valueof( newLead[0].id), newLead[0].Business_ID_SBAPPP__c, string.valueof( newLead[0].Application_ID_SBAPPP__c) , newLead[0].Owner_ID_Owner_1__c);
                
                IsLeadToOppFileDataApi = true;
                
                // sendReportsAttachmentToJava(string.valueof( newLead[0].id), newLead[0].Business_ID_SBAPPP__c, string.valueof( newLead[0].Application_ID_SBAPPP__c) , newLead[0].Owner_ID_Owner_1__c);
                
                
            }
            
            if( (Test.isRunningTest()) || (!System.isFuture() && !System.isBatch() && IsLeadToOppSBA_Docs == false && triggerONOFF.LeadSBAMethod4__c && newLead[0].Business_ID_SBAPPP__c != null ))
            {
                if( newLead[0].PortalAPIEndPoint__c != null && newLead[0].PortalAPIEndPoint__c != '' && newLead[0].RecordTypeid ==SBAPPRecordTypeId)
                    JavaAPICallOut.makeAdditionalDocumentsApiCall(newLead[0].PortalAPIEndPoint__c ,string.valueof( newLead[0].id),  newLead[0].Business_ID_SBAPPP__c, string.valueof(newLead[0].ConvertedOpportunityId));
                if( (newLead[0].PortalAPIEndPoint__c != null && newLead[0].PortalAPIEndPoint__c != '') && newLead[0].RecordTypeid !=SBAPPRecordTypeId)
                    JavaAPICallOut.makeAdditionalDocumentsApiCall(JavaDefaultEndPoint,string.valueof( newLead[0].id),  newLead[0].Business_ID_SBAPPP__c, string.valueof(newLead[0].ConvertedOpportunityId));
                IsLeadToOppSBA_Docs = true;
                
            }
            
            if(!System.isFuture() && !System.isBatch() && IsLeadToOppSBA_Docs == false && triggerONOFF.Lead_NonSBA_Method_5__c && newLead[0].BusinessId__c != null )
            {
                if( newLead[0].PortalAPIEndPoint__c != null && newLead[0].PortalAPIEndPoint__c != '' && newLead[0].RecordTypeid ==SBAPPRecordTypeId)
                    JavaAPICallOut.makeAdditionalDocumentsApiCall(JavaDefaultEndPoint,string.valueof( newLead[0].id),  newLead[0].BusinessId__c, string.valueof(newLead[0].ConvertedOpportunityId));
                if( (newLead[0].PortalAPIEndPoint__c != null && newLead[0].PortalAPIEndPoint__c != '') && newLead[0].RecordTypeid !=SBAPPRecordTypeId)
                    JavaAPICallOut.makeAdditionalDocumentsApiCall(JavaDefaultEndPoint,string.valueof( newLead[0].id),  newLead[0].Business_ID_SBAPPP__c, string.valueof(newLead[0].ConvertedOpportunityId));
                IsLeadToOppSBA_Docs = true;
                
            }
            
            
            
        }
        // else if( newLead[0].Interest_Type__c != null && newLead[0].processing_fee__c && newLead[0].Origination_Fee__c != null)
        
        
        for(Lead eachLead : newLead)
        {
            system.debug('*********************eachLead***************>>'+eachLead.creditchecker__Average_Score__c);
            Lead objOldLead = new Lead();
            objOldLead = oldLeadMap.get(eachLead.id);
            
            // added by saurabh kumar on 14 december 2020
            if(objOldLead.status != eachLead.status){
                leadForHistory.add(eachLead);                 
            }
            
            
            if( eachLead.IsConverted  && eachLead.BusinessId__c != null && eachLead.BusinessId__c != '' ) 
            {
                if( eachLead.Email != null && eachLead.Email != '' && eachLead.Owner_ID_Owner_1__c != null && eachLead.Owner_ID_Owner_1__c != '')
                {
                    mapOfContactEmails.put(eachLead.Email, eachLead.Owner_ID_Owner_1__c);
                    mapOfOwnersCreditScore.put(eachLead.Owner_ID_Owner_1__c , string.valueof(eachLead.Actual_Owner1_Credit_Score__c));
                }   
                if( eachLead.Email_2nd_Owner__c != null && eachLead.Email_2nd_Owner__c != '' && eachLead.Owner_ID_Owner_2__c != null && eachLead.Owner_ID_Owner_2__c != '')
                {
                    mapOfContactEmails.put(eachLead.Email_2nd_Owner__c, string.valueof(eachLead.Owner_ID_Owner_2__c));
                    mapOfOwnersCreditScore.put(eachLead.Owner_ID_Owner_2__c , string.valueof(eachLead.Actual_Owner2_Credit_Score__c));
                }
                if( eachLead.Email_3rd_Owner__c != null && eachLead.Email_3rd_Owner__c != '' && eachLead.Owner_ID_Owner_3__c != null && eachLead.Owner_ID_Owner_3__c != '')
                {
                    mapOfContactEmails.put(eachLead.Email_3rd_Owner__c, eachLead.Owner_ID_Owner_3__c);
                    mapOfOwnersCreditScore.put(eachLead.Owner_ID_Owner_3__c , string.valueof(eachLead.Actual_Owner3_Credit_Score__c));
                }
                if( eachLead.Email_4th_Owner__c != null && eachLead.Email_4th_Owner__c != '' && eachLead.Owner_ID_Owner_4__c!=null && eachLead.Owner_ID_Owner_4__c!= '' )
                {
                    mapOfContactEmails.put(eachLead.Email_4th_Owner__c, eachLead.Owner_ID_Owner_4__c);
                    mapOfOwnersCreditScore.put(eachLead.Owner_ID_Owner_4__c , string.valueof(eachLead.Actual_Owner4_Credit_Score__c));
                    
                }
                if( eachLead.Email_5th_Owner__c != null && eachLead.Email_5th_Owner__c != '' && eachLead.Owner_ID_Owner_5__c != null && eachLead.Owner_ID_Owner_5__c != '')
                {
                    mapOfContactEmails.put(eachLead.Email_5th_Owner__c, eachLead.Owner_ID_Owner_5__c);
                    mapOfOwnersCreditScore.put(eachLead.Owner_ID_Owner_5__c , string.valueof(eachLead.Actual_Owner5_Credit_Score__c));
                }
                
            }
            
            system.debug('*********************mapOfOwnersCreditScore ***************>>'+mapOfOwnersCreditScore );
            
        }
        
        
        // Added by ushank Khanna
        createCreateReport(newLead, oldLeadMap); 
        createCriminalCheckerReports(newLead,oldLeadMap);
        // by saurabh Kumar
        insertLeadHistory.updateAndInsertHistory(leadForHistory);  
        //added by cloud maven, inc - will update the criminal report owner
        verifyOwnerShipChange(newLead,oldLeadMap);
    }

    public void verifyOwnerShipChange(List<Lead> newLead, Map<ID, Lead> oldLeadMap) {
        Map<Id, Decimal> mapLeadPercentage = new Map<Id, Decimal>();
        Id GrantNYCrecTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Grant-NYC').getRecordTypeId();

        for(Lead oRecord : newLead) {
            Lead oldRecord = oldLeadMap.get(oRecord.Id);
            if(GrantNYCrecTypeId == oRecord.RecordTypeId && oldRecord != null && oRecord.of_Ownership_Owner__c != oldRecord.of_Ownership_Owner__c) {
                mapLeadPercentage.put(oRecord.Id, oRecord.of_Ownership_Owner__c);
            }
        }

        if(mapLeadPercentage != null && !mapLeadPercentage.isEmpty()) {
            List<criminalreports__Criminal_Report__c> listCriminalRecord = new List<criminalreports__Criminal_Report__c>();
            
            for(criminalreports__Criminal_Report__c oRecord : [Select Id, criminalreports__Lead__c, of_Ownership_Owner__c from criminalreports__Criminal_Report__c where criminalreports__Lead__c in: mapLeadPercentage.KeySet() FOR UPDATE]) {
                oRecord.of_Ownership_Owner__c = mapLeadPercentage.get(oRecord.criminalreports__Lead__c);
                listCriminalRecord.add(oRecord);
            }
            if(listCriminalRecord != null && !listCriminalRecord.isEmpty()) {
                database.update(listCriminalRecord, false);
            }
        }
    }

    
    public void OnBeforeUpdate( List<Lead> newLead, List<Lead> old, Map<ID, Lead> newLeadMap , Map<ID, Lead> oldLeadMap )
    {
        String currentuserid = userInfo.getUserId();
        map<String, string> mapofAccountIdANDOppId = new map<String, string>();
        map<Id, Opportunity> mapofConvertedOpp = new map<Id, Opportunity>();
        list<Contact> lstofNewContacts = new list<Contact>();
        list<Opportunity> lstOfOpportunities = new list<Opportunity>();
        set<ID> setOfContactID = new set<ID>();
        set<ID> setOfContactReports = new set<ID>();
        Opportunity objOpportunity = new Opportunity();
        string convertedOppId = '';
        Id LeadNYCRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Grant-NYC').getRecordTypeId();
        Id OppNYCRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('GRANT-NYC').getRecordTypeId();
        Id LeadProspectiveRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Prospective Proposal').getRecordTypeId();
        Id AccProspectiveRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Prospective Proposal').getRecordTypeId();
        Id ConProspectiveRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Prospective Proposal').getRecordTypeId();
        Id OppProspectiveRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Prospective Proposal').getRecordTypeId();
        String GQRecordTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('General Questions Contact Form').getRecordTypeId();
        String PCRecordTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Partnership Contact Form').getRecordTypeId();
        Id LeadGrantRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('GRANT').getRecordTypeId();
        if( newLead[0].IsConverted && newLead[0].RecordTypeId != GQRecordTypeID && newLead[0].RecordTypeId != PCRecordTypeID)
        {
            updateCreditReportRelatedListOnOpp(newLead[0].Id , newLead[0].ConvertedOpportunityId, newLead[0].ConvertedContactId);
            updateMultipleDocsRelatedListOnOpp(newLead[0].Id , newLead[0].ConvertedOpportunityId);
            updateQuestionRelatedListOnOpp(newLead[0].Id , newLead[0].ConvertedOpportunityId);
            updateScoreRelatedListOnOpp(newLead[0].Id , newLead[0].ConvertedOpportunityId);
            
        }
        /*else if( newLead[0] != null && newLead[0].IsConverted == false &&  old[0].OwnerId != newLead[0].OwnerId)
        newLead[0].previous_lead_ownerID__c = old[0].OwnerId ;
        Set<Id> objSetPreOwnerIds = new Set<Id>();
        for( Lead eachLead : newLead ){
            objSetPreOwnerIds.add(eachLead.previous_lead_ownerID__c);
        }*/
        Map<Id,Boolean> objMapOwnerIDisActive = new Map<Id,Boolean>();
        //Map<Id,User> objUserPreOwnerMap = new Map<Id,User>([Select Id,isActive from User where ID IN : objSetPreOwnerIds]);
        
        for( Lead eachLead : newLead )
        {
           
          if(eachLead.RecordTypeId == LeadGrantRecordTypeId && eachLead.Run_Credit_Report__c == true && eachLead.Loan_Type__c == 'PA CARES BB'){
                eachLead.PA_Cares_BB__c = true;
          }  
          if(eachLead.RecordTypeId != GQRecordTypeID && eachLead.RecordTypeId != PCRecordTypeID){  
            if( (eachLead.Custom_Last_Modified_By__c  == null  ) || (eachLead.Custom_Last_Modified_By__c  != null && eachLead.Custom_Last_Modified_By__c == oldLeadMap.get(eachLead.id).Custom_Last_Modified_By__c    ))
                eachLead.Custom_Last_Modified_By__c  = userinfo.getuserid(); 
            if( eachLead.LastModifiedDate != null)   
                eachLead.Custom_Last_Modified_Date__c = eachLead.LastModifiedDate;  
            
            if( eachLead.Base64CreatedDate__c != null && eachLead.Base64CreatedDate__c != oldLeadMap.get(eachLead.id).Base64CreatedDate__c)
            {
                Datetime GMTDate =  eachLead.Base64CreatedDate__c.addDays(90);
                String strConvertedDate =  GMTDate.format('MM.dd.yyyy HH:mm', 'America/New_York');
                
                string UrlParam = string.valueof(eachLead.id)+'||'+strConvertedDate ;
                eachLead.Base64_Encoded_Pardot_Url_Parameter__c = EncodingUtil.base64Encode(Blob.valueof(UrlParam));
                
                system.debug('----------Base 64  code'+eachLead.Base64CreatedDate__c);
            }
            if( eachLead.IsConverted )
            {
                //  records mapping from Lead to converted Opportunity.
                mapofAccountIdANDOppId.put(eachLead.ConvertedAccountId,  eachLead.ConvertedOpportunityId);
                objOpportunity = new Opportunity( Id=eachLead.ConvertedOpportunityId);
                objOpportunity.Owner__c = eachLead.convertedContactId;
                objOpportunity.Of_Ownership_1__c = eachLead.of_Ownership_Owner__c;
                objOpportunity.OwnerId = string.valueof(eachLead.OwnerId); 
                /*if( eachLead.previous_lead_ownerID__c != null && objUserPreOwnerMap.keySet().Contains(eachLead.previous_lead_ownerID__c) && objUserPreOwnerMap.get(eachLead.previous_lead_ownerID__c).isActive == true){
                   objOpportunity.OwnerId = string.valueof(eachLead.previous_lead_ownerID__c); 
                }else{
                    objOpportunity.OwnerId = string.valueof(eachLead.OwnerId); 
                }*/
                
                
                // Added for SBA-PPP Opportunity Conversion
                string recordTypename = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName().get('SBA_PPP').getname();
                objOpportunity.Email__c = eachLead.Email;
                objOpportunity.Phone__c = eachLead.Phone;
                objOpportunity.SSN1__c = eachLead.SSN1__c;
                objOpportunity.Website__c = eachLead.website;
                objOpportunity.of_Employees__c = eachLead.NumberOfEmployees;
                if(recordTypename == 'SBA - PPP'){
                    if(eachLead.Loan_Approval_Date__c != null )
                        objOpportunity.Projected_Close_Date__c = eachLead.Loan_Approval_Date__c + 10;
                    
                }
                
                contact primarycontact = new contact(id =eachLead.convertedContactId );
                primarycontact.SSN1__c = eachLead.SSN1__c;
                primarycontact.OwnerId = string.valueof(eachLead.OwnerId) ;
                //if( eachLead.previous_lead_ownerID__c != null )
                //primarycontact.OwnerId = string.valueof(eachLead.previous_lead_ownerID__c) ;
                
               /* if( eachLead.previous_lead_ownerID__c != null && objUserPreOwnerMap.keySet().Contains(eachLead.previous_lead_ownerID__c) && objUserPreOwnerMap.get(eachLead.previous_lead_ownerID__c).isActive == true){
                   primarycontact.OwnerId = string.valueof(eachLead.previous_lead_ownerID__c) ; 
                }else{
                    primarycontact.OwnerId = string.valueof(eachLead.OwnerId) ;
                }*/
                
                if( eachLead.DOB_Owner_1__c != null )
                primarycontact.birthdate= Date.valueof(eachLead.DOB_Owner_1__c ) ;
                
               
                
                //lstofNewContacts.add(primarycontact);
                Account objConvertedAcc = new Account(id = string.valueof(eachLead.convertedAccountId) );
                objConvertedAcc.ownerId= string.valueof(eachLead.OwnerId) ;
                //if( eachLead.previous_lead_ownerID__c != null )
                //objConvertedAcc.ownerId= string.valueof(eachLead.previous_lead_ownerID__c) ;
                /*if( eachLead.previous_lead_ownerID__c != null && objUserPreOwnerMap.keySet().Contains(eachLead.previous_lead_ownerID__c) && objUserPreOwnerMap.get(eachLead.previous_lead_ownerID__c).isActive == true){
                   objConvertedAcc.ownerId= string.valueof(eachLead.previous_lead_ownerID__c) ; 
                }else{
                    objConvertedAcc.ownerId= string.valueof(eachLead.OwnerId) ;
                }*/
                
                if( eachLead.Last_Name_2nd_Owner__c != null && eachLead.Last_Name_2nd_Owner__c != '')
                {
                    //  Creating Second Contact.
                    Contact objContact2 = new Contact();
                    objContact2.AccountId = eachLead.ConvertedAccountId;
                    objContact2.FirstName = eachLead.First_Name_2nd_Owner__c;
                    objContact2.LastName =  eachLead.Last_Name_2nd_Owner__c;
                    objContact2.Title = eachLead.Title_2nd_Owner__c;
                    objContact2.MobilePhone = eachLead.Mobile_2nd_Owner__c;
                    objContact2.Phone = eachLead.Phone_2nd_Owner__c;
                    objContact2.Email = eachLead.Email_2nd_Owner__c;
                    objContact2.SSN1__c = eachLead.SSN2__c;
                    objContact2.Opportunity_Id__c = eachLead.ConvertedOpportunityId;
                    objContact2.owner_Id__c = eachLead.Owner_ID_Owner_2__c;
                    objcontact2.street__c = eachLead.Street_Owner_2__c ;
                    objcontact2.city__C = eachLead.City_Owner_2__c;
                    objcontact2.State__c = eachLead.State_Owner_2__c;
                    objcontact2.Zip_Code__c = eachLead.Zip_Code_Owner_2__c;
                    objcontact2.Country__c = eachLead.Country_Owner_2__c;
                    objContact2.ContactNumber__c = 2;
                    objOpportunity.Of_Ownership_2__c = eachLead.of_Ownership_Second_Owner__c;
                    //            objContact2.Lead_ID__c = eachLead.ConvertedOpportunityId;
                    lstofNewContacts.add(objContact2);
                }
                
                if( eachLead.Last_Name_3rd_Owner__c != null && eachLead.Last_Name_3rd_Owner__c != '')
                {
                    //  Creating Third Contact.
                    Contact objContact3 = new Contact();
                    objContact3.AccountId = eachLead.ConvertedAccountId;
                    objContact3.FirstName = eachLead.First_Name_3rd_Owner__c;
                    objContact3.LastName =  eachLead.Last_Name_3rd_Owner__c;
                    objContact3.Title = eachLead.Title_3rd_Owner__c;
                    objContact3.MobilePhone = eachLead.Mobile_3rd_Owner__c;
                    objContact3.Phone = eachLead.Phone_3rd_Owner__c;
                    objContact3.Email = eachLead.Email_3rd_Owner__c;
                    objContact3.SSN1__c = eachLead.SSN_3rd_Owner__c;
                    objContact3.Opportunity_Id__c = eachLead.ConvertedOpportunityId;
                    objContact3.owner_Id__c = eachLead.Owner_ID_Owner_3__c;
                    objContact3.street__c = eachLead.Street_Owner_3__c ;
                    objContact3.city__C = eachLead.City_Owner_3__c;
                    objContact3.State__c = eachLead.State_Owner_3__c;
                    objContact3.Zip_Code__c = eachLead.Zip_Code_Owner_3__c;
                    objContact3.Country__c = eachLead.Country_Owner_3__c;
                    objContact3.ContactNumber__c = 3;   
                    objOpportunity.of_Ownership_3rd_Owner__c = eachLead.of_Ownership_3rd_Owner__c;
                    //         objContact3.Lead_ID__c = eachLead.ConvertedOpportunityId;
                    lstofNewContacts.add(objContact3);
                }
                if( eachLead.Last_Name_4th_Owner__c != null && eachLead.Last_Name_4th_Owner__c != '')
                {
                    //  Creating Fourth Contact.
                    Contact objContact4 = new Contact();
                    objContact4.AccountId = eachLead.ConvertedAccountId;
                    objContact4.FirstName = eachLead.First_Name_4th_Owner__c;
                    objContact4.LastName =  eachLead.Last_Name_4th_Owner__c;
                    objContact4.Title = eachLead.Title_4th_Owner__c;
                    objContact4.MobilePhone = eachLead.Mobile_4th_Owner__c;
                    objContact4.Phone = eachLead.Phone_4th_Owner__c;
                    objContact4.Email = eachLead.Email_4th_Owner__c;
                    objContact4.SSN1__c = eachLead.SSN_4th_Owner__c;
                    objContact4.Opportunity_Id__c = eachLead.ConvertedOpportunityId;
                    objContact4.owner_Id__c = eachLead.Owner_ID_Owner_4__c;
                    objContact4.street__c = eachLead.Street_Owner_4__c ;
                    objContact4.city__C = eachLead.City_Owner_4__c;
                    objContact4.State__c = eachLead.State_Owner_4__c;
                    objContact4.Zip_Code__c = eachLead.Zip_Code_Owner_4__c;
                    objContact4.Country__c = eachLead.Country_Owner_4__c;
                    objContact4.ContactNumber__c = 4;
                    objOpportunity.of_Ownership_4th_Owner__c = eachLead.of_Ownership_4th_Owner__c;
                    //           objContact4.Lead_ID__c = eachLead.ConvertedOpportunityId;
                    lstofNewContacts.add(objContact4);
                }
                if( eachLead.Last_Name_5th_Owner__c != null && eachLead.Last_Name_5th_Owner__c != '')
                {
                    //  Creating Fifth Contact.
                    Contact objContact5 = new Contact();
                    objContact5.AccountId = eachLead.ConvertedAccountId;
                    objContact5.FirstName = eachLead.First_Name_5th_Owner__c;
                    objContact5.LastName =  eachLead.Last_Name_5th_Owner__c;
                    objContact5.Title = eachLead.Title_5th_Owner__c;
                    objContact5.MobilePhone = eachLead.Mobile_5th_Owner__c;
                    objContact5.Phone = eachLead.Phone_5th_Owner__c;
                    objContact5.Email = eachLead.Email_5th_Owner__c;
                    objContact5.SSN1__c = eachLead.SSN_5th_Owner__c;
                    objContact5.Opportunity_Id__c = eachLead.ConvertedOpportunityId;
                    objContact5.owner_Id__c = eachLead.Owner_ID_Owner_5__c;
                    objContact5.street__c = eachLead.Street_Owner_5__c ;
                    objContact5.city__C = eachLead.City_Owner_5__c;
                    objContact5.State__c = eachLead.State_Owner_5__c;
                    objContact5.Zip_Code__c = eachLead.Zip_Code_Owner_5__c;
                    objContact5.Country__c = eachLead.Country_Owner_5__c;
                    objContact5.ContactNumber__c = 5;
                    objOpportunity.of_Ownership_5th_Owner__c = eachLead.of_Ownership_5th_Owner__c;
                    //          objContact5.Lead_ID__c = eachLead.ConvertedOpportunityId;
                    lstofNewContacts.add(objContact5);
                }
                
                if(eachLead.RecordTypeId == LeadProspectiveRecordTypeId){
                    objOpportunity.RecordTypeId = OppProspectiveRecordTypeId;
                    primarycontact.RecordTypeId = ConProspectiveRecordTypeId;
                    objConvertedAcc.RecordTypeId = AccProspectiveRecordTypeId;
                }
                if(eachLead.RecordTypeId == LeadNYCRecordTypeId){
                    objOpportunity.RecordTypeId = OppNYCRecordTypeId;
                }
                
                update objConvertedAcc;
                
                update primarycontact;
                setOfContactReports.add(primarycontact.id);
                update objOpportunity;
            }
            //mapofConvertedOpp.put(eachLead.ConvertedOpportunityId, objOpporunity);
          }      
        }
        
        if( lstofNewContacts != null && lstofNewContacts.size() > 0 )
        {
            Database.SaveResult[] srList = Database.insert(lstofNewContacts);
            
            // Iterate through each returned result
            for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    
                    setOfContactID.add(sr.getId());
                    setOfContactReports.add(sr.getId());
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Account fields that affected this error: ' + err.getFields());
                    }
                }
            }
            
            if( setOfContactID != null  && setOfContactID.size() > 0 )
            {
                List<Contact> lstOfContacts = [ Select Id, ContactNumber__c, AccountId from Contact where ID IN:setOfContactID];
                
                for( Contact eachContact : lstOfContacts )
                {    
                    /*if( eachContact.ContactNumber__c != 2 && eachContact.ContactNumber__c != 3 && eachContact.ContactNumber__c != 4 && eachContact.ContactNumber__c != 5 )
objOpportunity.Owner__c = eachContact.Id;*/
                    if( eachContact.ContactNumber__c == 2)
                        objOpportunity.Second_Owner__c = eachContact.Id;
                    if( eachContact.ContactNumber__c == 3)
                        objOpportunity.Third_Owner__c = eachContact.Id;
                    if( eachContact.ContactNumber__c == 4)
                        objOpportunity.Fourth_Owner__c = eachContact.Id;
                    if(  eachContact.ContactNumber__c == 5)
                        objOpportunity.Fifth_Owner__c = eachContact.Id;
                    
                    mapofConvertedOpp.put(mapofAccountIdANDOppId.get( eachContact.AccountId), objOpportunity);
                }
                
                if( mapofConvertedOpp != null && mapofConvertedOpp.size() > 0)
                    update mapofConvertedOpp.values();
                
            }    
        }
        System.debug('Before updatetelesles method called');
        updatetelesles( newLead,  old,  newLeadMap , oldLeadMap);
    }
    private static void createCreateReport(List<Lead> listLead, Map<Id, Lead> mapLeads) {
        String GQRecordTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('General Questions Contact Form').getRecordTypeId();
        String PCRecordTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Partnership Contact Form').getRecordTypeId();
        List<creditchecker__Credit_Report__c> listCR = new List<creditchecker__Credit_Report__c>();
        map< String , string> mapLeadIdAndOwnerId = new map< String , string>();
        List<creditchecker__Credit_Report__c>  lstOfPrimaryCreditReports = new List<creditchecker__Credit_Report__c>();
        if( mapLeads != null )
        {
            lstOfPrimaryCreditReports = [ Select Id, Name, Owner_ID__c, Owner_Type__c, creditchecker__Lead__c  from creditchecker__Credit_Report__c where creditchecker__Lead__r.Id IN : mapLeads.KeySet() ];
            if( lstOfPrimaryCreditReports != null && lstOfPrimaryCreditReports.size() > 0 )
            {   for( creditchecker__Credit_Report__c each : lstOfPrimaryCreditReports )
            {
                if( each.Owner_ID__c != null && each.creditchecker__Lead__c != null )
                    mapLeadIdAndOwnerId.put(each.creditchecker__Lead__c, each.Owner_ID__c );
            }
            }
        }
        for(Lead oLead: listLead) {
         if(oLead.RecordTypeId != GQRecordTypeID && oLead.RecordTypeId != PCRecordTypeID){
            Lead oldLead =  mapLeads != null && mapLeads.containsKey(oLead.Id) ? mapLeads.get(oLead.Id) : null; 
            //if(oLead.Run_Credit_Report__c && (oldLead == null || (oldLead != null && oldLead.Run_Credit_Report__c != oLead.Run_Credit_Report__c))) {
            
            if( ( (mapLeadIdAndOwnerId.get(oLead.id) != oLead.Owner_ID_Owner_1__c) || ( (oLead.BusinessId__c == null || oLead.BusinessId__c == '' ) && ( oLead.Owner_ID_Owner_1__c == null || oLead.Owner_ID_Owner_1__c == '' )) ) && oLead.Run_Credit_Report__c && (oldLead == null || (oldLead != null && oldLead.Run_Credit_Report__c != oLead.Run_Credit_Report__c))) {
                creditchecker__Credit_Report__c oRecord4 = new creditchecker__Credit_Report__c();
                oRecord4.creditchecker__Applicants_First_Name__c = oLead.FirstName;
                oRecord4.creditchecker__Applicants_Last_Name__c = oLead.LastName;
                oRecord4.creditchecker__Applicants_SSN__c = oLead.SSN1__c;
                oRecord4.creditchecker__Current_Line__c = oLead.Street_Owner_1__c;
                oRecord4.creditchecker__Current_City__c = oLead.City_Owner_1__c;
                oRecord4.creditchecker__Current_Zip_Code__c = oLead.Zip_Code_Owner_1__c;
                oRecord4.creditchecker__Current_StateCode__c = oLead.State_Owner_1__c;
                oRecord4.creditchecker__Current_Country__c = oLead.Country_Owner_1__c;
                oRecord4.creditchecker__Applicants_Residency_Type__c = 'Unknown';
                oRecord4.creditchecker__Parent_Record_Id__c = oLead.Id;
                oRecord4.Owner_Type__c = 'Owner 1';
                oRecord4.Owner_ID__c = oLead.Owner_ID_Owner_1__c;
                listCR.add(oRecord4);
            }
            
            
            if(oLead.Run_Owner2_Credit_Report__c && (oldLead == null || (oldLead != null && oldLead.Run_Owner2_Credit_Report__c != oLead.Run_Owner2_Credit_Report__c))) {
                creditchecker__Credit_Report__c oRecord4 = new creditchecker__Credit_Report__c();
                oRecord4.creditchecker__Applicants_First_Name__c = oLead.First_Name_2nd_Owner__c;
                oRecord4.creditchecker__Applicants_Last_Name__c = oLead.Last_Name_2nd_Owner__c;
                oRecord4.creditchecker__Applicants_SSN__c = oLead.SSN2__c;
                oRecord4.creditchecker__Current_Line__c = oLead.Street_Owner_2__c;
                oRecord4.creditchecker__Current_City__c = oLead.City_Owner_2__c;
                oRecord4.creditchecker__Current_Zip_Code__c = oLead.Zip_Code_Owner_2__c;
                oRecord4.creditchecker__Current_StateCode__c = oLead.State_Owner_2__c;
                oRecord4.creditchecker__Current_Country__c = oLead.Country_Owner_2__c;
                oRecord4.creditchecker__Applicants_Residency_Type__c = 'Unknown';
                oRecord4.creditchecker__Parent_Record_Id__c = oLead.Id;
                oRecord4.Owner_Type__c = 'Owner 2';
                oRecord4.Owner_ID__c = oLead.Owner_ID_Owner_2__c;
                listCR.add(oRecord4);        
            }
            
            if(oLead.Run_Owner3_Credit_Report__c && (oldLead == null || (oldLead != null && oldLead.Run_Owner3_Credit_Report__c != oLead.Run_Owner3_Credit_Report__c))) {
                creditchecker__Credit_Report__c oRecord4 = new creditchecker__Credit_Report__c();
                oRecord4.creditchecker__Applicants_First_Name__c = oLead.First_Name_3rd_Owner__c;
                oRecord4.creditchecker__Applicants_Last_Name__c = oLead.Last_Name_3rd_Owner__c;
                oRecord4.creditchecker__Applicants_SSN__c = oLead.SSN_3rd_Owner__c;
                oRecord4.creditchecker__Current_Line__c = oLead.Street_Owner_3__c;
                oRecord4.creditchecker__Current_City__c = oLead.City_Owner_3__c;
                oRecord4.creditchecker__Current_Zip_Code__c = oLead.Zip_Code_Owner_3__c;
                oRecord4.creditchecker__Current_StateCode__c = oLead.State_Owner_3__c;
                oRecord4.creditchecker__Current_Country__c = oLead.Country_Owner_3__c;
                oRecord4.creditchecker__Applicants_Residency_Type__c = 'Unknown';
                oRecord4.creditchecker__Parent_Record_Id__c = oLead.Id;
                oRecord4.Owner_Type__c = 'Owner 3';
                oRecord4.Owner_ID__c = oLead.Owner_ID_Owner_3__c;
                listCR.add(oRecord4);        
            }
            
            if(oLead.Run_Owner4_Credit_Report__c && (oldLead == null || (oldLead != null && oldLead.Run_Owner4_Credit_Report__c != oLead.Run_Owner4_Credit_Report__c))) {
                creditchecker__Credit_Report__c oRecord4 = new creditchecker__Credit_Report__c();
                oRecord4.creditchecker__Applicants_First_Name__c = oLead.First_Name_4th_Owner__c;
                oRecord4.creditchecker__Applicants_Last_Name__c = oLead.Last_Name_4th_Owner__c;
                oRecord4.creditchecker__Applicants_SSN__c = oLead.SSN_4th_Owner__c;
                oRecord4.creditchecker__Current_Line__c = oLead.Street_Owner_4__c;
                oRecord4.creditchecker__Current_City__c = oLead.City_Owner_4__c;
                oRecord4.creditchecker__Current_Zip_Code__c = oLead.Zip_Code_Owner_4__c;
                oRecord4.creditchecker__Current_StateCode__c = oLead.State_Owner_4__c;
                oRecord4.creditchecker__Current_Country__c = oLead.Country_Owner_4__c;
                oRecord4.creditchecker__Applicants_Residency_Type__c = 'Unknown';
                oRecord4.creditchecker__Parent_Record_Id__c = oLead.Id;
                oRecord4.Owner_Type__c = 'Owner 4';
                oRecord4.Owner_ID__c = oLead.Owner_ID_Owner_4__c;
                listCR.add(oRecord4);        
            }
            
            if(oLead.Run_Owner5_Credit_Report__c && (oldLead == null || (oldLead != null && oldLead.Run_Owner5_Credit_Report__c != oLead.Run_Owner5_Credit_Report__c))) {
                creditchecker__Credit_Report__c oRecord4 = new creditchecker__Credit_Report__c();
                oRecord4.creditchecker__Applicants_First_Name__c = oLead.First_Name_5th_Owner__c;
                oRecord4.creditchecker__Applicants_Last_Name__c = oLead.Last_Name_5th_Owner__c;
                oRecord4.creditchecker__Applicants_SSN__c = oLead.SSN_5th_Owner__c;
                oRecord4.creditchecker__Current_Line__c = oLead.Street_Owner_5__c;
                oRecord4.creditchecker__Current_City__c = oLead.City_Owner_5__c;
                oRecord4.creditchecker__Current_Zip_Code__c = oLead.Zip_Code_Owner_5__c;
                oRecord4.creditchecker__Current_StateCode__c = oLead.State_Owner_5__c;
                oRecord4.creditchecker__Current_Country__c = oLead.Country_Owner_5__c;
                oRecord4.creditchecker__Applicants_Residency_Type__c = 'Unknown';
                oRecord4.creditchecker__Parent_Record_Id__c = oLead.Id;
                oRecord4.Owner_Type__c = 'Owner 5';
                oRecord4.Owner_ID__c = oLead.Owner_ID_Owner_5__c;
                listCR.add(oRecord4);        
            }                
        }
        if(listCR != null && listCR.size()>0) {
            insert listCR;
        }
      }  
    }
    //=======================it will transfer list of multiple object docs to Converted Opportunity ==============================
    
    public static void updateMultipleDocsRelatedListOnOpp(string leadId, string convertedOpportunityId )
    {
        list<Multiple_Files_Upload__c> listOfOppMultipleFiles = new list<Multiple_Files_Upload__c>();
        list<Multiple_Files_Upload__c>  ListOfMultipleDocs = [ Select Id, Lead__c, Opportunity__c from Multiple_Files_Upload__c Where Lead__c=:leadId];
        if( ListOfMultipleDocs != null && ListOfMultipleDocs.size() > 0 )
        {
            for( Multiple_Files_Upload__c each : ListOfMultipleDocs )
            {
                each.Opportunity__c = convertedOpportunityId;
                listOfOppMultipleFiles.add(each);
            }
            
            update listOfOppMultipleFiles;
        }
    }
    public static void updateCreditReportRelatedListOnOpp( string leadId, string oppId, string contactId)
    {
        list< creditchecker__Credit_Report__c > lstOfcreditReports = [ Select Id, name, Opportunity__c from creditchecker__Credit_Report__c Where creditchecker__Lead__c=:leadId];
        list< creditchecker__Credit_Report__c > lstupdatedOfcreditReports = new list< creditchecker__Credit_Report__c >();
        list<criminalreports__Criminal_Report__c> lstOfCriminalReports = [Select Id, Opportunity__c from criminalreports__Criminal_Report__c Where criminalreports__Lead__c=:leadId];
        list<criminalreports__Criminal_Report__c> lstupdatedOfcriminalReports = new list< criminalreports__Criminal_Report__c >();
        if( lstOfcreditReports != null && lstOfcreditReports.size() > 0 )
        {
            for(creditchecker__Credit_Report__c eachReport :  lstOfcreditReports)
            {
                eachReport.Opportunity__c = oppId;
                lstupdatedOfcreditReports.add(eachReport);
            }
            
            update lstupdatedOfcreditReports;
        }
        if(lstOfCriminalReports != null && lstOfCriminalReports.size() > 0){
            for(criminalreports__Criminal_Report__c oCriminalReport : lstOfCriminalReports){
                oCriminalReport.Opportunity__c = oppId;
                oCriminalReport.criminalreports__Contact__c = contactId;
                lstupdatedOfcriminalReports.add(oCriminalReport);
            }
            update lstupdatedOfcriminalReports;
        }
        
    }
    
    
    
    public static void sendReportsAttachmentToJava(String portalEndPointUrl,  string leadId, string businessId, string applicationId, string PrimaryOwnerId )
    {
        map<string, string> mapOfParentAtt= new map<string, string>();
        list<creditchecker__Credit_Report__c> lstOfReports = [select id, Owner_ID__c from creditchecker__Credit_Report__c where creditchecker__Lead__c=:leadId];
        if( PrimaryOwnerId == null || PrimaryOwnerId == '' && ( lstOfReports != null && lstOfReports.size() > 0) )
        {
            for( creditchecker__Credit_Report__c each: lstOfReports)
            {
                
                JavaAPICallOut.makeJavaPortalFileAPICall( portalEndPointUrl, each.Owner_ID__c , businessId  , each.id, applicationId);
                //ApexUtil.wait(2000);
            } 
        }
        else if( PrimaryOwnerId != null && PrimaryOwnerId != '' &&( lstOfReports != null && lstOfReports.size() > 0) )
            JavaAPICallOut.makeJavaPortalFileAPICall(portalEndPointUrl, PrimaryOwnerId , businessId  , lstOfReports[0].id, applicationId); 
        
        IsLeadRecursiveAtt = true;
    }
    
    // Added to update Telesales on Lead when owner is changed and old owner is part of public group
    public void updatetelesles(List<Lead> newLead, List<Lead> old, Map<ID, Lead> newLeadMap , Map<ID, Lead> oldLeadMap)
    {
        System.debug('Method updatetelesles Started');
        set<string> setOfgrpusers = new set<string>();
        list<groupmember>  lstOfGroupMember = [Select userorgroupid from groupmember Where group.name = 'Telesales User Group'];
        for( groupmember eachmember : lstOfGroupMember )
        {
            setOfgrpusers.add(eachmember.userorgroupid);
        }
        List<Lead> updateLeads = new List<Lead>();
        for (Lead c : newLead)
        {
            //system.debug('oldLeadMap.get(c.OwnerId)'+oldLeadMap.get(c.OwnerId));
            //system.debug('oldLeadMap.get(c.ID).OwnerID'+oldLeadMap.get(c.ID).ownerID);
            //system.debug('newLeadMap.get(c.OwnerId)'+newLeadMap.get(c.OwnerId));
            if(oldLeadMap.get(c.ID).OwnerID != newLeadMap.get(c.ID).OwnerID)
            {
                
                if( (setOfgrpusers.contains(string.valueof(oldLeadMap.get(c.ID).OwnerID)))  && (!(setOfgrpusers.contains(string.valueof(c.OwnerID)) )) )
                {
                    
                    //System.debug('string.valueof(oldLeadMap.get(c.OwnerId))'+string.valueof(oldLeadMap.get(c.OwnerId)));
                    c.telesales__c = string.valueof(oldLeadMap.get(c.ID).OwnerID);
                    c.Transfer_Date__c = Date.today();  
                    updateLeads.add(c);
                }
                
                
            } 
        }
        //system.debug('updateLeads'+updateLeads);
        //if(updateLeads != null || updateLeads.size()>0)
        // update updateLeads;
    }
    
    // upate opp on Question 
    public static void updateQuestionRelatedListOnOpp(string leadId, string oppId){
               
        list<Lead_Questions__c> lstOfQuestion = [ Select Id, Lead__c,Opportunity__c  from Lead_Questions__c Where Lead__c=:leadId];
        list< Lead_Questions__c> lstOfQuestionUpdate = new list< Lead_Questions__c>();
        if( lstOfQuestion != null && lstOfQuestion.size() > 0 ){
            for(Lead_Questions__c eachQstion :  lstOfQuestion ){
                eachQstion.Opportunity__c = oppId;
                lstOfQuestionUpdate .add(eachQstion );
            }
            
            if(lstOfQuestionUpdate != null)
                update lstOfQuestionUpdate ;
        }
    }
    // update score card here
    public static void updateScoreRelatedListOnOpp(string leadId, string oppId){
        try{
            ScoreCard__c objScoreCarrd = [ Select Id, Lead__c,Opportunity__c,External_ID__c
                                          from ScoreCard__c  Where Lead__c=:leadId]; 
            // check if Scorecard exist
            if(objScoreCarrd !=null){
                objScoreCarrd.Opportunity__c = Oppid;
                objScoreCarrd.External_ID__c  = Oppid;
                update objScoreCarrd;
            }  
        }Catch(exception ex){}
    }
    
    //Added by Cloud Maven, INC ..Credit Report Criminal Checker Changes...
    public void runCriminalReport(List<Lead> lstLead, Map<Id,Lead> leadOldMap){
        Id GrantNyrrecTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('GRANT-NYR').getRecordTypeId();
        Id GrantNYCrecTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Grant-NYC').getRecordTypeId();
        if(lstLead != null && lstLead.size() > 0){
            for(Lead oLead : lstLead){
                if( oLead.RecordTypeId == GrantNyrrecTypeId || (oLead.RecordTypeId == GrantNYCrecTypeId) ){
                //if( oLead.RecordTypeId == GrantNyrrecTypeId){
                // Owner 1
                if(!String.isBlank(oLead.FirstName) && !String.isBlank(oLead.LastName) && (oLead.DOB_Owner_1__c != null) && !String.isBlank(oLead.SSN1__c) && !String.isBlank(oLead.Street_Owner_1__c) && !String.isBlank(oLead.City_Owner_1__c) && !String.isBlank(oLead.State_Owner_1__c) && !String.isBlank(oLead.Zip_Code_Owner_1__c) && !String.isBlank(oLead.Country_Owner_1__c) && !oLead.Second_Update_Ran__c && !oLead.Run_Owner1_Criminal_Report__c){
                    oLead.Run_Owner1_Criminal_Report__c = true;
                    oLead.Second_Update_Ran__c = true;
                }
                
                 /*----------Commented By Salesforce DevOps Team------------
                //Owner 2
                if(!String.isBlank(oLead.First_Name_2nd_Owner__c) && !String.isBlank(oLead.Last_Name_2nd_Owner__c) && (oLead.DOB_Owner_2__c != null) && !String.isBlank(oLead.SSN2__c) && !String.isBlank(oLead.Street_Owner_2__c) && !String.isBlank(oLead.City_Owner_2__c) && !String.isBlank(oLead.State_Owner_2__c) && !String.isBlank(oLead.Zip_Code_Owner_2__c) && !String.isBlank(oLead.Country_Owner_2__c) && !oLead.Second_Update_Ran__c && !oLead.Run_Owner2_Criminal_Report__c){
                
                oLead.Run_Owner2_Criminal_Report__c = true;
                oLead.Second_Update_Ran_Owner2__c = true;
                
                }
                
                //Owner 3
                if(!String.isBlank(oLead.First_Name_3rd_Owner__c) && !String.isBlank(oLead.Last_Name_3rd_Owner__c) && (oLead.DOB_Owner_3__c != null) && !String.isBlank(oLead.SSN_3rd_Owner__c) && !String.isBlank(oLead.Street_Owner_3__c) && !String.isBlank(oLead.City_Owner_3__c) && !String.isBlank(oLead.State_Owner_3__c) && !String.isBlank(oLead.Zip_Code_Owner_3__c) && !String.isBlank(oLead.Country_Owner_3__c)&& !oLead.Second_Update_Ran__c && !oLead.Run_Owner3_Criminal_Report__c){
                
                oLead.Run_Owner3_Criminal_Report__c = true;
                oLead.Second_Update_Ran_Owner3__c = true;
                }
                
                //Owner 4
                if(!String.isBlank(oLead.First_Name_4th_Owner__c) && !String.isBlank(oLead.Last_Name_4th_Owner__c) && (oLead.DOB_Owner_4__c != null) && !String.isBlank(oLead.SSN_4th_Owner__c) && !String.isBlank(oLead.Street_Owner_4__c) && !String.isBlank(oLead.City_Owner_4__c) && !String.isBlank(oLead.State_Owner_4__c) && !String.isBlank(oLead.Zip_Code_Owner_4__c) && !String.isBlank(oLead.Country_Owner_4__c) && !oLead.Second_Update_Ran__c && !oLead.Run_Owner4_Criminal_Report__c){
                
                oLead.Run_Owner4_Criminal_Report__c = true;
                oLead.Second_Update_Ran_Owner4__c = true;
                
                }
                
                
                //Owner 5
                if(!String.isBlank(oLead.First_Name_5th_Owner__c) && !String.isBlank(oLead.Last_Name_5th_Owner__c) && (oLead.DOB_Owner_5__c != null) && !String.isBlank(oLead.SSN_5th_Owner__c) && !String.isBlank(oLead.Street_Owner_5__c) && !String.isBlank(oLead.City_Owner_5__c) && !String.isBlank(oLead.State_Owner_5__c) && !String.isBlank(oLead.Zip_Code_Owner_5__c) && !String.isBlank(oLead.Country_Owner_5__c)&& !oLead.Second_Update_Ran__c && !oLead.Run_Owner5_Criminal_Report__c){
                
                oLead.Run_Owner5_Criminal_Report__c = true;
                oLead.Second_Update_Ran_Owner5__c = true;
                
                }
                */
            }
            }
        }
    }
    // Credit Report Criminal Checker Changes...
    public static void createCriminalCheckerReports(List<Lead> lstLead, Map<Id,Lead> mapOldLead){
        Id GrantNyrrecTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('GRANT-NYR').getRecordTypeId();
        Id GrantNYCrecTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Grant-NYC').getRecordTypeId();

        if(lstLead != null && lstLead.size() > 0){
            List<criminalreports__Criminal_Report__c> lstCriminalReport = new List<criminalreports__Criminal_Report__c>();
            for(Lead oLead : lstLead){
                
                if( GrantNyrrecTypeId == oLead.RecordTypeId || (GrantNYCrecTypeId == oLead.RecordTypeId)) {
                //if( GrantNyrrecTypeId == oLead.RecordTypeId) {
                //For Owner 1
                if(oLead.Run_Owner1_Criminal_Report__c && (mapOldLead == null || (mapOldLead != null && mapOldLead.containsKey(oLead.Id) && mapOldLead.get(oLead.Id).Run_Owner1_Criminal_Report__c != oLead.Run_Owner1_Criminal_Report__c))){
                    criminalreports__Criminal_Report__c oCriminal = createCriminalReport(oLead.FirstName,oLead.LastName,oLead.DOB_Owner_1__c,oLead.SSN1__c,oLead.Street_Owner_1__c,oLead.City_Owner_1__c,oLead.State_Owner_1__c,oLead.Zip_Code_Owner_1__c,oLead.Country_Owner_1__c,oLead.Id,'Owner 1', oLead.RecordTypeId, oLead.of_Ownership_Owner__c);
                    lstCriminalReport.add(oCriminal);
                    
                }
                
                /*----------Commented By Salesforce DevOps Team------------

                //For Owner 2
                if(oLead.Run_Owner2_Criminal_Report__c && (mapOldLead == null || (mapOldLead != null && mapOldLead.containsKey(oLead.Id) && mapOldLead.get(oLead.Id).Run_Owner2_Criminal_Report__c != oLead.Run_Owner2_Criminal_Report__c))){
                    
                    criminalreports__Criminal_Report__c oCriminal = createCriminalReport(oLead.First_Name_2nd_Owner__c,oLead.Last_Name_2nd_Owner__c,oLead.DOB_Owner_2__c,oLead.SSN2__c,oLead.Street_Owner_2__c,oLead.City_Owner_2__c,oLead.State_Owner_2__c,oLead.Zip_Code_Owner_2__c,oLead.Country_Owner_2__c,oLead.Id,'Owner 2');
                    lstCriminalReport.add(oCriminal);
                }
                
                //For Owner 3
                if(oLead.Run_Owner3_Criminal_Report__c && (mapOldLead == null || (mapOldLead != null && mapOldLead.containsKey(oLead.Id) && mapOldLead.get(oLead.Id).Run_Owner3_Criminal_Report__c != oLead.Run_Owner3_Criminal_Report__c))){
                    
                    criminalreports__Criminal_Report__c oCriminal = createCriminalReport(oLead.First_Name_3rd_Owner__c,oLead.Last_Name_3rd_Owner__c,oLead.DOB_Owner_3__c,oLead.SSN_3rd_Owner__c,oLead.Street_Owner_3__c,oLead.City_Owner_3__c,oLead.State_Owner_3__c,oLead.Zip_Code_Owner_3__c,oLead.Country_Owner_3__c,oLead.Id,'Owner 3');
                    lstCriminalReport.add(oCriminal);
                    
                }
                
                
                //For Owner 4
                if(oLead.Run_Owner4_Criminal_Report__c && (mapOldLead == null || (mapOldLead != null && mapOldLead.containsKey(oLead.Id) && mapOldLead.get(oLead.Id).Run_Owner4_Criminal_Report__c != oLead.Run_Owner4_Criminal_Report__c))){
                    
                    criminalreports__Criminal_Report__c oCriminal = createCriminalReport(oLead.First_Name_4th_Owner__c,oLead.Last_Name_4th_Owner__c,oLead.DOB_Owner_4__c,oLead.SSN_4th_Owner__c,oLead.Street_Owner_4__c,oLead.City_Owner_4__c,oLead.State_Owner_4__c,oLead.Zip_Code_Owner_4__c,oLead.Country_Owner_4__c,oLead.Id,'Owner 4');
                    lstCriminalReport.add(oCriminal);
                }
                
                
                //For Owner 5
                if(oLead.Run_Owner5_Criminal_Report__c && (mapOldLead == null || (mapOldLead != null && mapOldLead.containsKey(oLead.Id) && mapOldLead.get(oLead.Id).Run_Owner5_Criminal_Report__c != oLead.Run_Owner5_Criminal_Report__c))){
                    
                    criminalreports__Criminal_Report__c oCriminal = createCriminalReport(oLead.First_Name_5th_Owner__c,oLead.Last_Name_5th_Owner__c,oLead.DOB_Owner_5__c,oLead.SSN_5th_Owner__c,oLead.Street_Owner_5__c,oLead.City_Owner_5__c,oLead.State_Owner_5__c,oLead.Zip_Code_Owner_5__c,oLead.Country_Owner_5__c,oLead.Id,'Owner 5');
                    lstCriminalReport.add(oCriminal);
                }
*/
                }
            }
            try{
                if(lstCriminalReport != null && lstCriminalReport.size()>0) {
                    Database.insert (lstCriminalReport,false);
                }
            }
            catch(Exception ex){
                System.debug('Exception Caught');
            }
            
            
            
        } 
    }
    
    public static criminalreports__Criminal_Report__c createCriminalReport(String firstName, String lastName, Date dateBirth, String socialSecurity, String streetAddress, String city, String state, String zipCode,String country, Id leadId,String owner, String recordTypeName, Decimal dPercantage){
        criminalreports__Criminal_Report__c oCriminalReport = new criminalreports__Criminal_Report__c();
        oCriminalReport.criminalreports__First_Name__c = firstName;
        oCriminalReport.criminalreports__Last_Name__c = lastName;
        oCriminalReport.criminalreports__DOB__c = dateBirth;
        oCriminalReport.criminalreports__SSN__c = socialSecurity;
        oCriminalReport.criminalreports__Street_Name__c = streetAddress;
        oCriminalReport.criminalreports__City__c = city;
        oCriminalReport.criminalreports__State__c = state;
        oCriminalReport.criminalreports__Zip_Code__c = zipCode;
        oCriminalReport.criminalreports__Lead__c = leadId;
        oCriminalReport.criminalreports__Country__c = country;
        oCriminalReport.criminalreports__Parent_Record_Id__c = leadId;
        oCriminalReport.Owner_Information__c = owner;
        oCriminalReport.Lead_RecordType__c = recordTypeName;
        oCriminalReport.of_Ownership_Owner__c = dPercantage;
        return oCriminalReport;
    }
    
}