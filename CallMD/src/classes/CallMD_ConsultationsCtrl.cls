public class CallMD_ConsultationsCtrl {

   Public Open_Consultants__c openConsult{get;set;}
   
   Private String consultID=ApexPages.CurrentPage().getParameters().get('id');
   Private String MemberID=ApexPages.CurrentPage().getParameters().get('mid');
   Private String SubID=ApexPages.CurrentPage().getParameters().get('sid');
   Private String ProvID=ApexPages.CurrentPage().getParameters().get('ProvId');
   Private String ProgID=ApexPages.CurrentPage().getParameters().get('ProgId');
  
   
   Public string consultationType{get;set;}

   Public Member__c mem;

    public CallMD_ConsultationsCtrl(ApexPages.StandardController controller) {
       openConsult=(Open_Consultants__c)controller.getRecord();
    }
    
    Public PageReference p;
    Public PageReference Save(){
      openConsult.Member__c=MemberID;
      openConsult.Subscription__c=SubID;
      openConsult.Member_Consultation_Type__c=consultationType;
      insert openConsult;
      p=new pageReference('/apex/CallMD_PrivateConsultations');
      p.getParameters().put('cid',openConsult.id);
      p.getParameters().put('mid',MemberID);
      
      return p;
    }
    
    
    
    Public Member__c getMemberDetails(){
    
     if(MemberID!=null){
      mem=[SELECT id,FirstName__c,LastName__c,DateofBirth__c,Age__c,
                          Gender__c,Address_Line1__c,City__c,State__c,Home_Phone__c,
                          Work_Phone__c,Cell_Phone__c,Height__c,Weight__c 
                          FROM Member__c
                          WHERE ID=:MemberID];
      }
      return mem;
    }
    
    Public List<selectOption> getConsultOpt(){
    
       List<selectOption> option=new List<selectOption>();
      
      if(string.isNotEmpty(progId)){    
       Programs__c prog=[SELECT id, Consultations_Type__c FROM Programs__c WHERE ID=:ProgId];
       
       string consultationType=prog.Consultations_Type__c;
       
       List<String> consultVal=consultationType.split(';');
       
       for(string s:consultVal){
         
         option.add(new SelectOption(s,s));
       }
       }
       return option;
       
       
    }
    
    

}