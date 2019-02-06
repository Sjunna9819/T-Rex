public class OpportunityTriggerHelper {
    
    // This is the method called from handler class which has the actual logic
    public static void createSubscriptionRecord(List<Opportunity> opList, Map<Id,Opportunity> OldMapOpp){
       
        
        Set<String> tierNa = new Set<String>();
        Map<string,id> tierWithUserId = new Map<String,Id>();
        for(opportunity op : opList){
            // Loop through Opportunity to check for condition and store the Tier information
            if(op.tier__c!=null && op.billing_Schedule__c!=null && op.stagename!=OldMapOpp.get(op.id).stagename && op.IsWon)
            {
                // Triger is bulkified to handle multiple Tier (Silver, Gold, Platinum).
                tierNa.add(op.Tier__c);
            }
        }
            
        if(!tierNa.isEmpty()){
            // Query User record to find the Tier and its corresponding User. 
            // It is assumed that for one tier there shold be one user(which ideally is not the case)
            
            for(user us : [select tier__c,id from user where tier__c=:tierNa limit 50000 ]){
                // Store the map of tier Name with user Id to assign it to Owner
                // Like Silve - Arvind ,  Noah - Gold , Shrawan -Diamond
                tierWithUserId.put(us.tier__c,us.id);
            } 
        
            // Value collected. now use it to create subscription data
            List<Subscription__c> subToInsert = new List<Subscription__c>();
            for(opportunity op : opList){
                // check the condition again. Though its not needed because this condition is still under Tier check 
               if(op.tier__c!=null && op.billing_Schedule__c!=null && op.stagename!=OldMapOpp.get(op.id).stagename && op.IsWon)
               {
                   // Create instance of Subscription and store in to List
                   subscription__c sc = new Subscription__c();
                       sc.tier__c= op.tier__c;
                       sc.account__c=op.accountid;
                       sc.Billing_Schedule__c = op.Billing_Schedule__c;
                       sc.ownerid=tierWithUserId.get(op.tier__c);
                       sc.Active__c=true;
                       if(op.billing_schedule__c=='Monthly')
                           sc.amount__c=op.amount;
                       else if(op.billing_schedule__c=='Quarterly')
                           sc.amount__c=op.amount*4;
                       else if (op.billing_schedule__c=='Yearly')
                           sc.amount__c=op.amount*12;
                   subToInsert.add(sc);
               }
            }
            
            // Check list size and insert 
            if(!subToInsert.isEmpty()){
                     
                insert subToInsert;
                
            }
        } 
    }
}