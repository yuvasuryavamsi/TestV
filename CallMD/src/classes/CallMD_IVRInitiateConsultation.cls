@RestResource(urlMapping='/v1/CallMD_IVRInitiateConsultation/*')
global class CallMD_IVRInitiateConsultation {
    
    @HttPPost
    global static ConsultationWrapper doCreateConsultation(String subscriptionID,String memberId,String callBackNumber,
                                                           String product,String IncomingNo,String paymentStatus,
                                                           String recordingId,String patientComplaint,String PaymentTransactionID)
    {
        //Subscriptions__c subs=[SELECT id,Status__c FROM Subscriptions__c WHERE ID=:subscriptionID];
        
        ConsultationWrapper consultWrapp=new ConsultationWrapper();
        Open_Consultants__c openConsult=new Open_Consultants__c();
        openConsult.CallBack_Number__c=callBackNumber;
        openConsult.Subscription__c =subscriptionID;
        openConsult.Products__c=product;
        openConsult.Member__c=memberId;
        openConsult.Incoming_Number__c=IncomingNo;
        openConsult.Payment_Status__c= paymentStatus;
        openConsult.Recording_ID__c=recordingId;
        openConsult.Problem_History__c=patientComplaint;
        openConsult.Payment_transaction_id__c=PaymentTransactionID;
        
        
         insert openConsult;
        
         if(openConsult.id!=null){
             consultWrapp.consultationID=openConsult.id;
             consultWrapp.statusMsg='Consultation Created Successfully';
         }
         else{
            consultWrapp.statusMsg='Consultation was not Successfully';
         }
       /* }
       else{
           consultWrapp.statusMsg='Subscription was not active'; 
       }*/
        return consultWrapp;  
    }
    
     global class ConsultationWrapper{
       public string consultationID;
       public string statusMsg;
     }

}