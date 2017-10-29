<%@ Page Language="C#" MasterPageFile="~/VPCRMSMaster.master" AutoEventWireup="true" CodeFile="ErrorPage.aspx.cs" Inherits="ErrorPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row error_pagewrap">
        <div class="col-md-12 text-center error_content" style="margin: 10% auto;">
            <img src="assets/images/error_icon.png">
            <h1>Something Went Wrong!</h1>
            <h4>Sorry, please contact administrator!</h4>
            <%--<button class="btn btn-info "><i class="fa fa-mail-reply"></i>Return to last page</button>--%>
        </div>
    </div>
</asp:Content>