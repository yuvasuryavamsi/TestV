public class CallMD_AllergiesExt {

    Public Allergies__c a{get;set;}
    Private String MemberID=ApexPages.CurrentPage().getParameters().get('mid');

    public CallMD_AllergiesExt(ApexPages.StandardController controller) {
       a=(Allergies__c)controller.getRecord();
    }
    
    Public PageReference p;
    Public PageReference Save(){
       a.Member__c=MemberID;
       insert a;
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