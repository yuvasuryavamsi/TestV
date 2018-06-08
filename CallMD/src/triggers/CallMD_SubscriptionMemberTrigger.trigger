trigger CallMD_SubscriptionMemberTrigger on Subscriptions__c (before insert,before update,after insert,after update) {
    
  Set<id> memberIds=new Set<id>();
  Set<id> programIds=new Set<id>();
  
  List<Subscriptions__c> subList=new List<Subscriptions__c>();

  if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
       
    for(Subscriptions__c sub:Trigger.New){
        
      sub.B2B_D2C_Ref__c=sub.B2B_D2C__c;
      
        memberIds.add(sub.Member__c);
        programIds.add(sub.Program__c);
    }
       
    Map<id,Programs__c> mapProgram=new Map<id,Programs__c>([SELECT id,Name,Duration__c,Days__c,Program_Type__c
                                                                            FROM Programs__c 
                                                                            WHERE ID IN:programIds]);
   if(!mapProgram.isEmpty()){
     for(Subscriptions__c sub:Trigger.New){
        Programs__c p=mapProgram.get(sub.Program__c);
        if(p.Program_Type__c=='D2C')
        {
            if(sub.Remaining_Consultation__c==0){
                
                sub.Subscription_Type__c='Renewal';
            }
            if(sub.Subscription_Type__c=='New' && sub.Payment__c=='Successful')
            {
                sub.Start_Date__c=sub.Payment_Date__c;
                sub.End_Date__c=sub.Payment_Date__c + integer.valueOf(p.Days__c);
            }
        }
     }
   }  
  }    
}