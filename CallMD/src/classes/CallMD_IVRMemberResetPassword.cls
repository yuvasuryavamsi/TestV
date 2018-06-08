@RestResource(urlMapping='/v1/resetpassword/*')
global class CallMD_IVRMemberResetPassword {
    
    @HttPPost
    global static memberResponse MemberResetPassword(string memberid,string answer,string password){
        
        Member__c mem=[SELECT id,Answer__c,Confirm_Member_Pin__c,Member_Pin__c 
                                                   FROM Member__c 
                                                   WHERE id=:memberid];
        
        memberResponse resp=new memberResponse();
        
        if(mem.Answer__c==answer){
          mem.Member_Pin__c=password;
          mem.Confirm_Member_Pin__c=password;
          update mem;
          resp.statusMsg='Updated Successfully';
          resp.status='Success';
          resp.memberId=mem.id;   
        }
        else{
          resp.statusMsg='No Answer Matched';
          resp.status='Failed';
          resp.memberId=mem.id;
        }
        
        return resp;
        
    }
    
    
    global class memberResponse{
        
        public string statusMsg;
        public string status;
        public string memberId;
        
    }

}