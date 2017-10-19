<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CalendarControlwithDifferentDateRange.aspx.cs" Inherits="CalendarControlwithDifferentDateRange" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>jQuery UI Datepicker - Set Different Date Formats</title>

    <link href="Test/css/ui-lightness/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <script src="Test/js/jquery-1.7.2.min.js"></script>
    <script src="Test/js/jquery-ui-1.8.19.custom.min.js"></script>
<script type="text/javascript">
    $(function() {
        $("#txtDate").datepicker({ dateFormat: 'd MM, yy' });
    });
</script>
<style type="text/css">
.ui-datepicker { font-size:8pt !important}
</style>
</head>
<body>
<form id="form1" runat="server">
<div class="demo">
<b>Date:</b> <asp:TextBox ID="txtDate" runat="server"/>
</div>
</form>
</body>
</html>