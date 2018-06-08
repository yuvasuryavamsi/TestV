public class CallMD_MedicalTypesExtCtrl {

    Public MedicalTypes__c medTypes{get;set;}
    Public string recordId{get;set;}
    Public PageReference p;
    Public List<Symptoms__c> sym;
    Private String medicalTypeID=ApexPages.CurrentPage().getParameters().get('id'); 
    
    public CallMD_MedicalTypesExtCtrl(ApexPages.StandardController controller) {
    if(controller.getId()!=null){
     medTypes=(MedicalTypes__c)controller.getRecord();
     }
     else{
      medTypes=new MedicalTypes__c();
     }
    }
    
    
    
    Public PageReference Save(){
    
      insert medTypes;
      
      p=new PageReference('/apex/CallMD_MedicalTypes');
      p.setRedirect(true);
     
      return p;
    }
    
    Public PageReference UpdateMed(){
     try{
      update medTypes;
      p=new PageReference('/apex/CallMD_MedicalTypes');
      p.setRedirect(true);
    }
    catch(exception e){}  
    
      return p;
    
    }
    
    Public List<MedicalTypes__c> getMediTypes(){
      List<MedicalTypes__c> MediType=[SELECT id,Name__c FROM MedicalTypes__c ORDER BY Name__c];
      return MediType;
      
   }
   
   Public void deleteMed(){
   
     MedicalTypes__c mt=new MedicalTypes__c();
     mt.id=recordId;
     delete mt;
   
   }
   
   
   Public List<Symptoms__c> getSymList(){
   if(medicalTypeID!=NULL){
     sym=[SELECT id,SymptomName__c,MedicalTypes__r.Name__c FROM Symptoms__c WHERE MedicalTypes__c=:medicalTypeID];
     }
     return sym;
   }
   
    public void DeleteMediCondition(){
    
     Symptoms__c sm=new Symptoms__c();
     sm.id=recordId;
     delete sm;
   
   }
   

}