public class ContactTriggerHandler {
    
     public static void onAfterUpdate(List<Contact> contacts, Map<Id, Contact> contactOldMap) {
         
         // Create a map of contact records where Run_Hard_Credit__c or Run_Credit_Report__c is ticked
         Map<Id, Contact> mapContacts = new Map<Id, Contact>();
         
         for( Contact c : contacts ) {
             
             // Check for the changes on Run_Hard_Credit__c or Run_Credit_Report__c
             if( c.creditchecker__Average_Score__c != null && c.creditchecker__Average_Score__c > 0 && c.creditchecker__Average_Score__c != contactOldMap.get( c.Id ).creditchecker__Average_Score__c 
              ) {
                 mapContacts.put( c.Id, c );
             }
         } 
         System.debug(' mapContacts : ' + mapContacts);
         // Call method which will update the score on the related open opportunities
         if( !mapContacts.isEmpty() ) {
             updateScoreOnOpenOpportunities( mapContacts );
         }
         
     }
     
     /** 
      * Method which updates the credit score on the open opportunites
      * from the respective owner's contact record
     **/ 
     private static void updateScoreOnOpenOpportunities( Map<Id, Contact> mapContacts ) {
         
         List<Opportunity> lstOpenOpportunities = new List<Opportunity>();
         system.debug('updateScoreOnOpenOpportunities mapContacts::: '+mapContacts);
         system.debug('updateScoreOnOpenOpportunities mapContacts::: '+mapContacts.values());
         
         for( Opportunity opp : [ 
             SELECT 
                 Id,
                 Owner__c,
                 Second_Owner__c,
                 Third_Owner__c,
                 Fourth_Owner__c,
                 Fifth_Owner__c
             FROM 
                 Opportunity 
             WHERE IsClosed = False AND 
             ( 
                 Owner__c IN :mapContacts.keySet() OR 
                 Second_Owner__c IN :mapContacts.keySet() OR 
                 Third_Owner__c IN :mapContacts.keySet() OR 
                 Fourth_Owner__c IN :mapContacts.keySet() OR
                 Fifth_Owner__c IN :mapContacts.keySet() 
             )                                                     
         ]
         ) {
             
             // Update the credit score and add opportunity into the list which will be updated in DML
             if( mapContacts.containsKey( opp.Owner__c ) && mapContacts.containsKey( opp.Owner__c )) {
                 opp.First_Owner_Credit_SCore__c = mapContacts.get( opp.Owner__c ).creditchecker__Average_Score__c; 
             } 
             
             if( mapContacts.containsKey( opp.Second_Owner__c ) && mapContacts.containsKey( opp.Second_Owner__c )) {
                 opp.Second_Owner_Credit_Score__c = mapContacts.get( opp.Second_Owner__c ).creditchecker__Average_Score__c; 
             }
             
             if( mapContacts.containsKey( opp.Third_Owner__c) && mapContacts.containsKey( opp.Third_Owner__c )) {
                 opp.Third_Owner_Credit_Score__c = mapContacts.get( opp.Third_Owner__c ).creditchecker__Average_Score__c; 
             }
             
             if( mapContacts.containsKey( opp.Fourth_Owner__c ) && mapContacts.containsKey( opp.Fourth_Owner__c )) {
                 opp.Fourth_Owner_Credit_Score__c = mapContacts.get( opp.Fourth_Owner__c ).creditchecker__Average_Score__c; 
             }
             
             if( mapContacts.containsKey( opp.Fifth_Owner__c ) && mapContacts.containsKey( opp.Fifth_Owner__c )) {
                 opp.Fifth_Owner_Credit_Score__c = mapContacts.get( opp.Fifth_Owner__c ).creditchecker__Average_Score__c; 
             }
             lstOpenOpportunities.add( opp );
             
         }
         
         
         // Update opportunity records
         if( !lstOpenOpportunities.isEmpty() ) {
             
             update lstOpenOpportunities;
             
         }
     }
}