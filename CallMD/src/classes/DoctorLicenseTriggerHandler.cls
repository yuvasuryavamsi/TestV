public class DoctorLicenseTriggerHandler {
    
    Public static void DoctorLicense(List<License__c> lstLicen){
        
        Set<Id> doctorIds=new Set<Id>();
        String activeStatesLicen='';
        String inActiveStatesLicen='';
        
        Map<id,Doctor__c> docList=new Map<id,Doctor__c>();
        
        for(License__c l:lstLicen){
            doctorIds.add(l.Doctor__c);  
        }
        if(!doctorIds.isEmpty()) {
        Map<id,Doctor__c> mapDoctor=new Map<id,Doctor__c>([SELECT id,License_States__c,InActive_Licenses__c 
                                                                            FROM Doctor__c 
                                                                            WHERE ID IN:doctorIds]);
        
        for(License__c l:[SELECT id,States__c,Status__c FROM License__c WHERE Doctor__c IN:doctorIds AND status__c='Active']){
           
                activeStatesLicen+=l.States__c+';';
        }
        
        for(License__c l:[SELECT id,States__c,Status__c FROM License__c WHERE Doctor__c IN:doctorIds AND status__c='InActive'])
        {
             inActiveStatesLicen+=l.States__c+';';                
        }
        
        for(License__c l:lstLicen){  
            Doctor__c d=MapDoctor.get(l.Doctor__c);
            if(activeStatesLicen!=null || activeStatesLicen!=''){
                d.License_States__c=activeStatesLicen.removeEnd(';');
            }
            if(inActiveStatesLicen!=null || inActiveStatesLicen!=''){
                d.InActive_Licenses__c=inActiveStatesLicen.removeEnd(';');
            } 
            docList.put(d.id,d);
        }
        if(!docList.isEmpty()){
            update docList.values();
        }
    }
   }
}