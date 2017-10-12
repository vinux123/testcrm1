<%@ Page Language="C#" MasterPageFile="~/VPCRMSMaster.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<script type="text/javascript">
    jQuery(document).ready(function ($) {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "Dashboard.aspx/GetMonthlyData",
            dataType: "json",
            success: function (data) {
                var JSONDataR = $.parseJSON(data.d);
                var dataSource = JSONDataR;
                $("#bar-1").dxChart({
                    dataSource: dataSource,
                    commonSeriesSettings: {
                        argumentField: "Type"
                    },
                    series: [
                        { valueField: "Count", name: "Status", color: "#40bbea" }
                    ],
                    argumentAxis: {
                        grid: {
                            visible: true
                        }
                    },
                    tooltip: {
                        enabled: true
                    },
                    title: "",
                    legend: {
                        verticalAlignment: "bottom",
                        horizontalAlignment: "center"
                    },
                    commonPaneSettings: {
                        border: {
                            visible: true,
                            right: false
                        }
                    }
                });
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("some error");
            }
        });

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "Dashboard.aspx/GetHalfYearlyData",
            dataType: "json",
            success: function (data) {
                var JSONDataR = $.parseJSON(data.d);
                var dataSource = JSONDataR;
                $("#bar-2").dxChart({
                    dataSource: dataSource,
                    commonSeriesSettings: {
                        argumentField: "Type"
                    },
                    series: [
                        { valueField: "Count", name: "Status", color: "#40bbea" }
                    ],
                    argumentAxis: {
                        grid: {
                            visible: true
                        }
                    },
                    tooltip: {
                        enabled: true
                    },
                    title: "",
                    legend: {
                        verticalAlignment: "bottom",
                        horizontalAlignment: "center"
                    },
                    commonPaneSettings: {
                        border: {
                            visible: true,
                            right: false
                        }
                    }
                });
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("some error");
            }
        });

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "Dashboard.aspx/GetYearlyData",
            dataType: "json",
            success: function (data) {
                var JSONDataR = $.parseJSON(data.d);
                var dataSource = JSONDataR;
                $("#bar-3").dxChart({
                    dataSource: dataSource,
                    commonSeriesSettings: {
                        argumentField: "Type"
                    },
                    series: [
                        { valueField: "Count", name: "Status", color: "#40bbea" }
                    ],
                    argumentAxis: {
                        grid: {
                            visible: true
                        }
                    },
                    tooltip: {
                        enabled: true
                    },
                    title: "",
                    legend: {
                        verticalAlignment: "bottom",
                        horizontalAlignment: "center"
                    },
                    commonPaneSettings: {
                        border: {
                            visible: true,
                            right: false
                        }
                    }
                });
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("some error");
            }
        });
    });
</script>
   <div class="page-title">
        <div class=" col-md-10 title-env">
            <h2 class="title">Dashboard</h2>
            <ol class="breadcrumb bc-1">
                <li>
                    <a href="/Dashboard.aspx">Dashboard</a>
                </li>
                
            </ol>
            <h2 class="epg-tit">
                <asp:Label ID="lblCompanyName" runat="server"></asp:Label>
            </h2>
        </div>
    </div>
    
     <div class="col-md-12">
          <div class="panel  panel-default blue-box">
           <div class="panel-heading">
            <h3 class="panel-title">Monthly</h3>
            </div>
          <div class="panel-body">
            <div id="bar-1" style="height: 260px; width: 100%;"></div>
          </div>
          </div>
       </div>   
    <%--<div class="col-md-12">
          <div class="panel  panel-default blue-box">
           <div class="panel-heading">
            <h3 class="panel-title">Half Yearly</h3>
            </div>
          <div class="panel-body">
            <div id="bar-2" style="height: 260px; width: 100%;"></div>
          </div>
          </div>
       </div>   --%>
    <div class="col-md-12">
          <div class="panel  panel-default blue-box">
           <div class="panel-heading">
            <h3 class="panel-title">Yearly</h3>
            </div>
          <div class="panel-body">
            <div id="bar-3" style="height: 260px; width: 100%;"></div>
          </div>
          </div>
       </div>   
    

<!-- Imported scripts on this page --> 
<script src="assets/js/devexpress-web-14.1/js/globalize.min.js"></script> 
<script src="assets/js/devexpress-web-14.1/js/dx.chartjs.js"></script> 
</asp:Content>
