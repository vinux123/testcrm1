﻿<%@ Page Language="C#" MasterPageFile="~/VPCRMSMaster.master" AutoEventWireup="true" CodeFile="Report1.aspx.cs" Inherits="Report1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<script type="text/javascript">
    jQuery(document).ready(function ($) {
        $("#btnGenerate").click(function (e) {
            //debugger;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Report1.aspx/GetReportData",
                dataType: "json",
                success: function (data) {
                    data = "Testing";
                    var openpdf = $('<a id="openpdf" download="Report.pdf" href="data:apploication/pdf;base64,' + data + '" target="_blank">');
                    $('body').append(openpdf);
                    document.getElementById("openpdf").click();
                    $("#openpdf").remove();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("some error");
                }
            });
        });

        $('#openpdf').click(function () {
            var Nwin = window.open($(this).prop('href'), '', 'height=800,width=800');
            if (window.focus) {
                Nwin.focus();
            }
            return false;
        });
    });
</script>--%>
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
                        <%--<button type="button" class="btn btn-info pull-right" id="btnGenerate" runat="server">Generate</button>--%>
                        <asp:Button ID="btnGenerate" class="btn btn-info pull-right" Text="Generate" runat="server" OnClick="btnGenerate_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--main-content-ends-->
</asp:Content>