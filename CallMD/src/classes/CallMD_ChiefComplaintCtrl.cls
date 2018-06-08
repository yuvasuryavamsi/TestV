public class CallMD_ChiefComplaintCtrl {

  Public String ChiefComplaintId{get;set;}
  Public ApexPages.StandardSetController sc{get{
  
   if(sc==NULL){
    List<Chief_Complaint_Symptoms__c> cc=[SELECT id,Name FROM Chief_Complaint_Symptoms__c];
    sc=new ApexPages.StandardSetController(cc);
    sc.setPageSize(10);
   }
    return sc;
  
  }set;}

  Public List<Chief_Complaint_Symptoms__c> getChiefComplaintSymList(){
    return sc.getRecords();
  }
  
  Public void next(){
    sc.next();
  }
  
  Public Void previous(){
    sc.previous();
  }
  
  Public void first(){
    sc.first();
  }
  
  Public void last(){
   sc.last();
  }
  
  Public Boolean getHasNext(){
    return sc.getHasNext();
  }
  
  Public Boolean getHasPrevious(){
    return sc.getHasPrevious();
  }
  
  
  Public Chief_Complaint_Symptoms__c cc;
  public void deleteChiefCompliant() {
  
   if(ChiefComplaintId!=NULL){
     cc=[SELECT id,Name FROM Chief_Complaint_Symptoms__c WHERE id=:ChiefComplaintId];
     delete cc;
   }
      
 }
  
}