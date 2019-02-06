@isTest
public class AMEX_OpportunityTriggerTestClass {
    
    static testMethod void testPositiveTest() {
        
        System.runAs(TestDataFactory.userRecord()){
            // Test data setup
            // Create Account and Opportuntity
            
            List<Opportunity> opsCr = TestDataFactory.createAccountsWithOpps(1,200);
            
            // Perform test
            Test.startTest();
                for(Opportunity ops : opsCr){
                    ops.StageName='Closed Won';
                    
                }
                Update opsCr;
            Test.stopTest();
            
            // Assume trigger fired correctly and subscriptions are created for one account and 200 opportunties then we should
            // Be getting 200 subscriptions .
            
            List<Subscription__c> CheckSubCount = [Select id,amount__C from Subscription__c where account__c=:opsCr[0].accountid];
            // Compare count of subscription with Opportuntiy size)
            System.assertEquals(200, CheckSubCount.size());
            
            //
            System.assertEquals(100*12, CheckSubCount[0].Amount__c);
        }
    }
}