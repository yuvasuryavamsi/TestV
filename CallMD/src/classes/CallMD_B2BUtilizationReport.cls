public class CallMD_B2BUtilizationReport {

  public String programValue { get; set; }
    
  public map<id,string> mapProgramName{get;set;}
  
  public map<id,List<id>> mapProgProvName{get;set;}
  
  public map<id,string> mapProviderName{get;set;}
  
  Public List<Providers__c> provList;
  
  public string providerValue{get;set;}
  
  Public List<selectOption> providerOpt{get;set;}
  
  public List<Programs__c> progList;
  
  public List<Providers__c> provList2;
  
  public map<String,Double> mapFinal{get;set;}
  
  Public Date StartDate{get;set;}
  
  Public Date EndDate{get;set;}
    
  public CallMD_B2BUtilizationReport(){
  
       provList=[SELECT id,Name FROM Providers__c WHERE Customer_Type__c='B2B' ORDER BY Name];
       System.debug('Providers List:: '+provList);
       
       providerOpt=new List<selectOption>();
       
       for(providers__c p:provList){
         
         providerOpt.add(new selectOption(p.id,p.name));
       }
  }
  
  public List<selectOption> opt;
  
  Public List<selectOption> getProgramOption(){
  
    opt=new List<selectOption>();
     
     List<Programs__c> progList=[SELECT id,Name FROM Programs__c WHERE Program_Type__c='B2B'];
     
     for(Programs__c p : progList){
     
       opt.add(new selectOption(p.id,p.name));
     } 
   return opt;
  }
  
  
  public void change(){
 
  }
  
  
  public void CreateReport(){
  
    mapFinal=new map<string,Double>();
        
      provList2=[SELECT id,Name FROM Providers__c WHERE Customer_Type__c='B2B' AND ID=:providerValue];
      
      Set<Id> provIds=new Set<Id>();
      
      mapProviderName=new map<id,string>();
      
      for(Providers__c p:provList2){
          provIds.add(p.id);
          mapProviderName.put(p.id,p.name);
      }
      system.debug('Provider IDs:: '+provIds);
      
      system.debug('Provider Name:: '+mapProviderName);
      
      progList=[SELECT id,Name,Providers__c FROM Programs__c WHERE Providers__c IN:provIds AND ID=:programValue];
      System.debug('Program List:: '+progList);
      
      Set<Id> progIds=new Set<Id>();
      
      mapProgramName=new map<id,string>();
      
      mapProgProvName=new map<id,List<id>>();
      
      for(Programs__c p:progList){
          progIds.add(p.id);  
          mapProgramName.put(p.id,p.name); 
          
         if(!mapProgProvName.containsKey(p.Providers__c)){
            mapProgProvName.put(p.Providers__c,new List<Id>{p.id});
         }
         else{
           mapProgProvName.get(p.Providers__c).add(p.id);
         }
          
      }
      system.debug('Program Ids:: '+progIds);
      
      map<object,object> mapProgramConsultCount=new map<object,object>();
      
      AggregateResult[] arList=[SELECT Count(Subscription__r.Program__c),Program__c FROM Open_Consultants__c
                                WHERE B2B_D2C__c='B2B' AND (CreatedDate >=:StartDate AND CreatedDate <=:EndDate) GROUP BY Program__c  ];
      for(AggregateResult ar:arList){
          
          system.debug('PROG Count - Consultations:: '+ar.get('expr0')); 
          system.debug('Program ID:: '+ar.get('Program__c'));
          mapProgramConsultCount.put(ar.get('Program__c'),ar.get('expr0'));           
      }
      system.debug('Programs Count:: '+mapProgramConsultCount);
      
      map<object,object> mapProgramMemberCount=new map<object,object>();
      
      AggregateResult[] arList2=[SELECT count(id),B2B_Programs__c FROM Member__c WHERE Customer_Type__c='B2B' AND 
                                 B2B_Programs__c!=NULL 
                                 AND B2B_Programs__c IN:progIds AND (CreatedDate >=:StartDate AND CreatedDate <=:EndDate)
                                 GROUP BY B2B_Programs__c];
      
      for(AggregateResult ar:arList2){
          
          system.debug('Program ID:: '+ar.get('B2B_Programs__c'));
          system.debug('Member Count:: '+ar.get('expr0'));
          mapProgramMemberCount.put(ar.get('B2B_Programs__c'),ar.get('expr0'));
      }
      system.debug('Program Member Count:: '+mapProgramMemberCount);
     
      for(ID prog:progIds){
          
          Double d=double.ValueOf(mapProgramMemberCount.get(prog))/double.ValueOf(mapProgramConsultCount.get(prog))*100;
          system.debug(d);
          mapFinal.put(prog,d);  
          
      }
      system.debug('Program Utilization:: '+mapFinal);   
  
  
  }
  
  public pageReference generatePdf(){
    return page.CallMD_UtilizationReportPdf;
  }
    
  
}