global class UpdateoppNoOFDaysBatch implements   Database.Batchable<sObject> ,Database.AllowsCallouts,DataBase.StateFul{
    
    // instance member to retain state across transactions
     global final String Query;
     global UpdateoppNoOFDaysBatch(String q){
         query=q;
     }
    // start method here to get all records
    global Database.QueryLocator start(Database.BatchableContext bc) {      
        return Database.getQueryLocator(query);
    }
    
    // execute method perform all processing..
    global void execute(Database.BatchableContext bc, List<Opportunity> listOfOpportunity){
       // process each batch of records
       Set<String> setOfIds = new Set<String>();
        if(listOfOpportunity!=null && listOfOpportunity.size()>0){
            for(Opportunity objOpp : listOfOpportunity){           
                setOfIds.add(objOpp.Id);                                
            }  
            system.debug('setOfIds---------->>'+setOfIds);          
        }
        if(setOfIds!=null && setOfIds.size()>0 && !Test.isRunningTest()){    
            System.enqueueJob(new sendNoOfDaysQueueable (setOfIds ));  
            
        }
     } 
    global void finish(Database.BatchableContext bc){
         // callout future method
         
        
    }    
}