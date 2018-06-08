@RestResource(urlMapping='/v1/verifyMemberSubscriptionStatus/*')
global class CallMD_IVRMemberSubcriptionStatus {
    
    @HttpGet
    global static memberSubscriptionStatus doVerifyMemberPin(){
        
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        
        memberSubscriptionStatus respMem=new memberSubscriptionStatus();
        
        string CallMDAccountNumber=req.params.get('CallMDAccountNumber');
        string MemberPin=req.params.get('CallMDMemberPin');
        
        List<Member__c> memDetails;
        
        try{
            memDetails=[SELECT id,CallMDUserName__c,Cell_Phone__c,Member_Pin__c,Program_Status__c,Full_Name__c,State__c,
                               IVR_UI_Flow__c,Member_Type__c 
                               FROM Member__c 
                               WHERE CallMDUserName__c=:CallMDAccountNumber
                               AND Pin__c=:MemberPin];
            
            if(memDetails.size()==1){
                
                respMem.status='success';
                respMem.CallMDAccountNumber=memDetails[0].CallMDUserName__c;
                respMem.phoneNumber=memDetails[0].Cell_Phone__c;
                respMem.memberName=memDetails[0].Full_Name__c;
                respMem.memberID=memDetails[0].id;
                respMem.navigate=memDetails[0].IVR_UI_Flow__c;
                respMem.statusmsg='verified';
                respMem.state=memDetails[0].State__c;
                respMem.ProgramStatus=memDetails[0].Program_Status__c;
            } 
        }
        catch(exception e){}

        return respMem;
    }
    
    global class memberSubscriptionStatus{
        
        public string status;
        public string callMDAccountNumber;
        public string phoneNumber;
        public string statusmsg;
        public string subscriptionID;
        public string subscriptionStatus;
        public string providerID;
        public string providerName;
        public string programID;
        public string programName;
        public string memberName;
        public string memberID;
        public string state;
        Public string ProgramStatus;
        Public string navigate;
        public string memberType;
    }
    

}