<%@ Page Language="C#" MasterPageFile="~/VPCRMSMaster.master" AutoEventWireup="true" CodeFile="ProductAssignment.aspx.cs" Inherits="ProductAssignment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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

        function EditProductAssignment(ProdAssignedTo,ProductName, ProdTgtMth, ProdTgtYr) {
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
                        $('#ddlusername option:selected').val(val.customeruser);
                        $('#ddlProductName option:selected').val(val.customerproduct);
                        $('#txtprodamttgt').val(val.useramounttarget);
                        $('#txtprodqtytgt').val(val.userprodtarget);
                        $('#ddlprodtgtmth option:selected').val(val.targetmonth);
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
        
        <%--<div id="modal-dialog" class="modal fade" tabindex="-1" role="dialog">--%>
        <div id="modal-dialog" class="modal fade" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
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
                                    <label class=" control-label" for="field-1" >Assigned To</label>
                                    <asp:DropDownList ID="ddlusername" runat="server" CssClass="form-control" ClientIDMode="Static">
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group">
                                    
                                        <label class="control-label" for="prodname">Product Name</label>
                                    <%--<div class="form-group">
                                        <asp:TextBox runat="server" class="form-control" name="prodname" ID="txtprodname" autocomplete="off" ClientIDMode="Static" MaxLength="45"></asp:TextBox>
                                    </div>--%>
                                    <asp:DropDownList ID="ddlProductName" runat="server" CssClass="form-control" ClientIDMode="Static">
                                    </asp:DropDownList>
                                    
                                </div>
                                <div class="form-group">
                                    
                                       <label class="control-label" for="prodamttgt">Amount Target</label>
                                    <div class="form-group">
                                        <asp:TextBox runat="server" class="form-control" name="prodamttgt" ID="txtprodamttgt" autocomplete="off" ClientIDMode="Static" MaxLength="20"></asp:TextBox>
                                        </div>
                                    
                                </div>

                                <div class="form-group">
                                    
                                        <label class="control-label" for="prodqtytgt">Product Qty Target</label>
                                    <div class="form-group">
                                        <asp:TextBox runat="server" class="form-control" name="prodqtytgt" ID="txtprodqtytgt" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group">
                                    
                                        <label class="control-label" for="prodtgtmth">Product Target Month</label>
                                    <%--<div class="form-group">
                                        <asp:TextBox runat="server" class="form-control" name="prodtgtmth" ID="txtprodtgtmth" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                    </div>--%>

                                    <div class="form-group">
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
                                    </div>
                                </div>

                                <div class="form-group">
                                    
                                        <label class="control-label" for="prodtgtyr">Product Target Year</label>
                                    <div class="form-group">
                                        <asp:TextBox runat="server" class="form-control" name="prodtgtyr" ID="txtprodtgtyr" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                    </div>
                                </div>
                                <%--<div class="form-group">
                                    
                                        <label class="control-label" for="contactno">Email ID</label>
                                    <div class="form-group">
                                        <asp:TextBox runat="server" class="form-control" name="emailid" ID="txtemailid" autocomplete="off" ClientIDMode="Static" TextMode="Email" MaxLength="100"></asp:TextBox>
                                    </div>
                                </div>--%>
                                

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
                    
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button ID="btnSubmit" ClientIDMode="Static" runat="server" Text="Save" class="btn btn-primary"/>
                  
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
                                            <a href="#"><i class="fa fa-pencil"  id="EditButton" onclick="EditProductAssignment('<%# Eval("prodassignedto") %>','<%# Eval("productname") %>','<%# Eval("prodtgtmth") %>','<%# Eval("prodtgtyr") %>');"></i></a>
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
