public class ProgramsCtrl {

   Public Programs__c prog{get;set;}
   
   Private String ProviderId=ApexPages.CurrentPage().getParameters().get('provid');
   
   Private String ProgramID=ApexPages.CurrentPage().getParameters().get('progid');
   
    public ProgramsCtrl(ApexPages.StandardController controller) {

        prog=(Programs__c)controller.getRecord();
    }
    
    Public PageReference p;
    
    Public PageReference Save(){
     
     try{
      prog.Providers__c=ProviderId;
      
      if(ProgramID!=''||ProgramID!=NULL){
    
       Prog.Programs__c=ProgramID;
      }
      if(prog.Copay_Yes_No__c=='Yes' && prog.Copay__c==null){
      
         prog.Copay__c.addError('Copay Amount Cannot be kept empty');
      
      }
      else if(prog.Copay_Yes_No__c =='No' && prog.Copay__c!=null){
         prog.Copay__c.addError('Copay Amount Cannot be filled if copay doesnt exist');
      
      }
      else{
      insert prog;
      p=new PageReference('/apex/CallMD_Provider');
      p.getParameters().put('id',ProviderId);
      p.getParameters().put('mode','s');
     }
     
      
     }
    catch(exception e){
    
    } 
    return p;  
   }
   
   Public PageReference UpdateProg(){
   
   try{
   
     update prog;
     
      p=new PageReference('/apex/CallMD_Provider');
      p.getParameters().put('id',ProviderId);
      p.getParameters().put('mode','e');
     
    }
    catch(Exception e){
    
    }
    return p;
   }

}