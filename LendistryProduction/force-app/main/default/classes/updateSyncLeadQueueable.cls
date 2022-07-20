public class updateSyncLeadQueueable implements Queueable,Database.AllowsCallouts{
    public set<Lead> dummyLeadSet; 
    public string PortalEndPoint;
    public Boolean isRun=false;
    public String serverURL;
    public updateSyncLeadQueueable (set<Lead> setOfLead){
        dummyLeadSet = setOfLead;
    }
    public void execute(QueueableContext qc){
   
        set<id> setOfprodDefault = new set<id>();   
        String defaultUrl =System.Label.JavaPortalSBAPPPCluster;    // Portal URL String 
        
        for(Lead objLead : dummyLeadSet)
                setOfprodDefault.add(objLead.Id);
        
           
        if(setOfprodDefault !=null && setOfprodDefault.size()>0)             
            JavaAPICallOut.sendListOfLeadData(setOfprodDefault,defaultUrl );   
           
    }
      
}