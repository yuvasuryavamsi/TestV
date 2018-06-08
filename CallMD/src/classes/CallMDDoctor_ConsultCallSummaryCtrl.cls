public class CallMDDoctor_ConsultCallSummaryCtrl {

    Private String MemberID=ApexPages.CurrentPage().getParameters().get('id');
    
    Private String ConsultationID=ApexPages.CurrentPage().getParameters().get('cid');
    
    Private String DoctorID=ApexPages.CurrentPage().getParameters().get('did');
    
    Public Member__c m;
    
    Public List<Open_Consultants__c> oc;
    
    Public List<License__c> l;
    
    Public List<Scheduling__c> schList{get;set;}
    
    Public string show{get;set;}
    
    Public Open_Consultants__c openCons{get;set;}
    
    Public List<prescribWrapper> pw{get;set;}
     
   
    Public CallMDDoctor_ConsultCallSummaryCtrl(){
    
     schList=[SELECT id,Start_Time__c,End_Time__c,Day_of_Week__r.Name FROM Scheduling__c WHERE Doctor__c=:doctorId ORDER BY Day_Of_week__r.Day_Of_week__c];
     
    try{
     openCons=[SELECT id,Member__r.FirstName__c,Member__r.Lastname__c,Consultation_Type__c,Initiated_By__c,CallBack_Number__c,Problem_History__c,
                                      CallBack_Time__c,Address__c,States__c,Scheduling_After_3_Hours__c,Date__c,DoctorC__c,Comments__c,
                                      Pharmacy_Name_Phone__c,Meds_Prescribed_During_Consultation__c,What_would_you_have_done_with_your_medic__c,
                                      RX_Status__c,Rx_Follow_Up_Remarks__c,Pharmacy_Verifier__c, Rx_Follow_Up_Status__c,Consultation_Status__c,  
                                      Problem_History_cs__c,Impression_Diagnosis__c,Plan__c,Additional_Requested_Diagnostic_Procedur__c        
                                      FROM Open_Consultants__c 
                                      WHERE DoctorC__c=:DoctorID AND Member__c=:MemberID AND ID=:ConsultationID];
     
     
     pw=new List<prescribWrapper>();
     
     if(openCons.Consultation_Status__c=='Completed'){
     
        List<Prescribed_Medicine__c> lstPredMedi=[SELECT id,Doctor__c,Open_Consultation__c,Member__c,Medicine__r.Name,Name,Instructions__c,
                                                            Strength_Form__c,Synonyms__c FROM Prescribed_Medicine__c WHERE 
                                                            Doctor__c=:DoctorID AND Open_Consultation__c=:ConsultationID AND Member__c=:MemberID];
                                                            
        for(Prescribed_Medicine__c p:lstPredMedi){
       
          prescribWrapper pm=new prescribWrapper();
          pm.prescribOption=p.Medicine__c;
          pm.Instructions=p.Instructions__c;
          pm.StrengthForm=p.Strength_Form__c;
          pm.Synonyms=p.Synonyms__c;
          pw.add(pm);
        }                                                    
     
     
     }
     else{
       for(integer i=1;i<=4;i++){
     
         pw.add(new prescribWrapper());
       }
     }
     
     }
     catch(exception e){
     }
   }

   Public List<Open_Consultants__c> getOpenConsList(){
      if(DoctorID!=null)                           
       {
        oc=[SELECT id,Member__r.FirstName__c,Member__r.Lastname__c,Consultation_Type__c,Initiated_By__c,CallBack_Number__c,Problem_History__c,
                                      CallBack_Time__c,Address__c,States__c,Scheduling_After_3_Hours__c,Date__c,DoctorC__c,Comments__c, 
                                      Pharmacy_Name_Phone__c,Meds_Prescribed_During_Consultation__c,What_would_you_have_done_with_your_medic__c,
                                      RX_Status__c,Rx_Follow_Up_Remarks__c,Pharmacy_Verifier__c, Rx_Follow_Up_Status__c,Consultation_Status__c,  
                          
                                      Problem_History_cs__c,Impression_Diagnosis__c,Plan__c,Additional_Requested_Diagnostic_Procedur__c        
                                      FROM Open_Consultants__c 
                                      WHERE DoctorC__c=:DoctorID
                                      ];
        }
       return oc; 
    
    
    }
    
    
    Public Doctor__c doc;
    
    Public Doctor__c getDoctorInfo(){
    
       if(string.isNotEmpty(DoctorID)){
       
           doc=[SELECT id,Name,Last_Name__c,Email__c,Choose_a_time_zone__c FROM Doctor__c WHERE ID=:DoctorID];
       }
       return doc;
    }

   Public Member__c getMember(){
    
      if(MemberID!=NULL){
       m=[SELECT id,FirstName__c,LastName__c,DateofBirth__c,Age__c,
                          Gender__c,Address_Line1__c,City__c,State__c,Home_Phone__c,
                          Work_Phone__c,Cell_Phone__c,Height__c,Weight__c 
                          FROM Member__c
                          WHERE ID=:MemberID];
     }
                          
     return m;
    
    }
   
   public void UpdateConsult(){
   
     
     openCons.Consultation_Status__c='Completed';
     
     List<Prescribed_Medicine__c> listPresMed=new List<Prescribed_Medicine__c>();
     
     if((!pw.isEmpty()) && openCons.Consultation_Status__c!='Completed'){
     
       for(prescribWrapper p:pw){
         
           Prescribed_Medicine__c pm=new Prescribed_Medicine__c();
           
           pm.Doctor__c=DoctorID;
           pm.Open_Consultation__c=ConsultationID;
           pm.Member__c=MemberID;
           pm.Medicine__c=p.prescribOption;
           pm.Instructions__c=p.Instructions;
           pm.Strength_Form__c=p.StrengthForm;
           pm.Synonyms__c=p.Synonyms;
          
           
           listPresMed.add(pm);
       
       }
       
       if(!listPresMed.isEmpty()){
         insert listPresMed;
       }
     
     }
     
   
     update openCons;
    
   }
   
   
   Public List<License__c> getLicenseList(){
   
    if(DoctorID!=NULL){
       l=[SELECT id,Name,States__c,Expiration_date__c 
                                 FROM License__c
                                 WHERE Doctor__c=:DoctorID];
    }
      return l;                            
   }
    
  Public Member__c mem;
    
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
    
    
  
    
    Public Class prescribWrapper{
       
       public string prescribOption{get;set;}
       Public List<selectOption> pOpt{get;set;}
       Public string Instructions{get;set;}
       Public string StrengthForm{get;set;}
       Public string Synonyms{get;set;}
       
       
       Public prescribWrapper(){
         List<Medicines__c> med=[SELECT id,Name FROM Medicines__c LIMIT 999];
          pOpt=new List<selectOption>();
           for(Medicines__c m:med){
            pOpt.add(new SelectOption(m.id,m.name));
            }
        }
    }
    
    
   Public List<Scheduling__c> getSchedulingList(){
    
      return schList;
    }
    
    Public void UpdateSchedule(){
      update Doc;
      update schList;
    } 
    
    public void showDashboard(){
    
       show='Dashboard';
    } 
    
    public void showschedulling(){
      show='Schedulling';
    }
    
    Public void showLicenses(){
      show='License';
    }
    
    Public pageReference EPrescription(){
      return page.CallMD_EPrescription;
    }
    
}