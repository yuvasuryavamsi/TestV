public class subscriptionMemberTriggerHandler {
     
    public static void memberB2BUtilization(List<Subscriptions__c> subList){
        Set<id> programIds=new Set<Id>();
        Map<id,List<Subscriptions__c>> mapSubscription=new Map<id,List<Subscriptions__c>>();
        List<Member__c> memList=new List<Member__c>();
        map<id,Programs__c> mapProgramUpdate=new map<id,Programs__c>();
        map<id,Decimal> mapProgramConsultNo=new map<id,Decimal>();
        Decimal count=0; 
        
        for(Subscriptions__c sub:subList){
            programIds.add(sub.Program__c);
        }
        if(!programIds.isEmpty()){
            List<Subscriptions__c> lstSubscription=[SELECT id,Total_Consultations_Completed_B2B__c,Program__c  
                                                    FROM Subscriptions__c 
                                                    WHERE Program__c IN:programIds];
            
            for(Subscriptions__c sub:lstSubscription){
                
                count=count+sub.Total_Consultations_Completed_B2B__c;
                
                if(!mapProgramConsultNo.containsKey(sub.Program__c)){
                    mapProgramConsultNo.put(sub.Program__c,count);
                }
            }
            
            for(Subscriptions__c sub:subList){
                Programs__c p=new Programs__c();
                p.id=sub.Program__c;
                p.Consultations_Done_Till_Now__c=mapProgramConsultNo.get(sub.Program__c);
                mapProgramUpdate.put(sub.Program__c,p);
            }
            
            if(!mapProgramUpdate.isEmpty()){
                update mapProgramUpdate.values();
            } 
        }
    }

}