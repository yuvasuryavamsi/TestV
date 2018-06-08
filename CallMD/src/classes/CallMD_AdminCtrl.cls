public class CallMD_AdminCtrl {

   Public String recordId{get;set;}  //getting record id for particular object from vf page
   
   Public string MedicalTypeID=ApexPages.CurrentPage().getParameters().get('MedTypeID'); //Medical Type id
   
   Public string SymId=ApexPages.CurrentPage().getParameters().get('SymId');
   
   Public MedicalTypes__c mt;
   
   public MedicalTypes__c m;
   
   Public Symptoms__c SymDetails;
   
   Public CallMD_AdminCtrl(){
   
    
    if(medicalTypeID!=NULL){
     m=[SELECT ID,Name__c FROM MedicalTypes__c WHERE ID=:medicalTypeID];
     }
     
   if(SymId!=NULL){
     SymDetails=[SELECT id, SymptomName__c FROM Symptoms__c WHERE Id=:SymId];
   }
  
     
   }
   
   Public MedicalTypes__c showMedicalTypes{
   get{
    
     return m;
   }
   set;
   }
   
   //Creting New Medical Types 
   Public MedicalTypes__c getNewMediTypes(){
   
       mt=new MedicalTypes__c();
   
       return mt;
   }
   
   public PageReference createMedicalTypes() {
        insert mt;
        pageReference p=new PageReference('/apex/MedicalTypes');
        p.getParameters().put('tab','Admin');
        p.setRedirect(true);
        return p;
    }
   
   Public List<Symptoms__c> sym; 
   //Displaying Medical Conditions based on medical type getting from browser url
   Public List<Symptoms__c> getSym(){
   if(medicalTypeID!=NULL){
     sym=[SELECT id,SymptomName__c,MedicalTypes__r.Name__c FROM Symptoms__c WHERE MedicalTypes__c=:medicalTypeID];
     }
     return sym;
   }
   
   Public Symptoms__c s;
   
   Public Symptoms__c getNewSym(){
     s=new Symptoms__c();
     return s;
     
   }
   
   Public Symptoms__c getShowSym(){
   
     return SymDetails;
   }
   
   Public PageReference createSymptons(){
           
       s.MedicalTypes__c=medicalTypeID;
       insert s;
       PageReference p=new PageReference('/apex/CallMD_Medical_Conditions');
        p.getParameters().put('tab','Admin');
       p.getParameters().put('MedTypeId',MedicalTypeID);
       p.setRedirect(true);
       return p;
   
   }


   //Displaying list of Immunization in vf page
   Public List<Immunization__c> getImmuzList(){
   
     List<Immunization__c> immu=[SELECT id,Immunization__c FROM Immunization__c];
     return immu;
   }
   
   //Deleting particular Immunization record based on record id 
   Public void deleteImmuz(){
   
      Immunization__c i=new Immunization__c();
      i.id=recordId;
      delete i;
   }
   
   //Displaying list of medical types in vf page
   Public List<MedicalTypes__c> getMediTypes(){
      List<MedicalTypes__c> MediType=[SELECT id,Name__c FROM MedicalTypes__c ORDER BY Name__c];
      return MediType;
      
   }
   
   //deleting particlar medical types record based on record id
   public void deleteMedi(){
    
     MedicalTypes__c mt=new MedicalTypes__c();
     mt.id=recordId;
     delete mt;
   
   }
   
   public void DeleteMediCondition(){
    
     Symptoms__c sm=new Symptoms__c();
     sm.id=recordId;
     delete sm;
   
   }
   
   Public PageReference UpdateMedicalType(){
     
     update m;
     
     PageReference p=new PageReference('/apex/CallMD_MedicalTypes');
     p.getParameters().put('tab','Admin');
     p.setRedirect(true);
     return p;
      
   }
   
   public PageReference UpdateSymptons() {
   
      update SymDetails;
      
      PageReference p=new PageReference('/apex/CallMD_Medical_Conditions');
       p.getParameters().put('tab','Admin');
      p.getParameters().put('MedTypeId',MedicalTypeID);
      p.setRedirect(true);
        
      return p;
    }

  
}