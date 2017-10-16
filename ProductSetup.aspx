<%@ Page Language="C#" MasterPageFile="~/VPCRMSMaster.master" AutoEventWireup="true" CodeFile="ProductSetup.aspx.cs" Inherits="ProductSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            fixGridView($("#grdProduct"));
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
            var prodname = $('#txtprodname').val();
            var prodprice = $('#txtprodprice').val();
            var rege = /^[1-9]\d*$/;

            if (prodname.length <= 0) {
                $('#txtprodname').parent().addClass('validate-has-error');
                productnameHelper.innerHTML = "Please enter product name";
            }
            else {
                $('#txtprodname').parent().removeClass('validate-has-error');
                productnameHelper.innerHTML = "";
            }

            if (prodprice.length <= 0) {
                $('#txtprodprice').parent().addClass('validate-has-error');
                prodpriceHelper.innerHTML = "Please enter product price";
            }
            else if (!rege.test(prodprice)) {
                $('#txtprodprice').parent().addClass('validate-has-error');
                prodpriceHelper.innerHTML = "Please enter numeric fields only";
            }
            else {
                $('#txtprodprice').parent().removeClass('validate-has-error');
                prodpriceHelper.innerHTML = "";
            }
            
            if (($('.validate-has-error').length) > 0) {
                val = false;
            }
            else { val = true; }
            return val;
        }

        function EditProduct(ProductName) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ProductSetup.aspx/EditProductData",
                data: "{'productname': '" + ProductName + "'}",
                dataType: "json",
                success: function (data) {
                    var JsonData = data.d;
                    var JSONDataR = $.parseJSON(JsonData);
                    $.each(JSONDataR, function (index, val) {
                        $('#txtprodname').val(val.productname);
                        $('#txtproddesc').val(val.productdesc);
                        $('#txtprodhsn').val(val.producthsn);
                        $('#txtprodprice').val(val.prodprice);

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
            $("#grdProduct").dataTable({
                aLengthMenu: [
                    [25, 50, 100, -1], [25, 50, 100, "All"]
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
    </script>
    <script type="text/javascript">
        $(function () {
            //attach listner to .modal-close-btn so that when button is pressed the modal dialogue disappears
            $('body').on('click', '.modal-close-btn', function () {
                $('.modal').modal('hide');
            });

            //clear modal cache so that new contenet can be loaded
            $('.modal').on('hidden.bs.modal', function () {
                $(this).find("input,textarea,select").val('').end();
                $('div').removeClass('validate-has-error');
                $('span').val('');
                

            });

            $('#CancelModal').on('click', function () {
                return false;
            });
        });
    </script>
    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            $("#btnAddProduct").click(function (e) {
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
                    var prodname = $('#txtprodname').val();
                    var proddesc = $('#txtproddesc').val();
                    var prodhsn = $('#txtprodhsn').val();
                    var prodprice = $('#txtprodprice').val();

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "ProductSetup.aspx/SaveProdData",
                        data: "{'prodname': '" + prodname + "', 'proddesc': '" + proddesc + "', 'prodhsn': '" + prodhsn + "', 'prodprice': '" + prodprice + "'}",
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
                    <strong>Product Setup</strong>
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
            <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        &times;</button>
                    <h4 class="modal-title">Add Product - 
                            <asp:Label ID="lblModalCompanyName" runat="server"></asp:Label>
                    </h4>
                </div>
                <div class="modal-body" id="modalbody">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class=" control-label" for="field-1">Product Name</label>
                                    <asp:TextBox runat="server" class="form-control" name="productname" ID="txtprodname" ClientIDMode="Static" autocomplete="off" MaxLength="45"></asp:TextBox>
                                    <span id="productnameHelper"></span>
                                </div>
                                <div class="form-group">
                                        <label class="control-label" for="proddesc">Product Description</label>
                                        <asp:TextBox runat="server" class="form-control" name="proddesc" ID="txtproddesc" autocomplete="off" ClientIDMode="Static" MaxLength="50"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                        <label class="control-label" for="prodhsn">Product HSN</label>
                                        <asp:TextBox runat="server" class="form-control" name="prodhsn" ID="txtprodhsn" autocomplete="off" ClientIDMode="Static" MaxLength="20"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                        <label class="control-label" for="prodprice">Product Price</label>
                                        <asp:TextBox runat="server" class="form-control" name="prodprice" ID="txtprodprice" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                    <span id="prodpriceHelper"></span>
                                </div>
                            </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button ID="btnSubmit" ClientIDMode="Static" runat="server" Text="Save" class="btn btn-primary"/>
                </div>
            </div>
        </div>
            </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default blue-box">
                <div class="panel-heading">
                    <h3 class="panel-title">Product Master
                    </h3>
                    <div class="panel-options"><a href="#" data-toggle="panel"><span class="collapse-icon">–</span> <span class="expand-icon">+</span> </a></div>
                </div>
                <div class="panel-body">
                    <div class="col-md-2 pull-right">
        <button type="button" class="btn btn-info pull-right" id="btnAddProduct">Add Product</button>
      </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:GridView ID="grdProduct" ClientIDMode="Static" class="table table-striped table-bordered" runat="server" EmptyDataText="No Records Found" ShowHeaderWhenEmpty="true" AllowPaging="true" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField HeaderText="Product Name" DataField="productname">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Product Description" DataField="productdesc">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="HSN" DataField="producthsn">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Product Price" DataField="prodprice">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:BoundField>
                                    
                                    <asp:TemplateField HeaderStyle-Width="10%">
                                        <%--<ItemTemplate>
                                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" CommandArgument='<%# Eval("productname") %>'
                                                Text="Edit" class="btn btn-info" />
                                        </ItemTemplate>--%>
                                        <ItemTemplate>
                                            <a href="#"><i class="fa fa-pencil"  id="EditButton" onclick="EditProduct('<%# Eval("productname") %>');"></i></a>
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
