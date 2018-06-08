@isTest
private class CallMD_ProviderTest {
    
    @testSetup static void ProviderData(){
        CallMD_UtilityTestData.testTestDataProviderInfo();
    }
    
    static testMethod void Provider(){
      
        Providers__c p=[SELECT id,Name__c,Deactivate__c FROM Providers__c WHERE Name__c='Teland' LIMIT 1];
        ApexPages.currentPage().getParameters().put('mode','');
        
        ApexPages.StandardController sc=new ApexPages.StandardController(p);
        ApexPages.currentPage().getParameters().put('id',p.id);
        
        ProviderCtrl pCtrl=new ProviderCtrl(sc);
        pCtrl.ProviderStatus=false;
        pCtrl.ProviderName='Teland';
        pCtrl.searchSobject();
        pCtrl.mode='';
        pCtrl.updateProv();
        pCtrl.Edit();
        pCtrl.Clear();
        pCtrl.cancel();
        pCtrl.first();
        pCtrl.next();
        pCtrl.previous();
        pCtrl.last();
        pCtrl.getHasPrevious();
        pCtrl.getHasNext();
        pCtrl.getProgramList();
        pCtrl.ProgramStatus='Active';
        pCtrl.ChangeProgramStatus();
        pCtrl.NavigateToProvider();
        pCtrl.Save();
        
    }

}