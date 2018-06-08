public class CallMD_MedicationsExt {

    Private String MemberID=ApexPages.CurrentPage().getParameters().get('mid');
    Public Medications__c medi{get;set;}
    public CallMD_MedicationsExt(ApexPages.StandardController controller) {
       medi=(Medications__c)controller.getRecord();
    }
    
    Public PageReference p;
    Public PageReference Save(){
      medi.Member__c=MemberID;
      insert medi;
      p=new PageReference('/apex/CallMD_Member');
      p.getParameters().put('id',MemberID);
      p.getParameters().put('mode','e');
      return p;
    }
    
    Public PageReference Cancel(){
    
      p=new PageReference('/apex/CallMD_Member');
      p.getParameters().put('id',MemberID);
      p.getParameters().put('mode','e');
      return p;
    }

}