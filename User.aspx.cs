using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

using System.Web.Security;
using System.Configuration;
using System.Data.SqlClient;


public partial class User : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        /*ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('" + Roles.GetRolesForUser(User.Identity.Name) + "');", true);
        /System.Web.HttpContext.Current.Response.Write(hp.Text);*/
        FreeGrid.SelectRow(-1);

        if (string.IsNullOrEmpty(User.Identity.Name))
            Response.Redirect("~/Login.aspx", false);
        
        if (Roles.GetRolesForUser().Length > 0)
        {
           if (Roles.GetRolesForUser()[0].ToString() == "Administratör")
               Response.Redirect("~/Secure/Admin.aspx", false);
        }
       
        ContentPlaceHolder cp = (ContentPlaceHolder)this.Master.FindControl("ContentPlaceHolder1");
        Label lbl = (Label) this.Master.FindControl("UserLink");
        lbl.Text = "Du är inloggad som: " + User.Identity.Name;
        lbl.Visible = true;

        HyperLink hp = (HyperLink) this.Master.FindControl("settings");
        hp.Visible = true;

        SqlDataSourceUser.SelectParameters["UserName"].DefaultValue = User.Identity.Name;

        if (!string.IsNullOrEmpty(tbxNamn.Text + tbxTelefon.Text + tbxEmail.Text + tbxPersonNum.Text))
            return;
        
        var cmd = "SELECT * FROM Vikarie WHERE Anvandarnamn = @UserName";

        SqlConnection cnn = new SqlConnection();
        cnn.ConnectionString = ConfigurationManager.ConnectionStrings["FriskisSvettisConnectionString"].ConnectionString;


        using (SqlCommand cmd2 = new SqlCommand(cmd, cnn))
        {
            cmd2.Parameters.AddWithValue("@UserName", User.Identity.Name);
            cnn.Open();

            SqlDataReader nwReader = cmd2.ExecuteReader();
            while (nwReader.Read())
            {
                string Namn = (string) nwReader["Namn"];
                string Telefonnummer = (string)nwReader["Telefonnummer"];
                string Email = (string)nwReader["Email"];
                string Personnummer = (string)nwReader["Personnummer"];
                tbxNamn.Text = Namn;
                tbxTelefon.Text = Telefonnummer;
                tbxEmail.Text = Email;
                tbxPersonNum.Text = Personnummer;
            }
            
            cnn.Close();

            if (string.IsNullOrEmpty(tbxNamn.Text)
                || string.IsNullOrEmpty(tbxTelefon.Text)
                || string.IsNullOrEmpty(tbxEmail.Text)
                || string.IsNullOrEmpty(tbxPersonNum.Text))
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "showMessage();", true);
        }
    }

    protected void FreeGrid_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int id;

        if (!int.TryParse(e.CommandArgument.ToString(), out id))
            return;
        
        if (e.CommandName == "NejCommand")
            ExecuteNejCommand(id);

        if (e.CommandName == "JaCommand")
            ExecuteJaCommand(id);
    }

    private void ExecuteJaCommand(int passId)
    {
        FreeGrid.SelectRow(passId);
        string id = FreeGrid.SelectedRow.Cells[0].Text;
        FreeGrid.SelectedRow.Visible = false;

        var cmd = "UPDATE Pass SET NyLedare = (SELECT VikarieID FROM Vikarie WHERE Anvandarnamn = @User) Where PassID = @Id";

        SqlConnection cnn = new SqlConnection();
        cnn.ConnectionString = ConfigurationManager.ConnectionStrings["FriskisSvettisConnectionString"].ConnectionString;
     
        using (SqlCommand cmd2 = new SqlCommand(cmd, cnn))
        {
            cmd2.Parameters.AddWithValue("@User", User.Identity.Name);
            cmd2.Parameters.AddWithValue("@Id", id);
            cnn.Open();
            cmd2.ExecuteNonQuery();
            cnn.Close();
        }
        FreeGrid.SelectRow(-1);
        SetGrid.DataBind();
        FreeGrid.DataBind();
    } 

    private void ExecuteNejCommand(int passId)
    {
        FreeGrid.SelectRow(passId);
        string id = FreeGrid.SelectedRow.Cells[0].Text;

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
        //GridView1.DataSource = lstCustomer;
        FreeGrid.SelectRow(-1);
        FreeGrid.DataBind();
    }

    protected void FreeGrid_RowDataBound(object sender, GridViewRowEventArgs e)
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
    protected void SaveSettingsButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/User.aspx", false);

        var cmd = @"UPDATE Vikarie SET Namn = @Namn, Telefonnummer = @Telefonnummer, Email = @Email, Personnummer = @Personnummer WHERE Anvandarnamn = @User";

        SqlConnection cnn = new SqlConnection();
        cnn.ConnectionString = ConfigurationManager.ConnectionStrings["FriskisSvettisConnectionString"].ConnectionString;
        string gg = tbxNamn.Text;
        using (SqlCommand cmd2 = new SqlCommand(cmd, cnn))
        {
            cmd2.Parameters.AddWithValue("@User", User.Identity.Name);
            cmd2.Parameters.AddWithValue("@Namn", tbxNamn.Text);
            cmd2.Parameters.AddWithValue("@Telefonnummer", tbxTelefon.Text);
            cmd2.Parameters.AddWithValue("@Email", tbxEmail.Text);
            cmd2.Parameters.AddWithValue("@Personnummer", tbxPersonNum.Text);
            cnn.Open();
            cmd2.ExecuteNonQuery();
            cnn.Close();
        }
    }
    protected void CreatePassButton_Click(object sender, EventArgs e)
    {
        int id = 0;
        var cmdx = "SELECT * FROM Vikarie WHERE Anvandarnamn = @UserName";

        SqlConnection cnnx = new SqlConnection();
        cnnx.ConnectionString = ConfigurationManager.ConnectionStrings["FriskisSvettisConnectionString"].ConnectionString;

        using (SqlCommand cmd2x = new SqlCommand(cmdx, cnnx))
        {
            cmd2x.Parameters.AddWithValue("@UserName", User.Identity.Name);
            cnnx.Open();
            SqlDataReader nwReader = cmd2x.ExecuteReader();
            while (nwReader.Read())
            {
                id = (int)nwReader["VikarieID"];
            }
        }
        
        string s1 = String.Format("{0}", Request.Form["datepicker"]);
        string s2 = String.Format("{0}", Request.Form["timepicker"]);
        DateTime dateValue;
        if (!DateTime.TryParse(s1 + " " + s2, out dateValue))
            return;

        int anl = DropDownListFacility.SelectedIndex + 1;
        int pass = DropDownListTrainingCategory.SelectedIndex + 1;
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('" + anl.ToString() + "');", true); 
        SqlConnection cnn = new SqlConnection();
        cnn.ConnectionString = ConfigurationManager.ConnectionStrings["FriskisSvettisConnectionString"].ConnectionString;

        var cmd =
            @"INSERT INTO Pass (Datum, Anlaggning, OrdinarieLedare, NyLedare, TraningsForm, AntalNej)
            VALUES (@Datum, @Anlaggning, @OrdinarieLedare, null, @TraningsForm, '0')";

        using (SqlCommand cmd2 = new SqlCommand(cmd, cnn))
        {
            cmd2.Parameters.AddWithValue("@Datum", dateValue.ToString());
            cmd2.Parameters.AddWithValue("@Anlaggning", anl.ToString());
            cmd2.Parameters.AddWithValue("@OrdinarieLedare", id.ToString());
            cmd2.Parameters.AddWithValue("@TraningsForm", pass.ToString());
            cnn.Open();
            cmd2.ExecuteNonQuery();
            cnn.Close();
        }
        Response.Redirect("~/User.aspx");
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('" + DropDownList1.SelectedItem.Value + "');", true); 
    }

    protected void CancelButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/User.aspx");
    }
}