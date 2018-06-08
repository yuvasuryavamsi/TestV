public class CallMD_OpenConsultationsCtrl {


  Public ApexPages.StandardSetController sc{get{
  
    if(sc==NULL){
  
    List<Open_Consultants__c> openConsult=[SELECT CallBack_Number__c, CallBack_Time__c, Consulation_Remarks__c,
                                                  Date__c, Date_Time_of_consultation__c, Doctor__r.Name, 
                                                  Meds_Prescribed_During_Consultation__c, Member__r.FirstName__c,
                                                  Rx_Follow_up_Date_Time_Done__c, Rx_Follow_Up_Remarks__c,
                                                  Rx_Follow_up_Schedule__c, States__c, Status__c, StatusChange__c
                                                  FROM Open_Consultants__c];
      sc=new ApexPages.StandardSetController(openConsult);
   }
      return sc;
  
  }set;}
  
  Public List<Open_Consultants__c> getOpenConsultList(){
  
     return sc.getRecords();
  }
  
    public void first(){
        sc.first();
    }
    
    public void last(){
        sc.last();
    }
    
    public void previous(){
        sc.previous();
        
    }
    public void next(){
        sc.next();
    }
    
    Public Boolean getHasNext(){
        
        return sc.getHasNext();
        
    }
    
    Public Boolean getHasPrevious(){
        
        return sc.getHasPrevious();
    }
  

  

}