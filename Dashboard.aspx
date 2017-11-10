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
                            { valueField: "Count", name: "Status", color: "#FE0000" }
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
                            { valueField: "Count", name: "Status", color: "#FE0000" }
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
                            { valueField: "Count", name: "Status", color: "#FE0000" }
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
                url: "Dashboard.aspx/GetRevenueChartDetails",
                dataType: "json",
                success: function (data) {
                    var JSONDataR = $.parseJSON(data.d);
                    var dataSource = JSONDataR;
                    $("#sales-avg-chart div").dxPieChart({
                        dataSource: dataSource,
                        tooltip: {
                            enabled: true,
                            format: "number",
                            customizeText: function () {
                                return this.argumentText + "<br/>" + this.valueText;
                            }
                        },
                        size: {
                            height: 110
                        },
                        legend: {
                            visible: true
                        },
                        series: [{
                            type: "doughnut",
                            argumentField: "clientcustomerstatus"
                        }],
                        palette: ['#FE9900', '#FE0000', '#D1D1D1'],
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
    <div class="row">
    <div class="col-md-6">
        <div class="panel  panel-default blue-box">
            <div class="panel-heading">
                <h3 class="panel-title">Count by Status - Monthly</h3>
            </div>
            <div class="panel-body">
                <div id="bar-1" style="height: 260px; width: 100%;"></div>
            </div>
        </div>
    </div>
        <div class="col-md-6">
        <div class="panel  panel-default blue-box">
            <div class="panel-heading">
                <h3 class="panel-title">Count by Status - Yearly</h3>
            </div>
            <div class="panel-body">
                <div id="bar-3" style="height: 260px; width: 100%;"></div>
            </div>
        </div>
    </div>
        </div>
    <div class="row">
    <div class="col-md-6">
        <div class="panel  panel-default blue-box">
            <div class="panel-heading">
                <h3 class="panel-title">Revenue by Status - Monthly</h3>
            </div>
            <div class="panel-body">
                <div class="chart-label chart-label-small">
                    <%--<div class="chart-item-bg">
                            <div class="h4 text-secondary text-bold" data-count="this" data-from="0.00" data-to="320.45" data-decimal="," data-duration="2">0</div>
                            <span class="text-small text-upper text-muted">Avg. of Sales</span> </div>--%>
                <div id="sales-avg-chart" style="height: 134px; position: relative;">
                            <div style="position: absolute; top: 25px; right: 0; left: 40%; bottom: 0"></div>
                        </div></div>
            </div>
        </div>
    </div>
        <div class="col-md-6">
        <div class="panel  panel-default blue-box">
            <div class="panel-heading">
                <h3 class="panel-title">Revenue by Status - Yearly</h3>
            </div>
            <div class="panel-body">
                <div class="chart-label chart-label-small">
                    <%--<div class="chart-item-bg">
                            <div class="h4 text-secondary text-bold" data-count="this" data-from="0.00" data-to="320.45" data-decimal="," data-duration="2">0</div>
                            <span class="text-small text-upper text-muted">Avg. of Sales</span> </div>--%>
                <div id="sales-avg-chart" style="height: 134px; position: relative;">
                            <div style="position: absolute; top: 25px; right: 0; left: 40%; bottom: 0"></div>
                        </div></div>
            </div>
        </div>
    </div>
        </div>
    <!-- Imported scripts on this page -->
    <script src="assets/js/devexpress-web-14.1/js/globalize.min.js"></script>
    <script src="assets/js/devexpress-web-14.1/js/dx.chartjs.js"></script>
</asp:Content>
