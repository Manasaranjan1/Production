public class sendNoOfDaysQueueable implements Queueable,Database.AllowsCallouts{
    public set<String> setofOppId ; 
    public Boolean isRun=false;
    public sendNoOfDaysQueueable (set<String> OpportunityIdSet){
        setofOppId  = OpportunityIdSet;
    }
    public void execute(QueueableContext qc){
        if(!Test.isRunningTest())
            JavaAPICallOutNoOfDays.sendListOfOpportunity(setofOppId);        
    }
    
      
}