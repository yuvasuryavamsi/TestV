public class CallMD_SurgeriesExt {

    public Surgeries__c s{get;set;}
    Private String MemberID=ApexPages.CurrentPage().getParameters().get('mid');
    public CallMD_SurgeriesExt(ApexPages.StandardController controller) {
       s=(Surgeries__c)Controller.getRecord();
    }
    
    Public PageReference p;
    Public PageReference Save(){
      s.Member__c=MemberID;
      insert s;
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