using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VPCRMSMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        lblUserName.Text = Session["UserFirstName"].ToString().TrimEnd() + ' ' + Session["UserLastName"].ToString().TrimEnd();

        string userrole = Session["UserRole"].ToString().Trim();
                
        if ( userrole.Equals("Manager") )
        {
            mnuadmin.Visible = true;
        }
        else
        {
            mnuadmin.Visible = false;
        }
        
    }

    protected void lnkBtnLogout_Click(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
        Session["UserName"] = null;
        Session["UserID"] = null;
        Session["UserFirstName"] = null;
        Session["UserLastName"] = null;
        Session["UserRole"] = null;
        Session.Abandon();
    }
}
