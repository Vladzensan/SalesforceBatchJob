global class ResetTotalBatch implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext batchableContext){

        return Database.getQueryLocator([SELECT Own_Amount__c FROM Account]);
    }

    public void execute(Database.BatchableContext context, List<Account> accounts){
       for(Account a: accounts) {
           a.Total_Amount__c = a.Own_Amount__c;
       }

       update accounts;
    }

    public void finish(Database.BatchableContext context){
        Database.executeBatch(new TotalAmountBatch());
    }

  
}
