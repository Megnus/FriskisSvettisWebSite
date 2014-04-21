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
        if (!string.IsNullOrEmpty(User.Identity.Name))
            Response.Redirect("~/User.aspx", false);
    }

    protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
    {
        //Insert User in the table...
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('user created...", true);
        SqlConnection cnn = new SqlConnection();
        cnn.ConnectionString = ConfigurationManager.ConnectionStrings["FriskisSvettisConnectionString"].ConnectionString;

        var cmd =
            @"INSERT INTO Vikarie (Anvandarnamn, Namn, Telefonnummer, Email, Personnummer)
            VALUES (@UserName, '', '', @Email, '')";
        
        using (SqlCommand cmd2 = new SqlCommand(cmd, cnn))
        {
            cmd2.Parameters.AddWithValue("@UserName", CreateUserWizard1.UserName);
            cmd2.Parameters.AddWithValue("@Email", CreateUserWizard1.Email);
            cnn.Open();
            cmd2.ExecuteNonQuery();
            cnn.Close();
        }

        Response.Redirect("~/User.aspx", false);
    }   

    protected void loggedin(object sender, EventArgs e)
    {
        Response.Redirect("~/User.aspx");
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Default.aspx");
    }
}