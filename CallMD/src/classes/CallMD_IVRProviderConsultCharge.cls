@RestResource(urlMapping='/v1/CallMD_IVRProviderConsultCharge/*')
global class CallMD_IVRProviderConsultCharge {
    
    @HttPGet
    global static List<ConsultationWrapper> doGetConsultationCharge(){
        
        RestRequest req=RestContext.request;
        
        //Integer offset=integer.valueOf(req.params.get('start'));
        //Integer limits=integer.valueOf(req.params.get('end'));
         
      List<ConsultationWrapper> cw=new List<ConsultationWrapper>();
        
      //string query='SELECT Member__r.Full_Name__c,Program__r.Program_ID__c,Program__r.Name,Package__r.No_of_Consultations__c,Package__r.Pricing__c,Package__r.Copay__c,Package__r.Copay__c,Package__r.Remaining_Consultation__c FROM Subscriptions__c WHERE Status__c=\'Active\'';
       
       string query='SELECT Member__r.Full_Name__c,Program__r.Program_ID__c,Program__r.Name,Provider__r.Name,B2B_D2C__c,Pricing__c, Remaining_Consultation__c, Total_Consultations_Done__c,Total_Consultation_To_Do__c,Status__c, Start_Date__c, End_Date__c,Copay_Amount__c FROM Subscriptions__c WHERE Status__c=\'Active\'';
        
       List<Subscriptions__c> subList=Database.query(query);
        
        for(Subscriptions__c sub:subList){
           ConsultationWrapper c=new ConsultationWrapper(sub.Member__r.Full_Name__c,sub.Program__r.Program_ID__c,
                                                         sub.Program__r.Name,sub.Total_Consultations_Done__c,
                                                         sub.Remaining_Consultation__c,
                                                         sub.Pricing__c,sub.Copay_Amount__c);         
            cw.add(c);
        }
        return cw;
    }
    
    global class ConsultationWrapper{
        
       public string MemberName;
       public string ProgramID;
       Public String ProgramName;
       Public Decimal NoOfConsulatationsUsed;
       Public Decimal NoOfConsulatationsOwed;
       Public Decimal SubscriptionFee;
       Public Decimal CopayAmount;
        
        public ConsultationWrapper(string MemberName,string ProgramID,String ProgramName,Decimal NoOfConsulatationsUsed,Decimal NoOfConsulatationsOwed,Decimal Amount,Decimal CopayAmount){
            
            this.MemberName=MemberName;
            this.ProgramID=ProgramID;
            this.ProgramName=ProgramName;
            this.NoOfConsulatationsUsed=NoOfConsulatationsUsed;
            this.NoOfConsulatationsOwed=NoOfConsulatationsOwed;
            this.SubscriptionFee=Amount;
            this.CopayAmount=CopayAmount;
        }
   
    }
    

}