public class TestDataFactory {
    public static List<Account> generateAccHierarchy(String namePrefix, Integer nestingLevel) {
        List<Account> accs = new List<Account>();

        Account parent = null;
        for(Integer i = 0; i < nestingLevel; i++) {
            Account a = new Account(Name = namePrefix +  2 * (nestingLevel - i), ParentId = (parent != null ? parent.Id : null));
            insert a;     
            parent = a;  

            Account rightChild = new Account(Name= namePrefix + '1', ParentId = a.Id);
            insert rightChild;


            accs.add(a);
            accs.add(rightChild);     
        }

        return accs;

    }   


}
