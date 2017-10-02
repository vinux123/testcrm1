<%@ Page Language="C#" MasterPageFile="~/VPCRMSMaster.master" AutoEventWireup="true" CodeFile="Test.aspx.cs" Inherits="Test" %>
<%--<head id="Head1" runat="server">
    <title></title>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
    
</head>--%>
<%--<body>--%>
    <%--<form id="form1" runat="server">--%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type='text/javascript'>
        function openModal() {
            $('#myModal').insertAfter($('body'));
            $('#myModal').modal('show');
        }
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <asp:UpdatePanel ID="updResult" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:DataList ID="GetMergedAll" runat="server" DataKeyName="CategoryID" OnItemCommand="GetMergedAll_ItemCommand1">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"CategoryName") %>'
                        Font-Bold="True " ForeColor="" Font-Size="" />
                    </h4>
                    <asp:Label ID="lblpost" runat="server" Text='<%# Eval("Description")%>' Font-Names="Comic Sans MS"
                        Font-Bold="False" Font-Strikeout="False" ForeColor="#333333">
                    </asp:Label>
                    <asp:Button ID="btnClick" Text="Click" runat="server" CommandName="SharePost" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"CategoryID") %>'
                        OnClick="btnClick_Click" />
                </ItemTemplate>
            </asp:DataList>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        &times;</button>
                    <h4 class="modal-title">
                        Modal Header</h4>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpdatePanel2model" runat="server">
                        <ContentTemplate>
                            <p>
                            </p>
                            <br />
                            <asp:FormView ID="SharePost" runat="server" CssClass=" table table-bordered table-striped table-hover">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtComment" runat="server" placeholder="Add Comment... " TextMode="MultiLine"
                                        CssClass="form-control" Height="80px"></asp:TextBox>
                                    <!-- Conversations are loaded here -->
                                    <div class="">
                                        <!-- Message. Default to the left -->
                                        <div class="" style="margin-bottom: 1px; margin-left: 8px; margin-top: 8px; margin-right: 8px">
                                            <div class=" " style="">
                                                <ul class="media-list">
                                                    <li class="media">
                                                        <div class="media-body">
                                                            <h5 class="media-heading">
                                                                <asp:Label ID="lblCategoryId" runat="server" Text='<%#Eval("CategoryID")%>' Font-Bold="True "
                                                                    ForeColor="#666666" />
                                                                <asp:Label ID="lblCategoryName" runat="server" Text='<%#Eval("CategoryName")%>' Font-Bold="True "
                                                                    ForeColor="#666666" />
                                                                <br />
                                                                <asp:Label ID="lblDescription" runat="server" Text='<%#Eval("Description")%>' Font-Size="X-Small"
                                                                    Font-Bold="True" ForeColor="Gray" />
                                                                <div class="clearfix">
                                                                </div>
                                                            </h5>
                                                            <div class=" col-lg-12" style="margin-top: 2px; margin-bottom: 2px">
                                                            </div>
                                                            <!-- Nested media object -->
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <!--/.direct-chat-messages-->
                                        <!-- Contacts are loaded here -->
                                    </div>
                                    <!-- /.box-body -->
                                    <asp:Button ID="btnSubmit" type="button" Text="Submit" OnClick="OnSubmit" class="btn btn-default"
                                        runat="server" />
                                </ItemTemplate>
                            </asp:FormView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="GetMergedAll" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        Close</button>
                </div>
            </div>
        </div>
    </div>
    </asp:Content>
    <%--</form>--%>
<%--</body>--%>