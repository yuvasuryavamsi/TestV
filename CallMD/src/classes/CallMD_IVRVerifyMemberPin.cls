@RestResource(urlMapping='/v1/verifymemberpin/*')
global class CallMD_IVRVerifyMemberPin {
    
    @HttpGet
    global static responseMemberPin doVerifyMemPin(){
        
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        
        responseMemberPin respMem=new responseMemberPin();
        
        string CallMDAccountNumber=req.params.get('CallMDAccountNumber');
        string MemberPin=req.params.get('CallMDMemberPin');
        List<Member__c> memDetails;
        
        try{
        
            memDetails=[SELECT id,Name,Cell_Phone__c,Member_Pin__c,Program_Status__c,Full_Name__c,State__c  
                               FROM Member__c 
                               WHERE Name=:CallMDAccountNumber
                               AND Pin__c=:MemberPin];
            
            if(memDetails.size()==1){
                
                respMem.status='success';
                respMem.CallMDAccountNumber=memDetails[0].Name ;
                respMem.phoneNumber=memDetails[0].Cell_Phone__c;
                respMem.memberName=memDetails[0].Full_Name__c;
                respMem.memberID=memDetails[0].id;
                respMem.statusmsg='verified';
                respMem.state=memDetails[0].State__c;
                respMem.ProgramStatus=memDetails[0].Program_Status__c;
                
               
                    
                    Subscriptions__c sub=[SELECT id,Member__c,Member__r.Full_Name__c,Program__c,Program__r.Product__c,Program_Name__c,
                                                 Provider__c,Copay_Amount__c,Stage__c, 
                                                 Provider_Name__c,Status__c,Total_Consultations_Done__c,Total_Consultation_To_Do__c 
                                                 FROM Subscriptions__c 
                                                 WHERE Member__c=:memDetails[0].id ORDER BY CreatedDate DESC LIMIT 1];
                
                     if(sub!=null){
                         
                         respMem.subscriptionID=sub.id;
                         respMem.subscriptionStatus=sub.Status__c;
                         respMem.providerID=sub.Provider__c;
                         respMem.providerName=sub.Provider_Name__c;
                         respMem.programID=sub.Program__c;
                         respMem.programName=sub.Program_Name__c;
                         respMem.statusMsg='verified';
                         respMem.consultationUsed =sub.Total_Consultations_Done__c;
                         respMem.consultationOwed =sub.Total_Consultation_To_Do__c;
                         respMem.CopayAmount=sub.Copay_Amount__c;
                         respMem.title=sub.Program__r.Product__c;
                         respMem.stage=sub.Stage__c; 
                      }       
                
          }
         else{
                respMem.status='Failure';
                respMem.CallMDAccountNumber=CallMDAccountNumber;
                respMem.statusmsg='Not Verified';
            }
        }
        catch(Exception e){  
        }
        return respMem; 
    }
    
   global class responseMemberPin{
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
        public double consultationUsed;
        public double consultationOwed; 
        public double copayAmount;
        public string title; 
        public string memberName;
        public string memberID;
        public string state;
        Public string ProgramStatus;
        Public string stage;
    }

}