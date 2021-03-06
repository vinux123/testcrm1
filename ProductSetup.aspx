﻿<%@ Page Language="C#" MasterPageFile="~/VPCRMSMaster.master" AutoEventWireup="true" CodeFile="ProductSetup.aspx.cs" Inherits="ProductSetup" %>

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

        .form-group.required .control-label:after {
            content: " *";
            color: red;
            font-size: medium;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "ProductSetup.aspx/GetProductDetails",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $('#fullpageloading').show()
                },
                complete: function () {
                    $('#fullpageloading').hide();
                },
                success: function (data) {
                    var finaldata = "<tr><th>Product Name</th><th>Product Description</th><th>HSN</th><th>Product Price</th><th>Action</th></tr>";
                    var JSONDataR = $.parseJSON(data.d);
                    for (var i = 0; i < JSONDataR.length; i++) {
                        finaldata = finaldata + '<tr><td>' + JSONDataR[i].productname + '</td><td>' + JSONDataR[i].productdesc + '</td><td>' + JSONDataR[i].producthsn + '</td><td>' + JSONDataR[i].prodprice + '</td><td><a href=#><i class="fa fa-pencil" id="I9" onclick="EditProduct(\'' + JSONDataR[i].productname + '\');"></i></a></td></tr>';
                    }
                    $("#grdProduct").append(finaldata);
                    fixGridView($("#grdProduct"));
                    $("#grdProduct").dataTable({
                        aLengthMenu: [
                            [5, 10, 15, 20, 25, 50, 100, -1], [5, 10, 15, 20, 25, 50, 100, "All"]
                        ],
                        "aoColumnDefs": [
                  { 'bSortable': false, 'aTargets': [4] }
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
                beforeSend: function () {
                    $('#fullpageloading').show()
                },
                complete: function () {
                    $('#fullpageloading').hide();
                },
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
            $("#btnAddProduct").click(function (e) {
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
                        beforeSend: function () {
                            $('#fullpageloading').show()
                        },
                        complete: function () {
                            $('#fullpageloading').hide();
                        },
                        success: function (data) {
                            $('.modal').modal('hide');
                            $.alert({
                                title: 'Confirm!',
                                content: 'Records Updated Successfully',
                                confirmButtonClass: 'btn-primary',
                                animation: 'zoom',
                                backgroundDismiss: false,
                                confirm: function () {
                                    window.top.location = "ProductSetup.aspx";
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
    <div class="page-title">
        <div class=" col-md-10 title-env">
            <h1 class="title">Product Setup</h1>
            <ol class="breadcrumb bc-1">
                <li>
                    <a href="/Dashboard.aspx">Dashboard</a>
                </li>
                <li class="active">
                    <strong>Product Setup</strong>
                </li>
            </ol>
            <h2 class="epg-tit">
                <asp:Label ID="lblCompanyName" runat="server" ClientIDMode="Static"></asp:Label>
            </h2>
        </div>
    </div>
    <div class="row">
        <div id="modal-dialog" class="modal fade custom-width" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog" style="width: 60%;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                        <h4 class="modal-title">Product - 
                            <asp:Label ID="lblModalCompanyName" runat="server" ClientIDMode="Static"></asp:Label>
                        </h4>
                    </div>
                    <div class="modal-body" id="modalbody">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class=" control-label" for="field-1">Product Name</label>
                                    <asp:TextBox runat="server" class="form-control" name="productname" ID="txtprodname" ClientIDMode="Static" autocomplete="off" MaxLength="45"></asp:TextBox>
                                    <span id="productnameHelper" class="removespan"></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label" for="proddesc">Product Description</label>
                                    <asp:TextBox runat="server" class="form-control" name="proddesc" ID="txtproddesc" autocomplete="off" ClientIDMode="Static" MaxLength="50"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label" for="prodhsn">Product HSN</label>
                                    <asp:TextBox runat="server" class="form-control" name="prodhsn" ID="txtprodhsn" autocomplete="off" ClientIDMode="Static" MaxLength="20"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class="control-label" for="prodprice">Product Price</label>
                                    <asp:TextBox runat="server" class="form-control" name="prodprice" ID="txtprodprice" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                    <span id="prodpriceHelper" class="removespan"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <%--<asp:Button ID="btnSubmit" ClientIDMode="Static" runat="server" Text="Save" class="btn btn-primary"/>--%>
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
                            <table class="table table-striped table-bordered" border="1" id="grdProduct" style="border-collapse: collapse;">
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="fullpageloading">
        <div style="margin: 20%">
            <img alt="loading" src="Images/fullpageloadingimg2.gif" />
        </div>
    </div>
    <!--main-content-ends-->
</asp:Content>
