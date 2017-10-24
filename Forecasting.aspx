

<%@ Page Language="C#" MasterPageFile="~/VPCRMSMaster.master" AutoEventWireup="true" CodeFile="Forecasting.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
                        <script type="text/javascript">
                            jQuery(document).ready(function ($) {
                                var dataSource = [
                                    { state: "China", oil: 4.95, gas: 2.85, coal: 45.56 },
                                    { state: "Russia", oil: 12.94, gas: 17.66, coal: 4.13 },
                                    { state: "USA", oil: 8.51, gas: 19.87, coal: 15.84 },
                                    { state: "Iran", oil: 5.3, gas: 4.39 },
                                    { state: "Canada", oil: 4.08, gas: 5.4 },
                                    { state: "Saudi Arabia", oil: 12.03 },
                                    { state: "Mexico", oil: 3.86 }
                                ];

                                $("#bar-5").dxChart({
                                    equalBarWidth: false,
                                    dataSource: dataSource,
                                    commonSeriesSettings: {
                                        argumentField: "state",
                                        type: "bar"
                                    },
                                    series: [
                                        { valueField: "oil", name: "Oil Production", color: "#0e62c7" },
                                        { valueField: "gas", name: "Gas Production", color: "#2c2e2f" },
                                        { valueField: "coal", name: "Coal Production", color: "#7c38bc" }
                                    ],
                                    legend: {
                                        verticalAlignment: "bottom",
                                        horizontalAlignment: "center"
                                    },
                                    title: ""
                                });
                            });
							</script>
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

        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            fixGridView($("#grdForecasting"));
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
            $("#grdForecasting").dataTable({
                aLengthMenu: [
                    [25, 50, 100, -1], [25, 50, 100, "All"]
                ]

            });

            $("#ddlstatus").select2({
                placeholder: 'Select Status...',
                allowClear: true
            }).on('select2-open', function () {
                // Adding Custom Scrollbar
                $(this).data('select2').results.addClass('overflow-hidden').perfectScrollbar();
            });

            $("#ddlsource").select2({
                placeholder: 'Select Source...',
                allowClear: true
            }).on('select2-open', function () {
                // Adding Custom Scrollbar
                $(this).data('select2').results.addClass('overflow-hidden').perfectScrollbar();
            });

            $("#ddlcompanytype").select2({
                placeholder: 'Select Company Type...',
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

            $("#ddlassignedto").select2({
                placeholder: 'Select Assignedto...',
                allowClear: true
            }).on('select2-open', function () {
                // Adding Custom Scrollbar
                $(this).data('select2').results.addClass('overflow-hidden').perfectScrollbar();
            });

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
                $('#modal-container').modal('hide');
            });

            //clear modal cache so that new contenet can be loaded
            $('.modal').on('hidden.bs.modal', function () {
                //                $(this).removeData('bs.modal');
                $(this).find("input,textarea,select").val('').end();
                $('.form-group').removeClass('validate-has-error');
                //$('span').html("");
                $('.modal').find('span').html("");
            });

            $('#CancelModal').on('click', function () {
                return false;
            });
        });
    </script>


    <div class="page-title">
        <div class=" col-md-10 title-env">
            <h1 class="title">Sales Forecasting</h1>
            <ol class="breadcrumb bc-1">
                <li>

                    <%--<a href="ui-panels.html">Admin </a>--%>
                    <a href="/Dashboard.aspx">Dashboard</a>
                </li>
                <li class="active">

                    <strong>Sales Forecasting</strong>
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
                    <h3 class="panel-title">Forecasting
       
                    </h3>
                    <div class="panel-options"><a href="#" data-toggle="panel"><span class="collapse-icon">–</span> <span class="expand-icon">+</span> </a></div>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="control-label">Select Status</label>
                                <script type="text/javascript">
                                    jQuery(document).ready(function ($) {
                                        $("#ddlstatus").selectBoxIt().on('open', function () {
                                            // Adding Custom Scrollbar
                                            $(this).data('selectBoxSelectBoxIt').list.perfectScrollbar();
                                        });
                                    });
                                </script>
                                <label class="control-label" for="status"></label>
                                <asp:DropDownList ID="ddlstatus" runat="server" CssClass="form-control" ClientIDMode="Static">
                                    <asp:ListItem Value="DCR" Text="DCR" Selected="True"></asp:ListItem>
                                    <asp:ListItem Value="Prospect" Text="Prospect"></asp:ListItem>
                                    <asp:ListItem Value="Qualified" Text="Qualified"></asp:ListItem>
                                    <asp:ListItem Value="JunkLost" Text="Junk/Lost"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class=" control-label" for="customeruser1">Assigned To</label>
                                <asp:DropDownList ID="ddlassignedto" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:DropDownList>

                            </div>
                        </div>
                    </div>
                    <div class="row"><div class="col-md-6"><div class="form-group">
                        <label class="cbr-inline">
                            <input type="radio" name="radio-2" class="cbr">
                            Monthly</label>
                        <label class="cbr-inline">
                            <input type="radio" name="radio-2" class="cbr">
                            Yearly</label>
                    </div></div>
                        <div class="col-md-2 pull-right">
                            <asp:Button ID="btnShow" runat="server"  class="btn btn-info pull-right" Text="Show" OnClick="btnShow_Click"/>
                    </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-12">
                            <asp:GridView ID="grdForecasting" class="table table-striped table-bordered" CellSpacing="0" Width="100%" runat="server"
                                EmptyDataText="No Records Found" ShowHeaderWhenEmpty="true" AutoGenerateColumns="False" ClientIDMode="Static">
                                <Columns>
                                    <asp:BoundField HeaderText="Client Name" DataField="clientcustomername">
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
                                    <asp:TemplateField HeaderStyle-Width="10%" HeaderText="Action">
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
            <div id="bar-5" style="height: 260px; width: 100%; -moz-user-select: none;" class="dx-visibility-change-handler">
                <svg style="display: block; overflow: hidden;" width="444" height="260" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" stroke="none" stroke-width="0" fill="none" class="dxc dxc-chart" direction="ltr"><defs><clipPath id="DevExpress_77"><rect x="0" y="0" width="444" height="260" rx="0" ry="0" fill="none" stroke="none" stroke-width="0"></rect></clipPath><pattern id="DevExpress_84" width="5" height="5" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="5" height="5" rx="0" ry="0" fill="#0e62c7" opacity="0.75"></rect><path stroke-width="2" stroke="#0e62c7" d="M 2.5 -2.5 L -2.5 2.5M 0 5 L 5 0 M 7.5 2.5 L 2.5 7.5"></path></pattern><pattern id="DevExpress_85" width="5" height="5" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="5" height="5" rx="0" ry="0" fill="#0e62c7" opacity="0.5"></rect><path stroke-width="2" stroke="#0e62c7" d="M 2.5 -2.5 L -2.5 2.5M 0 5 L 5 0 M 7.5 2.5 L 2.5 7.5"></path></pattern><pattern id="DevExpress_86" width="5" height="5" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="5" height="5" rx="0" ry="0" fill="#2c2e2f" opacity="0.75"></rect><path stroke-width="2" stroke="#2c2e2f" d="M 2.5 -2.5 L -2.5 2.5M 0 5 L 5 0 M 7.5 2.5 L 2.5 7.5"></path></pattern><pattern id="DevExpress_87" width="5" height="5" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="5" height="5" rx="0" ry="0" fill="#2c2e2f" opacity="0.5"></rect><path stroke-width="2" stroke="#2c2e2f" d="M 2.5 -2.5 L -2.5 2.5M 0 5 L 5 0 M 7.5 2.5 L 2.5 7.5"></path></pattern><pattern id="DevExpress_88" width="5" height="5" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="5" height="5" rx="0" ry="0" fill="#7c38bc" opacity="0.75"></rect><path stroke-width="2" stroke="#7c38bc" d="M 2.5 -2.5 L -2.5 2.5M 0 5 L 5 0 M 7.5 2.5 L 2.5 7.5"></path></pattern><pattern id="DevExpress_89" width="5" height="5" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="5" height="5" rx="0" ry="0" fill="#7c38bc" opacity="0.5"></rect><path stroke-width="2" stroke="#7c38bc" d="M 2.5 -2.5 L -2.5 2.5M 0 5 L 5 0 M 7.5 2.5 L 2.5 7.5"></path></pattern><clipPath id="DevExpress_90"><rect x="21" y="9" width="423" height="151" rx="0" ry="0" fill="none" stroke="none" stroke-width="0"></rect></clipPath><pattern id="DevExpress_78" width="6" height="6" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="6" height="6" rx="0" ry="0" fill="#0e62c7" opacity="0.75"></rect><path stroke-width="2" stroke="#0e62c7" d="M 3 -3 L -3 3M 0 6 L 6 0 M 9 3 L 3 9"></path></pattern><pattern id="DevExpress_79" width="6" height="6" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="6" height="6" rx="0" ry="0" fill="#0e62c7" opacity="0.5"></rect><path stroke-width="2" stroke="#0e62c7" d="M 3 -3 L -3 3M 0 6 L 6 0 M 9 3 L 3 9"></path></pattern><pattern id="DevExpress_80" width="6" height="6" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="6" height="6" rx="0" ry="0" fill="#2c2e2f" opacity="0.75"></rect><path stroke-width="2" stroke="#2c2e2f" d="M 3 -3 L -3 3M 0 6 L 6 0 M 9 3 L 3 9"></path></pattern><pattern id="DevExpress_81" width="6" height="6" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="6" height="6" rx="0" ry="0" fill="#2c2e2f" opacity="0.5"></rect><path stroke-width="2" stroke="#2c2e2f" d="M 3 -3 L -3 3M 0 6 L 6 0 M 9 3 L 3 9"></path></pattern><pattern id="DevExpress_82" width="6" height="6" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="6" height="6" rx="0" ry="0" fill="#7c38bc" opacity="0.75"></rect><path stroke-width="2" stroke="#7c38bc" d="M 3 -3 L -3 3M 0 6 L 6 0 M 9 3 L 3 9"></path></pattern><pattern id="DevExpress_83" width="6" height="6" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="6" height="6" rx="0" ry="0" fill="#7c38bc" opacity="0.5"></rect><path stroke-width="2" stroke="#7c38bc" d="M 3 -3 L -3 3M 0 6 L 6 0 M 9 3 L 3 9"></path></pattern><filter id="DevExpress_104" x="-50%" y="-50%" width="200%" height="200%"><feGaussianBlur in="SourceGraphic" result="gaussianBlurResult" stdDeviation="2"></feGaussianBlur><feOffset in="gaussianBlurResult" result="offsetResult" dx="0" dy="4"></feOffset><feFlood result="floodResult" flood-color="#000000" flood-opacity="0.4"></feFlood><feComposite in="floodResult" in2="offsetResult" operator="in" result="compositeResult"></feComposite><feComposite in="SourceGraphic" in2="compositeResult" operator="over"></feComposite></filter></defs><g class="dxc-background"></g><g class="dxc-strips-group"><g class="dxc-h-strips" clip-path="url(#DevExpress_90)"></g><g class="dxc-v-strips" clip-path="url(#DevExpress_90)"></g></g><g class="dxc-axes-group"><g class="dxc-h-axis" clip-path="url(#DevExpress_77)"><g class="dxc-grid"></g><g class="dxc-elements"><text style="fill: rgb(118, 118, 118); font-family: &quot;Segoe UI&quot;,&quot;Helvetica Neue&quot;,&quot;Trebuchet MS&quot;,Verdana; font-weight: 400; font-size: 12px; cursor: default;" x="51" y="183" text-anchor="middle" transform="rotate(0,0,0)"><tspan x="51" dy="0">China</tspan></text><text style="fill: rgb(118, 118, 118); font-family: &quot;Segoe UI&quot;,&quot;Helvetica Neue&quot;,&quot;Trebuchet MS&quot;,Verdana; font-weight: 400; font-size: 12px; cursor: default;" x="112" y="183" text-anchor="middle" transform="translate(0,22) rotate(0,0,0)"><tspan x="112" dy="0">Russia</tspan></text><text style="fill: rgb(118, 118, 118); font-family: &quot;Segoe UI&quot;,&quot;Helvetica Neue&quot;,&quot;Trebuchet MS&quot;,Verdana; font-weight: 400; font-size: 12px; cursor: default;" x="172" y="183" text-anchor="middle" transform="rotate(0,0,0)"><tspan x="172" dy="0">USA</tspan></text><text style="fill: rgb(118, 118, 118); font-family: &quot;Segoe UI&quot;,&quot;Helvetica Neue&quot;,&quot;Trebuchet MS&quot;,Verdana; font-weight: 400; font-size: 12px; cursor: default;" x="233" y="183" text-anchor="middle" transform="translate(0,22) rotate(0,0,0)"><tspan x="233" dy="0">Iran</tspan></text><text style="fill: rgb(118, 118, 118); font-family: &quot;Segoe UI&quot;,&quot;Helvetica Neue&quot;,&quot;Trebuchet MS&quot;,Verdana; font-weight: 400; font-size: 12px; cursor: default;" x="293" y="183" text-anchor="middle" transform="rotate(0,0,0)"><tspan x="293" dy="0">Canada</tspan></text><text style="fill: rgb(118, 118, 118); font-family: &quot;Segoe UI&quot;,&quot;Helvetica Neue&quot;,&quot;Trebuchet MS&quot;,Verdana; font-weight: 400; font-size: 12px; cursor: default;" x="353" y="183" text-anchor="middle" transform="translate(0,22) rotate(0,0,0)"><tspan x="353" dy="0">Saudi Arabia</tspan></text><text style="fill: rgb(118, 118, 118); font-family: &quot;Segoe UI&quot;,&quot;Helvetica Neue&quot;,&quot;Trebuchet MS&quot;,Verdana; font-weight: 400; font-size: 12px; cursor: default;" x="414" y="183" text-anchor="middle" transform="rotate(0,0,0)"><tspan x="414" dy="0">Mexico</tspan></text></g><g class="dxc-line"></g><g class="dxc-title"></g></g><g class="dxc-v-axis" clip-path="url(#DevExpress_77)"><g class="dxc-grid"><path stroke-width="1" stroke="#d3d3d3" d="M 21 160.5 L 444 160.5"></path><path stroke-width="1" stroke="#d3d3d3" d="M 21 130.5 L 444 130.5"></path><path stroke-width="1" stroke="#d3d3d3" d="M 21 100.5 L 444 100.5"></path><path stroke-width="1" stroke="#d3d3d3" d="M 21 70.5 L 444 70.5"></path><path stroke-width="1" stroke="#d3d3d3" d="M 21 39.5 L 444 39.5"></path><path stroke-width="1" stroke="#d3d3d3" d="M 21 9.5 L 444 9.5"></path></g><g class="dxc-elements"><text style="fill: rgb(118, 118, 118); font-family: &quot;Segoe UI&quot;,&quot;Helvetica Neue&quot;,&quot;Trebuchet MS&quot;,Verdana; font-weight: 400; font-size: 12px; cursor: default;" x="13" y="164" text-anchor="end"><tspan x="13" dy="0">0</tspan></text><text style="fill: rgb(118, 118, 118); font-family: &quot;Segoe UI&quot;,&quot;Helvetica Neue&quot;,&quot;Trebuchet MS&quot;,Verdana; font-weight: 400; font-size: 12px; cursor: default;" x="13" y="134" text-anchor="end"><tspan x="13" dy="0">10</tspan></text><text style="fill: rgb(118, 118, 118); font-family: &quot;Segoe UI&quot;,&quot;Helvetica Neue&quot;,&quot;Trebuchet MS&quot;,Verdana; font-weight: 400; font-size: 12px; cursor: default;" x="13" y="104" text-anchor="end"><tspan x="13" dy="0">20</tspan></text><text style="fill: rgb(118, 118, 118); font-family: &quot;Segoe UI&quot;,&quot;Helvetica Neue&quot;,&quot;Trebuchet MS&quot;,Verdana; font-weight: 400; font-size: 12px; cursor: default;" x="13" y="74" text-anchor="end"><tspan x="13" dy="0">30</tspan></text><text style="fill: rgb(118, 118, 118); font-family: &quot;Segoe UI&quot;,&quot;Helvetica Neue&quot;,&quot;Trebuchet MS&quot;,Verdana; font-weight: 400; font-size: 12px; cursor: default;" x="13" y="43" text-anchor="end"><tspan x="13" dy="0">40</tspan></text><text style="fill: rgb(118, 118, 118); font-family: &quot;Segoe UI&quot;,&quot;Helvetica Neue&quot;,&quot;Trebuchet MS&quot;,Verdana; font-weight: 400; font-size: 12px; cursor: default;" x="13" y="13" text-anchor="end"><tspan x="13" dy="0">50</tspan></text></g><g class="dxc-line"></g><g class="dxc-title"></g></g></g><g class="dxc-constant-lines-group"><g class="dxc-h-constant-lines"></g><g class="dxc-v-constant-lines"></g></g><g class="dxc-strips-labels-group"><g class="dxc-axis-labels"></g><g class="dxc-axis-labels"></g></g><g class="dxc-border"></g><g class="dxc-series-group"><g class="dxc-series"><g fill="#0e62c7" stroke="#0e62c7" stroke-width="0" class="dxc-markers" opacity="1" transform="translate(0,0) scale(1,1)"><rect x="30" y="145" width="12" height="15" rx="0" ry="0" stroke-width="0"></rect><rect x="91" y="121" width="12" height="39" rx="0" ry="0" stroke-width="0"></rect><rect x="151" y="134" width="12" height="26" rx="0" ry="0" stroke-width="0"></rect><rect x="211" y="144" width="19" height="16" rx="0" ry="0" stroke-width="0"></rect><rect x="271" y="148" width="19" height="12" rx="0" ry="0" stroke-width="0"></rect><rect x="332" y="124" width="42" height="36" rx="0" ry="0" stroke-width="0"></rect><rect x="393" y="148" width="42" height="12" rx="0" ry="0" stroke-width="0"></rect></g></g><g class="dxc-series"><g fill="#2c2e2f" stroke="#2c2e2f" stroke-width="0" class="dxc-markers" opacity="1" transform="translate(0,0) scale(1,1)"><rect x="45" y="151" width="12" height="9" rx="0" ry="0" stroke-width="0"></rect><rect x="106" y="107" width="12" height="53" rx="0" ry="0" stroke-width="0"></rect><rect x="166" y="100" width="12" height="60" rx="0" ry="0" stroke-width="0"></rect><rect x="234" y="147" width="19" height="13" rx="0" ry="0" stroke-width="0"></rect><rect x="294" y="144" width="19" height="16" rx="0" ry="0" stroke-width="0"></rect></g></g><g class="dxc-series"><g fill="#7c38bc" stroke="#7c38bc" stroke-width="0" class="dxc-markers" opacity="1" transform="translate(0,0) scale(1,1)"><rect x="60" y="23" width="12" height="137" rx="0" ry="0" stroke-width="0"></rect><rect x="121" y="148" width="12" height="12" rx="0" ry="0" stroke-width="0"></rect><rect x="181" y="112" width="12" height="48" rx="0" ry="0" stroke-width="0"></rect></g></g></g><g class="dxc-labels-group"><g class="dxc-labels" visibility="hidden" clip-path="url(#DevExpress_90)" opacity="1"></g><g class="dxc-labels" visibility="hidden" clip-path="url(#DevExpress_90)" opacity="1"></g><g class="dxc-labels" visibility="hidden" clip-path="url(#DevExpress_90)" opacity="1"></g></g><g class="dxc-crosshair-cursor"></g><g class="dxc-legend" clip-path="url(#DevExpress_77)" transform="translate(0,0)"><g transform="translate(75,219)"><g class="dxc-item" transform="translate(34,0)"><rect x="0" y="0" width="12" height="12" rx="0" ry="0" fill="#0e62c7"></rect><text style="fill: rgb(118, 118, 118); font-family: &quot;Segoe UI&quot;,&quot;Helvetica Neue&quot;,&quot;Trebuchet MS&quot;,Verdana; font-weight: 400; font-size: 12px; cursor: default;" x="6" y="27" text-anchor="middle"><tspan x="6" dy="0">Oil Production</tspan></text></g><g class="dxc-item" transform="translate(137,0)"><rect x="0" y="0" width="12" height="12" rx="0" ry="0" fill="#2c2e2f"></rect><text style="fill: rgb(118, 118, 118); font-family: &quot;Segoe UI&quot;,&quot;Helvetica Neue&quot;,&quot;Trebuchet MS&quot;,Verdana; font-weight: 400; font-size: 12px; cursor: default;" x="6" y="27" text-anchor="middle"><tspan x="6" dy="0">Gas Production</tspan></text></g><g class="dxc-item" transform="translate(244,0)"><rect x="0" y="0" width="12" height="12" rx="0" ry="0" fill="#7c38bc"></rect><text style="fill: rgb(118, 118, 118); font-family: &quot;Segoe UI&quot;,&quot;Helvetica Neue&quot;,&quot;Trebuchet MS&quot;,Verdana; font-weight: 400; font-size: 12px; cursor: default;" x="6" y="27" text-anchor="middle"><tspan x="6" dy="0">Coal Production</tspan></text></g></g><g class="dxc-legend-trackers" stroke="none" fill="grey" opacity="0.0001" transform="translate(75,219)"><rect x="-10" y="-4" width="101" height="39" rx="0" ry="0"></rect><rect x="91" y="-4" width="105" height="39" rx="0" ry="0"></rect><rect x="196" y="-4" width="109" height="39" rx="0" ry="0"></rect></g></g><g class="dxc-tooltip"><path d="M 0 0 Z" filter="url(#DevExpress_104)" stroke-width="1" stroke="#d3d3d3" visibility="hidden"></path><g style="font-family: &quot;Segoe UI&quot;,&quot;Helvetica Neue&quot;,&quot;Trebuchet MS&quot;,Verdana; font-weight: 400; font-size: 12px; fill: rgb(35, 35, 35); cursor: default;" text-anchor="middle" visibility="hidden"><text style="font-size: 12px;" x="0" y="0"></text></g></g><g class="dxc-trackers" opacity="0.0001" stroke="gray" fill="gray"><g class="dxc-crosshair-trackers" stroke="none" fill="grey"></g><g class="dxc-series-trackers"><g class="dxc-pane-tracker"><g></g><g></g><g></g></g></g><g class="dxc-markers-trackers" stroke="none" fill="grey"><g class="dxc-pane-tracker"><g clip-path="url(#DevExpress_90)"><rect x="30" y="145" width="12" height="15" rx="0" ry="0"></rect><rect x="91" y="121" width="12" height="39" rx="0" ry="0"></rect><rect x="151" y="134" width="12" height="26" rx="0" ry="0"></rect><rect x="211" y="144" width="19" height="16" rx="0" ry="0"></rect><rect x="271" y="148" width="19" height="12" rx="0" ry="0"></rect><rect x="332" y="124" width="42" height="36" rx="0" ry="0"></rect><rect x="393" y="148" width="42" height="12" rx="0" ry="0"></rect></g><g clip-path="url(#DevExpress_90)"><rect x="45" y="151" width="12" height="9" rx="0" ry="0"></rect><rect x="106" y="107" width="12" height="53" rx="0" ry="0"></rect><rect x="166" y="100" width="12" height="60" rx="0" ry="0"></rect><rect x="234" y="147" width="19" height="13" rx="0" ry="0"></rect><rect x="294" y="144" width="19" height="16" rx="0" ry="0"></rect></g><g clip-path="url(#DevExpress_90)"><rect x="60" y="23" width="12" height="137" rx="0" ry="0"></rect><rect x="121" y="148" width="12" height="12" rx="0" ry="0"></rect><rect x="181" y="112" width="12" height="48" rx="0" ry="0"></rect></g></g></g></g></svg></div>
                    </div></div>
                </div>
            </div>
        </div>
    </div>
    <!--main-content-ends-->

</asp:Content>
