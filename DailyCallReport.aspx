
<%@ Page Language="C#" MasterPageFile="~/VPCRMSMaster.master" AutoEventWireup="true" CodeFile="DailyCallReport.aspx.cs" Inherits="testdcr" %>

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
        $(function () {
            $('#txtdate').datepicker({
                autoclose: true,
                format: 'yyyy-mm-dd'
            });

            $('#txtfollowupdate').datepicker({
                autoclose: true,
                format: 'yyyy-mm-dd'
            });

            $.ajax({
                type: "POST",
                url: "DailyCallReport.aspx/GetDailyCallReportDetails",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $('#fullpageloading').show()
                },
                complete: function () {
                    $('#fullpageloading').hide();
                },
                success: function (data) {
                    var finaldata = "<tr><th>Client ID</th><th>Client Name</th><th>Contact Number</th><th>Email ID</th><th>Assigned To</th><th>Status</th><th>Action</th></tr>";
                    var JSONDataR = $.parseJSON(data.d);
                    for (var i = 0; i < JSONDataR.length; i++) {
                        finaldata = finaldata + '<tr><td>' + JSONDataR[i].clientcustomerid + '</td><td>'
                                                           + JSONDataR[i].clientcustomername + '</td><td>'
                                                           + JSONDataR[i].clientcustomerpcontact + '</td><td>'
                                                           + JSONDataR[i].clientcustomeremailid + '</td><td>'
                                                           + JSONDataR[i].clientuserfirstname + '</td><td>'
                                                           + JSONDataR[i].customerstatus + '</td><td>' +
                                                           '<a href=#><i class="fa fa-pencil" id="EditDCR" data-toggle="tooltip" data-container="body" data-placement="bottom" data-original-title="Edit" onclick="EditDCR(\'' + JSONDataR[i].clientcustomerid + '\');"></i></a>&nbsp;&nbsp;&nbsp;<a href=#><i class="fa fa-plus" id="AddQuotation" data-toggle="tooltip" data-container="body" data-placement="bottom" data-original-title="Add Quotation" onclick="GenerateQuotation(\'' + JSONDataR[i].clientcustomerid + '\');"></i></a></td>'
                                                           + '</tr>';
                    }

                    $("#grdDCR").append(finaldata);
                    fixGridView($("#grdDCR"));
                    $("#grdDCR").dataTable({
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

        });
    </script>
    <script type="text/javascript">
        function Info() {
            this.ProductName = '';
            this.ProductQTY = '';
            this.ProductPrice = '';
            this.ProductAmount = '';
            this.ProductFinalAmount = '';
        }

        function adderr(f, index) {
            $("#msg").show();
            $(index).find("td").parent("tr").css("background-color", "#F5ECCE");
        }

        function calcProductAmount(rownumber) {
            var jq_ddl_ProductQty = $('#ProductDetails_' + rownumber + '__quotedqty').val();//ProductDetails_0__quotedqty
            var jq_ddl_ProductPrice = $('#ProductDetails_' + rownumber + '__quoteprice').val();
            var rege = /^[1-9]\d*$/;
            
            if ($.trim(jq_ddl_ProductQty) != '' && $.trim(jq_ddl_ProductPrice) != '')
            {
                    $('#ProductDetails_' + rownumber + '__quoteamt').val(jq_ddl_ProductQty * jq_ddl_ProductPrice);
            }
        }

        function getProductPrice(rownumber) {
            var jq_ddl_ProductName = $('#ProductDetails_' + rownumber + '__ProductName').val();
            if (jq_ddl_ProductName == 'Select') {
                $('#ProductDetails_' + rownumber + '__quoteprice').val('');
            }
            else {
                $.ajax({
                    type: "POST",
                    url: "DailyCallReport.aspx/GetProductPrice",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'ProductName': '" + jq_ddl_ProductName + "'}",
                    beforeSend: function () {
                        $('#fullpageloading').show()
                    },
                    complete: function () {
                        $('#fullpageloading').hide();
                    },
                    success: function (data) {
                        var JSONDataR = $.parseJSON(data.d);
                        $.each(JSONDataR, function (index, val) {
                            $('#ProductDetails_' + rownumber + '__quoteprice').val(val.prodprice);
                            //$('#ProductDetails_' + rownumber + '__quoteprice').attr("disabled", true);
                        });
                    },
                    error: function (data) {
                        console.log('ajax call error');
                    }
                });
            }
        }

        function isvalid(ProductName, ProductQTY, ProductPrice, ProductAmount, ProductFinalAmount, i, index) {
            $("#tblProduct tbody tr > td ").removeClass("validate-has-error");
            if ($.trim(ProductName) == 'Select') {
                $("#msg").html("Please select product at row " + i);
                adderr(1, index);
                return false;
            }

            if ($.trim(ProductQTY) == '') {
                $("#msg").html("Please enter product quantity at row " + i);
                adderr(2, index);
                return false;
            }

            if ($.trim(ProductPrice) == '') {
                $("#msg").html("Please enter product price at row " + i);
                adderr(3, index);
                return false;
            }

            if ($.trim(ProductAmount) == '') {
                $("#msg").html("Please enter product Amount at row " + i);
                adderr(4, index);
                return false;
            }

            if ($.trim(ProductFinalAmount) == '') {
                $("#msg").html("Please enter product final amount at row " + i);
                adderr(5, index);
                return false;
            }
            
            else {
                $("#msg").hide();
                return true;
            }
        }

        function fixGridView(tableEl) {
            var jTbl = $(tableEl);
            if (jTbl.find("tbody>tr>th").length > 0) {
                jTbl.find("tbody").before("<thead><tr></tr></thead>");
                jTbl.find("thead tr").append(jTbl.find("th"));
                jTbl.find("tbody tr:first").remove();
            }
        }

        function addnewrow(no) {
            debugger;
            var drpvalues = '';
            $.ajax({
                type: "POST",
                url: "DailyCallReport.aspx/GetProductList",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    drpvalues = data.d;
                    var drpValue = drpvalues.split(',');
                    var intProductCount = parseInt($('#hidProductCount').val());

                    var tblftpurl = document.getElementById("tblProduct");
                    var x = document.createElement('tr');
                    var y = document.createElement('td');
                    var z = document.createElement('select');
                    var new_option_element1 = new Option('Select', 'Select');
                    z.appendChild(new_option_element1);
                    for (var i = 0; i < drpValue.length; i++) {
                        var new_option_element = new Option(drpValue[i], drpValue[i]);
                        z.appendChild(new_option_element);
                    }

                    z.id = "ProductDetails_" + intProductCount + "__ProductName"; z.name = "ProductDetails[" + intProductCount + "].ProductName";
                    z.setAttribute("class", "form-control");

                    $(z).change(function () {
                        var RowNumber = intProductCount - 1;
                        return getProductPrice(RowNumber);
                    });
                    y.appendChild(z);
                    x.appendChild(y);

                    var y = document.createElement('td');
                    var z = document.createElement('input');
                    z.type = "text";
                    z.autocomplete = "off";
                    z.id = "ProductDetails_" + intProductCount + "__quotedqty"; z.name = "ProductDetails[" + intProductCount + "].quotedqty";
                    z.setAttribute("class", "form-control");
                    $(z).change(function () {
                        var RowNumber = intProductCount - 1;
                        return calcProductAmount(RowNumber);
                    });
                    y.appendChild(z);
                    x.appendChild(y);

                    var y = document.createElement('td');
                    var z = document.createElement('input');
                    z.type = "text";
                    z.autocomplete = "off";
                    z.id = "ProductDetails_" + intProductCount + "__quoteprice"; z.name = "ProductDetails[" + intProductCount + "].quoteprice";
                    z.setAttribute("class", "form-control");
                    $(z).change(function () {
                        var RowNumber = intProductCount - 1;
                        return calcProductAmount(RowNumber);
                    });
                    y.appendChild(z);
                    x.appendChild(y);

                    var y = document.createElement('td');
                    var z = document.createElement('input');
                    z.type = "text";
                    z.autocomplete = "off";
                    z.id = "ProductDetails_" + intProductCount + "__quoteamt"; z.name = "ProductDetails[" + intProductCount + "].quoteamt";
                    z.setAttribute("class", "form-control");
                    y.appendChild(z);
                    x.appendChild(y);

                    var y = document.createElement('td');
                    var z = document.createElement('input');
                    z.type = "text";
                    z.autocomplete = "off";
                    z.id = "ProductDetails_" + intProductCount + "__totalamount"; z.name = "ProductDetails[" + intProductCount + "].totalamount";
                    z.setAttribute("class", "form-control");
                    y.appendChild(z);
                    x.appendChild(y);

                    var y = document.createElement('td');
                    var add_del_but;
                    if (no == 1) {
                        add_del_but = $("<button><i class=\"fa fa-plus\"></i></button>").click(function () {
                            addnewrow(no + 1);
                        }).get(0);
                    }
                    else {
                        add_del_but = $("<button><i class=\"fa fa-minus\"></i></button>").click(function () {
                            var x = this.parentElement.parentElement;
                            var y = this.parentElement.parentElement.parentElement;
                            x.parentNode.removeChild(x);
                            //rebindFTPDetails();
                        }).get(0);
                    }
                    var z = document.createElement('input');
                    z.type = "image"; z.id = "btnminus_" + intProductCount;
                    z.setAttribute("src", "images/delImage_14_14.jpg");
                    z.addEventListener("click", function () {
                        var x = this.parentElement.parentElement;
                        var y = this.parentElement.parentElement.parentElement;
                        x.parentNode.removeChild(x);
                    });
                    y.appendChild(add_del_but);
                    x.appendChild(y);
                    tblProduct.tBodies[0].appendChild(x);
                    intProductCount = intProductCount + 1;
                    $('#hidProductCount').val(intProductCount);
                    return false;
                },
                error: function (data) {
                    console.log('ajax call error');
                }
            });
            
            
        }

        function addZero(i) {
            if (i < 10) {
                i = "0" + i;
            }
            return i;
        }

        function ValidateModal() {
            var rege = /^[1-9]\d*$/;
            var customeruser = $('#ddlcustomeruser option:selected').index();
            var prodname = $('#ddlProductName option:selected').index();
            var quoteqty = $('#txtquoteqty').val();
            var quoteprice = $('#txtquoteprice').val();
            var quoteamt = $('#txtquoteamt').val();
            var totalamount = $('#txttotalamount').val();
            var val = true

            if (customeruser == 0) {
                $('#ddlcustomeruser').parent().addClass('validate-has-error');
                customeruserHelper.innerHTML = "Please select User";
            } else {
                $('#ddlcustomeruser').parent().removeClass('validate-has-error');
                customeruserHelper.innerHTML = "";
            }

            if (prodname == 0) {
                $('#ddlProductName').parent().addClass('validate-has-error');
                ProductNameHelper.innerHTML = "Please select Product";
            } else {
                $('#ddlProductName').parent().removeClass('validate-has-error');
                ProductNameHelper.innerHTML = "";
            }

            if (quoteqty.length <= 0) {
                $('#txtquoteqty').parent().addClass('validate-has-error');
                quoteqtyHelper.innerHTML = "Please select amount target";
            }
            else if (!rege.test(quoteqty)) {
                $('#txtquoteqty').parent().addClass('validate-has-error');
                quoteqtyHelper.innerHTML = "Please enter numeric fields only";
            }
            else {
                $('#txtquoteqty').parent().removeClass('validate-has-error');
                quoteqtyHelper.innerHTML = "";
            }

            if (quoteprice == 0) {
                $('#txtquoteprice').parent().addClass('validate-has-error');
                quotepriceHelper.innerHTML = "Please enter quote price";
            }
            else if (!rege.test(quoteprice)) {
                $('#txtquoteprice').parent().addClass('validate-has-error');
                quotepriceHelper.innerHTML = "Please enter numeric fields only";
            }
            else {
                $('#txtquoteprice').parent().removeClass('validate-has-error');
                quotepriceHelper.innerHTML = "";
            }

            if (quoteamt == 0) {
                $('#txtquoteamt').parent().addClass('validate-has-error');
                quoteamtHelper.innerHTML = "Please quote amt";
            }
            else if (!rege.test(quoteamt)) {
                $('#txtquoteamt').parent().addClass('validate-has-error');
                quoteamtHelper.innerHTML = "Please enter numeric fields only";
            }
            else {
                $('#txtquoteamt').parent().removeClass('validate-has-error');
                quoteamtHelper.innerHTML = "";
            }

            if (totalamount == 0) {
                $('#txttotalamount').parent().addClass('validate-has-error');
                totalamountHelper.innerHTML = "Please enter total amount";
            }
            else if (!rege.test(totalamount)) {
                $('#txttotalamount').parent().addClass('validate-has-error');
                totalamountHelper.innerHTML = "Please enter numeric fields only";
            }
            else {
                $('#txttotalamount').parent().removeClass('validate-has-error');
                totalamountHelper.innerHTML = "";
            }
            if (($('.validate-has-error').length) > 0) {
                val = false;
            }
            else { val = true; }
            return val;
        }

        function ValidateDCR() {

            var rege = /^[1-9]\d*$/;
            var date = $('#txtdate').val();
            var AssignedTo = $('#ddlassignedto option:selected').val();
            var company = $('#txtcompany').val();
            var Email = $('#txtemail').val();
            var primarycontact = $('#txtprimarycontact').val();
            var Status = $('#ddlstatus option:selected').val();
            var Revenue = $('#txterevenue').val();
            var Source = $('#ddlsource  option:selected').val();
            var followupdate = $('#txtfollowupdate').val();
            var PinCode = $('#txtpincode').val();
            var Remarks = $('#txtremarks').val();
            var val = true

            if (date.length <= 0) {
                $('#txtdate').parent().addClass('validate-has-error');
                txtdateHelper.innerHTML = "Please select date";
            }
            else {
                $('#txtdate').parent().removeClass('validate-has-error');
                txtdateHelper.innerHTML = "";
            }

            if (AssignedTo == 0) {
                $('#ddlassignedto').parent().addClass('validate-has-error');
                ddlassignedtoHelper.innerHTML = "Please select Assigned to";
            } else {
                $('#ddlassignedto').parent().removeClass('validate-has-error');
                ddlassignedtoHelper.innerHTML = "";
            }

            if (company.length <= 0) {
                $('#txtcompany').parent().addClass('validate-has-error');
                txtcompanyHelper.innerHTML = "Please select company";
            }
            else {
                $('#txtcompany').parent().removeClass('validate-has-error');
                txtcompanyHelper.innerHTML = "";
            }

            if (Email.length <= 0) {
                $('#txtemail').parent().addClass('validate-has-error');
                EmailHelper.innerHTML = "Please enter email";
            }
            else {
                $('#txtemail').parent().removeClass('validate-has-error');
                EmailHelper.innerHTML = "";
            }

            if (primarycontact.length <= 0) {
                $('#txtprimarycontact').parent().addClass('validate-has-error');
                txtprimarycontactHelper.innerHTML = "Please enter Primary Contact";
            }
            else {
                $('#txtprimarycontact').parent().removeClass('validate-has-error');
                txtprimarycontactHelper.innerHTML = "";
            }

            if (Status == 0) {
                $('#ddlstatus').parent().addClass('validate-has-error');
                ddlstatusHelper.innerHTML = "Please select Status";
            } else {
                $('#ddlstatus').parent().removeClass('validate-has-error');
                ddlstatusHelper.innerHTML = "";
            }

            if (Revenue.length <= 0) {
                $('#txterevenue').parent().addClass('validate-has-error');
                ExpectedRevenueHelper.innerHTML = "Please enter expected revenue";
            }
            else {
                $('#txterevenue').parent().removeClass('validate-has-error');
                ExpectedRevenueHelper.innerHTML = "";
            }

            if (Source == 0) {
                $('#ddlsource').parent().addClass('validate-has-error');
                ddlSourceHelper.innerHTML = "Please select source";
            } else {
                $('#ddlsource').parent().removeClass('validate-has-error');
                ddlSourceHelper.innerHTML = "";
            }

            if (PinCode.length <= 0) {
                $('#txtpincode').parent().addClass('validate-has-error');
                PinCodeHelper.innerHTML = "Please enter Pincode";
            }
            else {
                $('#txtpincode').parent().removeClass('validate-has-error');
                PinCodeHelper.innerHTML = "";
            }

            if (Remarks.length <= 0) {
                $('#txtremarks').parent().addClass('validate-has-error');
                RemarksHelper.innerHTML = "Please enter remarks";
            }
            else {
                $('#txtremarks').parent().removeClass('validate-has-error');
                RemarksHelper.innerHTML = "";
            }

            if (followupdate.length <= 0) {
                $('#txtfollowupdate').parent().addClass('validate-has-error');
                txtfollowupdateHelper.innerHTML = "Please enter followup date";
            }
            else {
                $('#txtfollowupdate').parent().removeClass('validate-has-error');
                txtfollowupdateHelper.innerHTML = "";
            }

            if (($('.validate-has-error').length) > 0) {
                val = false;
            }
            else { val = true; }
            return val;
        }

        function EditDCR(ClientCustomerID) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "DailyCallReport.aspx/EditDCRDetails",
                data: "{'ClientCustomerID': '" + ClientCustomerID + "'}",
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
                        // Format date received via JSON response. Date retrieved is 1 day lesser, hence after parse added 1 extra day to get exact date. 
                        // this was known bug in JSON framework, discussed on StackOverFlow in detail and best Possible Solution was given to add 1 extra day. ;)
                        var d = /\/Date\((\d*)\)\//.exec(val.clientdate);
                        var d1 = new Date(+d[1]);
                        var yy = d1.getFullYear();
                        var mm = addZero(d1.getMonth() + 1);
                        var dd = addZero(d1.getDate());
                        $('#txtdate').val(yy + '-' + mm + '-' + dd);
                        $('#txtcompany').val(val.clientcustomername);
                        $('#txtfirstname').val(val.custfollowuppersonfn);
                        $('#txtoccupation').val(val.followuppersondesgn);
                        $('#txtprimarycontact').val(val.clientcustomerpcontact);
                        $('#txtwebsite').val(val.companywebsite);
                        $('#txterevenue').val(val.clientcustomerpamt)

                        var d2 = /\/Date\((\d*)\)\//.exec(val.custfollowupdate);
                        var d1a = new Date(+d2[1]);
                        var yy1 = d1a.getFullYear();
                        var mm1 = addZero(d1a.getMonth() + 1);
                        var dd1 = addZero(d1a.getDate());
                        $('#txtfollowupdate').val(yy1 + '-' + mm1 + '-' + dd1);

                        $('#txtcompanyadd1').val(val.clientcustomeradd1);
                        $('#txtcompanyadd2').val(val.clientcustomeradd2);
                        $('#txtaddresscity').val(val.clientcustomercity);
                        $('#txtaddressdist').val(val.clientcustomerdistrict);
                        $('#txtaddressstate').val(val.clientcustomerstate);
                        $('#txtaddresscountry').val(val.clientcustomercountry);
                        $('#txtpincode').val(val.clientcustomerpincode);
                        $('#txtremarks').val(val.clientremarks);

                        $("#<%=ddlassignedto.ClientID %>").val(val.customeruser);
                        $("#<%=ddlcompanytype.ClientID %>").val(val.clientcompanytype);
                        $('#txtlastname').val(val.custfollowuppersonln);
                        $('#txtemail').val(val.clientcustomeremailid);
                        $('#txtalternatecontact').val(val.clientcustomeracontact);
                        $("#<%=ddlstatus.ClientID %>").val(val.clientcustomerstatus);
                        $("#<%=ddlsource.ClientID %>").val(val.clientsource);
                        $('#txtsaddress1').val(val.shippingadd1);
                        $('#txtsaddress2').val(val.shippingadd2);
                        $('#txtscity').val(val.shippingcity);
                        $('#txtsdistrict').val(val.shippingdistrict);
                        $('#txtsstate').val(val.shippingstate);
                        $('#txtscountry').val(val.shippingcountry);
                        $('#txtspincode').val(val.shippingpincode);
                        $('#hdnClientCustID').val(val.clientcustomerid);
                        $('#btnSubmit').attr('value', 'Update');
                        $('#modal-dialog').on('show.bs.modal', function (event) {
                            $('#modal-dialog').insertAfter($('body'));
                        });
                        $('#modal-dialog').modal('show');
                    });
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("some error");
                }
            });
        }
        function GenerateQuotation(ClientCustomerID) {
            $('#modal_dialog1').on('show.bs.modal', function (event) {
                $('#modal_dialog1').insertAfter($('body'));
            });
            $("#ProductDetailRows").html("");
            $('#msg').hide();
            $('#hdnClientCustID').val(ClientCustomerID);
            $('#hidProductCount').val("0");

            if ($('#hidProductCount').val() == 0) {
                addnewrow('1');
            }
            $('#modal_dialog1').modal('show');
        }
    </script>
    <script type="text/javascript">
        jQuery(document).ready(function ($) {

            $("#ddlcustomeruser").select2({
                placeholder: 'Select Assignedto...',
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
            $("#btnAddDCR").click(function (e) {
                $('#modal-dialog').on('show.bs.modal', function (event) {
                    $('#modal-dialog').insertAfter($('body'));
                });
                $('#modal-dialog').modal('show');
            });
        });
    </script>
    <script>
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                if (ValidateDCR()) {
                    var clientdate = $('#txtdate').val();
                    var company = $('#txtcompany').val();
                    var firstname = $('#txtfirstname').val();
                    var occupation = $('#txtoccupation').val();
                    var primarycontact = $('#txtprimarycontact').val();
                    var website = $('#txtwebsite').val();
                    var erevenue = $('#txterevenue').val();
                    var followupdate = $('#txtfollowupdate').val();
                    var companyadd1 = $('#txtcompanyadd1').val();
                    var companyadd2 = $('#txtcompanyadd2').val();
                    var addresscity = $('#txtaddresscity').val();
                    var addressdist = $('#txtaddressdist').val();
                    var addressstate = $('#txtaddressstate').val();
                    var addresscountry = $('#txtaddresscountry').val();
                    var pincode = $('#txtpincode').val();
                    var remarks = $('#txtremarks').val();
                    var assignedto = $('#ddlassignedto option:selected').val();
                    var companytype = $('#ddlcompanytype option:selected').val();
                    var lastname = $('#txtlastname').val();
                    var email = $('#txtemail').val();
                    if ($('#txtalternatecontact').val() == ' ') {
                        var alternatecontact = '0';
                    }
                    else {
                        var alternatecontact = $('#txtalternatecontact').val();
                    }

                    var status = $('#ddlstatus option:selected').val();
                    var source = $('#ddlsource option:selected').val();
                    var saddress1 = $('#txtsaddress1').val();
                    var saddress2 = $('#txtsaddress2').val();
                    var scity = $('#txtscity').val();
                    var sdistrict = $('#txtsdistrict').val();
                    var sstate = $('#txtsstate').val();
                    var scountry = $('#txtscountry').val();
                    if ($('#txtspincode').val() == ' ') {
                        var spincode = '0';
                    }
                    else {
                        var spincode = $('#txtspincode').val();
                    }

                    var Mode = "";
                    var clientcustomerid = "0";
                    if ($('#btnSubmit').val() == "Update") {
                        Mode = "Update";
                        clientcustomerid = $('#hdnClientCustID').val();
                    }
                    else {
                        Mode = "Insert";
                    }

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "DailyCallReport.aspx/SaveDCR",
                        data: "{'clientdate': '" + clientdate + "', 'company': '" + company + "', 'firstname': '" + firstname + "', 'occupation': '" + occupation + "', 'primarycontact': '" + primarycontact + "', 'website': '" + website + "', 'erevenue': '" + erevenue + "', 'followupdate': '" + followupdate + "', 'companyadd1': '" + companyadd1 + "' , 'companyadd2': '" + companyadd2 + "', 'addresscity': '" + addresscity + "', 'addressdist': '" + addressdist + "', 'addressstate': '" + addressstate + "', 'addresscountry': '" + addresscountry + "', 'pincode': '" + pincode + "', 'remarks': '" + remarks + "', 'assignedto': '" + assignedto + "', 'companytype': '" + companytype + "', 'lastname': '" + lastname + "', 'email': '" + email + "', 'alternatecontact': '" + alternatecontact + "', 'status': '" + status + "', 'source': '" + source + "', 'saddress1': '" + saddress1 + "', 'saddress2': '" + saddress2 + "', 'scity': '" + scity + "', 'sdistrict': '" + sdistrict + "', 'sstate': '" + sstate + "', 'scountry': '" + scountry + "', 'spincode': '" + spincode + "', 'Mode': '" + Mode + "', 'clientcustomerid': '" + clientcustomerid + "'}",
                        dataType: "json",
                        beforeSend: function () {
                            $('#fullpageloading').show()
                        },
                        complete: function () {
                            $('#fullpageloading').hide();
                        },
                        success: function (data) {
                            $('#modal-dialog').modal('hide');
                            $.alert({
                                title: 'Confirm!',
                                content: 'Records Updated Successfully',
                                confirmButtonClass: 'btn-primary',
                                animation: 'zoom',
                                backgroundDismiss: false,
                                confirm: function () {
                                    window.top.location = "DailyCallReport.aspx";
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

    <script>
        $(document).ready(function () {
            $("#btnQuoteSubmit").click(function () {
                var inputs = new Array();
                var CheckIsValid = true;

                if (CheckIsValid) {
                    var customeruser = $('#ddlcustomeruser option:selected').index();
                    if (customeruser == 0) {
                        $("#msg").html("Please select assignee person");
                        $("#msg").show();
                        CheckIsValid = false;
                    }
                    else {
                        $("#tblProduct tbody tr").each(function (i, index) {
                            var ProductName = $(index).find("td:eq(0)").find("option:selected").text();
                            var ProductQTY = $(index).find("td:eq(1) input").val();
                            var ProductPrice = $(index).find("td:eq(2) input").val();
                            var ProductAmount = $(index).find("td:eq(3) input").val();
                            var ProductFinalAmount = $(index).find("td:eq(4) input").val();

                            if (!isvalid(ProductName, ProductQTY, ProductPrice, ProductAmount, ProductFinalAmount, i, index)) {
                                CheckIsValid = false;
                            }


                            var obj = new Info();

                            obj.ProductName = ProductName;
                            obj.ProductQTY = ProductQTY;
                            obj.ProductPrice = ProductPrice;
                            obj.ProductAmount = ProductAmount;
                            obj.ProductFinalAmount = ProductFinalAmount;
                            inputs.push(obj);
                        });
                    }
                }
                if (CheckIsValid) {
                    var AllData = JSON.stringify(inputs);
                    var customeruser = $('#ddlcustomeruser option:selected').val();
                    var clientcustid = $('#hdnClientCustID').val();

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "DailyCallReport.aspx/SaveQuotationDetails",
                        data: "{'clientcustid': '" + clientcustid + "', 'customeruser': '" + customeruser + "', 'AllData': '" + AllData + "'}",

                        dataType: "json",
                        beforeSend: function () {
                            $('#fullpageloading').show()
                        },
                        complete: function () {
                            $('#fullpageloading').hide();
                        },
                        success: function (data) {
                            $('#modal_dialog1').modal('hide');
                            $.alert({
                                title: 'Confirm!',
                                content: 'Quotation Generated Successfully',
                                confirmButtonClass: 'btn-primary',
                                animation: 'zoom',
                                backgroundDismiss: false,
                                confirm: function () {
                                    window.top.location = "DailyCallReport.aspx";
                                }
                            });
                        },
                        error: function (response) {
                            alert(response);
                        }
                    });
                }
                //}
                else { return false; }
            });
        });
    </script>
    <div class="page-title">
        <div class=" col-md-10 title-env">
            <h1 class="title">Daily Call Report</h1>
            <ol class="breadcrumb bc-1">
                <li>
                    <a href="/Dashboard.aspx">Dashboard</a>
                </li>
                <li class="active">
                    <strong>Daily Call Report</strong>
                </li>
            </ol>
            <h2 class="epg-tit">
                <asp:Label ID="lblCompanyName" runat="server"></asp:Label>
            </h2>
        </div>
    </div>
    <asp:HiddenField runat="server" ID="hdnClientCustID" ClientIDMode="Static" />
    <div class="row">
        <div id="modal-dialog" class="modal fade custom-width" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog" style="width: 60%;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                        <h4 class="modal-title">Daily Call Report - 
                            <asp:Label ID="lblModalCompanyName" runat="server"></asp:Label>
                        </h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class=" control-label" for="date">Date</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtdate" ClientIDMode="Static"></asp:TextBox>
                                    <span id="txtdateHelper" class="removespan"></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class="control-label" for="company">Company/Client Name</label>
                                    <asp:TextBox runat="server" class="form-control" name="company" ID="txtcompany" autocomplete="off" ClientIDMode="Static" MaxLength="100"></asp:TextBox>
                                    <span id="txtcompanyHelper" class="removespan"></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label" for="firstname">First Name</label>
                                    <asp:TextBox runat="server" class="form-control" name="firstname" ID="txtfirstname" autocomplete="off" ClientIDMode="Static" MaxLength="20"></asp:TextBox>
                                    <span id="txtfirstnameHelper" class="removespan"></span>
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
                                    <label class="control-label" for="primarycontactno">Primary Contact No</label>
                                    <asp:TextBox runat="server" class="form-control" name="primarycontactno" ID="txtprimarycontact" autocomplete="off" ClientIDMode="Static"></asp:TextBox>
                                    <span id="txtprimarycontactHelper" class="removespan"></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class=" control-label" for="website">Company Website</label>
                                    <asp:TextBox runat="server" class="form-control" name="website" ID="txtwebsite" ClientIDMode="Static" autocomplete="off" MaxLength="100"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class=" control-label" for="erevenue">Expected Revenue</label>
                                    <asp:TextBox runat="server" class="form-control" name="erevenue" ID="txterevenue" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                    <span id="ExpectedRevenueHelper" class="removespan"></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class=" control-label" for="followupdate">Follow Up Date</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtfollowupdate" ClientIDMode="Static"></asp:TextBox>
                                    <span id="txtfollowupdateHelper" class="removespan"></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class=" control-label" for="companyadd1">Company Address</label>
                                    <label class=" control-label" for="companyadd1">Address Line 1</label>
                                    <asp:TextBox runat="server" class="form-control" name="companyadd1" ID="txtcompanyadd1" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class=" control-label" for="companyadd2">Address Line 2</label>
                                    <asp:TextBox runat="server" class="form-control" name="companyadd2" ID="txtcompanyadd2" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class=" control-label" for="addresscity">City</label>
                                    <asp:TextBox runat="server" class="form-control" name="addresscity" ID="txtaddresscity" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class=" control-label" for="addressdistrict">District</label>
                                    <asp:TextBox runat="server" class="form-control" name="addressdistrict" ID="txtaddressdist" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class=" control-label" for="addressstate">State</label>
                                    <asp:TextBox runat="server" class="form-control" name="addressstate" ID="txtaddressstate" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class=" control-label" for="addresscountry">Country</label>
                                    <asp:TextBox runat="server" class="form-control" name="addresscountry" ID="txtaddresscountry" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class=" control-label" for="field-1">Assigned To</label>
                                    <asp:DropDownList ID="ddlassignedto" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:DropDownList>
                                    <span id="ddlassignedtoHelper" class="removespan"></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label" for="companytype">Company Type</label>
                                    <asp:DropDownList ID="ddlcompanytype" runat="server" CssClass="form-control" ClientIDMode="Static">
                                        <asp:ListItem Value="Electronics" Text="Electronics" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="Engineering" Text="Engineering"></asp:ListItem>
                                        <asp:ListItem Value="FMCG" Text="FMCG"></asp:ListItem>
                                        <asp:ListItem Value="Manufacturing" Text="Manufacturing"></asp:ListItem>
                                        <asp:ListItem Value="Technology" Text="Technology"></asp:ListItem>
                                        <asp:ListItem Value="Others" Text="Others"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label" for="occupation">Occupation</label>
                                    <asp:TextBox runat="server" class="form-control" name="occupation" ID="txtoccupation" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                    <span id="txtoccupationHelper" class="removespan"></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class="control-label" for="email">Email</label>
                                    <asp:TextBox runat="server" class="form-control" name="email" ID="txtemail" ClientIDMode="Static" autocomplete="off" TextMode="Phone" MaxLength="100"></asp:TextBox>
                                    <span id="EmailHelper" class="removespan"></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label" for="alternatecontact">Alternate Contact No</label>
                                    <asp:TextBox runat="server" class="form-control" name="alternatecontact" ID="txtalternatecontact" ClientIDMode="Static" autocomplete="off" TextMode="Phone" MaxLength="10" Text="0"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class="control-label" for="status">Status</label>
                                    <asp:DropDownList ID="ddlstatus" runat="server" CssClass="form-control" ClientIDMode="Static">
                                        <asp:ListItem Value="0" Text="Select Status"></asp:ListItem>
                                        <asp:ListItem Value="Prospect" Text="Prospect"></asp:ListItem>
                                        <asp:ListItem Value="Qualified" Text="Qualified"></asp:ListItem>
                                        <asp:ListItem Value="JunkLost" Text="Junk/Lost"></asp:ListItem>
                                        <asp:ListItem Value="Closed" Text="Closed"></asp:ListItem>
                                    </asp:DropDownList>
                                    <span id="ddlstatusHelper" class="removespan"></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class="control-label" for="source">Source</label>
                                    <asp:DropDownList ID="ddlsource" runat="server" CssClass="form-control" ClientIDMode="Static">
                                        <asp:ListItem Value="0" Text="Select Source"></asp:ListItem>
                                        <asp:ListItem Value="Existing_Data" Text="Existing Data"></asp:ListItem>
                                        <asp:ListItem Value="Self_Generated" Text="Self Generated"></asp:ListItem>
                                        <asp:ListItem Value="Web" Text="Web"></asp:ListItem>
                                        <asp:ListItem Value="Referral" Text="Referral"></asp:ListItem>
                                        <asp:ListItem Value="Others" Text="Others"></asp:ListItem>
                                    </asp:DropDownList>
                                    <span id="ddlSourceHelper" class="removespan"></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class=" control-label" for="companysadd1">Shipping Address</label>
                                    <label class=" control-label" for="companysadd1">Address Line 1</label>
                                    <asp:TextBox runat="server" class="form-control" name="companysadd1" ID="txtsaddress1" ClientIDMode="Static" autocomplete="off" MaxLength="50"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class=" control-label" for="companysadd2">Address Line 2</label>
                                    <asp:TextBox runat="server" class="form-control" name="companysadd2" ID="txtsaddress2" ClientIDMode="Static" autocomplete="off" MaxLength="50"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class=" control-label" for="saddresscity">City</label>
                                    <asp:TextBox runat="server" class="form-control" name="saddresscity" ID="txtscity" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class=" control-label" for="saddressdistrict">District</label>
                                    <asp:TextBox runat="server" class="form-control" name="saddressdistrict" ID="txtsdistrict" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class=" control-label" for="saddressstate">State</label>
                                    <asp:TextBox runat="server" class="form-control" name="saddressstate" ID="txtsstate" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class=" control-label" for="saddresscountry">Country</label>
                                    <asp:TextBox runat="server" class="form-control" name="saddresscountry" ID="txtscountry" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class=" control-label" for="spincode">Pincode</label>
                                    <asp:TextBox runat="server" class="form-control" name="spincode" ID="txtspincode" ClientIDMode="Static" autocomplete="on" MaxLength="6" Text="0"></asp:TextBox>
                                    <span id="sPinCodeHelper" class="removespan"></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class=" control-label" for="remarks">Remarks</label>
                                    <asp:TextBox runat="server" class="form-control" name="remarks" ID="txtremarks" ClientIDMode="Static" autocomplete="off" TextMode="MultiLine" MaxLength="1000"></asp:TextBox>
                                    <span id="RemarksHelper" class="removespan"></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class=" control-label" for="pincode">Pincode</label>
                                    <asp:TextBox runat="server" class="form-control" name="pincode" ID="txtpincode" ClientIDMode="Static" autocomplete="on" MaxLength="6"></asp:TextBox>
                                    <span id="PinCodeHelper" class="removespan"></span>
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
        <div id="modal_dialog1" class="modal fade custom-width" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog" style="width: 60%;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                        <h4 class="modal-title">Add Quotation - 
                            <asp:Label ID="lblQuotModalCompanyName" runat="server"></asp:Label>
                        </h4>
                    </div>
                    <div class="modal-body">
                        <div class="row"><div class="col-md-12">
                                <div class="form-group">
                                    <div class="error" id="msg"></div></div></div></div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group required">
                                    <label class=" control-label" for="customeruser1">Assigned To</label>
                                    <asp:DropDownList ID="ddlcustomeruser" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:DropDownList>
                                    <span id="customeruserHelper" class="removespan"></span>
                                </div>
                            </div>
                            <%--<div class="col-md-6">
                                <div class="form-group required">
                                    <label class="control-label" for="clientquotedproduct">Product</label>
                                    <asp:DropDownList ID="ddlProductName" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:DropDownList>
                                    <span id="ProductNameHelper" class="removespan"></span>
                                </div>
                            </div>--%>
                        </div>
                        <div class="row">
                            <%--<div class="col-md-6">
                                <div class="form-group required">
                                    <label class="control-label" for="quotedqty">Product Qty</label>
                                     <asp:TextBox runat="server" class="form-control" name="quotedqty" ID="txtquoteqty" autocomplete="off" ClientIDMode="Static" MaxLength="10"></asp:TextBox>
                                    <span id="quoteqtyHelper" class="removespan"></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class="control-label" for="quoteprice">Quote Price</label>
                                    <asp:TextBox runat="server" class="form-control" name="quoteprice" ID="txtquoteprice" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
                                    <span id="quotepriceHelper" class="removespan"></span>
                                </div>
                            </div>--%>
                            
                            <table id="tblProduct" class="table table-model-2 ftp">
                                <thead>
                                    <tr>
                                        <th>Product
                                        </th>
                                        <th>Product QTY
                                        </th>
                                        <th>Product Price
                                        </th>
                                        <th>Product Amount
                                        </th>
                                        <th>Product Final Amt
                                        </th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <%--<tbody id="ProductDetailRows" style="background-color: #fcfcfc">--%>
                                <tbody id="ProductDetailRows">
                                </tbody>
                            </table>
                            <asp:HiddenField runat="server" id="hidProductCount" ClientIDMode="Static" />
                        </div>
                        <%--<div class="row">
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class="control-label" for="quoteamt">Quoted Amount</label>
                                    <asp:TextBox runat="server" class="form-control" name="quoteamt" ID="txtquoteamt" autocomplete="off" ClientIDMode="Static" OnTextChanged="calculate_gst"></asp:TextBox>
                                    <span id="quoteamtHelper" class="removespan"></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group required">
                                    <label class="control-label" for="totalamt">Total Amount (Inclusive of GST)</label>
                                    <asp:TextBox runat="server" class="form-control" name="totalamount" ID="txttotalamount" autocomplete="off" ClientIDMode="Static"></asp:TextBox>
                                    <span id="totalamountHelper" class="removespan"></span>
                                </div>
                            </div>
                        </div>--%>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <button type="button" id="btnQuoteSubmit" class="btn btn-primary">Submit</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default blue-box">
                <div class="panel-heading">
                    <h3 class="panel-title">Daily Call Report
                    </h3>
                    <div class="panel-options"><a href="#" data-toggle="panel"><span class="collapse-icon">–</span> <span class="expand-icon">+</span> </a></div>
                </div>
                <div class="panel-body">
                    <div class="col-md-2 pull-right">
                        <button type="button" class="btn btn-info pull-right" id="btnAddDCR">Add DCR</button>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <table class="table table-striped table-bordered" border="1" id="grdDCR" style="border-collapse: collapse;">
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
