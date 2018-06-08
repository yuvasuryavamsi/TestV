public class CallMD_DoctorExtCtrl {

   Public Doctor__c doc;
   Private List<License__c> licenses;
   Private String doctorId=ApexPages.CurrentPage().getParameters().get('id');
   
   public string filename{get;set;}
   public transient blob filebody{get;set;}
   
   public String mode{get{
   
     return ApexPages.CurrentPage().getParameters().get('mode');
   }set;}
   
   Public Boolean isShow{get;set;}
   
   Public List<Scheduling__c> schList{get;set;}
   
   public CallMD_DoctorExtCtrl(ApexPages.StandardController controller) {
    
      doc=(Doctor__c)controller.getRecord();
      
      schList=[SELECT id,Start_Time__c,End_Time__c,Day_of_Week__r.Name FROM Scheduling__c WHERE Doctor__c=:doctorId ORDER BY Day_Of_week__r.Day_Of_week__c];

    }
    
    Public pageReference save(){
     pageReference p;
     try{
      insert doc;
      p=new pageReference('/apex/CallMD_Doctor');
      p.getParameters().put('id',doc.id);
      p.getParameters().put('mode','e');
      p.setRedirect(true);
      }
      catch(exception e){}
      
      return p;
    }
    
    Public pageReference updateDoctor(){
     try{
      update doc;
      p=new pageReference('/apex/CallMD_Doctor');
      p.getParameters().put('id',doctorID);
      p.getParameters().put('mode','s');
      p.setRedirect(true);
     }
     catch(exception e){}
     
     return p;
    }
    
    Public pageReference updateDoctor2(){
     try{
      update doc;
      p=new pageReference('/apex/CallMD_HomePage');
      p.getParameters().put('did',doctorID);
      p.setRedirect(true);
     }
     catch(exception e){}
     
     return p;
    }
    
 
    Public List<License__c> getDoctorLicenseList(){
     
     if(doctorId!=null){
       licenses=[SELECT Name,States__c,Status__c,Expiration_date__c FROM License__c WHERE Doctor__c=:doctorId];
     }  
       return licenses;
       
    }
    
    Public List<Scheduling__c> getSchedulingList(){
    
      return schList;
    }
    
    Public void UpdateSchedule(){
      update schList;
    }
    
    Public pageReference p;
    
    Public PageReference CreateLicense(){
    
      p=new pageReference('/apex/CallMD_DoctorLicenses');
      p.getParameters().put('did',doc.id);
      p.getParameters().put('name',doc.Name);
      p.setRedirect(true);
      return p;
    }
    
    Public pageReference edit(){
    
       p=new PageReference('/apex/CallMD_Doctor');
       p.getParameters().put('id',doctorId);
       p.getParameters().put('mode','e');
       p.getParameters().put('retPageName','CallMD_Doctor');
       p.setRedirect(true);
       return p; 
    }
    
     public void upload(){
    
      Attachment att = new Attachment();
      att.Name=filename;
      att.body=filebody;
      att.parentId=doctorId;
      insert att;
    
    }
    
    public List<Attachment> getDocList(){
    
    
      List<Attachment> attachList;
    
      if(string.isNotEmpty(DoctorId)){
      
         attachList = [SELECT id,Name FROM Attachment WHERE ParentId =: DoctorId];
      }
      
      return attachList;
    
    
    }
    
    
    Public PageReference Cancel(){
    
       p=new PageReference('/apex/CallMD_Doctor');
       p.getParameters().put('id',doctorId);
       p.getParameters().put('mode','s');
       p.getParameters().put('retPageName','CallMD_Doctor');
       p.setRedirect(true);
       return p; 
    
    }
    
    Public PageReference CancelDoctor(){
    
       p=new PageReference('/apex/CallMD_HomePage');
       p.getParameters().put('did',doctorId);
       p.setRedirect(true);
       return p; 
    
    }

}