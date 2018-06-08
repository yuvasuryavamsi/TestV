public class CallMD_ConsultationReport {
    
    Public Map<id,List<id>> mapProv{get;set;}
    
    Public Map<id,List<Programs__c>> mapProgram{get;set;}
    
    
    
    /*
    
       Provider Name
       
       Program Name       No of Consultations (As Per Date)
       
       p1                 4
       p2                 5
       p3                 6
       
    
    */
    
    Public  Map<String,List<ConsultationWrapper>> consultWrap;
    
    Public CallMD_ConsultationReport(){
    
       consultWrap=new Map<String,List<ConsultationWrapper>>();
       
       List<ConsultationWrapper> lstConsult=new List<ConsultationWrapper>();
       
       ConsultationWrapper cw=new ConsultationWrapper();
       cw.providerName='CallMD';
       cw.programName='One Time';
       cw.programCount=20;
       lstConsult.add(cw);
       
       consultWrap.put('CallMD',lstConsult);
        
    }
    
    Public Map<String,List<ConsultationWrapper>> mapConsultReport{get{
    
      
       
       
       return consultWrap;
    
    }
    set;}
    
 
    
    
  /*  Public Map<string,ConsultationWrapper> consultWrapper{get{
    
       Map<String,ConsultationWrapper> mapConsulWrapp =new Map<String,ConsultationWrapper>();
       
       List<Open_Consultants__c> openConsultList=[SELECT id,Name,Subscription__r.Program__c,Subscription__r.Provider__c 
                                                            FROM Open_Consultants__c];
                                                      
       Map<String,List<ProgramInfo>> mapConsult=new Map<String,List<ProgramInfo>>();   
       
       List<ProgramInfo> progInfo=new List<ProgramInfo>();  
       
       Set<String> provIds=new Set<String>();                                        
                                                      
       for(Open_Consultants__c openConsult:openConsultList){
       
              ProgramInfo p=new ProgramInfo();
              p.Programid=openConsult.Subscription__r.Program__c;
              p.programName=openConsult.Subscription__r.Program__c;
              
           if(!mapConsult.containsKey(openConsult.Subscription__r.Provider__c)){
              mapConsult.put(openConsult.Subscription__r.Provider__c,new List<ProgramInfo>{p});
           }
           else{
             mapConsult.get(openConsult.Subscription__r.Provider__c).add(p);
           }
          provIds.add(openConsult.Subscription__r.Provider__c);
       }
       
       Map<id,Providers__c> mapProviders=new Map<id,Providers__c>([SELECT id,Name FROM Providers__c WHERE ID IN:provIds]);
       
       for(Id p:provIds){
       
           ConsultationWrapper cw=new ConsultationWrapper();
           cw.ProviderName=mapProviders.get(p).Name;
           List<ProgramWrapper> pw=new List<ProgramWrapper>();
           ProgramWrapper pp=new ProgramWrapper();
           pp.ProgramName='test';
           pp.ProgramCount=mapConsult.size();
           pw.add(pp);
           cw.progWrapp=pw;
           mapConsulWrapp.put(p,cw);
       }
       return mapConsulWrapp;
    }set;}
    
    */
    
    
    Public class ProgramInfo{
    
      Public string ProgramId;
      Public string ProgramName;
    }
    
    Public class ConsultationWrapper{
    
       Public string providerName{get;set;}
       public string ProgramName{get;set;}
       Public integer programCount{get;set;}
    
    }
    
    Public class ProgramWrapper{
    
      Public string programName;
      Public integer programCount;
    
    }
    
    
    //Public CallMD_ConsultationReport(){
        
    /* mapProv=new Map<id,List<id>>();
    mapProgram =new Map<id,List<Programs__c>>();
    
    List<Open_Consultants__c> openConsultList=[SELECT id,Name,Subscription__r.Program__c,Subscription__r.Provider__c 
                                                      FROM Open_Consultants__c];
    
    for(Open_Consultants__c op:openConsultList){
      
     if(op.Subscription__r.Provider__c!=null && op.Subscription__r.Program__c!=null){ 
        if(!mapProv.containsKey(op.Subscription__r.Provider__c)){
            mapProv.put(op.Subscription__r.Provider__c,new List<id>{op.Subscription__r.Program__c});
        }
        else {
            mapProv.get(op.Subscription__r.Provider__c).add(op.Subscription__r.Program__c);
        }
      } 
    }
    system.debug('Provider:: '+mapProv);
    for(Programs__c p:[SELECT id,Name,Providers__c FROM Programs__c WHERE Providers__c IN:mapProv.keyset()]){
     if(!mapProgram.containsKey(p.Providers__c)){
      mapProgram.put(p.Providers__c,new List<Programs__c>{p});
     }
     else{
      mapProgram.get(p.Providers__c).add(p);
     }
    }
    system.debug('Program:: '+mapProgram); */
    
   //}     
   
    

}