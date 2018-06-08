public class CallMD_OpenConsultations {

    public CallMD_OpenConsultations(ApexPages.StandardController controller) {

    }
    
   
    Public ApexPages.StandardSetController sc{get{
  
    if(sc==NULL){
  
    List<Open_Consultants__c> openConsult=[SELECT CallBack_Number__c, CallBack_Time__c, Consulation_Remarks__c,
                                                  Date__c, Date_Time_of_consultation__c, Doctorc__r.Name, Consultation_Type__c, 
                                                  Meds_Prescribed_During_Consultation__c, Member__r.FirstName__c,Member__r.Full_Name__c,
                                                  Rx_Follow_up_Date_Time_Done__c, Rx_Follow_Up_Remarks__c,Doctor_Consultation_Remark__c,
                                                  Rx_Follow_up_Schedule__c, States__c, Status__c, StatusChange__c,Subscription__r.Program_Name__c,
                                                  Benefit_Provider__c,CreatedBy.Name,CreatedDate
                                                  FROM Open_Consultants__c ORDER BY CreatedDate DESC];
      sc=new ApexPages.StandardSetController(openConsult);
   }
   
      sc.setPageSize(100);
      return sc;
  
  }set;}
  
  Public List<Open_Consultants__c> getOpenConsultList(){
  
     return sc.getRecords();
  }
  
  Public void first(){
    sc.first();
  }
  
  Public void last(){
    sc.last();
  }
  
  Public void previous(){
    sc.previous();
  }
  
  Public void next(){
    sc.next();
  }
  
  Public Boolean getHasNext(){
   return sc.gethasNext();
  }
  
  Public Boolean getHasPrevious(){
  
   return sc.getHasPrevious();
  }

}