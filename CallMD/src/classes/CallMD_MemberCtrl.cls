public class CallMD_MemberCtrl {

   Public Member__c mem{get;set;}
   Public string firstname{get;set;}
   public string lastname{get;set;}
   public string numberVal{get;set;}
   public string city{get;set;}
   Public string phone{get;set;}
   Public Date dob{get;set;}
   Public string benefitProvider{get;set;}
   Public string states{get;set;}
   Public string program{get;set;}
   Public string zipcode{get;set;}
   Public String status{get;set;}
   Public string programValue{get;set;}
 
   Public String parentId=ApexPages.CurrentPage().getParameters().get('mid');
   Public String pageName=ApexPages.CurrentPage().getParameters().get('pageName');
   Public List<Member__c> membersList{get;set;}
   Private String MemberID=ApexPages.CurrentPage().getParameters().get('id');
   Public List<string> conditions = new List<string>();
   private integer totalRecs = 0;
   private integer OffsetSize = 0;
   private integer LimitSize= 10;
       
    public CallMD_MemberCtrl(ApexPages.StandardController controller) {

       mem=(Member__c)controller.getRecord();
    }
    
    Public String mode{
  get{
     return ApexPages.CurrentPage().getParameters().get('mode');
   }set;}
    
     public List<SelectOption> getBenefitProviderOpt(){
      List<SelectOption> options =  new List<SelectOption>(); 
      options.add(new selectOption('None','--- None ---')); 
      
      Schema.DescribeFieldResult fieldResult = Member__c.BenefitsProvider__c.getDescribe();    
        List<Schema.picklistEntry> ple = fieldResult.getPicklistValues();    
        for(Schema.picklistEntry f:ple)    
        {    
            options.add(new selectOption(f.getLabel(),f.getValue()));                    
        }    
        return Options;       
    }
    
    public List<SelectOption> getProgramOpt(){
      List<SelectOption> options =  new List<SelectOption>(); 
      options.add(new selectOption('None','--- None ---')); 
      
      Schema.DescribeFieldResult fieldResult = Member__c.Program__c.getDescribe();    
        List<Schema.picklistEntry> ple = fieldResult.getPicklistValues();    
        for(Schema.picklistEntry f:ple)    
        {    
            options.add(new selectOption(f.getLabel(),f.getValue()));                    
        }    
        return Options;       
    }

    public List<SelectOption> getStateOpt(){
      List<SelectOption> options =  new List<SelectOption>(); 
      options.add(new selectOption('None','--- None ---')); 
      
      Schema.DescribeFieldResult fieldResult = Member__c.State__c.getDescribe();    
        List<Schema.picklistEntry> ple = fieldResult.getPicklistValues();    
        for(Schema.picklistEntry f:ple)    
        {    
            options.add(new selectOption(f.getLabel(),f.getValue()));                    
        }    
        return Options;       
    }
    
  /*  Public List<SelectOption> getBenefitProvOpt(){
    
       List<SelectOption> options =  new List<SelectOption>(); 
       
       List<Providers__c> lstProvider=[SELECT id,Name FROM Providers__c];
       
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
       
        List<Programs__c> lstProgram=[SELECT id,Name FROM Programs__c WHERE Providers__c=:BenefitProvider];
       
        for(Programs__c p:lstProgram){
          option.add(new SelectOption(p.id,p.Name));
        }
    
    
    }
 */

   Public pageReference p;
    public PageReference save() {
    
      if(string.isNotEmpty(parentId)){
        mem.parent_Member__c=parentId;
      }
        //mem.Packages__c=ProgramValue;
        insert mem;
        p=new PageReference('/apex/CallMD_Member');
        p.getParameters().put('id',mem.id);
        p.getParameters().put('mode','e');
        p.getParameters().put('pageName','Call_MemberList');
        p.setRedirect(true);
        return p;
    }
    
    Public PageReference UpdateMem(){
     //mem.Packages__c=ProgramValue;
    update mem;
    p=new PageReference('/apex/CallMD_Member');
        p.getParameters().put('id',mem.id);
        p.getParameters().put('mode','s');
        p.getParameters().put('pageName','Call_Member');
        p.setRedirect(true);
        return p;
    }
    
     public void searchSobject(){
            totalRecs = 0;
            OffsetSize = 0;
            
            searchSobjects();
            //conditions.clear();
        }
    
    public Void searchSobjects(){
        if(membersList != null && !membersList.isEmpty()){
                membersList.clear();
            }
            String strQuery ='SELECT id,Name,Number__c,LastName__c, FirstName__c,DateofBirth__c, City__c, State__c,BenefitsProvider__c, ZipCode__c, Customer_Type__c, Program_Status__c,Status__c FROM Member__c';

 if(dob!=null){
  
   conditions.add('DateofBirth__c='+dob);
 }
 
 if(city!=null && city!=''){
   conditions.add('City__c Like \'%' +city+'%\' ');
 }
 
 
 if(FirstName !=null && FirstName !=''){
   conditions.add('FirstName__c Like \'%' +firstname+'%\' ');
 }
 
 if(LastName !=null && LastName !=''){
   conditions.add('LastName__c Like \'%' +LastName+'%\' ');
 }
 
 if(Phone!=null && Phone!=''){
   conditions.add('Cell_Phone__c Like \'%' +Phone+'%\' ');
 }
 
 /* if(benefitProvider!=null && benefitProvider!=''){
   conditions.add('BenefitsProvider__c  Like \'%' +benefitProvider+'%\' ');
 } */
 
 /* if(program!=null && program!=''){
   conditions.add('Program__c Like \'%' +program+'%\' ');
 } */
 
 if(status!=null && status!=''){
   conditions.add('Status__c Like \'%' +status+'%\' ');
 }
            if (conditions.size() > 0) {
                strQuery += '  WHERE ' + conditions[0];
                for (Integer i = 1; i < conditions.size(); i++)
                    strQuery += '  OR  ' + conditions[i];
            }
            if(totalRecs !=null && totalRecs ==0){
                List<Member__c> accTemp = Database.query(strQuery);
                totalRecs = (accTemp !=null &&accTemp.size()>0)?accTemp.size():0;
            }
        
            strQuery += ' ORDER BY Name  ASC, CreatedDate DESC LIMIT :LimitSize OFFSET :OffsetSize';
            membersList  =Database.query(strQuery);
        }

      
        
     Public PageReference NavigateToMember(){
        
          p=new PageReference('/apex/CallMD_Member');
          p.getParameters().put('pageName','Call_Member');
          p.setRedirect(true);
          return p;
     }
    
     public void first()
        {
            OffsetSize = 0;
            searchSobjects();
        }
        public void previous()
        {
            OffsetSize = (OffsetSize-LimitSize);
            searchSobjects();
        }
        public void next()
        {
            OffsetSize = OffsetSize + LimitSize;
            searchSobjects();
        }
        public void last()
        {
            OffsetSize = totalrecs - math.mod(totalRecs,LimitSize);
            searchSobjects();
        }
        public boolean getHasPrevious()
        {
           Boolean res1; 
            if(OffsetSize == 0){
                
                res1=true;
            }
            return res1;
        }
        public boolean getHasNext()
        {
           Boolean res1;
           if((OffsetSize + LimitSize) > totalRecs){
                
                res1=true;
            }
           return res1;
        }
        
        Public List<Open_Consultants__c> openConsult;
        
        Public List<Open_Consultants__c> getOpenConsultList(){
        
        if(MemberID!=null){
          openConsult=[SELECT CallBack_Number__c, CallBack_Time__c, Consulation_Remarks__c,
                                                  Date__c, Date_Time_of_consultation__c, Doctor__r.Name, Problem_History__c, 
                                                  Meds_Prescribed_During_Consultation__c, Member__r.FirstName__c,Consultation_Type__c,
                                                  Member__r.LastName__c,Rx_Follow_up_Date_Time_Done__c, Rx_Follow_Up_Remarks__c,
                                                  Rx_Follow_up_Schedule__c, States__c, Status__c, StatusChange__c
                                                  FROM Open_Consultants__c WHERE Member__c=:MemberID];
          }
          return openConsult;   
        }
        
        
   Public List<Subscriptions__c> getSubscriptionList(){
    
     List<Subscriptions__c> subList  =[SELECT Member__r.Full_Name__c,Program__r.Program_ID__c,Program__r.Name,Provider__r.Name,Subscription_Type__c,Stage__c,
                                                         B2B_D2C__c, Pricing__c, Remaining_Consultation__c, Total_Consultations_Done__c, Total_Consultation_To_Do__c,
                                                         Status__c, Start_Date__c, End_Date__c,Copay_Amount__c
                                                         FROM Subscriptions__c 
                                                         WHERE Member__c=:MemberID];
                 
     return subList;
   }
        
   Public List<Pharamcies__c> getPharmaciesList(){
   
     List<Pharamcies__c> pharmaList=[SELECT id,Name,Primary__c,Primary_Phone__c
                                            FROM Pharamcies__c 
                                            WHERE Member__c=:MemberID];
                                            
     return pharmaList;
   }
   
   Public List<Physicians__c> getPhysiciansList(){
   
     List<Physicians__c> p=[SELECT id,Name,Phone__c,Fax__c,Email__c,Address__c,Speciality__c
                                   FROM  Physicians__c
                                   WHERE Member__c=:MemberID];
   
     return P;
   }
   
   Public List<Immunization_Members__c> getImmunizationsList(){
   
     List<Immunization_Members__c> immList=[SELECT id,Name,Date__c,Comments__c 
                                           FROM Immunization_Members__c
                                           WHERE Member__c=:MemberID];
   
     return immList;
   }
   
   Public List<Member__c> memList;
   
   Public List<Member__c> getMemberList(){
   
    if(string.isNoTEmpty(MemberID)){
     memList=[SELECT id,Name,FirstName__c,LastName__c,Parent_Member__r.Full_Name__c,Parent_Member__c FROM Member__c WHERE Parent_Member__c=:MemberID];
    } 
     return memList;
      
   }
   
   Public List<selectOption> getProgramList(){
   
     List<selectOption> option=new List<selectOption>();
     
     List<Programs__c> progList=[SELECT id,Name FROM Programs__c];
     
     for(Programs__c prog:progList){
         option.add(new SelectOption(prog.Name,prog.Name)); 
     }
     
     return option;
      
     
   }
    
  Public void Clear(){
  
   searchSobject();
  }
  
  Public PageReference Edit(){
  
        p=new PageReference('/apex/CallMD_Member');
        p.getParameters().put('id',memberId);
        p.getParameters().put('mode','e');
        p.setRedirect(true);
        return p;
  }
  
  Public PageReference Cancel(){
      
        p=new PageReference('/apex/CallMD_Member');
        p.getParameters().put('id',memberId);
        p.getParameters().put('mode','s');
        p.setRedirect(true);
        return p;
  }
}