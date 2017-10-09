<%@ Page Language="C#" MasterPageFile="~/VPCRMSMaster.master" AutoEventWireup="true" CodeFile="UserMaster.aspx.cs" Inherits="UserMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            fixGridView($("#grdUserMaster"));
        });

        function fixGridView(tableEl) {
            var jTbl = $(tableEl);
            if (jTbl.find("tbody>tr>th").length > 0) {
                jTbl.find("tbody").before("<thead><tr></tr></thead>");
                jTbl.find("thead tr").append(jTbl.find("th"));
                jTbl.find("tbody tr:first").remove();
            }
        }

        function ValidateModal() {
            if ($('#txtusername').val().length <= 0) {
                $('#errorMessage').text("Please Enter User Name");
                return false;
            }
            else return true;
        }

        function EditUser(UserID) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "UserMaster.aspx/EditUserData",
                data: "{'userid': '" + UserID + "'}",
                dataType: "json",
                success: function (data) {
                    var JsonData = data.d;
                    var JSONDataR = $.parseJSON(JsonData);
                    $.each(JSONDataR, function (index, val) {
                        $('#txtuserid').val(val.clientuserid);
                        $('#txtusername').val(val.clientusername);
                        $('#txtpassword').prop("disabled", true);
                        $('#txtrepassword').prop("disabled", true);
                        $('#txtfirstname').val(val.clientuserfirstname);
                        $('#txtlastname').val(val.clientuserlastname);
                        $('#txtdoj').val(val.clientuserdoj);
                        $('#txtcontactno').val(val.clientusercontactno);
                        $('#txtemailid').val(val.clientuseremailid);
                        $('#ddlrole option:selected').val(val.clientuserrole);
                        $('#btnSubmit').attr('value', 'Update');
                        $('.modal').on('show.bs.modal', function (event) {
                            $('.modal').insertAfter($('body'));
                        });
                        $('.modal').modal('show');
                    });
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("some error");
                }
            });
        }
    </script>
    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            $("#grdUserMaster").dataTable({
                aLengthMenu: [
                    [25, 50, 100, -1], [25, 50, 100, "All"]
                ],
                "aoColumnDefs": [
          { 'bSortable': false, 'aTargets': [7] }
                ]
            });

            $("#ddlrole").select2({
                placeholder: 'Select Role...',
                allowClear: true
            }).on('select2-open', function () {
                // Adding Custom Scrollbar
                $(this).data('select2').results.addClass('overflow-hidden').perfectScrollbar();
            });

        });
    </script>
    <script type="text/javascript">
        $(function () {
            //attach listner to .modal-close-btn so that when button is pressed the modal dialogue disappears
            $('body').on('click', '.modal-close-btn', function () {
                $('#modal-container').modal('hide');
            });

            //clear modal cache so that new contenet can be loaded
            $('#modal-container').on('hidden.bs.modal', function () {
                $(this).removeData('bs.modal');
            });

            $('#CancelModal').on('click', function () {
                return false;
            });
        });
    </script>
    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            $("#btnAddUser").click(function (e) {
                debugger;
                $('.modal').on('show.bs.modal', function (event) {
                    $('.modal').insertAfter($('body'));
                });
                $('.modal').modal('show');
            });

            
        });
    </script>
    <script>
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                if (ValidateModal()) {
                    var userid = $('#txtuserid').val();
                    var username = $('#txtusername').val();
                    var password = $('#txtpassword').val();
                    var repassword = $('#txtrepassword').val();
                    var firstname = $('#txtfirstname').val();
                    var lastname = $('#txtlastname').val();
                    var doj = $('#txtdoj').val();
                    var contactno = $('#txtcontactno').val();
                    var emailid = $('#txtemailid').val();
                    var role = $('#ddlrole option:selected').val();
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "UserMaster.aspx/SaveUserData",
                        data: "{'userid': '" + userid + "', 'username': '" + username + "', 'password': '" + password + "', 'repassword': '" + repassword + "', 'firstname': '" + firstname + "', 'lastname': '" + lastname + "', 'doj': '" + doj + "', 'contactno': '" + contactno + "', 'emailid': '" + emailid + "' , 'role': '" + role + "'}",
                        dataType: "json",
                        success: function (data) {
                            $('.modal').modal('hide');
                        },
                        error: function (response) {
                            alert(response);
                        }
                    });
                }
                else {
                    return false;
                }
            });
        });
    </script>
    <style type="text/css">
        .modal-content {
            width: 600px !important;
            margin: 30px auto !important;
        }
    </style>
    <div class="page-title">
        <div class=" col-md-10 title-env">
            <h1 class="title">User Master</h1>
            <ol class="breadcrumb bc-1">
                <li>
                    <a href="/Dashboard.aspx">Dashboard</a>
                </li>
                <li class="active">
                    <strong>User Master</strong>
                </li>
            </ol>
            <h2 class="epg-tit">
                <asp:Label ID="lblCompanyName" runat="server"></asp:Label>
            </h2>
        </div>
    </div>

    <%--Vinayak--%>
    <div class="row">
        <div id="modal-dialog" class="modal fade" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        &times;</button>
                    <h4 class="modal-title">Add User - 
                            <asp:Label ID="lblModalCompanyName" runat="server"></asp:Label>
                    </h4>
                </div>
                <label id="errorMessage" ></label>
                <div class="modal-body">
                    <%--<asp:Label ID="errorMessage" runat="server" ClientIDMode="Static"></asp:Label>--%>
                    
                            <div class="col-md-6">

                                <div class="form-group">
                                    <label class=" control-label" for="field-1">User ID</label>
                                    <div class="form-group">
                                        <asp:TextBox runat="server" class="form-control" name="userid" ID="txtuserid" ClientIDMode="Static" autocomplete="off" MaxLength="10"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    
                                        <label class="control-label" for="password">Password</label>
                                    <div class="form-group">
                                        <asp:TextBox runat="server" class="form-control" name="password" ID="txtpassword" autocomplete="off" ClientIDMode="Static" TextMode="Password" MaxLength="20"></asp:TextBox>
                                        </div>
                                    
                                </div>
                                <div class="form-group">
                                    
                                        <label class="control-label" for="firstname">First Name</label>
                                    <div class="form-group">
                                        <asp:TextBox runat="server" class="form-control" name="firstname" ID="txtfirstname" autocomplete="off" ClientIDMode="Static" MaxLength="20"></asp:TextBox>
                                        </div>
                                    
                                </div>

                                <div class="form-group">
                                    
                                        <label class="control-label" for="doj">Date of Joining</label>
                                    <div class="form-group">
                                        <%--<asp:TextBox runat="server" class="form-control" name="doj" ID="txtdoj" ClientIDMode="Static" autocomplete="off" TextMode="Date"></asp:TextBox>--%>
                                        <asp:TextBox runat="server" CssClass="form-control datepicker" ID="txtdoj" ClientIDMode="Static" data-start-date="-2d" data-end-date="+1w"></asp:TextBox>									
                                    </div>
                                </div>

                                <div class="form-group">
                                    
                                        <label class="control-label" for="contactno">Email ID</label>
                                    <div class="form-group">
                                        <asp:TextBox runat="server" class="form-control" name="emailid" ID="txtemailid" autocomplete="off" ClientIDMode="Static" TextMode="Email" MaxLength="100"></asp:TextBox>
                                    </div>
                                </div>
                                

                            </div>
                            <div class="col-md-6">

                                <div class="form-group">
                                    <label class=" control-label" for="field-1">Username</label>
                                    <div class="form-group">
                                        <asp:TextBox runat="server" class="form-control" name="username" ID="txtusername" ClientIDMode="Static" autocomplete="off" MaxLength="10"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                        <label class="control-label" for="repassword">Reenter Password</label>
                                    <div class="form-group">
                                        <asp:TextBox runat="server" class="form-control" name="repassword" ID="txtrepassword" autocomplete="off" TextMode="Password" ClientIDMode="Static" MaxLength="20"></asp:TextBox>
                                        </div>
                                    </div>
                                <div class="form-group">
                                    
                                        <label class="control-label" for="lastname">Last Name</label>
                                    <div class="form-group">
                                        <asp:TextBox runat="server" class="form-control" name="lastname" ClientIDMode="Static" ID="txtlastname" autocomplete="off" MaxLength="20"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group">
                                    
                                        <label class="control-label" for="contactno">Contact No</label>
                                    <div class="form-group">
                                        <asp:TextBox runat="server" class="form-control" name="contactno" ID="txtcontactno" ClientIDMode="Static" autocomplete="off" TextMode="Phone" MaxLength="10"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    
                                        <label class="control-label" for="role">Role</label>
                                    <div class="form-group">
                                        <asp:DropDownList ID="ddlrole" runat="server" CssClass="form-control" ClientIDMode="Static">
                                            <asp:ListItem Value="Associate" Text="Associate" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="Manager" Text="Manager" Enabled="false"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                </div>
                </div>
                <div class="modal-footer">
                   <asp:Button ID="btnSubmit" runat="server" ClientIDMode="Static" Text="Save" CssClass="btn btn-info" />
                            <button class="btn btn-info" data-dismiss="modal" aria-hidden="true">Close</button>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default blue-box">
                <div class="panel-heading">
                    <h3 class="panel-title">User Master
                    </h3>
                    <div class="panel-options"><a href="#" data-toggle="panel"><span class="collapse-icon">–</span> <span class="expand-icon">+</span> </a></div>
                </div>
                <div class="panel-body">
                    <div class="col-md-2 pull-right">
        <%--<button type="button" class="btn btn-info pull-right" id="btnAddUser">Add User</button>--%>
                        <button type="button" class="btn btn-info pull-right" id="btnAddUser">Add User</button>
                        <%--<asp:Button ID ="btnAddUser" CssClass="btn btn-info pull-right" ClientIDMode="Static" Text="Add User" runat="server" />--%>
      </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:GridView ID="grdUserMaster" ClientIDMode="Static" class="table table-striped table-bordered" runat="server" EmptyDataText="No Records Found" ShowHeaderWhenEmpty="true" AllowPaging="true" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField HeaderText="User Name" DataField="clientUserName">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="First Name" DataField="clientuserfirstname">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Last Name" DataField="clientuserlastname">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Date of Joining" DataField="clientuserdoj">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Contact Number" DataField="clientusercontactno">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Email ID" DataField="clientuseremailid">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Role" DataField="clientuserrole">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderStyle-Width="10%" HeaderText="Action">
                                        <ItemTemplate>
                                            <a href="#"><i class="fa fa-pencil"  id="EditButton" onclick="EditUser('<%# Eval("clientuserid") %>');"></i></a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--main-content-ends-->
</asp:Content>
