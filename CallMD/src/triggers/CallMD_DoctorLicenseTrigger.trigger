trigger CallMD_DoctorLicenseTrigger on License__c(after insert,after update) {
    
  if(Trigger.isAfter){ 
      if(Trigger.isInsert || Trigger.isUpdate){
          
          DoctorLicenseTriggerHandler.DoctorLicense(Trigger.New);
             
      }
  }

}