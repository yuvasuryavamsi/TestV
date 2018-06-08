@isTest
private class CallMD_OpenConsultationsCtrlTest {
    
    testMethod static void OpenConsultations(){
        
        CallMD_OpenConsultationsCtrl openConsult=new CallMD_OpenConsultationsCtrl();
        
        Open_Consultants__c op=new Open_Consultants__c ();
        op.Consultation_Type__c='Phone consultation';
        op.Initiated_By__c='Provider';
        op.CallBack_Number__c='(909) 909-9090';
        op.Pharmacy_Name_Phone__c='(809) 909-9090';
        op.Products__c='CallMD'; 
        insert op;
        
        Open_Consultants__c opc=[SELECT Consultation_Type__c,Initiated_By__c,CallBack_Number__c,Pharmacy_Name_Phone__c,Products__c
                                       FROM Open_Consultants__c
                                       WHERE id=:op.id];
        
        system.assertEquals('Phone consultation',opc.Consultation_Type__c);
        system.assertEquals('Provider',opc.Initiated_By__c);
        system.assertEquals('(909) 909-9090',opc.CallBack_Number__c);
        system.assertEquals('(809) 909-9090',opc.Pharmacy_Name_Phone__c);
        system.assertEquals('CallMD',opc.Products__c);
        
        openConsult.getOpenConsultList();
        openConsult.first();
        openConsult.last();
        openConsult.previous();
        openConsult.next();
        openConsult.getHasNext();
        openConsult.getHasPrevious();
    }

}