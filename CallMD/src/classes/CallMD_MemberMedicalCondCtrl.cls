public class CallMD_MemberMedicalCondCtrl {
    
    
    //Public Boolean isCreated{get;set;}
    public string MemberId{get{
        
     return ApexPages.currentPage().getParameters().get('id');   
    }set;}
    
    Public List<Medical_Conditions__c> getMedicalCondList(){
        List<Medical_Conditions__c> medicalCondition=[SELECT id,Name,Current__c,Comments__c 
                                                             FROM Medical_Conditions__c
                                                             WHERE Member__c=:MemberId];
        return medicalCondition;  
    }
    
    Public List<Allergies__c> getAllergiesList(){
        List<Allergies__c> allergies=[SELECT id,Name,Reaction__c  
                                             FROM Allergies__c
                                             WHERE Member__c=:MemberId]; 
        return allergies;   
    }
    
    Public List<Surgeries__c> getSurgeriesList(){  
        List<Surgeries__c> surgeries=[SELECT id,Name,Date__c,Comments__c 
                                            FROM Surgeries__c
                                            WHERE Member__c=:MemberId];
        return surgeries;   
    }
    
    Public List<Medications__c> getMedicationList(){ 
       List<Medications__c> medication=[SELECT id,Name,Current__c,Dosage__c,Dosage_units__c,How_often__c
                                               FROM Medications__c
                                               WHERE Member__c=:MemberId];  
       return medication;
        
    }    
}