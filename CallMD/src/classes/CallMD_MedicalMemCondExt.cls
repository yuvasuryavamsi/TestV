public class CallMD_MedicalMemCondExt {

    Private String MemberID=ApexPages.CurrentPage().getParameters().get('mid');
    Public Medical_Conditions__c mediCon{get;set;}
    
    public CallMD_MedicalMemCondExt(ApexPages.StandardController controller) {
      mediCon=(Medical_Conditions__c)controller.getRecord();
    }
    
    Public PageReference p;
    Public PageReference Save(){
      mediCon.Member__c=MemberID;
      insert mediCon;
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