public class OpportunityTriggerHandler {
    
    // This is where all the After update Function will be defined. Similary we should have function for other events
    
    public static void afterUpdate(List<Opportunity> opList, Map<Id,Opportunity> OldMapOpp){
        // function to create subscription record when Opportunity is ClosedWon
        OpportunityTriggerHelper.createSubscriptionRecord(opList,OldMapOpp);
        //
    }
}