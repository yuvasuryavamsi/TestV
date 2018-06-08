public class CallMD_MemberDependentCtrl {

   Public string MemberID=ApexPages.CurrentPage().getParameters().get('mid');
   
   public string mode{get;set;}
   
   public Member__c memInfo{get;set;}

    public CallMD_MemberDependentCtrl(ApexPages.StandardController controller) {
    
     memInfo=(member__c)controller.getRecord();
    
      mode='e';

    }
    
    Public Member__c mem;
    
    Public Member__c getMemberDetails(){
    
     if(MemberID!=null){
      mem=[SELECT id,FirstName__c,LastName__c,DateofBirth__c,Age__c,
                          Gender__c,Address_Line1__c,City__c,State__c,Home_Phone__c,
                          Work_Phone__c,Cell_Phone__c,Height__c,Weight__c 
                          FROM Member__c
                          WHERE ID=:MemberID];
      }
      return mem;
    }
    
    Public List<Member__c> memList;
    
    public integer memSize{get;set;}
    
    Public List<Member__c> getMembersList(){
    
      if(memberID!=null){
      
        memList=[SELECT id,Name,FirstName__c,LastName__c,Parent_Member__r.Full_Name__c,Parent_Member__c,DateofBirth__c,
                         Customer_Type__c,City__c,State__c,ZipCode__c   
                         FROM Member__c WHERE Parent_Member__c=:MemberID];
        
        memSize=memList.size();
      }
      
      return memList;
    
    }
    
    public pageReference p;
    public pageReference save(){
    try{
      if(memInfo.CallMDUserName__c==null){
        memInfo.CallMDUserName__c.addError('Cannot be Empty and must be numeric...!');
      }
      else{
       memInfo.Parent_Member__c=MemberID;
       insert memInfo;
       if(memInfo.id!=null){
          p=new pageReference('/apex/CallMD_MemberDependent');
          p.getParameters().put('mid',MemberID);
          p.setRedirect(true);
         
       }
      }
     }
     catch(exception e){}
      return p;
    }
    
    

}