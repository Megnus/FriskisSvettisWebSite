using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ContentPlaceHolder cp = (ContentPlaceHolder)this.Master.FindControl("ContentPlaceHolder1");
        HyperLink hp = (HyperLink)this.Master.FindControl("UserLink");
        hp.Text = "Du är inloggad som: " + User.Identity.Name;
        hp.Visible = true;
    }
}