public class CallMD_PrivateConsultationCtrl {

    public String notes { get; set; }
    
    Private String MemberID=ApexPages.CurrentPage().getParameters().get('mid');
    
    Private String ConsultationID=ApexPages.CurrentPage().getParameters().get('cid');
    
    Public string type{get;set;}
    
    Public Member__c m;
    
    
    Public Open_Consultants__c oc;
    
    Public Open_Consultants__c OpenCons;
    
    Public CallMD_PrivateConsultationCtrl(){
    
      if(MemberID!=NULL){
        oc=[SELECT id,Consultation_Type__c,Initiated_By__c,CallBack_Number__c,Problem_History__c,
                                      CallBack_Time__c,Address__c,States__c,Scheduling_After_3_Hours__c,
                                      Pharmacy_Name_Phone__c,Meds_Prescribed_During_Consultation__c,What_would_you_have_done_with_your_medic__c,
                                      RX_Status__c,Rx_Follow_Up_Remarks__c,Pharmacy_Verifier__c, Rx_Follow_Up_Status__c,Doctorc__r.id,Doctor__c,
                                      Doctorc__r.Name,Doctorc__r.Mobile__c,Doctorc__r.State__c,
                                      CreatedDate,Member__r.FirstName__c,Member__r.LastName__c,Doctorc__c,
                                      Problem_History_cs__c,Impression_Diagnosis__c,Plan__c,Comments__c,Date__c        
                                      FROM Open_Consultants__c WHERE Member__c=:MemberID AND ID=:ConsultationID
                                      ];
       OpenCons=[SELECT id,Consultation_Type__c,Initiated_By__c,CallBack_Number__c,Problem_History__c,Consulation_Remarks__c,
                                      CallBack_Time__c,Address__c,States__c,Scheduling_After_3_Hours__c,
                                      Pharmacy_Name_Phone__c,Meds_Prescribed_During_Consultation__c,What_would_you_have_done_with_your_medic__c,
                                      RX_Status__c,Rx_Follow_Up_Remarks__c,Pharmacy_Verifier__c, Rx_Follow_Up_Status__c,Doctorc__r.id,
                                      Doctorc__r.Name,Doctorc__r.Mobile__c,Doctorc__r.State__c, Doctor_Consultation_Remark__c,
                                      CreatedDate,Member__r.FirstName__c,Member__r.LastName__c, Date_Time_of_consultation__c,
                                      Problem_History_cs__c,Impression_Diagnosis__c,Plan__c,Comments__c,Date__c, StatusChange__c       
                                      FROM Open_Consultants__c WHERE Member__c=:MemberID AND ID=:ConsultationID
                                      ];

       } 

    }

    
    Public Open_Consultants__c getOpenConsList(){
                                 
       return oc; 
  
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
    
    
     Public Open_Consultants__c getOpenCons(){
       
        //OpenCons.states__c=getMember().state__c;                             
                             
       return OpenCons;  
    
    }
  
    
    Public List<Chief_Complaint_Symptoms__c> ChiefCompSyn;
    
    Public List<Chief_Complaint_Symptoms__c> getChiefCompSynList(){
    
       ChiefCompSyn=[SELECT Name FROM Chief_Complaint_Symptoms__c];
      return ChiefCompSyn;
    
    }
  
    
    Public List<License__c> getFindDoctor(){
    
       List<License__c> docList=[SELECT Doctor__c,Doctor__r.Name,Doctor__r.Mobile__c,
                                        Doctor__r.Email__c,Doctor__r.Board_Cent__c,Doctor__r.Comments__c 
                                        FROM License__c 
                                        WHERE States__c=:getOpenCons().States__c];
      
       return docList;
    
    }
    
   
  
    
    Public void updateConsultation(){
    
      //oc.RX_Status__c=RxStatusOpt;
      
    
      update OpenCons;
    
    
    }
    
    Public void Consultation(){
    
       type='consultation';
    }
    
    Public void findDoctors(){
    
      type='findDoctors';
    }
    
    Public String DoctorId{get;set;}
    
    Public PageReference Assign(){
    
       oc.Doctorc__c=DoctorId;
       
       update oc;
       
       return null;
    
    
    }
    
    Public Void Resend(){
    }
    
    
    
}