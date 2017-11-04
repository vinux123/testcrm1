<%@ Page Language="C#" MasterPageFile="~/VPCRMSMaster.master" AutoEventWireup="true" CodeFile="Forecasting.aspx.cs" Inherits="Forecasting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        #fullpageloading {
            background-color: Gray;
            opacity: 0.5;
            cursor: auto;
            width: 100%;
            height: 100%;
            z-index: 15; /* Positioning */
            position: absolute;
            left: 0;
            top: 0;
            vertical-align: middle;
            text-align: center;
            display: none;
        }
    </style>
    <script type="text/javascript">
        jQuery(document).ready(function ($) {
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnShow").click(function () {
                $("#grdForecasting").html("");
                debugger;
                var status = $('#ddlstatus option:selected').val();
                var assignedto = $('#ddlassignedto option:selected').val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Forecasting.aspx/GetForecastingReportDetails",
                    data: "{'status': '" + status + "', 'assignedto': '" + assignedto + "'}",
                    dataType: "json",
                    beforeSend: function () {
                        $('#fullpageloading').show()
                    },
                    complete: function () {
                        $('#fullpageloading').hide();
                    },
                    success: function (data) {
                        var finaldata = "<table class='table table-striped table-bordered' border='1' id='grdForecasting' style='border-collapse: collapse;'><tr><th>Client Name</th><th>Assigned To</th><th>Status</th></tr>";
                        var JSONDataR = $.parseJSON(data.d);
                        for (var i = 0; i < JSONDataR.length; i++) {
                            finaldata = finaldata + '<tr><td>' + JSONDataR[i].clientcustomername + '</td><td>' + JSONDataR[i].clientuserfirstname + '</td><td>' + JSONDataR[i].customerstatus + '</td></tr>';
                        }
                        finaldata = finaldata + '</table>';
                        $("#Grid").html("");
                        //var oTable = $("#grdForecasting");
                        //oTable.dataTable().fnDestroy();    // destroy the old datatable
                        $("#Grid").append(finaldata);
                        fixGridView($("#grdForecasting"));
                        $("#grdForecasting").dataTable({
                            aLengthMenu: [
                                [5, 10, 15, 20, 25, 50, 100, -1], [5, 10, 15, 20, 25, 50, 100, "All"]
                            ]
                        });

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        Console.log(errorThrown);
                        return false;
                    }
                });

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Forecasting.aspx/GetForecastingChartDetails",
                    data: "{'status': '" + status + "', 'assignedto': '" + assignedto + "'}",
                    dataType: "json",
                    beforeSend: function () {
                        $('#fullpageloading').show()
                    },
                    complete: function () {
                        $('#fullpageloading').hide();
                    },
                    success: function (data) {
                        var JSONDataR = $.parseJSON(data.d);
                        var dataSource = JSONDataR;
                        $("#bar-5").dxChart({
                            equalBarWidth: false,
                            dataSource: dataSource,
                            commonSeriesSettings: {
                                argumentField: "state",
                                type: "bar"
                            },
                            series: [
                                { valueField: "Prospect", name: "Prospect", color: "#0e62c7" },
                                { valueField: "Qualified", name: "Qualified", color: "#2c2e2f" },
                                { valueField: "JunkLost", name: "JunkLost", color: "#7c38bc" },
                            { valueField: "Closed", name: "Closed", color: "#5f38bd" }
                            ],
                            tooltip: {
                                enabled: true
                            },
                            legend: {
                                verticalAlignment: "bottom",
                                horizontalAlignment: "center"
                            },
                            title: "Sales Forecasting"
                        });


                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        Console.log(errorThrown);
                        return false;
                    }
                });
            });
        });

        //    });
        //});

        function fixGridView(tableEl) {
            var jTbl = $(tableEl);
            if (jTbl.find("tbody>tr>th").length > 0) {
                jTbl.find("tbody").before("<thead><tr></tr></thead>");
                jTbl.find("thead tr").append(jTbl.find("th"));
                jTbl.find("tbody tr:first").remove();
            }
        }
    </script>
    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            $("#ddlstatus").select2({
                placeholder: 'Select Status...',
                allowClear: true
            }).on('select2-open', function () {
                // Adding Custom Scrollbar
                $(this).data('select2').results.addClass('overflow-hidden').perfectScrollbar();
            });

            $("#ddlassignedto").select2({
                placeholder: 'Select Assignedto...',
                allowClear: true
            }).on('select2-open', function () {
                // Adding Custom Scrollbar
                $(this).data('select2').results.addClass('overflow-hidden').perfectScrollbar();
            });
        });
    </script>
    <div class="page-title">
        <div class=" col-md-10 title-env">
            <h1 class="title">Sales Forecasting</h1>
            <ol class="breadcrumb bc-1">
                <li>
                    <a href="/Dashboard.aspx">Dashboard</a>
                </li>
                <li class="active">

                    <strong>Sales Forecasting</strong>
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
                    <h3 class="panel-title">Forecasting
       
                    </h3>
                    <div class="panel-options"><a href="#" data-toggle="panel"><span class="collapse-icon">–</span> <span class="expand-icon">+</span> </a></div>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="control-label">Select Status</label>
                                <script type="text/javascript">
                                    jQuery(document).ready(function ($) {
                                        $("#ddlstatus").selectBoxIt().on('open', function () {
                                            // Adding Custom Scrollbar
                                            $(this).data('selectBoxSelectBoxIt').list.perfectScrollbar();
                                        });
                                    });
                                </script>
                                <label class="control-label" for="status"></label>
                                <asp:DropDownList ID="ddlstatus" runat="server" CssClass="form-control" ClientIDMode="Static">
                                    <asp:ListItem Value="0" Text="Select Status"></asp:ListItem>
                                    <asp:ListItem Value="Prospect" Text="Prospect"></asp:ListItem>
                                    <asp:ListItem Value="Qualified" Text="Qualified"></asp:ListItem>
                                    <asp:ListItem Value="JunkLost" Text="Junk/Lost"></asp:ListItem>
                                    <asp:ListItem Value="Closed" Text="Closed"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class=" control-label" for="customeruser1">Assigned To</label>
                                <asp:DropDownList ID="ddlassignedto" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2 pull-right">
                            <button type="button" id="btnShow" class="btn btn-info pull-right">Show</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12" id="Grid">
                            <%--<table class="table table-striped table-bordered" border="1" id="grdForecasting" style="border-collapse: collapse;"></table>--%>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div id="bar-5" style="height: 260px; width: 100%; -moz-user-select: none;" class="dx-visibility-change-handler">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--main-content-ends-->
    <div id="fullpageloading">
        <div style="margin: 20%">
            <img alt="loading" src="Images/fullpageloadingimg2.gif" />
        </div>
    </div>
    <!-- Imported scripts on this page -->
    <script src="assets/js/devexpress-web-14.1/js/globalize.min.js"></script>
    <script src="assets/js/devexpress-web-14.1/js/dx.chartjs.js"></script>

</asp:Content>
