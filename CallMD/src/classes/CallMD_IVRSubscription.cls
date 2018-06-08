@RestResource(urlMapping='/v1/subscription/*')
global class CallMD_IVRSubscription {
    
    @HttPPost
    global static subResponse SubscriptionCopay(string memberId,string transactionId,String ProviderId,String ProgramId){
        
       subResponse sResp=new subResponse();
        
       Subscriptions__c sub=new Subscriptions__c();
        
       sub.Member__c=memberId;
       sub.Payment_Date__c=Date.today();
       sub.Transaction_Id__c=transactionId;
       sub.Payment__c='Successful';
       sub.Payment_Method__c='Stripe';
       sub.Subscription_Type__c='New';
       sub.Program__c=programId;
       sub.Provider__c=ProviderId;
       
      try{
       insert sub;
        
        sResp.memberId=memberId;
        sResp.subscriptionId=sub.id;
        sResp.statusmsg='created successfully';
        sResp.status='Success';
      }
      catch(exception e){
         sResp.statusmsg='Problem in creation'; 
         sResp.status='Problem';
      }
       
      return sResp;
        
    }
    
    global class subResponse{
        
        public string memberId;
        public string subscriptionId;
        public string statusmsg;
        public string status;
        
    }

}