

<%@ Page Language="C#" MasterPageFile="~/VPCRMSMaster.master" AutoEventWireup="true" CodeFile="FollowUp.aspx.cs" Inherits="FollowUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        #fullpageloading
        {
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
            fixGridView($("#grdFollowUp"));

            $.ajax({
                type: "POST",
                url: "Followup.aspx/GetFollowupDetails",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $('#fullpageloading').show()
                },
                complete: function () {
                    $('#fullpageloading').hide();
                },
                success: function (data) {
                    var finaldata = "<tr><th>Client ID</th><th>Client Name</th><th>Follow Up Date</th><th>Contact Number</th><th>Email ID</th><th>Assigned To</th><th>Status</th></tr>";
                    var JSONDataR = $.parseJSON(data.d);
                    for (var i = 0; i < JSONDataR.length; i++) {
                        var date1 = new Date(parseInt(JSONDataR[i].custfollowupdate.replace('/Date(', ''))).toISOString();
                        finaldata = finaldata + '<tr><td>' + JSONDataR[i].clientcustomerid + '</td><td>' + JSONDataR[i].clientcustomername + '</td><td>' + date1.substring(0, 10) + '</td><td>' + JSONDataR[i].clientcustomerpcontact + '</td><td>' + JSONDataR[i].clientcustomeremailid + '</td><td>' + JSONDataR[i].customeruser + '</td><td>' + JSONDataR[i].customerstatus + '</td></tr>';
                    }
                    $("#grdFollowUp").append(finaldata);
                    fixGridView($("#grdFollowUp"));
                    $("#grdFollowUp").dataTable({
                        aLengthMenu: [
                            [5, 10, 15, 20, 25, 50, 100, -1], [5, 10, 15, 20, 25, 50, 100, "All"]
                        ],
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
        });

        function fixGridView(tableEl) {
            var jTbl = $(tableEl);
            if (jTbl.find("tbody>tr>th").length > 0) {
                jTbl.find("tbody").before("<thead><tr></tr></thead>");
                jTbl.find("thead tr").append(jTbl.find("th"));
                jTbl.find("tbody tr:first").remove();
            }
        }
    </script>
    <div class="page-title">
        <div class=" col-md-10 title-env">
            <h1 class="title">Follow Up</h1>
            <ol class="breadcrumb bc-1">
                <li>
                    <a href="/Dashboard.aspx">Dashboard</a>
                </li>
                <li class="active">
                    <strong>Follow Up</strong>
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
                    <h3 class="panel-title">Follow Up
       
                    </h3>
                    <div class="panel-options"><a href="#" data-toggle="panel"><span class="collapse-icon">–</span> <span class="expand-icon">+</span> </a></div>
                </div>
                <div class="panel-body">

                    <div class="row">
                        <div class="col-md-12">
                            <table class="table table-striped table-bordered" border="1" id="grdFollowUp" style="border-collapse: collapse;">
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--main-content-ends-->
    <div id="fullpageloading">
        <div style="margin: 20%">
            <img alt="loading" src="Images/fullpageloadingimg2.gif"  />
        </div>
    </div>
</asp:Content>
