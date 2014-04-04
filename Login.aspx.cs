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

    protected void sdf(object sender, EventArgs e)
    {

        Response.Redirect("User.aspx", false);
    }
    protected void loggedin(object sender, EventArgs e)
    {
        Response.Redirect("User.aspx", false);
    }
}