using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Test : System.Web.UI.Page
{
    System.Text.StringBuilder sb = new System.Text.StringBuilder();
    private VPCRMSBAL VPCRMSBAL = new VPCRMSBAL();
    //private string constring = ConfigurationManager.ConnectionStrings["Constring"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            if (!this.IsPostBack)
            {
                DataTable dt = GetData();
                ViewState["DataTable"] = dt;
                DataTable dtLogin = new DataTable();
                dtLogin = VPCRMSBAL.GetUsersDetails();
                GetMergedAll.DataSource = dt;
                GetMergedAll.DataBind();
            }
        }
    }

    private static DataTable GetData()
    {
        DataTable dt = new DataTable();
        dt.Columns.AddRange(new DataColumn[3] { new DataColumn("CategoryID", typeof(int)), new DataColumn("CategoryName"), new DataColumn("Description") });
        dt.Rows.Add(1, "Category 1", "Description 1");
        dt.Rows.Add(2, "Category 2", "Description 2");
        dt.Rows.Add(3, "Category 3", "Description 3");
        dt.Rows.Add(4, "Category 4", "Description 4");
        return dt;
    }

    protected void btnClick_Click(object sender, EventArgs e)
    {
        ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);
    }

    protected void GetMergedAll_ItemCommand1(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "SharePost")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            DataTable dt = (DataTable)ViewState["DataTable"];
            IEnumerable<DataRow> query = from i in dt.AsEnumerable()
                                         where i.Field<int>("CategoryID").Equals(index)
                                         select i;
            DataTable detailTable = query.CopyToDataTable();
            SharePost.DataSource = detailTable;
            SharePost.DataBind();
        }
    }

    protected void OnSubmit(object sender, EventArgs e)
    {
        string modelId = (SharePost.Row.FindControl("lblCategoryId") as Label).Text;
        string userName = (SharePost.Row.FindControl("lblCategoryName") as Label).Text;
        string description = (SharePost.Row.FindControl("lblDescription") as Label).Text;
        string contentPost = (SharePost.Row.FindControl("txtComment") as TextBox).Text;
        DateTime sendDate = DateTime.Now;
        //InsertDatabase(modelId, userName, description, contentPost, sendDate);
        sb.Append(@"<script type='text/javascript'>");
        sb.Append("$(function () {");
        sb.Append(" $('#myModal').modal('hide');});");
        sb.Append("</script>");
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ModelScript", sb.ToString(), false);
    }

    //private void InsertDatabase(string modelId, string userName, string description, string contentPost, DateTime sendDate)
    //{
    //    using (SqlConnection con = new SqlConnection(constring))
    //    {
    //        using (SqlCommand cmd = new SqlCommand("INSERT INTO SharePost VALUES(@ModelId,@userName,@contentPost,@description,@sendDate)", con))
    //        {
    //            cmd.Parameters.AddWithValue("@ModelId", modelId);
    //            cmd.Parameters.AddWithValue("@userName", userName);
    //            cmd.Parameters.AddWithValue("@contentPost", contentPost);
    //            cmd.Parameters.AddWithValue("@description", description);
    //            cmd.Parameters.AddWithValue("@sendDate", sendDate);
    //            con.Open();
    //            cmd.ExecuteNonQuery();
    //            con.Close();
    //        }
    //    }
    //}
}