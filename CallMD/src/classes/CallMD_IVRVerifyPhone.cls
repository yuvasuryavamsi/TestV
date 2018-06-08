@RestResource(urlMapping='/v1/verifyphone/*')
global class CallMD_IVRVerifyPhone {
    
    @HttpGet
    global static responsePhone doVerifyPhone(){
        
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        responsePhone resPhone=new responsePhone();
        
        string Phone=req.params.get('PhoneNumber');
        List<Member__c> memDetails;
        try{
            memDetails=[SELECT id,Cell_Phone__c,CallMDUserName__c  FROM Member__c WHERE Cell_Phone__c Like:Phone];
            
            if(memDetails.size()==1){
                resPhone.status='success';
                resPhone.phonenumber=memDetails[0].Cell_Phone__c;
                resPhone.callMDAccountNumber=memDetails[0].CallMDUserName__c;
                resPhone.statusmsg='Found';
                resPhone.id=memDetails[0].id;
            }
            else{
                resPhone.status='Failure'; 
                resPhone.statusmsg='Not Found';
            }
        }
        catch(Exception e){
            
            
        }
        return resPhone;
    }
    

    global class responsePhone{
        public string status;
        public string phonenumber;
        public string callMDAccountNumber;
        public string statusmsg;
        public string id;
    }
}