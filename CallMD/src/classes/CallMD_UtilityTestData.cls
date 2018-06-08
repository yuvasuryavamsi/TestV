@isTest
public class CallMD_UtilityTestData {
    
    public static void testTestDataInfo(){
        
        List<Doctor__c> docList=new List<Doctor__c>();
        List<License__c> licList=new List<License__c>();
        
        Doctor__c doc1=new Doctor__c();
        doc1.Name='John';
        doc1.Last_Name__c='Smith';
        doc1.CallMD__c=true;
        doc1.Status__c='Active';
        doc1.Date_Of_Birth__c=date.newInstance(1880,1,10);
        doc1.Security_Question__c='What are the last five digits of your driver\'s license number?';
        doc1.Security_Answer__c='12234';
        doc1.License_States__c='NY';
        doc1.Secondary_Phone__c='9090909090';
        doc1.Primary_Phone__c='9090909090';
        docList.add(doc1);

        Doctor__c doc2=new Doctor__c();
        doc2.Name='Adam';
        doc2.Last_Name__c='Jeery';
        doc2.CallMD__c=true;
        doc2.Status__c='Active';
        doc2.Date_Of_Birth__c=date.newInstance(1880,1,10);
        doc2.Security_Question__c='What are the last five digits of your driver\'s license number?';
        doc2.Security_Answer__c='12256';
        doc2.License_States__c='NY';
        doc2.Secondary_Phone__c='8090909090';
        doc2.Primary_Phone__c='8090909090';
        docList.add(doc2);

        insert docList;
 
        system.assertEquals('John',docList[0].Name);
        system.assertEquals('Smith',docList[0].Last_Name__c);
        system.assertEquals(true,docList[0].CallMD__c);
        
        License__c lic11=new License__c();
        lic11.Name='1001';
        lic11.status__c='Active';
        lic11.Doctor__c=docList[0].id;
        lic11.States__c='NY';
        licList.add(lic11);
        
        License__c lic12=new License__c();
        lic12.Name='1002';
        lic12.status__c='Active';
        lic12.Doctor__c=docList[0].id;
        lic12.States__c='AR';
        licList.add(lic12);
        
        License__c lic13=new License__c();
        lic13.Name='1003';
        lic13.status__c='Active';
        lic13.Doctor__c=docList[0].id;
        lic13.States__c='CO';
        licList.add(lic13);
        
        License__c lic21=new License__c();
        lic21.Name='2001';
        lic21.status__c='Active';
        lic21.Doctor__c=docList[1].id;
        lic21.States__c='NY';
        licList.add(lic21);
        
        License__c lic22=new License__c();
        lic22.Name='2002';
        lic22.status__c='Active';
        lic22.Doctor__c=docList[1].id;
        lic22.States__c='AR';
        licList.add(lic22);
        
        License__c lic23=new License__c();
        lic23.Name='2003';
        lic23.status__c='Active';
        lic23.Doctor__c=docList[1].id;
        lic23.States__c='CO';
        licList.add(lic23);
        
        insert licList;

    }
    
    public static void testTestDataProviderInfo(){
        
        List<Providers__c> provList=new List<Providers__c>();
        
        Providers__c prov1=new Providers__c();
        prov1.Name__c='Teland';
        prov1.Phone1__c='8080808080';
        prov1.Contact_Person__c='JAmand';
        prov1.Email__c='john@prov.com';
        prov1.Consultant_Type__c='Video';
        prov1.Started_Date__c=Date.today();
        prov1.City__c='NewYork';
        prov1.State__c='NY';
        prov1.ZipCode__c='500890';
        provList.add(prov1);
 
        Providers__c prov2=new Providers__c();
        prov2.Name__c='Besark';
        prov2.Phone1__c='8080909080';
        prov2.Contact_Person__c='Smith';
        prov2.Email__c='smith@prov.com';
        prov2.Consultant_Type__c='Chat';
        prov2.Started_Date__c=Date.today();
        prov2.City__c='NewYork';
        prov2.State__c='NY';
        prov2.ZipCode__c='550890';
        provList.add(prov2);
        
        insert provList;
    }
    
    Public static void testTestDataMemberInfo(){
        
        List<Member__c> memList=new List<Member__c>();
        Member__c mem1=new Member__c();
        mem1.Name='10001';
        mem1.FirstName__c='John';
        mem1.LastName__c='Admin';
        mem1.Status__c='Active';
        mem1.Cell_Phone__c='9090909090';
        mem1.City__c='NW';
        mem1.ZipCode__c='900900';
        mem1.DateofBirth__c=date.newInstance(1999,1,20);
        memList.add(mem1);
        
        Member__c mem2=new Member__c();
        mem2.Name='10002';
        mem2.FirstName__c='Admin';
        mem2.LastName__c='Adam';
        mem2.Status__c='Active';
        mem2.Cell_Phone__c='9078979090';
        mem2.City__c='NW';
        mem2.ZipCode__c='900990';
        memList.add(mem2);
        
        insert memList; 
    }
}