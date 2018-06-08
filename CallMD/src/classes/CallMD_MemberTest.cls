@isTest
private class CallMD_MemberTest {
   
    @testSetup static void MemberData(){
        CallMD_UtilityTestData.testTestDataMemberInfo();
    }
    
    static testMethod void Member(){
        
       Member__c m=[SELECT id,Name FROM Member__c WHERE Name='10001'];
       ApexPages.CurrentPage().getParameters().put('id',m.id);
       ApexPages.CurrentPage().getParameters().put('pageName','CallMD_Member');
      
       ApexPages.StandardController sc=new ApexPages.StandardController(m);
       CallMD_MemberCtrl mem=new CallMD_MemberCtrl(sc);
        ApexPages.CurrentPage().getParameters().put('mode','s');
      /* mem.firstname='John';
       mem.lastname='Admin';
       mem.city='NW';
       mem.dob=date.newInstance(1999,1,20);
       mem.numberVal='1001';
       mem.states='NY';
       mem.benefitProvider='Teland'; */
       mem.status='Active';
       mem.mode='e';
       mem.searchSobject();
       mem.Cancel();
       mem.Edit();
       mem.last();
       mem.first();
       mem.next();
       mem.previous();
       mem.first();
       mem.getHasNext();
       mem.getHasPrevious();
       mem.getBenefitProviderOpt();
       mem.getProgramOpt();
       mem.getStateOpt();
       mem.NavigateToMember();
       mem.getOpenConsultList();
       mem.getImmunizationsList();
       mem.getPharmaciesList();
       mem.getPhysiciansList();
       mem.clear();
       mem.updateMem();
     
    }

}