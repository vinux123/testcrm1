﻿

<%@ Page Language="C#" MasterPageFile="~/VPCRMSMaster.master" AutoEventWireup="true" CodeFile="FollowUp.aspx.cs" Inherits="FollowUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            fixGridView($("#grdFollowUp"));
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
    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            $("#grdFollowUp").dataTable({
                aLengthMenu: [
                    [25, 50, 100, -1], [25, 50, 100, "All"]
                ]
            });
        });
	</script>

    <div class="page-title">
        <div class=" col-md-10 title-env">
            <h1 class="title">Follow Up</h1>
            <ol class="breadcrumb bc-1">
                <li>

                    <%--<a href="ui-panels.html">Admin </a>--%>
                    <a href="/Dashboard.aspx">Dashboard</a>
                </li>
                <li class="active">

                    <strong>Follow Up</strong>
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
                    <h3 class="panel-title">Follow Up
       
                    </h3>
                    <div class="panel-options"><a href="#" data-toggle="panel"><span class="collapse-icon">–</span> <span class="expand-icon">+</span> </a></div>
                </div>
                <div class="panel-body">

                    <div class="row">
                        <div class="col-md-12">
                            <asp:GridView ID="grdFollowUp" class="table table-striped table-bordered" cellspacing="0" width="100%" runat="server" 
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
                                    <asp:BoundField HeaderText="Follow Up Date" DataField="custfollowupdate">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Contact Number" DataField="clientcustomerpcontact">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Email ID" DataField="clientcustomeremailid">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Assigned To" DataField="customeruser">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>    
                                    <asp:BoundField HeaderText="Status" DataField="customerstatus">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>   
                                    <asp:TemplateField HeaderStyle-Width="10%">
                        <%--<ItemTemplate>
                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" CommandArgument='<%# Eval("clientcustomerid") %>'
                                Text="Edit" class="btn btn-info"/>
                        </ItemTemplate>--%>
                    </asp:TemplateField>   
                                    <%--<i class="fa fa-pencil"></i>--%>
                                </Columns>
                            </asp:GridView>
                            <%--<script type="text/javascript">
                    jQuery(document).ready(function ($) {
                        $("#example-1").dataTable({
                            aLengthMenu: [
								[25, 50, 100, -1], [25, 50, 100, "All"]
                            ]
                        });
                    });
					</script>
                <table id="example-1" class="table table-striped table-bordered" cellspacing="0" width="100%">
                  <thead>
                    <tr>
                      <th>Form Name</th>
                      <th>	Display Name</th>
                      <th>Action</th>
                     
                    </tr>
                  </thead>
                
                  <tbody>
                       
                    <tr>
                      <td>ChangePassword.aspx</td>
                      <td>ChangePassword</td>
                    
                      <td> <a href=""><i class="fa fa-trash"></i></a></td>
                    </tr>
                    <tr>
                      <td>AssignChannelsForCETEST1.aspx</td>
                      <td>AssignChannelsForCE</td>
                      
                      <td><a href=""><i class="fa fa-trash"></i></a></td>
                    </tr>
                    <tr>
                      <td>ChangePassword.aspx</td>
                      <td>ChangePassword</td>
                      
                      <td> <a href=""><i class="fa fa-trash"></i></a></td>
                    </tr>
                    <tr>
                      <td>VideoconFileUpload.aspx</td>
                      <td>File Upload</td>
                       
                      <td> <a href=""><i class="fa fa-trash"></i></a></td>
                    </tr>
                    <tr>
                      <td>MasterDataManagement.aspx</td>
                      <td>Animation</td>
                       
                      <td> <a href=""><i class="fa fa-trash"></i></a></td>
                    </tr>
                    <tr>
                      <td>Login_New.aspx</td>
                      <td>Animation</td>
                      
                      <td><a href=""><i class="fa fa-trash"></i></a></td>
                    </tr>
                  </tbody>
                </table>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--main-content-ends-->

</asp:Content>
