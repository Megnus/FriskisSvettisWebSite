﻿using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

/// <summary>
/// Handles the results of the querys.
/// </summary>
public class QueryResult : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataSet ds;

    /// <summary>
    /// This metgod returns the free pass list.
    /// </summary>
    /// <returns></returns>
    public DataSet GetFreePass()
    {
        //System.Web.HttpContext.Current.Response.Write("<p>" + User.Identity.Name + "</p>");
        
        con = new SqlConnection();
        con.ConnectionString = ConfigurationManager.ConnectionStrings["FriskisSvettisConnectionString"].ConnectionString;
        cmd = new SqlCommand();

        cmd.CommandText = @"SELECT DISTINCT Pass.PassID, Pass.Datum, Anlaggning.Namn, Vikarie.Namn, Traningsform.Namn FROM Pass 
                            LEFT JOIN Vikarie ON Pass.OrdinarieLedare = Vikarie.VikarieID 
                            LEFT JOIN Anlaggning ON Pass.Anlaggning = Anlaggning.AnlaggningID 
                            LEFT JOIN Traningsform ON Pass.TraningsForm = Traningsform.TraningsformID 
                            LEFT JOIN Respons ON Pass.PassID = Respons.PassID
                            WHERE Pass.NyLedare IS NULL AND Pass.AntalNej < @NumberOfNo AND Pass.PassId NOT IN (SELECT PassId FROM Respons 
                            WHERE VikarieID = (SELECT Vikarie.VikarieID FROM Vikarie WHERE Anvandarnamn =  @UserName)) 
                            AND Pass.OrdinarieLedare <> (SELECT Vikarie.VikarieID FROM Vikarie WHERE Anvandarnamn =  @UserName)";

        cmd.Connection = con;
        cmd.Parameters.AddWithValue("@UserName", User.Identity.Name);
        cmd.Parameters.AddWithValue("@NumberOfNo", "10");

        da = new SqlDataAdapter(cmd);
        ds = new DataSet();     
        da.Fill(ds);

       /*foreach (DataRow row in ds.Tables[0].Rows){
            foreach (object item in row.ItemArray){
                string temp = item.ToString();
                //System.Web.HttpContext.Current.Response.Write("<p>" + temp + "</p>");
            }
        }
        ds.Tables[0].Rows[10].Delete();
        System.Web.HttpContext.Current.Response.Write("<p>" + User.Identity.Name + "</p>");*/

        /*foreach (var user in Membership.GetAllUsers())
        {
            System.Web.HttpContext.Current.Response.Write("<p>" + user.ToString() + "</p>");
            //var u = Membership.FindUsersByName(user.ToString());
            //System.Web.HttpContext.Current.Response.Write("<p>" + u.ToString() + "</p>");
        }*/

        return ds;
    }
}