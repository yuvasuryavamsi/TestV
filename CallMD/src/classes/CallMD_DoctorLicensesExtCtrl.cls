public class CallMD_DoctorLicensesExtCtrl {

   Public License__c license{get;set;}
   Private String doctorId=ApexPages.CurrentPage().getParameters().get('did');
   public pageReference p;
   
   Public String doctorName{get
   {
     return ApexPages.CurrentPage().getParameters().get('Name');
   }set;}

    public CallMD_DoctorLicensesExtCtrl(ApexPages.StandardController controller) {
       license=(License__c)controller.getRecord();
    }
    
    Public PageReference Save(){
    
      license.Doctor__c=doctorId;
    
      insert license;
      if(license.id!=null){
      p=new pageReference('/apex/CallMD_Doctor');
      p.getParameters().put('id',doctorId);
      p.getParameters().put('mode','e');
      p.setRedirect(true);
      }
      return p;
    }
    
    Public pageReference updateLicenses(){
    
      update license;
      
      p=new pageReference('/apex/CallMD_Doctor');
      p.getParameters().put('id',doctorId);
      p.getParameters().put('mode','e');
      p.setRedirect(true);
      return p;
    }

}