

<%@ Page Language="C#" MasterPageFile="~/VPCRMSMaster.master" AutoEventWireup="true" CodeFile="Quotation.aspx.cs" Inherits="Quotation" %>

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
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "Quotation.aspx/GetQuotationDetails",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $('#fullpageloading').show()
                },
                complete: function () {
                    $('#fullpageloading').hide();
                },
                success: function (data) {
                    var finaldata = "<tr><th>Client ID</th><th>Client Name</th><th>Visit Date</th><th>Contact Number</th><th>Quotation ID</th><th>Quotation Amount</th><th></th></tr>";
                    var JSONDataR = $.parseJSON(data.d);
                    for (var i = 0; i < JSONDataR.length; i++) {
                        var date1 = new Date(parseInt(JSONDataR[i].customervisitdate.replace('/Date(', ''))).toISOString();
                        finaldata = finaldata + '<tr><td>' + JSONDataR[i].clientcustomerid + '</td><td>' + JSONDataR[i].clientcustomername + '</td><td>' + date1.substring(0, 10) + '</td><td>' + JSONDataR[i].clientcustomerpcontact + '</td><td>' + JSONDataR[i].customerquoteid + '</td><td>' + JSONDataR[i].customerquoteamt + '</td><td><button type="button" class="btn btn-primary" id="btnGenQuotPdf" onclick="GeneratePDF(\'' + JSONDataR[i].customerquoteid + '\');">Generate PDF</button></td></tr>';
                    }
                    $("#grdQuotation").append(finaldata);
                    fixGridView($("#grdQuotation"));
                    $("#grdQuotation").dataTable({
                        aLengthMenu: [
                            [5, 10, 15, 20, 25, 50, 100, -1], [5, 10, 15, 20, 25, 50, 100, "All"]
                        ],
                        "aoColumnDefs": [
                  { 'bSortable': false, 'aTargets': [6] }
                        ]
                        ,
                        "columnDefs": [{
                            "defaultContent": "-",
                            "targets": "_all"
                        }]
                    });
                },
                error: function (data) {
                    console.log('ajax call error');
                }
            });

            fixGridView($("#grdQuotation"));
        });

        function fixGridView(tableEl) {
            var jTbl = $(tableEl);
            if (jTbl.find("tbody>tr>th").length > 0) {
                jTbl.find("tbody").before("<thead><tr></tr></thead>");
                jTbl.find("thead tr").append(jTbl.find("th"));
                jTbl.find("tbody tr:first").remove();
            }
        }

        function GeneratePDF(customerquoteid) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                
                url: "Quotation.aspx/GenerateQuotationPDF",
                data: "{'customerquoteid': '" + customerquoteid + "'}",
                dataType: "text",
                success: function (data) {
                    var data1 = $.parseJSON(data);
                    
                    $.alert({
                        title: 'PDF',
                        content: 'Quotation Generated',
                        confirmButtonClass: 'btn-primary',
                        animation: 'zoom',
                        backgroundDismiss: false,
                        confirm: function () {
                            var link = document.createElement('a');
                            link.href = '/PDF-Files/Quotation_' + data1.d + '_' + customerquoteid + '.pdf';
                            link.download = 'Quotation_' + data1.d + '_' + customerquoteid + '.pdf';
                            link.dispatchEvent(new MouseEvent('click'));
                            window.top.location = "Quotation.aspx";
                        }
                    });
                    
                    
                },

                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("some error");
                }
            });
        }
    </script>
    <%--<script type="text/javascript">
        jQuery(document).ready(function ($) {
            $("#grdQuotation").dataTable({
                aLengthMenu: [
                    [25, 50, 100, -1], [25, 50, 100, "All"]
                ]
                ,
                "columnDefs": [{
                    "defaultContent": "-",
                    "targets": "_all"
                }]
            });
        });
    </script>--%>
    <div class="page-title">
        <div class=" col-md-10 title-env">
            <h1 class="title">Quotation</h1>
            <ol class="breadcrumb bc-1">
                <li>
                    <a href="/Dashboard.aspx">Dashboard</a>
                </li>
                <li class="active">
                    <strong>Quotation</strong>
                </li>
            </ol>
            <h2 class="epg-tit"><%--Company Name--%>
                <asp:Label ID="lblCompanyName" runat="server"></asp:Label>
            </h2>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default blue-box">
                <div class="panel-heading">
                    <h3 class="panel-title">Quotation
                    </h3>
                    <div class="panel-options"><a href="#" data-toggle="panel"><span class="collapse-icon">–</span> <span class="expand-icon">+</span> </a></div>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-12">
                            <table class="table table-striped table-bordered" border="1" id="grdQuotation" style="border-collapse: collapse;">
                            </table>
                            <%--<asp:GridView ID="grdQuotation" class="table table-striped table-bordered" CellSpacing="0" Width="100%" runat="server"
                                EmptyDataText="No Records Found" ShowHeaderWhenEmpty="true" AutoGenerateColumns="False" ClientIDMode="Static">
                                <Columns>
                                    <asp:BoundField HeaderText="Client ID" DataField="clientcustomerid">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Client Name" DataField="clientcustomername">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Visit Date" DataField="customervisitdate">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Contact Number" DataField="clientcustomerpcontact">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Quotation ID" DataField="customerquoteid">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Quotation Amount" DataField="customerquoteamt">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:TemplateField ShowHeader="true">
                                        <ItemTemplate>
                                            <button type="button" class="btn btn-primary" id="btnGenQuotPdf" onclick="GeneratePDF('<%# Eval("customerquoteid") %>');">Generate PDF</button>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="fullpageloading">
        <div style="margin: 20%">
            <img alt="loading" src="Images/fullpageloadingimg2.gif"  />
        </div>
    </div>
    <!--main-content-ends-->
</asp:Content>
