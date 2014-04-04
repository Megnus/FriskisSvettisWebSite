using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Security;

public partial class User : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('" + Roles.GetRolesForUser(User.Identity.Name) + "');", true);
        System.Web.HttpContext.Current.Response.Write(Roles.GetRolesForUser()[0]);
        GridView1.SelectRow(-1);

        //SqlDataSource1.SelectParameters["Id"].DefaultValue = "6"; //Where userID is your variable
        ContentPlaceHolder cp = (ContentPlaceHolder)this.Master.FindControl("ContentPlaceHolder1");
        HyperLink hp = (HyperLink)this.Master.FindControl("AdminLink");
        hp.Text = User.Identity.Name;
        SqlDataSource1.SelectParameters["UserName"].DefaultValue = User.Identity.Name;
    }

    protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        //System.Web.HttpContext.Current.Response.Write(hp.Text);
        if (e.CommandName != "NejCommand")
            return;

        GridView1.SelectRow(int.Parse(e.CommandArgument.ToString()));


        string id = GridView1.SelectedRow.Cells[0].Text;
        System.Web.HttpContext.Current.Response.Write(id);

        GridView1.SelectRow(int.Parse(e.CommandArgument.ToString()));
        GridView1.SelectedRow.Visible = false;

        SqlConnection cnn = new SqlConnection();
        cnn.ConnectionString = ConfigurationManager.ConnectionStrings["FriskisSvettisConnectionString"].ConnectionString;

        var cmd = "UPDATE Pass SET AntalNej = AntalNej + 1 Where PassID = @Id";
        using (SqlCommand cmd2 = new SqlCommand(cmd, cnn))
        {
            cmd2.Parameters.AddWithValue("@Id", id);
            cnn.Open();
            cmd2.ExecuteNonQuery();
            cnn.Close();
        }

        cmd = @"INSERT INTO Respons (PassID, VikarieID) VALUES 
                (@Id, (SELECT VikarieID FROM Vikarie WHERE Anvandarnamn = @User))";
        //using (SqlConnection cnn = new SqlConnection(cmd))
        //{
        using (SqlCommand cmd2 = new SqlCommand(cmd, cnn))
        {
            cmd2.Parameters.AddWithValue("@Id", id);
            cmd2.Parameters.AddWithValue("@User", User.Identity.Name);
            cnn.Open();
            cmd2.ExecuteNonQuery();
            cnn.Close();
        }

    }
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        // System.Web.HttpContext.Current.Response.Write(e);
        if (e.Row.RowType == System.Web.UI.WebControls.DataControlRowType.DataRow)
        {

            // when mouse is over the row, save original color to new attribute, and change it to highlight color
            e.Row.Attributes.Add("onmouseover", "this.originalstyle=this.style.backgroundColor;this.style.backgroundColor='#FAFAFA'");

            // when mouse leaves the row, change the bg color to its original value  
            e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=this.originalstyle;");
        }
    }
}