// Copyright (c) 2017 VP Consultancy Services. 
// 
// Permission to use, copy, modify, and distribute this software for given
// purpose with or without fee is hereby granted, provided that the above
// copyright notice and this permission notice appear in all copies & with 
// written approval of original VP Consultancy Services. 
//


using MySql.Data.MySqlClient;
using log4net;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;


/// <summary>
/// =================================================
/// Data Abstraction Layer(DAL) for CRMS application. 
/// =================================================
///     1. All stored procedures call are handled in this module.
///     2. Two database connection strings are used used in this program 
///         a. VPCS for user related queries b. CRMS for application specific files ( fetched from Session Parameter set on Login.aspx form. 
///     3. Business Abstraction Layer(BAL) of CRMS creates instance of each method defined here as per need. 
///     4. Every page of application calls method from Business Abstraction Layer(BAL) as required. 
/// </summary>
public class VPCRMSDAL
{
    #region private Member Functions

    // Track whether Dispose has been called
    private bool disposed;

    #endregion

   
   

    string connectionstring = ConfigurationManager.ConnectionStrings["SQLConnectionVPCS"].ToString();
        
    
    public VPCRMSDAL()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    
    // Get User List for User List Drop Down. 
    public DataTable GetUserList(Decimal ClientAlias)
    {
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        
        MySqlConnection conn = new MySqlConnection(connectionstring);
        MySqlCommand dCmd;
        DataTable dt = new DataTable();
        
        try
        {
            conn.Open();
            DataTable dtUsers = new DataTable();
            dCmd = new MySqlCommand("usp_getUserList", conn);
            dCmd.Parameters.AddWithValue("@client_alias", ClientAlias);
            dCmd.Parameters.AddWithValue("@client_user_role", HttpContext.Current.Session["UserRole"].ToString().Trim());
            dCmd.Parameters.AddWithValue("@client_user_id", HttpContext.Current.Session["UserID"].ToString().Trim());
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);

        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "GetUserList(" + ClientAlias + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
            
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }

    // Get quotation details by ID
    public DataTable GetQuotationDetailsbyID(Decimal clientquoteid)
    {
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        DataTable dt = new DataTable();
        MySqlConnection conn = new MySqlConnection(connectionstring_crms);
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_GetQuotationDetailsbyID", conn);
            dCmd.Parameters.AddWithValue("@client_quotation_id", clientquoteid);

            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);

        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "GetQuotationDetailsbyID(" + clientquoteid + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }

    // Get Product List for Product List Drop Down. 
    public DataTable GetProductList(Decimal ClientAlias)
    {
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring_crms);
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_getProductList", conn);
            dCmd.Parameters.AddWithValue("@client_alias", ClientAlias);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            //throw ex;
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }

    // Get Product List for Product List Drop Down. 
    public static DataTable GetProductNames(Decimal ClientAlias)
    {
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring_crms);
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_getProductName", conn);
            dCmd.Parameters.AddWithValue("@client_alias", ClientAlias);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "GetProductNames(" + ClientAlias + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }

    // Fetch user password for Login. 
    public DataTable GetUserPassword(String UserName)
    {
        // Connect to VPCRMS Admin Master Database to fetch user login details. 
        
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring);
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("fetch_user_pswd", conn);
            dCmd.Parameters.AddWithValue("@client_user_name", UserName);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "GetUserPassword(" + UserName + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }

    public static DataTable GetUsersDetails()
    {
        // Connect to VPCRMS Admin Master Database to fetch user details. 
        DataTable dt = new DataTable();
        string connectionstring = ConfigurationManager.ConnectionStrings["SQLConnectionVPCS"].ToString();
        MySqlConnection conn = new MySqlConnection(connectionstring);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            // fetch client alias & pass it to SP. 
            decimal client_alias = Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4));
            dCmd = new MySqlCommand("usp_GetUserDetails", conn);
            dCmd.Parameters.AddWithValue("@client_alias", client_alias);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: GetUserDetails()");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }

    // get product details which are to be edited
    public static DataTable GetEditedProdDetails(Decimal client_alias, String product_name)
    {
        // string connectionstring_crms = ConfigurationManager.ConnectionStrings["SQLConnectionCRMS"].ToString();
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim(); 
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring_crms);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_EditModalProdDetails", conn);
            dCmd.Parameters.AddWithValue("@client_alias", client_alias);
            dCmd.Parameters.AddWithValue("@product_name", product_name);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "GetEditedProdDetails(" + client_alias + "," + product_name + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }

    public static DataTable GetEditedProdAssignments(Decimal client_user, String customer_product, String target_month, String target_year)
    {
        //string connectionstring_crms = ConfigurationManager.ConnectionStrings["SQLConnectionCRMS"].ToString();
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring_crms);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_EditModalProdAssignment", conn);
            dCmd.Parameters.AddWithValue("@customer_user", client_user);
            dCmd.Parameters.AddWithValue("@customer_product", customer_product);
            dCmd.Parameters.AddWithValue("@target_month", target_month);
            dCmd.Parameters.AddWithValue("@target_year", target_year);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "GetEditedProdAssignments(" + client_user + "," + customer_product + "," + target_month + "," + target_year + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }
    
    public static DataTable GetEditDCRDetails(Decimal ClientUserID)
    {
        //string connectionstring_crms = ConfigurationManager.ConnectionStrings["SQLConnectionCRMS"].ToString();
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring_crms);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_EditModalDCR", conn);
            dCmd.Parameters.AddWithValue("@client_customer_id", ClientUserID);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            //throw ex;
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }

    public static DataTable GetProductPrice(String ProductName,decimal ProductPrice)
    {
        //string connectionstring_crms = ConfigurationManager.ConnectionStrings["SQLConnectionCRMS"].ToString();
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring_crms);

        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_GetProductPrice", conn);
            dCmd.Parameters.AddWithValue("@ProductName", ProductName);
            dCmd.Parameters.AddWithValue("@client_alias", ProductPrice);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "GetProductPrice(" + ProductName + "," + ProductPrice + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }

    public DataTable CheckClientActiveOrNot(Decimal ClientAlias)
    {
        // Connect to VPCRMS Admin Master Database to check whether client active or not.  
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_GetActiveClientDetails", conn);
            dCmd.Parameters.AddWithValue("@client_alias", ClientAlias);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "CheckClientActiveOrNot(" + ClientAlias + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }

    public DataTable GetMaxAllowedUsers(Decimal ClientAlias)
    {
        // Connect to VPCRMS Admin Master Database to check whether client active or not.  
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_getNumberOfAllowedUsers", conn);
            dCmd.Parameters.AddWithValue("@client_alias", ClientAlias);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            //throw ex;
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "GetMaxAllowedUsers(" + ClientAlias + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }


    public static DataTable GetQuotationDetails(Decimal UserID, String role)
    {
        // Get Quotation details of perticular user by passing UserID parameter. 
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring_crms);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_GetQuotationDetails", conn);
            dCmd.Parameters.AddWithValue("@client_customer_user", UserID);
            dCmd.Parameters.AddWithValue("@client_customer_role", role);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "GetQuotationDetails(" + UserID + "," + role + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }



    public static DataTable GetFollowupDetails(Decimal UserID)
    {
        // Get Quotation details of perticular user by passing UserID parameter. 
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring_crms);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_getFollowupDetails", conn);
            dCmd.Parameters.AddWithValue("@client_customer_user", UserID);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "GetFollowupDetails(" + UserID + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }



    public static DataTable GetDailyCallReportDetails(Decimal UserID, String UserRole)
    {
        // Get daily call report details of perticular user by passing UserID parameter. 
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring_crms);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();
        
        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_getDailyCallReport", conn);
            dCmd.Parameters.AddWithValue("@client_customer_user", UserID);
            dCmd.Parameters.AddWithValue("@client_customer_role", UserRole);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "GetDailyCallReportDetails(" + UserID + "," + UserRole + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }

    public static DataTable GetForecastingReportDetails(Decimal client_alias, String status, decimal assignedto)
    {
        // Get daily call report details of perticular user by passing UserID parameter. 
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring_crms);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();
        
        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_GetForecastingDetails", conn);
            dCmd.Parameters.AddWithValue("@client_alias", client_alias);
            dCmd.Parameters.AddWithValue("@client_forecasting_status", status);
            dCmd.Parameters.AddWithValue("@client_forecasting_userid", assignedto);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            //throw ex;
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }

    public static DataTable GetRevenueChartDetails()
    {
        // Get daily call report details of perticular user by passing UserID parameter. 
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring_crms);

        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("GetRevenueChartDetails", conn);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }
    public static DataTable GetForecastingChartDetails(Decimal client_alias, String status, decimal assignedto)
    {
        // Get daily call report details of perticular user by passing UserID parameter. 
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring_crms);

        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_GetForeCastingReportCount", conn);
            dCmd.Parameters.AddWithValue("@client_alias", client_alias);
            dCmd.Parameters.AddWithValue("@client_forecasting_status", status);
            dCmd.Parameters.AddWithValue("@client_forecasting_userid", assignedto);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "GetForecastingChartDetails(" + client_alias + "," + status + "," + assignedto + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }

    public DataTable GetCompanyName(Decimal ClientAlias)
    {
        // Get Quotation details of perticular user by passing UserID parameter. 
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_GetCompanyName", conn);
            dCmd.Parameters.AddWithValue("@client_alias", ClientAlias);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }



    public static DataTable GetProductDetails(Decimal client_alias)
    {
        // Get Product details of perticular user by passing UserID parameter. 
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring_crms);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_GetProductList", conn);
            dCmd.Parameters.AddWithValue("@client_alias", client_alias);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }


    // Get Product Assignment Details
    public static DataTable GetProductAssignDetails()
    {
        // Get Product Assignment details
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring_crms);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_GetProductAssignment", conn);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }

    // Generate New Customer ID for Sales Master/Details

    public static Decimal AssignClientCustomerID()
    {
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring_crms);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();
        decimal NewClientCustomerID = decimal.Zero;

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_getLatestClientCustomerID", conn);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
            if (String.IsNullOrEmpty(dt.Rows[0]["maxclientcustomerid"].ToString()))
            {
                NewClientCustomerID = 1;
            }
            else
            {
                NewClientCustomerID = Convert.ToDecimal(dt.Rows[0]["maxclientcustomerid"].ToString().Trim()) + 1;
            }
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return NewClientCustomerID;
    }

    // Get New User ID
    public static Decimal AssignNewUserID(Decimal client_alias)
    {
        string connectionstring = ConfigurationManager.ConnectionStrings["SQLConnectionVPCS"].ToString();

        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();
        decimal NewUserID = decimal.Zero;

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_GetLatestUserID", conn);
            dCmd.Parameters.AddWithValue("@client_alias", client_alias);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
            if (String.IsNullOrEmpty(dt.Rows[0]["maxclientuserid"].ToString()))
            {
                NewUserID = 1;
            }
            else
            {
                NewUserID = Convert.ToDecimal(dt.Rows[0]["maxclientuserid"].ToString().Trim()) + 1;
            }
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return NewUserID;
    }

    // Generate New Quote ID for Quotation Generation

    public static Decimal AssignQuoteID()
    {
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring_crms);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();
        decimal NewQuoteID = decimal.Zero;

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_GetLatestQuoteID", conn);

            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
            // if no quotation exists assign 1 to newquoteid. 
            if (String.IsNullOrEmpty(dt.Rows[0]["maxquoteid"].ToString()))
            {
                NewQuoteID = 1;
            }
            else
            {
                NewQuoteID = Convert.ToDecimal(dt.Rows[0]["maxquoteid"].ToString().Trim()) + 1;
            }
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return NewQuoteID;
    }

    public static void SaveProdData(Decimal alias, String prodname, String proddesc, String prodhsn, String prodprice)
    {
        string connectionstring = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        MySqlConnection conn = new MySqlConnection(connectionstring); ;
        try
        {

            conn = new MySqlConnection(connectionstring);
            conn.Open();
            using (MySqlCommand cmd = new MySqlCommand("save_prod_details", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@client_customer_alias", alias);
                cmd.Parameters.AddWithValue("@client_customer_prod_name", prodname);
                cmd.Parameters.AddWithValue("@client_customer_prod_desc", proddesc);
                cmd.Parameters.AddWithValue("@client_customer_prod_hsn", prodhsn);
                cmd.Parameters.AddWithValue("@client_customer_prod_price", prodprice);

                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
        }
        catch (MySqlException ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "SaveProdData(" + alias + "," + prodname + "," + proddesc + "," + prodhsn + "," + prodprice + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
        }

    }

    public static void SaveQuotationData(Decimal clientcustomerid, Decimal clientquoteid, Decimal clientcustomeruser, String clientquotedproduct, Decimal clientquotedprodqty, Decimal clientquotedprice, Decimal clientquotedamt)
    {
        string connectionstring = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        MySqlConnection conn = new MySqlConnection(connectionstring); ;
        try
        {

            conn = new MySqlConnection(connectionstring);
            conn.Open();
            using (MySqlCommand cmd = new MySqlCommand("usp_SaveQuotationDetails", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@client_customer_id", clientcustomerid);
                cmd.Parameters.AddWithValue("@client_quote_id", clientquoteid);
                cmd.Parameters.AddWithValue("@client_customer_user", clientcustomeruser);
                cmd.Parameters.AddWithValue("@client_quoted_product", clientquotedproduct);
                cmd.Parameters.AddWithValue("@client_quoted_product_qty", clientquotedprodqty);
                cmd.Parameters.AddWithValue("@client_quoted_price", clientquotedprice);
                cmd.Parameters.AddWithValue("@client_quoted_amount", clientquotedamt);

                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
        }
        catch (MySqlException ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "SaveQuotationData(" + clientcustomerid + "," + clientquoteid + "," + clientcustomeruser + "," + clientquotedproduct + "," + clientquotedprodqty + "," + clientquotedprice + "," + clientquotedamt + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
        }

    }

    //created reloaded method as chaged for inserting multiple products at one go.
    public static void SaveQuotationData(Decimal clientcustomerid, Decimal clientquoteid, Decimal clientcustomeruser, String XML)
    {
        string connectionstring = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        MySqlConnection conn = new MySqlConnection(connectionstring); ;
        try
        {
            conn = new MySqlConnection(connectionstring);
            conn.Open();
            using (MySqlCommand cmd = new MySqlCommand("usp_SaveQuotation", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@client_customer_id", clientcustomerid);
                cmd.Parameters.AddWithValue("@client_quotation_date", DateTime.Now.ToString("yyyy-MM-dd"));
                cmd.Parameters.AddWithValue("@client_quotation_id", clientquoteid);
                cmd.Parameters.AddWithValue("@client_customer_user", clientcustomeruser);
                cmd.Parameters.AddWithValue("@ptblProduct", XML);
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
        }
        catch (MySqlException ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "SaveQuotationData(" + clientcustomerid + "," + clientquoteid + "," + clientcustomeruser + "," + XML +")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
        }

    }

    // Update Closed on date & final amount when status changed to "Closed".
    public static void UpdateClosedOnDate(Decimal client_alias, Decimal clientcustomerid, Decimal closed_amount, String closed_on_date)
    {
        string connectionstring = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        MySqlConnection conn = new MySqlConnection(connectionstring); ;
        try
        {

            conn = new MySqlConnection(connectionstring);
            conn.Open();
            using (MySqlCommand cmd = new MySqlCommand("usp_UpdateClosedOnDate", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@client_alias", client_alias);
                cmd.Parameters.AddWithValue("@client_customer_id", clientcustomerid);
                cmd.Parameters.AddWithValue("@client_final_closed_amt", closed_amount);
                cmd.Parameters.AddWithValue("@client_closed_on_date", closed_on_date);
                
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
        }
        catch (MySqlException ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "UpdateClosedOnDate(" + client_alias + "," + clientcustomerid + "," + closed_amount + "," + closed_on_date + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
        }

    }

    public static void SaveProdAssignment(Decimal userid, String prodname, Decimal prodamttgt, Decimal prodqtytgt, String prodtgtmth, String prodtgtyr)
    {
        string connectionstring = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        
        MySqlConnection conn = new MySqlConnection(connectionstring); ;
        try
        {

            conn = new MySqlConnection(connectionstring);
            conn.Open();
            using (MySqlCommand cmd = new MySqlCommand("save_prod_assignment", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@client_customer_user", userid);
                cmd.Parameters.AddWithValue("@client_customer_product", prodname);
                cmd.Parameters.AddWithValue("@client_user_amt_target", prodamttgt);
                cmd.Parameters.AddWithValue("@client_user_prod_target", prodqtytgt);
                cmd.Parameters.AddWithValue("@client_target_month", prodtgtmth);
                cmd.Parameters.AddWithValue("@client_target_year", prodtgtyr);

                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
        }
        catch (MySqlException ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "SaveProdAssignment(" + userid + "," + prodname + "," + prodamttgt + "," + prodqtytgt + "," + prodtgtmth + "," + prodtgtyr + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }

        }

    }

    // Save/Update Daily Call Report. 
    public static void SaveDCR(String clientdate, String company, String firstname, String occupation, String primarycontact, String website, Decimal erevenue, String followupdate,
        String companyadd1, String companyadd2, String addresscity, String addressdist, String addressstate, String addresscountry, Decimal pincode, String remarks, Decimal assignedto,
        String companytype, String lastname, String email, Decimal alternatecontact, String status, String source, String saddress1, String saddress2, String scity, String sdistrict,
        String sstate, String scountry, Decimal spincode, String Mode, Decimal clientcustomerid)
    {
        string connectionstring = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        decimal NewSalesCustID = VPCRMSDAL.AssignClientCustomerID();
        MySqlConnection conn = new MySqlConnection(connectionstring);
        try
        {

            conn = new MySqlConnection(connectionstring);
            conn.Open();
            
            using (MySqlCommand cmd = new MySqlCommand("save_sales_master", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                 
                cmd.Parameters.AddWithValue("@client_alias", Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0,4)));
                cmd.Parameters.AddWithValue("@client_user", assignedto);
                if (Mode == "Update")
                {
                    cmd.Parameters.AddWithValue("@client_customer_id", clientcustomerid);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@client_customer_id", NewSalesCustID);
                }
                cmd.Parameters.AddWithValue("@client_customer_name", company);
                cmd.Parameters.AddWithValue("@client_customer_pamt", erevenue);
                cmd.Parameters.AddWithValue("@client_customer_famt", 0);
                cmd.Parameters.AddWithValue("@client_customer_status", status);
                cmd.Parameters.AddWithValue("@client_customer_add1", companyadd1);
                cmd.Parameters.AddWithValue("@client_customer_add2", companyadd2);
                cmd.Parameters.AddWithValue("@client_customer_city", addresscity);
                cmd.Parameters.AddWithValue("@client_customer_district", addressdist);
                cmd.Parameters.AddWithValue("@client_customer_state", addressstate);
                cmd.Parameters.AddWithValue("@client_customer_country", addresscountry);
                cmd.Parameters.AddWithValue("@client_customer_pincode", pincode);
                cmd.Parameters.AddWithValue("@client_customer_emailid", email);
                cmd.Parameters.AddWithValue("@client_customer_pri_contact", primarycontact);
                cmd.Parameters.AddWithValue("@client_customer_alt_contact", alternatecontact);
                cmd.Parameters.AddWithValue("@client_customer_gstn", " ");
                cmd.Parameters.AddWithValue("@client_customer_reg_date", clientdate);
                cmd.Parameters.AddWithValue("@client_customer_type", companytype);
                cmd.Parameters.AddWithValue("@client_customer_website", website);
                cmd.Parameters.AddWithValue("@client_customer_shipadd1", saddress1);
                cmd.Parameters.AddWithValue("@client_customer_shipadd2", saddress2);
                cmd.Parameters.AddWithValue("@client_customer_shipcity", scity);
                cmd.Parameters.AddWithValue("@client_customer_shipdist", sdistrict);
                cmd.Parameters.AddWithValue("@client_customer_shipstat", sstate);
                cmd.Parameters.AddWithValue("@client_customer_shipcnty", scountry);
                cmd.Parameters.AddWithValue("@client_customer_shippin", spincode);
                cmd.Parameters.AddWithValue("@client_customer_shipsame", "Y");
                cmd.Parameters.AddWithValue("@client_last_modified_date", clientdate);
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
        }
        catch (MySqlException ex)
        {
            
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
            
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
        }

        // Save/Update DCR Details
        MySqlConnection conn1 = new MySqlConnection(connectionstring);
        try
        {

            conn1 = new MySqlConnection(connectionstring);
            conn1.Open();
            using (MySqlCommand cmd1 = new MySqlCommand("save_sales_details", conn1))
            {
                cmd1.CommandType = CommandType.StoredProcedure;
                if (Mode == "Update")
                {
                    cmd1.Parameters.AddWithValue("@client_customer_id", clientcustomerid);
                }
                else
                {
                    cmd1.Parameters.AddWithValue("@client_customer_id", NewSalesCustID);
                }
                cmd1.Parameters.AddWithValue("@client_customer_status", status);

                cmd1.Parameters.AddWithValue("@client_customer_old_status", String.Empty);
                cmd1.Parameters.AddWithValue("@client_customer_user", assignedto);
                cmd1.Parameters.AddWithValue("@client_customer_visit_date", clientdate);
                cmd1.Parameters.AddWithValue("@client_customer_followup_date", followupdate);
                cmd1.Parameters.AddWithValue("@client_customer_followup_person_fn", firstname);
                cmd1.Parameters.AddWithValue("@client_customer_followup_person_ln", lastname);
                cmd1.Parameters.AddWithValue("@client_customer_followup_person_desgn", String.Empty);
                cmd1.Parameters.AddWithValue("@client_customer_folloup_email", email);
                cmd1.Parameters.AddWithValue("@client_customer_followup_done", String.Empty);
                cmd1.Parameters.AddWithValue("@client_customer_source", source);
                cmd1.Parameters.AddWithValue("@client_customer_remarks", remarks);
                cmd1.Parameters.AddWithValue("@client_customer_quoteid", Decimal.Zero);
                cmd1.Parameters.AddWithValue("@client_customer_quotedprod1", String.Empty);
                cmd1.Parameters.AddWithValue("@client_customer_quotedprodqty1", Decimal.Zero);
                cmd1.Parameters.AddWithValue("@client_customer_quoteprice1", Decimal.Zero);
                cmd1.Parameters.AddWithValue("@client_customer_quoteamt1", Decimal.Zero);
                cmd1.ExecuteNonQuery();
                cmd1.Dispose();
            }
        }
        catch (MySqlException ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn1.State == ConnectionState.Open)
            {
                conn1.Close();
                conn1.Dispose();
            }
        }

        // Update Closed On Date & Closed on amount in Sales Master. 
        if (status == "Closed")
        {
            VPCRMSDAL.UpdateClosedOnDate(Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)), clientcustomerid, erevenue, Convert.ToString(DateTime.Today.ToString("yyyy-MM-dd")));
        }

    }

    // Save/Update User details. 
    public static void SaveUserDetails(Decimal alias, String username, String password, String firstname, 
        String lastname, String doj, Decimal contactno, String emailid, String role, String defaultpwd, String mode, String userid)
    {
        string connectionstring = ConfigurationManager.ConnectionStrings["SQLConnectionVPCS"].ToString();
        decimal NewUserID = VPCRMSDAL.AssignNewUserID(alias);

        MySqlConnection conn = new MySqlConnection(connectionstring); ;
        try
        {

            conn = new MySqlConnection(connectionstring);
            conn.Open();
            using (MySqlCommand cmd = new MySqlCommand("usp_SaveClientUserDetails", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@client_alias", alias);
                if (mode == "Insert")
                {
                    cmd.Parameters.AddWithValue("@client_user_id", NewUserID);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@client_user_id", userid);
                }
                cmd.Parameters.AddWithValue("@client_user_name", username);
                cmd.Parameters.AddWithValue("@client_password", password);
                cmd.Parameters.AddWithValue("@client_user_firstname", firstname);
                cmd.Parameters.AddWithValue("@client_user_lastname", lastname);
                cmd.Parameters.AddWithValue("@client_user_doj", doj);
                cmd.Parameters.AddWithValue("@client_user_contact_no", contactno);
                cmd.Parameters.AddWithValue("@client_user_emailid", emailid);
                cmd.Parameters.AddWithValue("@client_user_role", role);
                cmd.Parameters.AddWithValue("@client_user_default_password", defaultpwd);

                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
        }
        catch (MySqlException ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }

        }

    }

    // Update default password for user & default password flag. 
    public static void UdpateUserPassword(Decimal alias, Decimal userid, String password)
    {
        string connectionstring = ConfigurationManager.ConnectionStrings["SQLConnectionVPCS"].ToString();
        MySqlConnection conn = new MySqlConnection(connectionstring); ;
        try
        {

            conn = new MySqlConnection(connectionstring);
            conn.Open();
            using (MySqlCommand cmd = new MySqlCommand("usp_UpdateDefaultPassword", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@client_user_alias", alias);
                cmd.Parameters.AddWithValue("@client_user_id", userid);
                cmd.Parameters.AddWithValue("@client_user_password", password);
                
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
        }
        catch (MySqlException ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }

        }

    }

    // Get existing user details
    public static DataTable GetUserDetails(Decimal userid)
    {
        string connectionstring = ConfigurationManager.ConnectionStrings["SQLConnectionVPCS"].ToString();
        DataTable dt = new DataTable();
        MySqlConnection conn = new MySqlConnection(connectionstring);
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_EditModalUserDetails", conn);
            dCmd.Parameters.AddWithValue("@UserID", userid);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }

    public static DataTable GetStatusCount(Decimal userid, String user_role)
    {
        DataTable dt = new DataTable();
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        MySqlConnection conn = new MySqlConnection(connectionstring_crms);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_StatusCountReport", conn);
            dCmd.Parameters.AddWithValue("@client_userid", userid);
            dCmd.Parameters.AddWithValue("@client_role", user_role);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "GetStatusCount(" + userid + "," + user_role + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }

    public static DataTable GetReportData(String fromdate, String todate, Decimal userid, String role)
    {
        DataTable dt = new DataTable();
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        MySqlConnection conn = new MySqlConnection(connectionstring_crms);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_GetReportData", conn);
            dCmd.Parameters.AddWithValue("@client_report_fromdate", fromdate);
            dCmd.Parameters.AddWithValue("@client_report_todate", todate);
            dCmd.Parameters.AddWithValue("@client_report_userid", userid);
            dCmd.Parameters.AddWithValue("@client_report_role", role);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }

    public static DataTable GetReportDataSalesDetails(String fromdate, String todate, Decimal userid, String role, String status)
    {
        DataTable dt = new DataTable();
        string connectionstring_crms = HttpContext.Current.Session["ConnectionStringCRMS"].ToString().Trim();
        MySqlConnection conn = new MySqlConnection(connectionstring_crms);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_GetReportDataSalesDetails", conn);

            dCmd.Parameters.AddWithValue("@client_report_fromdate", fromdate);
            dCmd.Parameters.AddWithValue("@client_report_todate", todate);
            dCmd.Parameters.AddWithValue("@client_report_userid", userid);
            dCmd.Parameters.AddWithValue("@client_report_role", role);
            dCmd.Parameters.AddWithValue("@client_report_status", status);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL method: " + "GetReportDataSalesDetails(" + fromdate + "," + todate + "," + userid + "," + role + "," + status + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }
    public static DataTable CheckUserName(string UserName)
    {
        string connectionstring = ConfigurationManager.ConnectionStrings["SQLConnectionVPCS"].ToString();
        DataTable dt = new DataTable();

        MySqlConnection conn = new MySqlConnection(connectionstring);
        
        MySqlCommand dCmd;
        DataTable dtUsers = new DataTable();

        try
        {
            conn.Open();
            dCmd = new MySqlCommand("usp_CheckUserName", conn);
            dCmd.Parameters.AddWithValue("@UserName", UserName);
            dCmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter daUsers = new MySqlDataAdapter(dCmd);
            daUsers.Fill(dt);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error("For Client Alias: " + Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
            logger.Error("For DAL Method: " + "CheckUserName(" + UserName + ")");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
            }
            dCmd = null;
        }
        return dt;
    }
}