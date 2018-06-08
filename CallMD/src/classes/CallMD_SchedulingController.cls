public class CallMD_SchedulingController {
   
  public DateTime currentTime{get;set;}
  
  Public string currTime{get;set;}
  
  private string Day;
  
  public CallMD_SchedulingController(){
     Date d = date.today();
     Datetime myDate = datetime.newInstance(d.year(), d.month(), d.day());
     currentTime = DateTime.Now();
     currTime= myDate.format('h:mm a');
     day = myDate.format('EEEE');
  }


  public List<Scheduling__c> getSchedulingList(){
  
     List<Scheduling__c> schList= [SELECT Doctor__r.Name, Day_of_Week__r.Day_of_Week__c, Start_Time__c, 
                                          End_Time__c,Doctor__r.State__c,Day_of_Week__r.Name 
                                          FROM Scheduling__c 
                                          WHERE Doctor__r.State__c='NY'
                                          AND Day_of_Week__r.Name=:day AND Start_Time__c=:currTime
                                          ORDER BY Day_of_Week__r.Day_of_Week__c ASC];

      system.debug('Sch List:: '+schList);
      
     return schList;
  
  }
  
   public List<Scheduling__c> getUnAvailbleSchedulingList(){
  
     List<Scheduling__c> schList= [SELECT Doctor__r.Name, Day_of_Week__r.Day_of_Week__c, Start_Time__c, 
                                          End_Time__c,Doctor__r.State__c,Day_of_Week__r.Name 
                                          FROM Scheduling__c 
                                          WHERE Doctor__r.State__c='NY'
                                          AND Day_of_Week__r.Name=:day
                                          ORDER BY Day_of_Week__r.Day_of_Week__c ASC];

      system.debug('Sch List:: '+schList);
      
     return schList;
  
  }


}