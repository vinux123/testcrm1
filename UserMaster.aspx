<%@ Page Language="C#" MasterPageFile="~/VPCRMSMaster.master" AutoEventWireup="true" CodeFile="UserMaster.aspx.cs" Inherits="UserMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<script src="Scripts/jquery-confirm/dist/jquery-confirm.min.js"></script>
    <link href="Scripts/jquery-confirm/dist/jquery-confirm.min.css" rel="stylesheet" />--%>
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
        .form-group.required .control-label:after {
            content:" *";
            color:red;
            font-size: medium; 
        }
    </style>
    
    <script type="text/javascript">
        $(function () {
            //debugger;
            $.ajax({
                type: "POST",
                url: "UserMaster.aspx/GetUserDetails",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $('#fullpageloading').show()
                },
                complete: function () {
                    $('#fullpageloading').hide();
                },
                success: function (data) {
                    var finaldata = "<tr><th>User Name</th><th>First Name</th><th>Last Name</th><th>Date of Joining</th><th>Contact Number</th><th>Email ID</th><th>Role</th><th>Action</th></tr>";
                    var JSONDataR = $.parseJSON(data.d);
                    for (var i = 0; i < JSONDataR.length; i++) {
                        var date1 = new Date(parseInt(JSONDataR[i].clientuserdoj.replace('/Date(', ''))).toISOString();
                        finaldata = finaldata + '<tr><td>' + JSONDataR[i].clientusername + '</td><td>' + JSONDataR[i].clientuserfirstname + '</td><td>' + JSONDataR[i].clientuserlastname + '</td><td>' + date1.substring(0, 10) + '</td><td>' + JSONDataR[i].clientusercontactno + '</td><td>' + JSONDataR[i].clientuseremailid + '</td><td>' + JSONDataR[i].clientuserrole + '</td><td><a href=#><i class="fa fa-pencil" id="I9" onclick="EditUser(\'' + JSONDataR[i].clientuserid + '\');"></i></a></td></tr>';
                    }
                    $("#grdUserMaster").append(finaldata);
                    fixGridView($("#grdUserMaster"));
                    $("#grdUserMaster").dataTable({
                        aLengthMenu: [
                            [5, 10, 15, 20, 25, 50, 100, -1], [5, 10, 15, 20, 25, 50, 100, "All"]
                        ],
                        "aoColumnDefs": [
                  { 'bSortable': false, 'aTargets': [7] }
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

            $('#chkReset').prop("checked", false);
            $('#chkdisplay').hide();
            $('#chkReset').click(function () {
                if ($('#chkReset').prop("checked")) {
                    $('#txtpassword').prop("disabled", false);
                    $('#txtrepassword').prop("disabled", false);
                    $('#txtpassword').val("");
                    $('#txtrepassword').val("");
                }
                else {
                    $('#txtpassword').prop("disabled", true);
                    $('#txtrepassword').prop("disabled", true);
                    $('#txtpassword').val("");
                    $('#txtrepassword').val("");
                    $('#txtrepassword').parent().removeClass('validate-has-error');
                    repassword.innerHTML = "";
                    $('#txtpassword').parent().removeClass('validate-has-error');
                    passwordHelper.innerHTML = "";
                }
            });

            $('#txtdoj').datepicker({
                autoclose: true,
                format: 'yyyy-mm-dd'
            });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            fixGridView($("#grdUserMaster"));

            $('#txtusername').change(function () {
                var username = $(this).val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "UserMaster.aspx/CheckUserName",
                    data: "{'username': '" + username + "'}",
                    dataType: "json",
                    beforeSend: function () {
                        $('#fullpageloading').show()
                    },
                    complete: function () {
                        $('#fullpageloading').hide();
                    },
                    success: function (data) {
                        var JsonData = data.d;
                        var JSONDataR = $.parseJSON(JsonData);
                        if (JSONDataR.length > 0) {
                            $.alert({
                                title: 'Alert!',
                                content: 'Login Name exists. Please specify another Login Name.',
                                confirmButtonClass: 'btn-primary',
                                icon: 'fa fa-info',
                                animation: 'zoom',
                                backgroundDismiss: false,
                                confirm: function () {
                                    $('#txtusername').val("");
                                    $('#txtusername').focus();
                                }
                            });
                        }
                        else {
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("some error");
                    }
                });
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

        function ValidateModal() {
            //alert($('#hdnMode').val());
            var Role = $('#ddlrole option:selected').val();
            var val = true

            if (Role == 0) {
                $('#ddlrole').parent().addClass('validate-has-error');
                RoleHelper.innerHTML = "Please select Role";
            } else {
                $('#ddlrole').parent().removeClass('validate-has-error');
                RoleHelper.innerHTML = "";
            }

            if ($('#txtusername').val().length <= 0) {
                $('#txtusername').parent().addClass('validate-has-error');
                usernameHelper.innerHTML = "Please enter username";
            } else {
                $('#txtusername').parent().removeClass('validate-has-error');
                usernameHelper.innerHTML = "";
            }

            if ($('#txtfirstname').val().length <= 0) {
                $('#txtfirstname').parent().addClass('validate-has-error');
                firstnameHelper.innerHTML = "Please enter first name";
            } else {
                $('#txtfirstname').parent().removeClass('validate-has-error');
                firstnameHelper.innerHTML = "";
            }

            if ($('#hdnMode').val() == 'Add') {
                if ($('#txtpassword').val().length <= 0) {
                    $('#txtpassword').parent().addClass('validate-has-error');
                    passwordHelper.innerHTML = "Please enter password";
                }

                else {
                    $('#txtpassword').parent().removeClass('validate-has-error');
                    passwordHelper.innerHTML = "";
                }

                if ($('#txtrepassword').val().length <= 0) {
                    $('#txtrepassword').parent().addClass('validate-has-error');
                    repassword.innerHTML = "Please re enter password";
                }
                else if ($('#txtpassword').val() != $('#txtrepassword').val()) {
                    $('#txtrepassword').parent().addClass('validate-has-error');
                    repassword.innerHTML = "Passwords do not match.";
                }
                else {
                    $('#txtrepassword').parent().removeClass('validate-has-error');
                    repassword.innerHTML = "";
                }
            }
            else if ($('#hdnMode').val() == 'Edit' && $('#chkReset').prop("checked")) {
                if ($('#txtpassword').val().length <= 0) {
                    $('#txtpassword').parent().addClass('validate-has-error');
                    passwordHelper.innerHTML = "Please enter password";
                } else {
                    $('#txtpassword').parent().removeClass('validate-has-error');
                    passwordHelper.innerHTML = "";
                }

                if ($('#txtrepassword').val().length <= 0) {
                    $('#txtrepassword').parent().addClass('validate-has-error');
                    repassword.innerHTML = "Please re enter password";
                }
                else if ($('#txtpassword').val() != $('#txtrepassword').val()) {
                    $('#txtrepassword').parent().addClass('validate-has-error');
                    repassword.innerHTML = "Passwords do not match.";
                }
                else {
                    $('#txtrepassword').parent().removeClass('validate-has-error');
                    repassword.innerHTML = "";
                }
            }
            else { }

            if (($('.validate-has-error').length) > 0) {
                val = false;
            }
            else { val = true; }
            return val;
        }

        function EditUser(UserID) {
            $('#hdnMode').val('Edit');
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "UserMaster.aspx/EditUserData",
                data: "{'userid': '" + UserID + "'}",
                dataType: "json",
                beforeSend: function () {
                    $('#fullpageloading').show()
                },
                complete: function () {
                    $('#fullpageloading').hide();
                },
                success: function (data) {
                    var JsonData = data.d;
                    $('#chkdisplay').show();
                    var JSONDataR = $.parseJSON(JsonData);
                    $.each(JSONDataR, function (index, val) {
                        $('#hdnuserid').val(val.clientuserid);
                        $('#txtusername').val(val.clientusername);
                        $('#txtpassword').prop("disabled", true);
                        $('#txtrepassword').prop("disabled", true);
                        $('#txtfirstname').val(val.clientuserfirstname);
                        $('#txtlastname').val(val.clientuserlastname);
                        var date1 = new Date(parseInt(val.clientuserdoj.replace('/Date(', ''))).toISOString();
                        $('#txtdoj').val(date1.substring(0, 10));
                        $('#txtcontactno').val(val.clientusercontactno);
                        $('#txtemailid').val(val.clientuseremailid);
                        $('#ddlrole').val(val.clientuserrole);
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
    <%--<script type="text/javascript">
        jQuery(document).ready(function ($) {
            $("#grdUserMaster").dataTable({
                aLengthMenu: [
                    [25, 50, 100, -1], [25, 50, 100, "All"]
                ],
                "aoColumnDefs": [
          { 'bSortable': false, 'aTargets': [7] }
                ]
            });

            //$("#ddlrole").select2({
            //    placeholder: 'Select Role...',
            //    allowClear: true
            //}).on('select2-open', function () {
            //    // Adding Custom Scrollbar
            //    $(this).data('select2').results.addClass('overflow-hidden').perfectScrollbar();
            //});

        });
    </script>--%>
    <script type="text/javascript">
        $(function () {
            //attach listner to .modal-close-btn so that when button is pressed the modal dialogue disappears
            $('body').on('click', '.modal-close-btn', function () {
                $('.modal').modal('hide');
            });

            //clear modal cache so that new contenet can be loaded
            $('.modal').on('hidden.bs.modal', function () {
                $(this).find("input,textarea,select").val('').end();
                $('.form-group').removeClass('validate-has-error');
                $('.modal-body').find('.removespan').html("");
            });

            $('#CancelModal').on('click', function () {
                return false;
            });
        });
    </script>
    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            $("#btnAddUser").click(function (e) {
                $('.modal').on('show.bs.modal', function (event) {
                    $('.modal').insertAfter($('body'));
                });
                $('#hdnMode').val('Add');
                $('.modal').modal('show');
                $('#chkdisplay').hide();
                $('#txtpassword').prop("disabled", false);
                $('#txtrepassword').prop("disabled", false);
                $('#txtpassword').val("");
                $('#txtrepassword').val("");
            });

        });
    </script>
    <script>
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                if (ValidateModal()) {
                    var username = $('#txtusername').val();
                    var password = $('#txtpassword').val();
                    var repassword = $('#txtrepassword').val();
                    var firstname = $('#txtfirstname').val();
                    var lastname = $('#txtlastname').val();
                    var doj = $('#txtdoj').val();
                    var contactno = $('#txtcontactno').val();
                    var emailid = $('#txtemailid').val();
                    var role = $('#ddlrole option:selected').val();
                    var userid = $('#hdnuserid').val();
                    var mode;
                    var message;
                    if ($('#hdnMode').val() == 'Add') {
                        message = 'User Added successfully'
                        mode = 'Insert';

                    }
                    else {
                        message = 'User details updated successfully'
                        mode = 'Update';
                    }

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "UserMaster.aspx/SaveUserData",
                        data: "{'username': '" + username + "', 'password': '" + password + "', 'repassword': '" + repassword + "', 'firstname': '" + firstname + "', 'lastname': '" + lastname + "', 'doj': '" + doj + "', 'contactno': '" + contactno + "', 'emailid': '" + emailid + "' , 'role': '" + role + "', 'mode': '" + mode + "', 'userid': '" + userid + "'}",
                        dataType: "json",
                        beforeSend: function () {
                            $('#fullpageloading').show()
                        },
                        complete: function () {
                            $('#fullpageloading').hide();
                        },
                        success: function (data) {
                            $('.modal').modal('hide');
                            // changes done alert. 
                            $.alert({
                                title: 'Confirm!',
                                content: message,
                                confirmButtonClass: 'btn-primary',
                                animation: 'zoom',
                                backgroundDismiss: false,
                                confirm: function () {
                                    window.top.location = "UserMaster.aspx";
                                }
                            });

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
            /*width: 600px !important;*/
            margin: 30px auto !important;
        }
    </style>
    <asp:HiddenField ID="hdnMode" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hdnuserid" ClientIDMode="Static" runat="server" />
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
        <div id="modal-dialog" class="modal fade custom-width" style="height: 1247px;" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
            <<div class="modal-dialog" style="width: 60%;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                        <h4 class="modal-title">User Maintenance - 
                            <asp:Label ID="lblModalCompanyName" runat="server"></asp:Label>

                        </h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class="control-label" for="firstname">First Name</label>
                                    <asp:TextBox runat="server" class="form-control" name="firstname" ID="txtfirstname" autocomplete="off" ClientIDMode="Static" MaxLength="20"></asp:TextBox>
                                    <span id="firstnameHelper" class="removespan"></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label" for="lastname">Last Name</label>
                                    <asp:TextBox runat="server" class="form-control" name="lastname" ClientIDMode="Static" ID="txtlastname" autocomplete="off" MaxLength="20"></asp:TextBox>
                                </div>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class=" control-label" for="field-1">Username</label>
                                    <asp:TextBox runat="server" class="form-control" name="username" ID="txtusername" ClientIDMode="Static" autocomplete="off" MaxLength="10"></asp:TextBox>
                                    <span id="usernameHelper" class="removespan"></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label" for="contactno">Email ID</label>
                                    <asp:TextBox runat="server" class="form-control" name="emailid" ID="txtemailid" autocomplete="off" ClientIDMode="Static" TextMode="Email" MaxLength="100"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12" id="chkdisplay">
                                <input checked="" class="iswitch iswitch-info" id="chkReset" type="checkbox">
                                <label>Enable reset password </label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class="control-label" for="password">Password</label>
                                    <asp:TextBox runat="server" class="form-control" name="password" ID="txtpassword" autocomplete="off" ClientIDMode="Static" TextMode="Password" MaxLength="20"></asp:TextBox>
                                    <span id="passwordHelper" class="removespan"></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class="control-label" for="repassword">Reenter Password</label>
                                    <asp:TextBox runat="server" class="form-control" name="repassword" ID="txtrepassword" autocomplete="off" TextMode="Password" ClientIDMode="Static" MaxLength="20"></asp:TextBox>
                                    <span id="repassword" class="removespan"></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label" for="contactno">Contact No</label>
                                    <asp:TextBox runat="server" class="form-control" name="contactno" ID="txtcontactno" ClientIDMode="Static" autocomplete="off" TextMode="Phone" MaxLength="10"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label" for="doj">Date of Joining</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtdoj" ClientIDMode="Static"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class="control-label" for="role">Role</label>
                                    <asp:DropDownList ID="ddlrole" runat="server" CssClass="form-control" ClientIDMode="Static">
                                        <asp:ListItem Value="0" Text="Select Role"></asp:ListItem>
                                        <asp:ListItem Value="Associate" Text="Associate"></asp:ListItem>
                                        <asp:ListItem Value="Manager" Text="Manager"></asp:ListItem>
                                    </asp:DropDownList>
                                    <span id="RoleHelper" class="removespan"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <button type="button" id="btnSubmit" class="btn btn-primary">Submit</button>
                    </div>
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
                        <button type="button" class="btn btn-info pull-right" id="btnAddUser">Add User</button>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <table class="table table-striped table-bordered" border="1" id="grdUserMaster" style="border-collapse: collapse;">
                            </table>
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
</asp:Content>
