public class CallMD_DoctorLoginPasswordCtrl {

    public String password { get; set; }
 
    public String username { get; set; }
    
    Public Boolean isShow{get;set;}
    
    Public pageReference p;
    
    Public List<Doctor__c> doc;

    public PageReference login() {
    
     if(String.isNotBlank(username) && String.isNotBlank(password)){
      try{
        doc=[SELECT ID,Username__c,Password__c,Confirm_Password__c 
                    FROM Doctor__c 
                    WHERE Username__c=:Username AND Confirm_Password__c=:password LIMIT 1];
        
        if(doc.size()==1){
        p=new pageReference('/apex/CallMD_HomePage');
        p.getParameters().put('tab','Dashboard');
        p.getParameters().put('did',doc[0].id);
        p.setRedirect(true);
        }
      }
      Catch(Exception e){
 
      }
     } 
       
       return p;
    }
    
    Public String statusMsg{get;set;}
    
    public PageReference ResetDoctorPassword() 
    {
     
     Doctor__c doc=[SELECT ID,Username__c,Password__c,Confirm_Password__c,isResetPassword__c 
                    FROM Doctor__c 
                    WHERE Username__c Like:Username LIMIT 1];
       if(doc.id!=null){
       
        statusMsg='Password reset link have been sent successfully to your mail';
        doc.isResetPassword__c=true;
        
        update doc;
        isshow=true;
        
       }
       else{
        statusMsg='Username doesn\'t found';
       }
     
     
     
      return null;
    }
    

}