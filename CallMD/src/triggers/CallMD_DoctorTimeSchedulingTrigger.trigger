trigger CallMD_DoctorTimeSchedulingTrigger on Doctor__c (after insert,after update) {

    Map<integer,id> mapDayOfMonth=new Map<integer,id>();
    List<Scheduling__c> lstScheduling=new List<Scheduling__c>();
    List<Day_Of_Week__c> lstDayOfMonth=[SELECT id,Name,Day_Of_Week__c FROM Day_Of_Week__c ORDER BY Day_Of_Week__c];
    Set<id> doctorIds=new Set<id>();
    
    for(Doctor__c d:Trigger.New){
        doctorIds.add(d.id);
    }
 
    Map<id,scheduling__c> mapScheduling=new Map<id,scheduling__c>([SELECT id,Name FROM scheduling__c 
                                                                                  WHERE Doctor__c IN:doctorIds]);
    
    for(Day_Of_Week__c day:lstDayOfMonth){
        mapDayOfMonth.put(integer.ValueOf(day.Day_Of_Week__c),day.id);
    }
    
     if(trigger.isAfter){
  
    if(trigger.isInsert){
      if((!mapDayOfMonth.isEmpty() && (mapScheduling.size()<7))){
        for(Doctor__c doc:Trigger.New){
          for(integer i=1;i<=lstDayOfMonth.size();i++){  
            if(doc.Status__c=='Active'){
                scheduling__c s=new scheduling__c(Doctor__c=doc.id,Day_Of_Week__c=mapDayOfMonth.get(i),Period__c='Normal');
                lstScheduling.add(s);
            }
          }  
        }   
    }
      
      if(!lstScheduling.isEmpty()){
        insert lstScheduling;
     }
    }
    if(trigger.isUpdate){
    
      if(!lstScheduling.isEmpty()){
        update lstScheduling;
     }
    }
  }  
    
    
    
}