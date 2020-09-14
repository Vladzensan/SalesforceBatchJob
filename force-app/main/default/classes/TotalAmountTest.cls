@isTest
private class TotalAmountTest {
    private static final String ACC_NAME_PREFIX = 'test';
    private static final Integer MAX_NESTING = 6;
    private static final Decimal OPPORTUNITY_AMOUNT = 100.0;

    @testSetup static void setup() {
        List<Account> accs = TestDataFactory.generateAccHierarchy(ACC_NAME_PREFIX, MAX_NESTING);

        List<Opportunity> ops = new List<Opportunity>();
        for(Account a: accs) {
            ops.add(new Opportunity(Name='testOp', StageName='Closed Won', CloseDate = Date.today(), AccountId=a.Id, Amount = OPPORTUNITY_AMOUNT));
        }

        insert ops;

    }

    @isTest
    static void testTotalCount() {
        String pattern = ACC_NAME_PREFIX + '%';
        
        Test.startTest();
        Database.executeBatch(new ResetTotalBatch());
        Test.stopTest();

 
        List<Account> accs = [SELECT Total_Amount__c, (SELECT Amount FROM Opportunities WHERE StageName = 'Closed Won') FROM Account WHERE Name LIKE :pattern ORDER BY Name ASC];
        
        for(Integer i = 0; i < MAX_NESTING; i++) {
            Account a = accs.get(i);
            System.assert(a.Total_Amount__c == (MAX_NESTING  - i) * OPPORTUNITY_AMOUNT);
        }


    }

    @isTest
    static void testResetAmount() {
        ResetTotalBatch resetBatch = new ResetTotalBatch();
        String pattern = ACC_NAME_PREFIX + '%';

        Test.startTest();
        List<Account> accs = [SELECT Total_Amount__c, Own_Amount__c FROM Account WHERE Name LIKE :pattern];

        resetBatch.execute(null, accs);

        accs = [SELECT Name, Total_Amount__c, (SELECT Amount FROM Opportunities WHERE StageName = 'Closed Won') FROM Account WHERE Name LIKE :pattern];

        Test.stopTest();

        for(Account a: accs) {
            System.assert(a.Total_Amount__c == a.Opportunities.size() * OPPORTUNITY_AMOUNT);
        }

    }
    
}
