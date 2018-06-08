public class CallMD_SubscriptionCtrl {

    Public String MemberID=ApexPages.CurrentPage().getParameters().get('mid');
    
    Public String SubID=ApexPages.CurrentPage().getParameters().get('id');
    
    Public String type=ApexPages.CurrentPage().getParameters().get('type');
    
    Public Member__c mem{get;set;}
    
    public Subscriptions__c sub{get;set;}
    
    public CallMD_SubscriptionCtrl(ApexPages.StandardController controller) {
    
     if(string.isNotEmpty(MemberID)){
     Mem=[SELECT id,Name,Full_Name__c FROM Member__c WHERE ID=:MemberID LIMIT 1];
     }
     
     if(string.isNotEmpty(SubID)){
       sub=(Subscriptions__c)controller.getRecord();
     }

    }
    
    Public String BenefitProvider{get;set;}
    
    Public String Program{get;set;}
    
    
    Public List<SelectOption> getBenefitProvOpt(){
    
       List<SelectOption> options =  new List<SelectOption>(); 
       
       List<Providers__c> lstProvider=[SELECT id,Name FROM Providers__c WHERE Customer_Type__c=:type];
       
       for(Providers__c p:lstProvider){
       
          options.add(new SelectOption(p.id,p.Name));
       
       }
       
       return options;
    }
    
    Public List<SelectOption> option;
    Public List<SelectOption> getProgOpt(){
    
      return option;
    }
    
    Public void ChangeBenefit(){
    
        option =  new List<SelectOption>(); 
       
        List<Programs__c> lstProgram=[SELECT id,Name FROM Programs__c 
                                                     WHERE Providers__c=:BenefitProvider AND Program_Type__c=:type];
       
        for(Programs__c p:lstProgram){
          option.add(new SelectOption(p.id,p.Name));
        }
    }
    
     Public PageReference p;
    
     Public PageReference CreateSubscription(){
     
       Subscriptions__c sub=new Subscriptions__c();
       sub.Member__c=MemberID;
       sub.Provider__c=BenefitProvider;
       sub.Program__c=Program;
       insert sub;
      if(string.isNotEmpty(sub.id)){ 
       p=new PageReference('/apex/CallMD_Member');
       p.getParameters().put('id',MemberID);
       p.getParameters().put('mode','s');
     }
       return p;
    }
    
    public pageReference UpdateSubscription(){
    
      update sub;
        PageReference p=new PageReference('/apex/CallMD_Consultations');
        p.getParameters().put('mid',MemberID);
        p.getParameters().put('mode','s');
        p.getParameters().put('sid',sub.id);
        p.getParameters().put('provId',sub.Provider__c);
        p.getParameters().put('progId',sub.Program__c);
     
        p.setRedirect(true);
      
      
      return p;
    }
    
    
    Public List<Open_Consultants__c> getOpenConsultList(){
    
     List<Open_Consultants__c> openConsult=[SELECT id,CallBack_Number__c, CallBack_Time__c, Consulation_Remarks__c,
                                                      Date__c, Date_Time_of_consultation__c, Doctor__r.Name, Problem_History__c, 
                                                      Meds_Prescribed_During_Consultation__c, Member__r.FirstName__c,Consultation_Type__c,
                                                      Member__r.LastName__c,Rx_Follow_up_Date_Time_Done__c, Rx_Follow_Up_Remarks__c,
                                                      Rx_Follow_up_Schedule__c, States__c, Status__c, StatusChange__c,CreatedBy.Name,CreatedDate
                                                      FROM Open_Consultants__c 
                                                      WHERE Member__c=:MemberID AND Subscription__c=:SubID 
                                                      
                                                  ];
    
     return openConsult;
    }

}