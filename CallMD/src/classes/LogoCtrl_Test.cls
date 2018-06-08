@isTest
private class LogoCtrl_Test {
    
    testMethod static void Logo(){
        
        Providers__c p=new Providers__c();
        p.Name__c='Test Provider';
        insert p;
        ApexPages.StandardController sc=new  ApexPages.StandardController(p);
        Logoctrl l=new Logoctrl(sc);
        l.LogoName='Provider';
        l.LogoBody=Blob.valueOf('Testing');
        l.upload();
    }

}