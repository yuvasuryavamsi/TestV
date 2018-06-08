@RestResource(urlMapping='/v1/updateSubscriptionConsultation')
global class CallMD_IVRUpdateSubscriptionConsultation {
    
    @HttPPost
    global static subscriptionRenewal doRenewal(String SubscriptionID){
        
        subscriptionRenewal subRenewal=new subscriptionRenewal();
        
        subscriptions__c sub=[SELECT id,Member__c,Copay_Yes_No__c,Copay_Amount__c,Consultation_Renewal__c 
                                                        FROM subscriptions__c 
                                                        WHERE ID=:SubscriptionID];
        
        sub.Consultation_Renewal__c=1;
        
        try{
        update sub;
      
        subRenewal.subscriptionID=sub.id;
        subRenewal.memberID=sub.Member__c;
        subRenewal.copayYesNo=sub.Copay_Yes_No__c;
        subRenewal.copayamount=sub.Copay_Amount__c;
        subRenewal.statusMsg='Renewal Sucessful';
        subRenewal.status='Success'; 
        }
        catch(exception e){
        subRenewal.subscriptionID=sub.id;
        subRenewal.memberID=sub.Member__c;
        subRenewal.copayYesNo=sub.Copay_Yes_No__c;
        subRenewal.copayamount=sub.Copay_Amount__c;
        subRenewal.statusMsg='Problem in renewal of subscription';
        subRenewal.status='Failed'; 
         
        }
        
        
        return subRenewal;
        
        
    }
    
    global class subscriptionRenewal{
        
        public string subscriptionID;
        public string memberID;
        public string statusMsg;
        public string status;
        public string copayYesNo;
        public Decimal copayamount;
    }

}