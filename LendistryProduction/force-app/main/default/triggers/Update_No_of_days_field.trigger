/*
 * Trigger to update the No of days field for each stage
 * and also deduct weekends and holidays while calculating no of days
 */
trigger Update_No_of_days_field on Opportunity (after insert, after update) {
    
    OPP_CALCULATE_DURATION.calling_duration(Trigger.new);
    }