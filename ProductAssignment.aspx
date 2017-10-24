

<%@ Page Language="C#" MasterPageFile="~/VPCRMSMaster.master" AutoEventWireup="true" CodeFile="ProductAssignment.aspx.cs" Inherits="ProductAssignment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>
    <%--<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
  <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/css/bootstrapValidator.min.css"/>
  <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/js/bootstrapValidator.min.js"> </script>--%>

    <script type="text/javascript">
        $(document).ready(function () {
            fixGridView($("#grdProductAssignment"));
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

            var rege = /^[1-9]\d*$/;
            var prodamttgt = $('#txtprodamttgt').val();
            var username = $('#ddlusername option:selected').index();
            var prodname = $('#ddlProductName option:selected').index();
            var prodqtytgt = $('#txtprodqtytgt').val();
            var prodqtyyr = $('#txtprodtgtyr').val();
            var val = true
            if (prodamttgt.length <= 0) {
                $('#txtprodamttgt').parent().addClass('validate-has-error');
                prodamttgtHelper.innerHTML = "Please select amount target";
            }
            else if (!rege.test(prodamttgt)) {
                $('#txtprodamttgt').parent().addClass('validate-has-error');
                prodamttgtHelper.innerHTML = "Please enter numeric fields only";
            }
            else {
                $('#txtprodamttgt').parent().removeClass('validate-has-error');
                prodamttgtHelper.innerHTML = "";
            }

            if (username == 0) {
                $('#ddlusername').parent().addClass('validate-has-error');
                ddlusernameHelper.innerHTML = "Please select User";
            } else {
                $('#ddlusername').parent().removeClass('validate-has-error');
                ddlusernameHelper.innerHTML = "";
            }

            if (prodname == 0) {
                $('#ddlProductName').parent().addClass('validate-has-error');
                ddlProductNameHelper.innerHTML = "Please select Product";
            } else {
                $('#ddlProductName').parent().removeClass('validate-has-error');
                ddlProductNameHelper.innerHTML = "";
            }

            if (prodqtytgt == 0) {
                $('#txtprodqtytgt').parent().addClass('validate-has-error');
                prodqtytgtHelper.innerHTML = "Please select Product Qty target";
            }
            else if (!rege.test(prodqtytgt)) {
                $('#txtprodqtytgt').parent().addClass('validate-has-error');
                prodqtytgtHelper.innerHTML = "Please enter numeric fields only";
            }
            else {
                $('#txtprodqtytgt').parent().removeClass('validate-has-error');
                prodqtytgtHelper.innerHTML = "";
            }

            if (prodqtyyr == 0) {
                $('#txtprodtgtyr').parent().addClass('validate-has-error');
                prodtgtyrHelper.innerHTML = "Please select Product target year";
            }
            else if (!rege.test(prodqtyyr)) {
                $('#txtprodtgtyr').parent().addClass('validate-has-error');
                prodtgtyrHelper.innerHTML = "Please enter numeric fields only";
            }
            else {

                $('#txtprodtgtyr').parent().removeClass('validate-has-error');
                prodtgtyrHelper.innerHTML = "";
            }

            if (($('.validate-has-error').length) > 0) {
                val = false;
            }
            else { val = true; }
            return val;
        }

        function EditProductAssignment(ProdAssignedTo, ProductName, ProdTgtMth, ProdTgtYr) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ProductAssignment.aspx/EditProductAssignment",
                data: "{'ProdAssignedTo': '" + ProdAssignedTo + "','productname': '" + ProductName + "','target_month': '" + ProdTgtMth + "','target_year': '" + ProdTgtYr + "'}",
                dataType: "json",
                success: function (data) {
                    var JsonData = data.d;
                    var JSONDataR = $.parseJSON(JsonData);
                    $.each(JSONDataR, function (index, val) {

                        $("#<%=ddlusername.ClientID %>").val(val.customeruser);
                        $("#<%=ddlProductName.ClientID %>").val(val.customerproduct);
                        $('#txtprodamttgt').val(val.useramounttarget);
                        $('#txtprodqtytgt').val(val.userprodtarget);
                        $("#<%=ddlprodtgtmth.ClientID %>").val(val.targetmonth);
                        $('#txtprodtgtyr').val(val.targetyear);

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
            $("#grdProductAssignment").dataTable({
                aLengthMenu: [
                    [25, 50, 100, -1], [25, 50, 100, "All"]
                ]
            });

            $("#ddlusername").select2({
                placeholder: 'Select Assignedto...',
                allowClear: true
            }).on('select2-open', function () {
                // Adding Custom Scrollbar
                $(this).data('select2').results.addClass('overflow-hidden').perfectScrollbar();
            });

            $("#ddlProductName").select2({
                placeholder: 'Select Product...',
                allowClear: true
            }).on('select2-open', function () {
                // Adding Custom Scrollbar
                $(this).data('select2').results.addClass('overflow-hidden').perfectScrollbar();
            });

            $("#ddlprodtgtmth").select2({
                placeholder: 'Select Month...',
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
                $('#modal-dialog').modal('hide');
            });

            //clear modal cache so that new contenet can be loaded
            $('#modal-dialog').on('hidden.bs.modal', function () {
                $(this).removeData('bs.modal');
                //$('#loginForm').formValidation('resetForm', true);
            });

            $('#CancelModal').on('click', function () {
                return false;
            });
        });
    </script>
    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            $("#btnAddProductAssign").click(function (e) {
                //debugger;
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
                    var username = $('#ddlusername option:selected').val();
                    var prodname = $('#ddlProductName option:selected').val();
                    var prodamttgt = $('#txtprodamttgt').val();
                    var prodqtytgt = $('#txtprodqtytgt').val();
                    //var prodtgtmth = $('#txtprodtgtmth').val();
                    var prodtgtmth = $('#ddlprodtgtmth option:selected').val();
                    var prodtgtyr = $('#txtprodtgtyr').val();

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "ProductAssignment.aspx/SaveProdAssignment",
                        data: "{'username': '" + username + "', 'prodname': '" + prodname + "', 'prodamttgt': '" + prodamttgt + "', 'prodqtytgt': '" + prodqtytgt + "', 'prodtgtmth': '" + prodtgtmth + "', 'prodtgtyr': '" + prodtgtyr + "'}",
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
            <%--<h1 class="title">User Master</h1>--%>
            <ol class="breadcrumb bc-1">
                <li>
                    <a href="/Dashboard.aspx">Dashboard</a>
                </li>
                <li class="active">
                    <strong>Product Assignment</strong>
                </li>
            </ol>
            <h2 class="epg-tit">
                <asp:Label ID="lblCompanyName" runat="server"></asp:Label>
            </h2>
        </div>
    </div>

    <%--Vinayak--%>
    <div class="row">
        <div class="modal fade custom-width" id="modal-2">
            <div class="modal-dialog" style="width: 60%;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Custom Width Modal</h4>
                    </div>
                    <div class="modal-body">
                        Any type of width can be applied.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-info">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="modal-dialog" class="modal fade" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                        <h4 class="modal-title">Add Product - 
                            <asp:Label ID="lblModalCompanyName" runat="server"></asp:Label>
                        </h4>
                    </div>
                    <div class="modal-body">
                        <%--<asp:FormView ID="frmModalPopup" runat="server" DefaultMode="Insert">
                        <InsertItemTemplate>--%>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class=" control-label" for="field-1">Assigned To</label>
                                <asp:DropDownList ID="ddlusername" runat="server" CssClass="form-control" ClientIDMode="Static">
                                </asp:DropDownList>
                                <span id="ddlusernameHelper"></span>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="prodname">Product Name</label>
                                <asp:DropDownList ID="ddlProductName" runat="server" CssClass="form-control" ClientIDMode="Static">
                                </asp:DropDownList>
                                <span id="ddlProductNameHelper"></span>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="prodamttgt">Amount Target</label>
                                <asp:TextBox runat="server" class="form-control" name="prodamttgt" ID="txtprodamttgt" autocomplete="off" ClientIDMode="Static" MaxLength="20" data-validate="required"></asp:TextBox>
                                <span id="prodamttgtHelper"></span>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="prodqtytgt">Product Qty Target</label>
                                <asp:TextBox runat="server" class="form-control" name="prodqtytgt" ID="txtprodqtytgt" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                <span id="prodqtytgtHelper"></span>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="prodtgtmth">Product Target Month</label>

                                <asp:DropDownList ID="ddlprodtgtmth" runat="server" CssClass="form-control" ClientIDMode="Static">
                                    <asp:ListItem Value="January" Text="January" Selected="True"></asp:ListItem>
                                    <asp:ListItem Value="February" Text="February" Enabled="true"></asp:ListItem>
                                    <asp:ListItem Value="March" Text="March" Enabled="true"></asp:ListItem>
                                    <asp:ListItem Value="April" Text="April" Enabled="true"></asp:ListItem>
                                    <asp:ListItem Value="May" Text="May" Enabled="true"></asp:ListItem>
                                    <asp:ListItem Value="June" Text="June" Enabled="true"></asp:ListItem>
                                    <asp:ListItem Value="July" Text="July" Enabled="true"></asp:ListItem>
                                    <asp:ListItem Value="August" Text="August" Enabled="true"></asp:ListItem>
                                    <asp:ListItem Value="September" Text="September" Enabled="true"></asp:ListItem>
                                    <asp:ListItem Value="October" Text="October" Enabled="true"></asp:ListItem>
                                    <asp:ListItem Value="November" Text="November" Enabled="true"></asp:ListItem>
                                    <asp:ListItem Value="December" Text="December" Enabled="true"></asp:ListItem>
                                </asp:DropDownList>
                                <span id="ddlprodtgtmthHelper"></span>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="prodtgtyr">Product Target Year</label>
                                <asp:TextBox runat="server" class="form-control" name="prodtgtyr" ID="txtprodtgtyr" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                <span id="prodtgtyrHelper"></span>
                            </div>
                        </div>
                        <%--<div class="col-md-6">

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
                        --%>


                        <%--</div>--%>
                        <%--</InsertItemTemplate>
                    </asp:FormView>--%>
                    </div>
                    <div class="modal-footer">

                        <button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>
                        <asp:Button ID="btnSubmit" ClientIDMode="Static" runat="server" Text="Save" class="btn btn-info" />

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default blue-box">
                <div class="panel-heading">
                    <h3 class="panel-title">Product Assignment
                    </h3>
                    <div class="panel-options"><a href="#" data-toggle="panel"><span class="collapse-icon">–</span> <span class="expand-icon">+</span> </a></div>
                </div>
                <div class="panel-body">
                    <div class="col-md-2 pull-right">
                        <button type="button" class="btn btn-info pull-right" id="btnAddProductAssign">Add</button>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:GridView ID="grdProductAssignment" ClientIDMode="Static" class="table table-striped table-bordered" runat="server" EmptyDataText="No Records Found" ShowHeaderWhenEmpty="true" AllowPaging="true" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField HeaderText="Assigned To" DataField="prodassignedto">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Product Name" DataField="productname">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Amount Target" DataField="prodamttgt">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Product Qty Target" DataField="prodqtytgt">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Product Target Month" DataField="prodtgtmth">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Product Target Year" DataField="prodtgtyr">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>

                                    <asp:TemplateField HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                            <a href="#"><i class="fa fa-pencil" id="EditButton" onclick="EditProductAssignment('<%# Eval("prodassignedto") %>','<%# Eval("productname") %>','<%# Eval("prodtgtmth") %>','<%# Eval("prodtgtyr") %>');"></i></a>
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

    <script src="assets/js/jquery-validate/jquery.validate.min.js"></script>
</asp:Content>
