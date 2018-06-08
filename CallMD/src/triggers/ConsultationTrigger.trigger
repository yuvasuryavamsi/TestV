trigger ConsultationTrigger on Open_Consultants__c (before insert,before update) {

   if(trigger.isBefore){
   
      if(trigger.isInsert || trigger.isUpdate){
      
        Set<id> subscriptionIds=new Set<id>();
        
        List<Subscriptions__c> subList=new List<Subscriptions__c>();
        
        for(Open_Consultants__c openConsult:Trigger.new){
        
           subscriptionIds.add(openConsult.Subscription__c);
        
        }
        
        map<id,Subscriptions__c> mapSubcription=new map<id,Subscriptions__c>([SELECT id,Name,Consultation_Renewal__c,Program__c
                                                                                 FROM Subscriptions__c WHERE ID IN:subscriptionIds]);
                                                                                 
        
        for(Open_Consultants__c openConsult:trigger.new){
        
          
        
          Subscriptions__c sub=mapSubcription.get(openConsult.Subscription__c);
          
          openConsult.Program__c=sub.Program__c;
          
         /* 
         if(sub!=null){
           sub.Consultation_Renewal__c=null;
           
           subList.add(sub);
         }*/
        
        }
        
       /* if(!subList.isEmpty()){
           update subList;
        }   */                                                                       
       
      }
   
   }

}