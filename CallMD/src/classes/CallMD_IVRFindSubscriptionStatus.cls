@RestResource(urlMapping='/v1/CallMD_IVRFindSubscriptionStatus/*')
global class CallMD_IVRFindSubscriptionStatus {
    
    @HttpGet
    global static subscriptionInfo findSubscriptionStatus(){
        
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        string memberID=req.params.get('memberID');
        subscriptionInfo subInfo=new subscriptionInfo();
        
     try{
        Subscriptions__c sub=[SELECT id,Member__c,Member__r.Full_Name__c,Program__c,Program_Name__c,Provider__c,Provider_Name__c,Status__c,
                                        Copay_Yes_No__c, Copay_Amount__c 
                                        FROM Subscriptions__c 
                                        WHERE Member__c=:memberID ORDER BY CreatedDate DESC LIMIT 1];
        if(sub!=null){
            subInfo.memberName=sub.Member__r.Full_Name__c;
            subInfo.memberID=sub.Member__c;
            subInfo.subscriptionID=sub.id;
            subInfo.subscriptionStatus=sub.Status__c;
            subInfo.providerID=sub.Provider__c;
            subInfo.providerName=sub.Provider_Name__c;
            subInfo.programID=sub.Program__c;
            subInfo.programName=sub.Program_Name__c;
            subInfo.statusMsg='Member Found';
            subInfo.CopayYesNo=sub.Copay_Yes_No__c;
            subInfo.CopayAmount=sub.Copay_Amount__c;
      }
      else{
          
        subInfo.statusMsg='No Member Found';
      }
    }
    catch(exception e){
        
       subInfo.statusMsg='No Subscription found for Member';
    } 
        return subInfo;
    } 
    
    global class subscriptionInfo{
        
        public string memberName;
        public string memberID;
        public string subscriptionID;
        public string subscriptionStatus;
        public string programID;
        public string programName;
        public string providerID;
        public string providerName;
        Public string statusMsg;
        Public String CopayYesNo;
        Public Decimal CopayAmount;
        
    }

}