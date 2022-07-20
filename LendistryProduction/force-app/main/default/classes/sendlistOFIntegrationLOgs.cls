public class sendlistOFIntegrationLOgs implements Queueable{
    public  List<Integration_Log__b> listOFIntegration_Log ; 
    public Boolean isRun=false;
    public sendlistOFIntegrationLOgs (List<Integration_Log__b> listOfIntegrationLog){
        listOFIntegration_Log = listOfIntegrationLog;
    }
    public void execute(QueueableContext qc){
        if(!Test.isRunningTest())
            database.insertImmediate(listOFIntegration_Log); 
       
               
    }
    
      
}