@RestResource(urlMapping='/v1/initiateconsultation/*')
global class CallMDIVR_Consultations {
    
    @HttPPost
    global static responseConsultation CreateConsultation(String CallbackNumber,String ConsultationType,String InitiatedBy,String Member,String Product){
        
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        
       responseConsultation respCon=new responseConsultation();
        Open_Consultants__c op=new Open_Consultants__c();
        
        try{
            op.CallBack_Number__c=CallbackNumber;
            op.Consultation_Type__c=ConsultationType;
            op.Initiated_By__c=InitiatedBy;
            op.Member__c=Member;
            op.Products__c=Product;
            
            insert op;
            
            if(op.id!=null){
                
                respCon.status='success';
                respCon.statusmsg='Created Successfully';
            }
            else{
                
                respCon.status='Failed';
                respCon.statusmsg='Created Failed';
                
            }
            
            
            
        }
        catch(Exception e){
            
        }
        return respCon;
    }
    
    global class responseConsultation{
        public string status;
        public string statusmsg;  
    }

}