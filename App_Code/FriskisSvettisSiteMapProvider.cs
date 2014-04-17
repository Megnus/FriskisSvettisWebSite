using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Collections.Specialized;
using System.Configuration;

/// <summary>
/// Summary description for FriskisSvettisSiteMapProvider
/// </summary>
public class FriskisSvettisSiteMapProvider : StaticSiteMapProvider
{
    static readonly string _errmsg = "Missing attribute: connectionStringName";
    string _connect;
    SiteMapNode _root;

    public FriskisSvettisSiteMapProvider()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public override void Initialize(string name, NameValueCollection attributes)
    {
        base.Initialize(name, attributes);
        if (attributes == null)
        {
            throw new ConfigurationException(_errmsg);
        }

        _connect = attributes["connectionStringName"];
        if (String.IsNullOrEmpty(_connect))
            throw new ConfigurationException(_errmsg);
    }

    public override SiteMapNode BuildSiteMap()
    {
        // Return immediately if this method has been called before
        if (_root != null)
            return _root;
        // Create the root SiteMapNode
        _root = new SiteMapNode(this, "Default.aspx", "Default.aspx", "Home");
        AddNode(_root, null);
        // Query the database for other SiteMapNodes
        SqlConnection connection = new SqlConnection
        (ConfigurationManager.ConnectionStrings[_connect].ConnectionString);
        try
        {
            connection.Open();
            SqlCommand command = new SqlCommand
            ("SELECT Title, Url, Roles FROM SiteMap", connection);
            SqlDataReader reader = command.ExecuteReader();
            int url = reader.GetOrdinal("Url");
            int title = reader.GetOrdinal("Title");
            int roles = reader.GetOrdinal("Roles");
            // Add the nodes to the site map
            while (reader.Read())
            {
                SiteMapNode node = new SiteMapNode(this, reader.GetString(url),
            reader.GetString(url), reader.GetString(title));
                if (!reader.IsDBNull(roles))
                {
                    string rolenames = reader.GetString(roles);
                    if (!String.IsNullOrEmpty(rolenames))
                    {
                        string[] rolelist =
                        rolenames.Split(new char[] { ',', ';' }, 512);
                        node.Roles = rolelist;
                    }
                }
                AddNode(node, _root);
            }
        }
        finally
        {
            connection.Close();
        }
        // Return the root SiteMapNode
        return _root;
    }

    public override bool IsAccessibleToUser(HttpContext context, SiteMapNode node)
    {
        if (!SecurityTrimmingEnabled || node.Roles == null || node.Roles.Count == 0)
            return true;
        foreach (string role in node.Roles)
        {
            if (string.Equals(role, "*", StringComparison.InvariantCultureIgnoreCase)
        || context.User.IsInRole(role))
                return true;
        }
        return false;
    }

    protected override SiteMapNode GetRootNodeCore()
    {
        BuildSiteMap();
        return _root;
    }
}