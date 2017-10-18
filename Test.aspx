<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Test.aspx.cs" Inherits="Test" %>
<head>
	<title>VPCRMS Login</title>

	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Arimo:400,700,400italic">
	<link rel="stylesheet" href="assets/css/fonts/linecons/css/linecons.css">
	<link rel="stylesheet" href="assets/css/fonts/fontawesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="assets/css/bootstrap.css">
	<link rel="stylesheet" href="assets/css/xenon-core.css">
	<link rel="stylesheet" href="assets/css/xenon-forms.css">
	<link rel="stylesheet" href="assets/css/xenon-components.css">
	<link rel="stylesheet" href="assets/css/xenon-skins.css">
	<link rel="stylesheet" href="assets/css/custom.css">
    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            // Reveal Login form
            setTimeout(function () { $(".fade-in-effect").addClass('in'); }, 1);
            alert('aa');

            // Validation and Ajax action
            $("#login").validate({
                rules: {
                    username: {
                        required: true
                    },

                    passwd: {
                        required: true
                    }
                },

                messages: {
                    username: {
                        required: 'Please enter your username.'
                    },

                    passwd: {
                        required: 'Please enter your password.'
                    }
                }
            });

            // Set Form focus
            $("form#login .form-group:has(.form-control):first .form-control").focus();
        });
				</script>
	<script src="assets/js/jquery-1.11.1.min.js"></script>

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
	
	
</head>
<body class="page-body login-page login-light">

	
	<div class="login-container">
	
		<div class="row">
		
			<div class="col-sm-12">
			
				
				
				<!-- Errors container -->
				<div class="errors-container">
				
									
				</div>
				
				<!-- Add class "fade-in-effect" for login form effect -->
				<form method="post" role="form" id="login" class="login-form fade-in-effect" runat="server">
					
					<div class="login-header">
						<a href="dashboard-1.html" class="logo">
							<%--<img src="assets/images/gracenote_black.png" alt=""  /> --%>
							 
						</a>
						
						<p>Dear user, log in to access the admin area!</p>
					</div>
	
					
					<div class="form-group">
						<label class="control-label" for="username">Username</label>
						<%--<input type="text" class="form-control" name="username" id="username" autocomplete="off" />--%>
                        <asp:TextBox runat="server" class="form-control" name="username" id="txtusername" autocomplete="off" ClientIDMode="Static"></asp:TextBox>
					</div>
					
					<div class="form-group">
						<label class="control-label" for="passwd">Password</label>
						<%--<input type="password" class="form-control" name="passwd" id="passwd" autocomplete="off" />--%>
                        <asp:TextBox runat="server" class="form-control" name="passwd" id="txtpasswd" autocomplete="off" TextMode="Password" ClientIDMode="Static"></asp:TextBox>
					</div>
					
					<div class="form-group">
						<button type="submit" class="btn btn-primary  btn-block text-left">
							<i class="fa-lock"></i>
							Log In
						</button>
					</div>
					
					<div class="login-footer">
						<a href="#">Forgot your password?</a>
						
						
						
					</div>
					
				</form>
				
				<!-- External login -->
				 
				
			</div>
			
		</div>
		
	</div>



	<!-- Bottom Scripts -->
	<script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/js/TweenMax.min.js"></script>
	<script src="assets/js/resizeable.js"></script>
	<script src="assets/js/joinable.js"></script>
	<script src="assets/js/xenon-api.js"></script>
	<script src="assets/js/xenon-toggles.js"></script>
	<script src="assets/js/jquery-validate/jquery.validate.min.js"></script>
	<script src="assets/js/toastr/toastr.min.js"></script>


	<!-- JavaScripts initializations and stuff -->
	<script src="assets/js/xenon-custom.js"></script>

</body>
