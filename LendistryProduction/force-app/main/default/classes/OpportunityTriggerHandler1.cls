/**
 * OpportunityTriggerHandler class
 * @date 22/1/2019
 * @description Follows the One Trigger Per Object design pattern, which allows for the control of execution order and recursion.
 * Ideally, business logic should not be included in this class. Trigger handlers are used to control recursion and order of execution and should delegate other work to service classes.
 * @group Trigger Handlers
 */
public with sharing class OpportunityTriggerHandler1 {
    /**
     * @description Method to process records on Before Insert
     * @param records List of new records to be processed
    */ 
    public static boolean isRecursive = true;
    public static void onBeforeInsert(List<Opportunity> records) {
        //OpportunityService.trackOpportunityStage(records, null);
        
        for( Opportunity each : records)
            {
                if( each.Custom_Last_Modified_By__c  == null )
                    each.Custom_Last_Modified_By__c  = userinfo.getuserid(); //ID.valueof(loggedInUser.id);
            }
            
    }

    /**
     * @description Method to process records on Before Update
     * @param records - List of new records to be processed
     * @param oldMap - Map of old records by Id
    */
    public static void onBeforeUpdate(List<Opportunity> records, Map<Id, Opportunity> oldMap) {
        //OpportunityService.trackOpportunityStage(records, oldMap);
        //============================ Added Some Checks For SBA PPP Opportunity Projected Close Date From Portal  ================================================
        
              
        
       for(Opportunity each: records )
        {
            if( each.Loan_Type__c =='SBA-PPP' && each.Projected_Close_Date__c==null)
            each.Projected_Close_Date__c = oldMap.get(each.id).Projected_Close_Date__c;
            
            string oldUserId = oldMap.get(each.id).Custom_Last_Modified_By__c ;
            string newUserId =each.Custom_Last_Modified_By__c;
            system.debug('-outer---newUserId --->>'+newUserId );
            system.debug('-outer---oldUserId --->>'+oldUserId );
            
            if((newUserId  == null || ( (newUserId == oldUserId && each.Is_Updating_From_Portal__c ==false))))
            {
                    each.Custom_Last_Modified_By__c  = userinfo.getUserId(); 
                    system.debug('-in---isRecursive --->>'+isRecursive );
                    system.debug('-in---newUserId --->>'+newUserId );
                    system.debug('-in---oldUserId --->>'+oldUserId );
                    
                   
            }
            system.debug('-opp--Id-->>'+each.id);
            if( each.Is_Updating_From_Portal__c == true)
               each.Is_Updating_From_Portal__c = false;
                       
            if( each.LastModifiedDate != null)   
                each.Custom_Last_Modified_Date__c = each.LastModifiedDate;  
                 
        }
        isRecursive = false;
    }

    // Added by Cloud Maven, INC - Credit Checker Code
    public static void onAfterInsert(List<Opportunity>opportunities, Map<Id, Opportunity> opportunityOldMap) {
        runCreditReportFromContact(opportunities, opportunityOldMap);
        //OpportunityService.copyAttachments(opportunities);
        //Added by Boddh
        if( opportunities[0].id  != null && !Test.isRunningTest())
            updateOppRecordType( opportunities[0].id );
    }
    
    // Added by Cloud Maven, INC - Credit Checker Code
    public static void onAfterUpdate(List<Opportunity>opportunities, Map<Id, Opportunity> opportunityOldMap) {
         Id GrantRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('GRANT').getRecordTypeId();
        Id GrantNyrrecTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('GRANT-NYR').getRecordTypeId();
        Id GrantNYCrecTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('GRANT-NYC').getRecordTypeId();
        runCreditReportFromContact(opportunities, opportunityOldMap);
       //  added by saurabh kumar for sending network selection opportuity
       for (Opportunity newopp : opportunities) {
        // Access the "old" record by its ID in Trigger.oldMap
        Opportunity oldOpp = opportunityOldMap.get(newopp .Id);
        if( newopp.Network_Selection__c != oldOpp.Network_Selection__c && (GrantRecordTypeId==newopp.recordTypeId || GrantNyrrecTypeId == newopp.recordTypeId || GrantNYCrecTypeId == newopp.recordTypeId)){
            JavaAPICallOutForOpportunity.sendNetworkSelction(newopp.PortalAPIEndPoint__c,newopp.BusinessId__c,newopp.Application_ID__c,newopp.stagename,newopp.Network_Selection__c,true, newopp.id);
        }               
    }
  
  }  
    // Added by Cloud Maven, INC - Credit Checker Code
    public static void runCreditReportFromContact(List<Opportunity>opportunities, Map<Id, Opportunity> opportunityOldMap) {
        Map<Id, Contact> mapContacts = new Map<Id, Contact>();
        Set<Id> setContactId = new Set<Id>();
        Set<Id> setFalseContactId = new Set<Id>();
        for(Opportunity oppty : opportunities) {
            //update screnario
            if(opportunityOldMap != null && opportunityOldMap.containsKey(oppty.Id)){
                Opportunity oldOppty  = opportunityOldMap.get(oppty.Id);
                // soft credit
                if(oppty.Run_Owner1_Credit_Report__c && oppty.Owner__c != null && oppty.Run_Owner1_Credit_Report__c != oldOppty.Run_Owner1_Credit_Report__c) {
                    setContactId.add(oppty.Owner__c);
                }
                if(oppty.Run_Owner2_Credit_Report__c && oppty.Second_Owner__c != null && oppty.Run_Owner2_Credit_Report__c != oldOppty.Run_Owner2_Credit_Report__c) {
                    setContactId.add(oppty.Second_Owner__c);
                }
                if(oppty.Run_Owner3_Credit_Report__c && oppty.Third_Owner__c != null && oppty.Run_Owner3_Credit_Report__c != oldOppty.Run_Owner3_Credit_Report__c) {
                    setContactId.add(oppty.Third_Owner__c);
                }
                if(oppty.Run_Owner4_Credit_Report__c && oppty.Fourth_Owner__c != null && oppty.Run_Owner4_Credit_Report__c != oldOppty.Run_Owner4_Credit_Report__c) {
                    setContactId.add(oppty.Fourth_Owner__c);
                }
                
                if(oppty.Run_Owner5_Credit_Report__c && oppty.Fifth_Owner__c != null && oppty.Run_Owner5_Credit_Report__c != oldOppty.Run_Owner5_Credit_Report__c) {
                    setContactId.add(oppty.Fifth_Owner__c);
                }
                
                if(!oppty.Run_Owner1_Credit_Report__c && oppty.Owner__c  != null && oppty.Run_Owner1_Credit_Report__c != oldOppty.Run_Owner1_Credit_Report__c) {
                    setFalseContactId.add(oppty.Owner__c );
                }
                if(!oppty.Run_Owner2_Credit_Report__c && oppty.Second_Owner__c != null && oppty.Run_Owner2_Credit_Report__c != oldOppty.Run_Owner2_Credit_Report__c) {
                    setFalseContactId.add(oppty.Second_Owner__c);
                }
                if(!oppty.Run_Owner3_Credit_Report__c && oppty.Third_Owner__c != null && oppty.Run_Owner3_Credit_Report__c != oldOppty.Run_Owner3_Credit_Report__c) {
                    setFalseContactId.add(oppty.Third_Owner__c);
                }
                if(!oppty.Run_Owner4_Credit_Report__c && oppty.Fourth_Owner__c != null && oppty.Run_Owner4_Credit_Report__c != oldOppty.Run_Owner4_Credit_Report__c) {
                    setFalseContactId.add(oppty.Fourth_Owner__c);
                }
                
                if(!oppty.Run_Owner5_Credit_Report__c && oppty.Fifth_Owner__c != null && oppty.Run_Owner5_Credit_Report__c != oldOppty.Run_Owner5_Credit_Report__c) {
                    setFalseContactId.add(oppty.Fourth_Owner__c);
                }
            }
            //insert screnario
            else {
                if(oppty.Run_Owner1_Credit_Report__c && oppty.Owner__c != null) {
                    setContactId.add(oppty.Owner__c);
                }
                if(oppty.Run_Owner2_Credit_Report__c && oppty.Second_Owner__c != null) {
                    setContactId.add(oppty.Second_Owner__c);
                }
                if(oppty.Run_Owner3_Credit_Report__c && oppty.Third_Owner__c != null) {
                    setContactId.add(oppty.Third_Owner__c);
                }
                if(oppty.Run_Owner4_Credit_Report__c && oppty.Fourth_Owner__c != null) {
                    setContactId.add(oppty.Fourth_Owner__c);
                }
                
                if(oppty.Run_Owner5_Credit_Report__c && oppty.Fifth_Owner__c != null) {
                    setContactId.add(oppty.Fifth_Owner__c);
                }
            }

            for(Id contactId : setContactId) {
                Contact oContact = new Contact();
                if(mapContacts.containsKey(contactId)) {
                    oContact = mapContacts.get(contactId);
                }
                oContact.Id = contactId;
                oContact.Run_Credit_Report__c = true;
                // Set the opportunity Id 
                oContact.Opportunity_Id__c = oppty.Id;
                mapContacts.put(oContact.Id, oContact);
            }
            
            for(Id contactId : setFalseContactId) {
                Contact oContact = new Contact();
                if(mapContacts.containsKey(contactId)) {
                    oContact = mapContacts.get(contactId);
                }
                oContact.Id = contactId;
                oContact.Run_Credit_Report__c = true;
                // Set the opportunity Id 
                oContact.Opportunity_Id__c = oppty.Id;
                mapContacts.put(oContact.Id, oContact);
            }

            system.debug( ' mapContacts ::::'+mapContacts);
            if(mapContacts != null && mapContacts.size() > 0) {
                update mapContacts.values();
            }
        }
    }
    // Added By Boddh To make lead coneversion successfully for Dynamic Loan Type values: 
    @Future
    public static void updateOppRecordType( Id OppId )
    {
        lead objLead = null; 
        if(!Test.isRunningTest())
        objLead = [ Select id, recordType.Name from Lead Where ConvertedOpportunityId=:OppId];
        else
        objLead = [ Select id, recordType.Name from Lead limit 1];
        Id GrantRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('GRANT').getRecordTypeId();
        Id GrantNyrrecTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('GRANT-NYR').getRecordTypeId();
        Id CarlRecTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Opportunity SBA-CARL').getRecordTypeId();
        Id SBAPPPRecTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Opportunity SBA - PPP').getRecordTypeId();
        Id prospectiveProposalRecTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Prospective Proposal').getRecordTypeId();
        Id LendistryLendingRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Lendistry Lending').getRecordTypeId();
        Opportunity objOpp = new Opportunity(id=OppId);
        if( objLead.recordType.Name == 'GRANT')
            objOpp.RecordTypeId = GrantRecordTypeId;
        if( objLead.recordType.Name == 'GRANT-NYR')
            objOpp.RecordTypeId = GrantNyrrecTypeId;
        if( objLead.recordType.Name == 'SBA-CARL')
            objOpp.RecordTypeId = CarlRecTypeId;
        if( objLead.recordType.Name == 'SBA - PPP')
            objOpp.RecordTypeId = SBAPPPRecTypeId;
         // addd by saurabh kumar on 1 April 2021
         if( objLead.recordType.Name == 'Prospective Proposal')
            objOpp.RecordTypeId = prospectiveProposalRecTypeId;
        if( objLead.recordType.Name == 'Lendistry Lending')
            objOpp.RecordTypeId = LendistryLendingRecordTypeId;
        
       System.debug('objLead.recordType.Name ----------->>'+objLead.recordType.Name ); 
       System.debug('GrantRecordTypeId----------->>'+GrantRecordTypeId); 
        update objOpp;
    }
}