@isTest
private class CallMD_DoctorTest {
    
    @testSetup static void testData(){
        
        CallMD_UtilityTestData.testTestDataInfo();
    }
    
    testMethod static void CallMDDoctor(){
        
        Doctor__c doctor=[SELECT id,Name,Last_Name__c FROM Doctor__c WHERE Name='John'];
        
        CallMD_PaginationCtrl p=new CallMD_PaginationCtrl();
        p.firstname='John';
        p.lastname='smith';
        p.phone='9090909090';
        p.status='Active';
        p.licenseState='NY';
        p.NavigateToDoctor();
        p.searchSobject();
        p.next();
        p.previous();
        p.first();
        p.last();
        p.getHasPrevious();
        p.getHasNext();
        
    }

}