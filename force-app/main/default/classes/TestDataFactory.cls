public class TestDataFactory {
    public static List<Account> generateAccHierarchy(String namePrefix, Integer nestingLevel) {
        List<Account> accs = new List<Account>();

        Account parent = null;
        for(Integer i = 0; i < nestingLevel; i++) {
            Account a = new Account(Name = namePrefix + i, ParentId = (parent != null ? parent.Id : null));
            insert a;     
            parent = a;  


            accs.add(a);     
        }

        return accs;

    }   


}
