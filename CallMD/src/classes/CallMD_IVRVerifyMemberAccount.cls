@RestResource(urlMapping='/v1/verifymemberaccount/*')
global class CallMD_IVRVerifyMemberAccount {
    
    @HttpGet
    global static responseMember doVerifyMember(){
        
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        
        responseMember respMem=new responseMember();
        
        string CallMDccountNumber=req.params.get('CallMDAccountNumber');
        List<Member__c> memDetails;   
        
        try{
        
            memDetails=[SELECT id,CallMDUserName__c,Cell_Phone__c FROM Member__c WHERE CallMDUserName__c=:CallMDccountNumber];
            
            if(memDetails.size()==1){
                
                respMem.status='success';
                respMem.CallMDAccountNumber=memDetails[0].CallMDUserName__c;
                respMem.phoneNumber=memDetails[0].Cell_Phone__c;
                respMem.statusmsg='Found';
                respMem.id=memDetails[0].id;
            }
            else{
                respMem.status='Failure';
                respMem.CallMDAccountNumber=CallMDccountNumber;
                respMem.statusmsg='No Found';
            }
        }
        catch(Exception e){
           
        }

        return respMem;  
    }
    
    global class responseMember{
        public string status;
        public string callMDAccountNumber;
        public string phoneNumber;
        public string statusmsg;
        public string id;  
    }
    
}