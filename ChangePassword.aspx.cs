using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    private VPCRMSBAL VPCRMSBAL = new VPCRMSBAL();

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnchgpwd_Click(object sender, EventArgs e)
    {
        lblErrorMesage.Text = "";

        if (txtpassword1.Text.ToString().Trim() == txtpassword2.Text.ToString().Trim())
        {
            decimal alias = Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4));

            string sltforpwd = BCrypt.GenerateSalt(10);
            string hashedpassword = BCrypt.HashPassword(txtpassword1.Text.ToString().Trim(), sltforpwd);

            decimal userid = Convert.ToDecimal(Session["UserID"].ToString().Trim());

            try
            {
                VPCRMSBAL.UdpateUserPassword(alias, userid, hashedpassword);
                lblErrorMesage.Text = "Success. You will be redirected to Login.";
                Response.Redirect("Login.aspx");
            }

            catch
            {

            }

    
        }
    }
}