using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for VRCRMSBAL
/// </summary>
public class VPCRMSBAL
{
    #region private Member Functions

    VPCRMSDAL VPCRMSDAL = new VPCRMSDAL();

    #endregion

    #region Public Member Functions

	public VPCRMSBAL()
	{
		//
		// TODO: Add constructor logic here
		//
    }

    // Get User List
    public DataTable GetUserList(Decimal ClientAlias)
    {
        DataTable dt = VPCRMSDAL.GetUserList(ClientAlias);
        return dt;
    }

    // Get Product List
    public DataTable GetProductList(Decimal ClientAlias)
    {
        DataTable dt = VPCRMSDAL.GetProductList(ClientAlias);
        return dt;
    }

    public DataTable GetUserPassword(String UserName)
    {
        DataTable dt = VPCRMSDAL.GetUserPassword(UserName);
        return dt;
    }

    public DataTable GetUsersDetails()
    {
        DataTable dt = VPCRMSDAL.GetUsersDetails();
        return dt;
    }

    public DataTable GetMaxAllowedUsers(Decimal ClientAlias)
    {
        DataTable dt = VPCRMSDAL.GetMaxAllowedUsers(ClientAlias);
        return dt;
    }

    public DataTable CheckClientActiveOrNot(Decimal ClientAlias)
    {
        DataTable dt = VPCRMSDAL.CheckClientActiveOrNot(ClientAlias);
        return dt;
    }

    // To fetch quotation details per user for Quatation form. 
    public DataTable GetQuotationDetails(Decimal UserID)
    {
        DataTable dt = VPCRMSDAL.GetQuotationDetails(UserID);
        return dt;
    }

    // To fetch follow up details of leads per user for Follow Up form. 
    public DataTable GetFollowupDetails(Decimal UserID)
    {
        DataTable dt = VPCRMSDAL.GetFollowupDetails(UserID);
        return dt;
    }

    // To fetch daily call report details per user for DCR form. 
    public DataTable GetDailyCallReportDetails(Decimal UserID)
    {
        DataTable dt = VPCRMSDAL.GetDailyCallReportDetails(UserID);
        return dt;
    }

    // To Fetch Company Name for each form. 
    public DataTable GetCompanyName(Decimal ClientAlias)
    {
        DataTable dt = VPCRMSDAL.GetCompanyName(ClientAlias);
        return dt;
    }

    // To Fetch Product Details of client. 
    public DataTable GetProductDetails(Decimal ClientAlias)
    {
        DataTable dt = VPCRMSDAL.GetProductDetails(ClientAlias);
        return dt;
    }

    // To fetch product assignment details. 
    public DataTable GetProductAssignment()
    {
        DataTable dt = VPCRMSDAL.GetProductAssignDetails();
        return dt;
    }

    // To Save/Update user details. 
    public static void SaveUserDetails(Decimal alias, Decimal userid, String username, String password, String firstname, String lastname, String doj, Decimal contactno, String emailid, String role)
    {
        VPCRMSDAL.SaveUserDetails(alias, userid, username, password, firstname, lastname, doj, contactno, emailid, role);
    }

    // To save quotation details. 
    public static void SaveQuotationData(Decimal clientcustomerid, Decimal clientquoteid, Decimal clientcustomeruser, String clientquotedproduct, Decimal clientquotedprodqty, Decimal clientquotedprice, Decimal clientquotedamt)
    {
        VPCRMSDAL.SaveQuotationData(clientcustomerid, clientquoteid, clientcustomeruser, clientquotedproduct, clientquotedprodqty, clientquotedprice, clientquotedamt);
    }

    // To get existing user details. 
    public static DataTable GetUserDetails(Decimal userid)
    {
        DataTable dt = VPCRMSDAL.GetUserDetails(userid);
        return dt;
    }

    public static DataTable GetEditedProductDetails(Decimal client_alias, String prod_name)
    {
        DataTable dt = VPCRMSDAL.GetEditedProdDetails(client_alias, prod_name);
        return dt;
    }

    public static DataTable GetEditedProdAssignments(Decimal client_user, String customer_product, String target_month, String target_year)
    {
        DataTable dt = VPCRMSDAL.GetEditedProdAssignments(client_user, customer_product, target_month, target_year);
        return dt;
    }

    public static DataTable GetEditDCRDetails(Decimal client_customer_id)
    {
        DataTable dt = VPCRMSDAL.GetEditDCRDetails(client_customer_id);
        return dt;
    }

    // Save product assignment
    public static void SaveProdAssignment(Decimal userid, String prodname, Decimal prodamttgt, Decimal prodqtytgt, String prodtgtmth, String prodtgtyr)
    {
        VPCRMSDAL.SaveProdAssignment(userid, prodname, prodamttgt, prodqtytgt, prodtgtmth, prodtgtyr);

    }
    // To Save/Update client products. 
    public static void SaveProdData(Decimal alias, String prodname, String proddesc, String prodhsn, String prodprice)
    {
        VPCRMSDAL.SaveProdData(alias, prodname, proddesc, prodhsn, prodprice);
    }

    // TO save/update DCR. 
    public static void SaveDCR(String clientdate, String company, String firstname, String occupation, String primarycontact, String website, Decimal erevenue, String followupdate,
        String companyadd1, String companyadd2, String addresscity, String addressdist, String addressstate, String addresscountry, Decimal pincode, String remarks, Decimal assignedto,
        String companytype, String lastname, String email, Decimal alternatecontact, String status, String source, String saddress1, String saddress2, String scity, String sdistrict,
        String sstate, String scountry, Decimal spincode, String Mode, Decimal clientcustomerid)
    {
        VPCRMSDAL.SaveDCR(clientdate, company, firstname, occupation, primarycontact, website, erevenue, followupdate,
        companyadd1,  companyadd2,  addresscity,  addressdist,  addressstate,  addresscountry, pincode, remarks, assignedto,
        companytype,  lastname, email, alternatecontact, status, source, saddress1,  saddress2,  scity,  sdistrict,
        sstate, scountry, spincode, Mode, clientcustomerid);
    }

    public static DataTable GetStatusCount(Decimal userid, String user_role)
    {
        DataTable dt = VPCRMSDAL.GetStatusCount(userid, user_role);
        return dt;
    }

    public static DataTable GetReportData()
    {
        DataTable dt = VPCRMSDAL.GetReportData();
        return dt;
    }


    #endregion
}