@RestResource(urlMapping='/v1/IVRVerifyMemStatusProg/*')
global class CallMD_IVRVerifyMemStatusProg {
    
    @HttpGet
    global static responseMember doVerifyMemberStatProg(){
        
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        
        responseMember respMem=new responseMember();
        
        string CallMDAccountNumber=req.params.get('CallMDMemberAccount');
        List<Member__c> memDetails;   
        
        try{
            
            memDetails=[SELECT id,CallMDUserName__c,Cell_Phone__c,Program_Status__c,Status__c    
                        FROM Member__c 
                        WHERE CallMDUserName__c=:CallMDAccountNumber
                        ];
            
            if(memDetails.size()==1){
                
                if(memDetails[0].Program_Status__c=='Active' && memDetails[0].Status__c=='Active'){
                    
                    respMem.status='success';
                    respMem.CallMDAccountNumber=memDetails[0].CallMDUserName__c;
                    respMem.phoneNumber=memDetails[0].Cell_Phone__c;
                    respMem.statusmsg='Active';
                    
                }
                else{
                    
                    respMem.status='failure';
                    respMem.CallMDAccountNumber=memDetails[0].CallMDUserName__c;
                    respMem.phoneNumber=memDetails[0].Cell_Phone__c;
                    respMem.statusmsg='In Active';
                    
                }
                
                
            }
            
        }
        catch(exception e){
            
        }
        
      
    return respMem;
    
}

global class responseMember{
    
    public string status;
    public string callMDAccountNumber;
    public string phoneNumber;
    public string statusmsg;      
    
    
}

}