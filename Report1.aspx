<%@ Page Language="C#" MasterPageFile="~/VPCRMSMaster.master" AutoEventWireup="true" CodeFile="Report1.aspx.cs" Inherits="Report1" %>

<%@ Register Assembly="OnlinePdfViewer" Namespace="OnlinePdfViewer" TagPrefix="PdfViewer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   
    <div class="page-title">
        <div class=" col-md-10 title-env">
            <h1 class="title">Report</h1>
            <ol class="breadcrumb bc-1">
                <li>
                    <a href="/Dashboard.aspx">Dashboard</a>
                </li>
                <li class="active">
                    <strong>Report1</strong>
                </li>
            </ol>
            <h2 class="epg-tit">
                <asp:Label ID="lblCompanyName" runat="server"></asp:Label>
            </h2>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default blue-box">
                <div class="panel-heading">
                    <h3 class="panel-title">Report
                    </h3>
                    <div class="panel-options"><a href="#" data-toggle="panel"><span class="collapse-icon">–</span> <span class="expand-icon">+</span> </a></div>
                </div>
                <div class="panel-body">
                    <div class="col-md-2 pull-right">
                        <asp:Button ID="btnGenerate" class="btn btn-info pull-right" Text="Generate" runat="server" OnClick="btnGenerate_Click" />
                        <asp:Button ID="btnSend" class="btn btn-info pull-right" Text="Send" runat="server" OnClick="btnSend_Click" />
                    </div>
                </div>

                <div class="panel-body">
                    <PdfViewer:DisplayPdf ID="displaypdf" runat="server" BorderStyle="Inset" BorderWidth="2px" Style="height: 500px;" Width="800px" Visible="false" ></PdfViewer:DisplayPdf>
                </div>
            </div>
        </div>
    </div>
    <!--main-content-ends-->
</asp:Content>
