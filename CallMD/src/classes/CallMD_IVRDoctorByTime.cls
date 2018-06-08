@RestResource(urlMapping='/v1/DoctorByTime/*')
global class CallMD_IVRDoctorByTime {

    @HttpGet
    global static List<DoctorWrapper> doGetDoctorByTime(){
    
      RestRequest req=RestContext.request;
      
      string state=req.params.get('state');
        
        List<Doctor__c> docList=[SELECT id,Name,Last_Name__c,Email__c,Mobile__c,State__c,Choose_a_time_zone__c
                                       FROM Doctor__c 
                                       WHERE State__c=:state];
        
        List<DoctorWrapper> lstDoctorWrap =new List<DoctorWrapper>();
         
        Set<Id> doctorIds=new Set<Id>(); 
        
        for(Doctor__c d:docList){
            doctorIds.add(d.id);
        }
        
        List<Scheduling__c > schList=[SELECT id,Day_Of_Week__r.Day_Of_week__c,Day_Of_Week__r.Name,Doctor__c,
                                             Start_Time__c,End_Time__c FROM Scheduling__c 
                                             WHERE Doctor__c IN:doctorIds];
        
        map<id,List<Scheduling__c>> mapScheduling=new map<id,List<Scheduling__c>>();
        
        for(Scheduling__c sch:schList){
            
            if(!mapScheduling.containsKey(sch.Doctor__c)){
                mapScheduling.put(sch.Doctor__c,new List<Scheduling__c>{sch});
            }
            else{
                mapScheduling.get(sch.Doctor__c).add(sch); 
            }
        }
        
        for(Doctor__c doc:docList){
          if(mapScheduling.get(doc.id)!=null)  {   
          DoctorWrapper doctorWrap=new DoctorWrapper();
          List<DoctorTimings> lstDocTime=new List<DoctorTimings>();
          doctorWrap.doctorId=doc.id;
          doctorWrap.doctorTimeZone=doc.Choose_a_time_zone__c; 
          doctorWrap.firstname=doc.Name;
          doctorWrap.lastname=doc.Last_Name__c;
          doctorWrap.email=doc.Email__c;
          doctorWrap.phone=doc.Mobile__c;
          doctorWrap.state=doc.State__c;
             
                for(Scheduling__c sch:mapScheduling.get(doc.id)){
                    
                    DoctorTimings docTime=new DoctorTimings();
                    docTime.day=sch.Day_Of_Week__r.Day_Of_week__c;
                    docTime.startTime=sch.Start_Time__c;
                    docTime.endTime=sch.End_Time__c;
                    lstDocTime.add(docTime);
                    
                }
          doctorWrap.DoctorTimings=lstDocTime;
          lstDoctorWrap.add(doctorWrap);
          }
        }
        return lstDoctorWrap;
        
    }

    global class DoctorWrapper{
        public string doctorId;
        public string doctorTimeZone;
        public string firstname;
        public string lastname;
        public string email;
        public string phone;
        public string state; 
        Public List<DoctorTimings> DoctorTimings;
        
        /* public DoctorWrapper(string fname,string lname,string email,string phone,string state,List<DoctorTimings> DoctorTimings){
            firstname=fname;
            lastname=lname;
            email=email;
            phone=phone;
            state=state;
            DoctorTimings=DoctorTimings;
        } */
        
    }
    
    Public class DoctorTimings{
         public string day;
         public string startTime;
         public string endTime;
    }
    

}