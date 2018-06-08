trigger MemberTrigger on Member__c (after insert) {
    
  if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){  
    List<Subscriptions__c> lstSub=new List<Subscriptions__c>();
      
      Set<String> programName=new Set<String>();
      
      for(Member__c mem:Trigger.New){
          programName.add(mem.Packages__c);
      }
      
      List<Programs__c> lstProgram=new List<Programs__c>([SELECT id,Name,Providers__c,Days__c FROM Programs__c 
                                                           WHERE NAME IN:programName]);
      
      Map<string,Programs__c> mapProgram=new Map<string,Programs__c>();
      
      for(Programs__c prog:lstProgram){
          mapProgram.put(prog.Name,prog);    
      }
      
      if(!mapProgram.isEmpty()){
          for(Member__c mem:Trigger.new){
              Programs__c prog=mapProgram.get(mem.Packages__c);
              Subscriptions__c sub=new Subscriptions__c();
              sub.Member__c=mem.id;
              sub.Program__c=prog.id;
              sub.Provider__c=prog.Providers__c;
              sub.Subscription_Type__c='New';
              sub.Payment__c='InProgress';
              sub.Payment_Method__c='Stripe';
              sub.Payment_Date__c=Date.today();
              sub.Start_Date__c=Date.today();
              sub.End_Date__c=Date.today() + integer.valueOf(prog.Days__c);
              lstSub.add(sub);    
          }
      }
      if(!lstSub.isEmpty()){
          insert lstSub; 
      } 
   }  
}