public class CallMD_SymptomsExtCtrl {

  Public Symptoms__c sym{get;set;}
  
  Public PageReference p;
  
  Private String medicalTypeID=ApexPages.CurrentPage().getParameters().get('MediTypeId');

    public CallMD_SymptomsExtCtrl(ApexPages.StandardController controller) {
    
       sym=(Symptoms__c)controller.getRecord();
     
      
    }
    
    Public PageReference createSymptoms(){
    
     try{
      
       sym.MedicalTypes__c=medicalTypeID;
       insert sym;
       p=new PageReference('/apex/CallMD_MedicalConditions');
        p.getParameters().put('tab','Admin');
       p.getParameters().put('id',MedicalTypeID);
       p.setRedirect(true);
     }
     catch(exception e){
     }  
            
     return p;
    }
    
    Public PageReference UpdateSymptoms(){
    
    try{
      update sym;
      
      p=new PageReference('/apex/CallMD_MedicalConditions');
       p.getParameters().put('tab','Admin');
      p.getParameters().put('id',MedicalTypeID);
      p.setRedirect(true);
     }
     catch(exception e){
     
     }
     return p;
    }

}