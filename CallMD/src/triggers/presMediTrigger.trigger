trigger presMediTrigger on Prescribed_Medicine__c (before insert,before update){

 if(trigger.isBefore){
   if(trigger.isInsert || trigger.isUpdate){
      Set<id> medicineIds=new Set<id>();
      for(Prescribed_Medicine__c p:Trigger.New){
        medicineIds.add(p.Medicine__c);
      }
  
  Map<id,Medicines__c> mapMedicines=new Map<id,Medicines__c>([SELECT id,Name FROM Medicines__c WHERE ID IN:medicineIds]);
  
  if(!mapMedicines.isEmpty()){
  
     for(Prescribed_Medicine__c p:Trigger.New){
       p.Name=mapMedicines.get(p.Medicine__c).Name;
     }
    }
   } 
 } 
}