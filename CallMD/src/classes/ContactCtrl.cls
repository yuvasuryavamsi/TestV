public class ContactCtrl {

   public Contact C { get; set; }

   

    public List<Contact> getCon() 
    {
      
      List<Contact> con=[SELECT FirstName,LastName FROM Contact];
    
        return con;
    }

}