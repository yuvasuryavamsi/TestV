@RestResource(urlMapping='/v1/assigndoctor/*')
global class CallMD_IVRAssignDoctor {
    
    @HttpPost
    global static responseDoctor AssignDoctor(string consultationid,string doctorid){
      
      responseDoctor resp=new responseDoctor();
      Open_Consultants__c openConsult=[SELECT id,DoctorC__c FROM Open_Consultants__c WHERE ID=:consultationid];
      openConsult.DoctorC__c=doctorid;
      update openConsult;
      
        if(openConsult.id!=null){
            resp.status='Success';
            resp.statusMsg='Assigned to Doctor Successfully';
        }
        else{
            resp.status='Failure';
            resp.statusMsg='Not Updated';
        }
        
      return resp;  
    }
    
    global class responseDoctor{
        
       public string status;
       public string statusMsg;
        
    }

}