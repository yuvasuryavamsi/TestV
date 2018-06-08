@RestResource(urlMapping='/v1/verifymobilepin/*')
global class CallMD_UserMobileLogin {
    
    @HttpGet
    global static responseMemberPin doVerifyMemPin(){
        
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        
        responseMemberPin respMem=new responseMemberPin();
        List<responseSubscription> responseSubList=new List<responseSubscription>();
        
        string UserAccess=req.params.get('UserAccess');
        string MemberPin=req.params.get('CallMDMemberPin');
        List<Member__c> memDetails;
        
        try{
        
            memDetails=[SELECT id,CallMDUserName__c,Cell_Phone__c,Email__c,Member_Pin__c,Program_Status__c   
                               FROM Member__c 
                               WHERE (CallMDUserName__c=:UserAccess OR Cell_Phone__c=:UserAccess OR Email__c=:UserAccess)
                               AND Pin__c=:MemberPin];
            
            if(memDetails.size()==1){
                
                respMem.status='success';
                respMem.UserAccess=memDetails[0].CallMDUserName__c;
                respMem.CallMDAccountNumber=memDetails[0].CallMDUserName__c;
                respMem.phoneNumber=memDetails[0].Cell_Phone__c;
                respMem.MemberId=memDetails[0].id;
                respMem.statusmsg='verified';
                
                if(memDetails[0].Program_Status__c=='Active'){
                    
                    List<Subscriptions__c> subList=[SELECT id,Member__c,Member__r.Full_Name__c,Program__c,Program__r.Product__c,Program_Name__c,Provider__c,
                                                 Provider_Name__c,Status__c,Total_Consultations_Done__c,Total_Consultation_To_Do__c,Pricing__c,Copay_Amount__c,  
                                                 Program__r.Description_content__c,Program__r.Title_content__c,Program__r.small_image_url__c,Program__r.large_image_url__c  
                                                 FROM Subscriptions__c 
                                                 WHERE Member__c=:memDetails[0].id];
                
                    
                    if(!subList.isEmpty()){  
                         for(Subscriptions__c sub:subList){
                          responseSubscription respSub=new responseSubscription();
                             respSub.subscriptionID=sub.id;
                             respSub.subscriptionStatus=sub.Status__c;
                             respSub.providerID=sub.Provider__c;
                             respSub.providerName=sub.Provider_Name__c;
                             respSub.programID=sub.Program__c;
                             respSub.programName=sub.Program_Name__c;
                             respSub.Amount=sub.Pricing__c;
                             respSub.consultationUsed =sub.Total_Consultations_Done__c;
                             respSub.consultationOwed =sub.Total_Consultation_To_Do__c;
                             respSub.CopayAmount=sub.Copay_Amount__c;
                             respSub.title=sub.Program__r.Product__c;
                             respSub.small_image_url=sub.Program__r.small_image_url__c;    
                             respSub.large_image_url=sub.Program__r.large_image_url__c;
                             respSub.title_content=sub.Program__r.Title_content__c;
                             respSub.description_content=sub.Program__r.Description_content__c;
                             responseSubList.add(respSub);
                         }
                      }
                        respMem.subscriptions=responseSubList;
                        system.debug('Subscriptions:: '+responseSubList);
                }
            }
            else{
                respMem.status='Failure';
                respMem.UserAccess=UserAccess;
                respMem.statusmsg='Not Verified';
            }
        }
        catch(exception e){}
        
        return respMem;
  
    }
    
   global class responseMemberPin{
        public string status;
        public string statusmsg; 
        public string callMDAccountNumber;
        public string UserAccess;
        public string memberName;
        public string MemberId;
        public string phoneNumber; 
        Public List<responseSubscription> subscriptions;
    }
   
    global class responseSubscription{
        
        public string subscriptionID;
        public string subscriptionStatus;
        public Double Amount;
        public string providerID;
        public string providerName;
        public string programID;
        public string programName;
        public double consultationUsed;
        public double consultationOwed; 
        public double copayAmount;
        public string title;
        public string small_image_url;
        public string large_image_url;
        public string title_content;
        public string description_content;
       
    }

}