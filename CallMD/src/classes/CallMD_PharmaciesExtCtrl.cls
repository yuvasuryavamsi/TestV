public class CallMD_PharmaciesExtCtrl {

     Private String MemberID=ApexPages.CurrentPage().getParameters().get('mid');
     
     Public Pharamcies__c phar{get;set;}

    public CallMD_PharmaciesExtCtrl(ApexPages.StandardController controller) {
       phar=(Pharamcies__c)Controller.getRecord();
    }
    
    Public PageReference p;
    Public PageReference Save(){
      phar.Member__c=MemberID;
      insert phar;
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