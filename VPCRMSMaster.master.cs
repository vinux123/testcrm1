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
        lblUserName.Text = Session["UserFirstName"].ToString().TrimEnd() + ' ' + Session["UserLastName"].ToString().TrimEnd()  ;

    }

    protected void lnkBtnLogout_Click(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
        Session["UserName"] = null;
        Session["UserID"] = null;
        Session.Abandon();
    }
}
