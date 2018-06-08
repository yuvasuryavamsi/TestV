public class CallMD_ImmunizationMemExt {
    Private String MemberID=ApexPages.CurrentPage().getParameters().get('mid');
    Public Immunization_Members__c immuzMem{get;set;}
    public CallMD_ImmunizationMemExt(ApexPages.StandardController controller) {
      immuzMem=(Immunization_Members__c)controller.getRecord();
    }
    
    Public PageReference p;
    Public PageReference Save(){
      immuzMem.Member__c=MemberID;
      insert immuzMem;
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