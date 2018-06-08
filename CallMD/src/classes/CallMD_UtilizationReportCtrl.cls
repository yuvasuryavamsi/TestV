public class CallMD_UtilizationReportCtrl {


  Public List<Providers__c> getProviderList(){
  
     return [SELECT id,Name FROM Providers__c WHERE Customer_Type__c='B2B'];
  
  }
  
  Public map<string,List<UtilizationWrapper>> mapUtilization{get{
  
       mapUtilization=new map<string,List<UtilizationWrapper>>();
       
       
       List<Providers__c> provList=[SELECT id,Name FROM Providers__c WHERE Customer_Type__c='B2B'];
      
       System.debug('Providers List:: '+provList);

       Set<Id> provIds=new Set<Id>();

       for(Providers__c p:provList){
           provIds.add(p.id);
       }

       system.debug('Provider IDs:: '+provIds);

       List<Programs__c> progList=[SELECT id,Name FROM Programs__c WHERE Providers__c IN:provIds];

       System.debug('Program List:: '+progList);

       Set<Id> progIds=new Set<Id>();

       for(Programs__c p:progList){
         progIds.add(p.id);   
       }

       system.debug('Program Ids:: '+progIds);

       Integer countConsult=[SELECT Count() FROM Open_Consultants__c WHERE B2B_D2C__c='B2B' AND 
                                             Subscription__r.Program__c IN:progIds];

       system.debug('Consultation Count:: '+countConsult);

       integer countMembers=[SELECT Count() FROM Member__c WHERE Customer_Type__c='B2B' AND B2B_Programs__c!=NULL AND B2B_Programs__c IN:progIds];

       system.debug('Members Count:: '+countMembers);

       Double Utilization=((countMembers/countConsult)*100);

       system.debug('Utilization %:: '+Utilization);
       
       List<UtilizationWrapper> lstUtiliztionWrap=new List<UtilizationWrapper>();
       
       UtilizationWrapper UtilWrapp=new UtilizationWrapper();
       
       UtilWrapp.programName='P1';
       UtilWrapp.totalConsults=countConsult;
       UtilWrapp.members=countMembers;
       UtilWrapp.Utilizationper=Utilization;
       lstUtiliztionWrap.add(UtilWrapp);
       
       mapUtilization.put('Business Provider',lstUtiliztionWrap);
       mapUtilization.put('Business Provider 2',lstUtiliztionWrap);
       
       
  
  return mapUtilization;
  }
  set;}
  
  
  Public class UtilizationWrapper{
  
    public string programName{get;set;}
    public integer totalConsults{get;set;}
    public Double members{get;set;}
    public Double Utilizationper{get;set;}
  
  }
   


  public String programName { get; set; }

  Public List<Programs__c> progUtilizationList{get;set;}
  
  public CallMD_UtilizationReportCtrl(){
  
      progUtilizationList=[SELECT id,Name,B2B_Consultation_Exceeded__c, Total_No_Of_Consultations_For_B2B__c,
                                     Utilization_Exceeded__c,Program_Type__c,Product__c,Utilization__c,
                                     Provider_Name__c, Total_Member_Count__c
                                     FROM Programs__c WHERE Program_Type__c='B2B'];
  }
  
  Public void search(){
    
     programName='%'+programName+'%';
     progUtilizationList=[SELECT id,Name,B2B_Consultation_Exceeded__c, Total_No_Of_Consultations_For_B2B__c,
                                     Utilization_Exceeded__c,Program_Type__c,Product__c,Utilization__c,
                                     Provider_Name__c, Total_Member_Count__c
                                     FROM Programs__c WHERE Program_Type__c='B2B' AND Name LIKE:programName];
     programName=programName.remove('%');
     
  }


}