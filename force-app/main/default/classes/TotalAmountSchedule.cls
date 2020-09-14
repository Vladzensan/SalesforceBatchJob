global class TotalAmountSchedule implements Schedulable{
   
    //Executed every Friday at 20:00
    global void execute(SchedulableContext ctx) {
        Database.executeBatch(new ResetTotalBatch());
    }
}
