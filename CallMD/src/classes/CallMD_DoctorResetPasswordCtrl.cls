public class CallMD_DoctorResetPasswordCtrl {

   Public string pwd{get;set;}
    Public String confirmpwd{get;set;}
    Public Doctor__c doc{get;set;}
    Private string doctorId=ApexPages.CurrentPage().getParameters().get('id');
    
    Public CallMD_DoctorResetPasswordCtrl(){
    if(doctorId!=null){
      doc=[SELECT id,Confirm_Password__c,Password__c 
                  FROM Doctor__c WHERE id=:doctorId];
    }
    }
    
    
    Public PageReference p;
    
    public PageReference ChangePassword() {
    
       if(pwd!=confirmpwd){
       
       }
       else{
         doc.Password__c=pwd;
         doc.Confirm_Password__c=confirmpwd;
         doc.Password__c=pwd;
         doc.Reset_Password_Date__c=Date.Today();
         update doc;
         p=new PageReference('/apex/CallMD_Thankyou');
       p.setRedirect(true);
       }
    
       
       return p;
    }

}