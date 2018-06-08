@isTest
Private class CallMD_AdminCtrlTest {
    testMethod static void AdminCtrl(){
        
        List<MedicalTypes__c> medicalTypesList=new List<MedicalTypes__c>();
        
        MedicalTypes__c mt1=new MedicalTypes__c(Name__c='BLOOD / CANCER');
        medicalTypesList.add(mt1);
        MedicalTypes__c mt2=new MedicalTypes__c(Name__c='ENT (EAR/NOSE/THROAT)');
        medicalTypesList.add(mt2);
        MedicalTypes__c mt3=new MedicalTypes__c(Name__c='BONES / JOINTS / MUSCLES (RHEUMATOLOGY)');
        medicalTypesList.add(mt3);
        MedicalTypes__c mt4=new MedicalTypes__c(Name__c='SKIN');
        medicalTypesList.add(mt4);      
        insert medicalTypesList;
        
        List<Symptoms__c> symList=new List<Symptoms__c>();
        
        Symptoms__c sym1=new Symptoms__c(SymptomName__c ='Testing1',MedicalTypes__c=medicalTypesList[0].id);
        Symptoms__c sym2=new Symptoms__c(SymptomName__c ='Testing2',MedicalTypes__c=medicalTypesList[0].id);
        
        symList.add(sym1);
        symList.add(sym2);
        insert symList;
       
        
        ApexPages.CurrentPage().getParameters().put('MedTypeID',medicalTypesList[0].id);
        
        CallMD_AdminCtrl adminCtrl=new CallMD_AdminCtrl();
        adminCtrl.mt.Name__c='BLOOD / CANCER';
        adminCtrl.getNewMediTypes();
        adminCtrl.createMedicalTypes();
        adminCtrl.showMedicalTypes.Name__c='BLOOD / CANCER';
        
        
       
    }

}