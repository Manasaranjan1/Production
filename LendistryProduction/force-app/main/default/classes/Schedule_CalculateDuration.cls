global class Schedule_CalculateDuration implements Schedulable {
    
    global void execute(SchedulableContext SC) {
        Batch_update_duration_on_Opp bat = new Batch_update_duration_on_Opp(); 
          database.executebatch(bat,200);
        
    } 
}