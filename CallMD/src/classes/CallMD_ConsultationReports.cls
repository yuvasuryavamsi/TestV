public class CallMD_ConsultationReports {

   Public Map<string,List<ConsultationInfo>> mapConsult{get{
   
      Map<string,List<ConsultationInfo>> mapConsultInfo=new Map<string,List<ConsultationInfo>>();
      
      ConsultationInfo consult=new ConsultationInfo();
      
      List<String> providersLst=new List<String>{'CallMD'};
      
      List<Open_Consultants__c> lstOpenConsultation=[SELECT id,Subscription__r.Program__c,Subscription__r.Program__r.Name,
                                                            Subscription__r.Provider__c,Subscription__r.Provider__r.Name 
                                                            FROM Open_Consultants__c];
                                                            
      Map<string,List<Open_Consultants__c>> mapConsultations=new Map<string,List<Open_Consultants__c>>();
         
      for(Open_Consultants__c openConsult:lstOpenConsultation){
        if(!mapConsultations.containsKey(openConsult.Subscription__r.Provider__c+'-'+openConsult.Subscription__r.Program__c)){
         mapConsultations.put(openConsult.Subscription__r.Provider__c+'-'+openConsult.Subscription__r.Program__c,
                                 new List<Open_Consultants__c>{openConsult});
         }
         else{
          mapConsultations.get(openConsult.Subscription__r.Provider__c+'-'+openConsult.Subscription__r.Program__c).add(openConsult);
         }
      } 
      
                                                          
                                                            
      
      List<ConsultationInfo> lstConsultInfo=new List<ConsultationInfo>();
      
      ConsultationInfo consInfo=new ConsultationInfo();
      consInfo.ProviderName='CallMD';
      consInfo.ProgramId='';
      consInfo.ProgramName='One Time';
      consInfo.NoOfConsultations=10;
      lstConsultInfo.add(consInfo);
       
      ConsultationInfo consInfo2=new ConsultationInfo();
      consInfo2.ProviderName='CallMD';
      consInfo2.ProgramId='';
      consInfo2.ProgramName='Family';
      consInfo2.NoOfConsultations=20;
      lstConsultInfo.add(consInfo2);
      
      ConsultationInfo consInfo3=new ConsultationInfo();
      consInfo3.ProviderName='CallMD';
      consInfo3.ProgramId='';
      consInfo3.ProgramName='Package-3 6 Months Subscription Plan';
      consInfo3.NoOfConsultations=30;
      lstConsultInfo.add(consInfo3);
      
      ConsultationInfo consInfo4=new ConsultationInfo();
      consInfo4.ProviderName='CallMD';
      consInfo4.ProgramId='';
      consInfo4.ProgramName='Package-4 12 Months Subscription Plan';
      consInfo4.NoOfConsultations=40;
      lstConsultInfo.add(consInfo4);
      
      
     
      mapConsultInfo.put('CallMD',lstConsultInfo);
  
      return mapConsultInfo;
   
   
   }set;}


   Public class ConsultationInfo{
   
     Public String ProgramName{get;set;}
     Public String ProgramId{get;set;}
     Public String ProviderName{get;set;}
     Public Integer NoOfConsultations{get;set;}
   
   
   }


}