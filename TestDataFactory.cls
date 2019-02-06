@isTest
public class TestDataFactory {

    // Create User record with Tier
    public static User userRecord (){
        
        User u = new User(
             ProfileId = UserInfo.getProfileId(),
             LastName = 'last',
             Email = 'TestAmex@Amex.com',
             Username = 'TestAmex@amex.com' + System.currentTimeMillis(),
             CompanyName = 'Amex',
             Title = 'Developer',
             Alias = 'Devada',
             TimeZoneSidKey = 'America/Los_Angeles',
             EmailEncodingKey = 'UTF-8',
             LanguageLocaleKey = 'en_US',
             LocaleSidKey = 'en_US',
             Tier__c='Silver'
             
        );

        return U;
    }
    
    // Create Account with opportunity
    public static List<Opportunity> createAccountsWithOpps(Integer numAccts, Integer numOppsPerAcct) {
    
        List<Account> accts = new List<Account>();
        
        for(Integer i=0;i<numAccts;i++) {
            Account a = new Account(Name='TestAccount' + i);
            accts.add(a);
        }
        insert accts;
        
        List<Opportunity> opps = new List<Opportunity>();
        for (Integer j=0;j<numAccts;j++) {
            Account acct = accts[j];
            // For each account just inserted, add opportunities
            for (Integer k=0;k<numOppsPerAcct;k++) {
                opps.add(new Opportunity(Name=acct.Name + ' Opportunity ' + k,
                                       StageName='Prospecting',
                                       CloseDate=System.today(),
                                       Amount=100,
                                       Tier__c='Silver',
                                       Billing_Schedule__c='Yearly',
                                       AccountId=acct.Id));
            }
        }
        // Insert all opportunities for all accounts.
        insert opps;
        
        return opps;
    }
}