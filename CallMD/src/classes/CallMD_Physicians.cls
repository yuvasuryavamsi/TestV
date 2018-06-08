public class CallMD_Physicians {
    
    Public Physicians__c phy{get;set;}
    Private String MemberID=ApexPages.CurrentPage().getParameters().get('mid');
    public CallMD_Physicians(ApexPages.StandardController controller) {
      phy=(Physicians__c)Controller.getRecord();
    }
    
    Public PageReference p;
    Public PageReference Save(){
      phy.Member__c=MemberID;
      insert phy;
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