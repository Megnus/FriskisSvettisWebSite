using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Security;
using System.Configuration;
using System.Data.SqlClient;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
      /*  System.Web.HttpContext.Current.Response.Write("<p>" + Login1.UserName + "</p>");
        System.Web.HttpContext.Current.Response.Write("<p>" + User.Identity.Name + "</p>");
        // NOTE: This is a static method .. which makes things easier to use.
        MembershipUser user = Membership.GetUser(User.Identity.Name);
        if (user == null)
        {
            throw new InvalidOperationException("User [" +
                User.Identity.Name + " ] not found.");
        }

        // Do whatever u want with the unique identifier.
        Guid guid = (Guid)user.ProviderUserKey;
        System.Web.HttpContext.Current.Response.Write("<p>" + guid + "</p>");*/
    
    /*********/
       /*SqlConnection cnn = new SqlConnection();
        cnn.ConnectionString = ConfigurationManager.ConnectionStrings["FriskisSvettisConnectionString"].ConnectionString;
        //SqlConnection cnn = new SqlConnection("Data Source=MAGNUS-HP\\SQLEXPRESS;Initial Catalog=FriskisSvettis;Integrated Security=True");

        var cmd =
            @"INSERT INTO Vikarie (Anvandarnamn, Bild, Fornamn, Efternamn, Telefonnummer, Email, Personnummer)
            VALUES (@UserName, null, 'Mange','Sundström','070-3945876','magnus@friskissvettis.se','196705180572')";
        //using (SqlConnection cnn = new SqlConnection(cmd))
        //{
        using (SqlCommand cmd2 = new SqlCommand(cmd, cnn))
        {
            cmd2.Parameters.AddWithValue("@UserName", "fucker");
            cnn.Open();
            cmd2.ExecuteNonQuery();
            cnn.Close();
        }*/
    
    
    }

    protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
    {
        //Insert User in the table...

        SqlConnection cnn = new SqlConnection();
        cnn.ConnectionString = ConfigurationManager.ConnectionStrings["FriskisSvettisConnectionString"].ConnectionString;
        //SqlConnection cnn = new SqlConnection("Data Source=MAGNUS-HP\\SQLEXPRESS;Initial Catalog=FriskisSvettis;Integrated Security=True");

        var cmd =
            @"INSERT INTO Vikarie (Anvandarnamn, Bild, Fornamn, Efternamn, Telefonnummer, Email, Personnummer)
            VALUES (@UserName, null, null, null, null, @Email, null)";
        //using (SqlConnection cnn = new SqlConnection(cmd))
        //{
        using (SqlCommand cmd2 = new SqlCommand(cmd, cnn))
        {
            cmd2.Parameters.AddWithValue("@UserName", CreateUserWizard1.UserName);
            cmd2.Parameters.AddWithValue("@Email", CreateUserWizard1.Email);
            cnn.Open();
            cmd2.ExecuteNonQuery();
            cnn.Close();
        }
    }
}