﻿<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description" content="Xenon Boostrap Admin Panel" />
<meta name="author" content="" />
<title>Exporter-create-schedule</title>
<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Arimo:400,700,400italic">
<link rel="stylesheet" href="assets/css/fonts/linecons/css/linecons.css">
<link rel="stylesheet" href="assets/css/fonts/fontawesome/css/font-awesome.min.css">
<link rel="stylesheet" href="assets/css/bootstrap.css">
<link rel="stylesheet" href="assets/css/xenon-core.css">
<link rel="stylesheet" href="assets/css/xenon-forms.css">
<link rel="stylesheet" href="assets/css/xenon-components.css">
<link rel="stylesheet" href="assets/css/xenon-skins.css">
<link rel="stylesheet" href="assets/css/custom.css">
<script src="assets/js/jquery-1.11.1.min.js"></script>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->

</head>
<body class="page-body  skin-navy">
<div class="page-container"><!-- add class "sidebar-collapsed" to close sidebar by default, "chat-visible" to make chat appear always --> 
  
  <!-- Add "fixed" class to make the sidebar fixed always to the browser viewport. --> 
  <!-- Adding class "toggle-others" will keep only one menu item open at a time. --> 
  <!-- Adding class "collapsed" collapse sidebar root elements and show only icons. -->
  <div class="sidebar-menu toggle-others fixed">
    <div class="sidebar-menu-inner">
      <header class="logo-env"> 
        
        <!-- logo -->
        <div class="logo"> <a href="#" class="logo-expanded"> <img src="assets/images/logo@2x.png"  alt="" /> </a> <a href="#" class="logo-collapsed"> <img src="assets/images/logo-collapsed@2x.png" width="40" alt="" /> </a> </div>
        
        <!-- This will toggle the mobile menu and will be visible only on mobile devices -->
        <div class="mobile-menu-toggle visible-xs"> <a href="#" data-toggle="user-info-menu"> <i class="fa-bell-o"></i> <span class="badge badge-success">7</span> </a> <a href="#" data-toggle="mobile-menu"> <i class="fa-bars"></i> </a> </div>
        
        <!-- This will open the popup with user profile settings, you can use for any purpose, just be creative --> 
        
      </header>
      <ul id="main-menu" class="main-menu">
        <!-- add class "multiple-expanded" to allow multiple submenus to open --> 
        <!-- class "auto-inherit-active-class" will automatically add "active" class for parent elements who are marked already with class "active" -->
        <li> <a href="#"> <i class="linecons-cog"></i> <span class="title">Dashboard</span> </a>
        <ul>
        	<li><a href="dashboard.html">User Dashboard</a></li>
        </ul>
         </li>
        <li><a href="#">  <i class="linecons-calendar"></i> <span class="title">Scheduler </span> </a>
          <ul>
            <li> <a href="assign_channel.html"> <span class="title">Assign Channels</span> </a> </li>
            <li> <a href="channel_package.html"> <span class="title">Format Packages</span> </a> </li>
            <li> <a href="create_schedule.html"> <span class="title">Generate EPG Files</span> </a> </li>
            <li> <a href="view_report.html"> <span class="title">View Report</span> </a> </li>
          </ul>
        </li>
         <li> <a href="#"> <i class="linecons-user"></i> <span class="title">Master </span> </a>
          <ul>
            <li> <a href="alert_notification.html"> <span class="title">Alert Notification</span> </a> </li> <li> <a href="Genre_subgenre_mapping.html"> <span class="title">Genre/Sub-genre Mapping</span> </a> </li>
            
          </ul>
        </li>
         <li> <a href="#"><i class="linecons-user"></i>  <span class="title">         Admin </span> </a>
          <ul>
            <li> <a href="FormGroupMapping.html"> <span class="title">Group Mapping</span> </a> </li>
            <li> <a href="schedule_unlocker.html"> <span class="title">Scheduler Unlocker</span> </a> </li>
              <li> <a href="traffic_keys.html"> <span class="title">Traffic Keys</span> </a> </li>
              <li> <a href="user_master.html"> <span class="title">User Master</span> </a> </li>
            
          </ul>
        </li>
          <li> <a href="#"><div class="fa-hover"><i class="fa fa-eye"></i> </div> <span class="title">Tracker </span> </a>
          <ul>
            <li> <a href="tracker.html"> <span class="title">Channel Tracker</span> </a> </li>
           
            
          </ul>
        </li>
      </ul>
    </div>
  </div>
  <div class="main-content"> 
    
    <!-- User Info, Notifications and Menu Bar -->
    <nav class="navbar user-info-navbar" role="navigation"> 
      
      <!-- Left links for user info navbar -->
      <ul class="user-info-menu left-links list-inline list-unstyled">
        <li class="hidden-sm hidden-xs"> <a href="#" data-toggle="sidebar"> <i class="fa-bars"></i> </a> </li>
      </ul>
      
      <!-- Right links for user info navbar -->
      <ul class="user-info-menu right-links list-inline list-unstyled">
        <li class="dropdown user-profile"> <a href="#" data-toggle="dropdown"> <img src="assets/images/user-4.png" alt="user-image" class="img-circle img-inline userpic-32" width="28" /> <span> Arlind Nushi <i class="fa-angle-down"></i> </span> </a>
          <ul class="dropdown-menu user-profile-menu list-unstyled">
            <li class="last"> <a href="extra-lockscreen.html"> <i class="fa-lock"></i> Logout </a> </li>
          </ul>
        </li>
      </ul>
    </nav>
    <!--main-content-->
    
    <div class="page-title ">
      <div class="title-env col-md-8">
         
        <h1 class="title">Traffic Keys</h1>
            <ol class="breadcrumb bc-1">
									<!--<li>
							<a href="dashboard-1.html"><i class="fa-home"></i>Home</a>
						</li>-->
								<li>
						
										<a href="ui-panels.html">Admin </a>
								</li>
							<li class="active">
						
										<strong>Traffic Keys</strong>
								</li>
								</ol>
         <h2 class="epg-tit" >EPG Scheduling System</h2>
      </div>
      <div class="col-md-2 pull-right">
        <button class="btn btn-info pull-right">View schedule</button>
      </div>
    </div>
    
    <!-- Basic Setup -->
    <div class="panel panel-default blue-box">
      <div class="panel-heading">
        <h3 class="panel-title">Traffickey Deletion
 </h3>
        <div class="panel-options">   <a href="#" data-toggle="panel"> <span class="collapse-icon">–</span> <span class="expand-icon">+</span> </a>     </div>
      </div>
      <div class="panel-body">
        <div class="row">
        <div class="col-md-12">
        <div class="form-group">Format Name<script type="text/javascript">
                                               jQuery(document).ready(function ($) {
                                                   $("#s2example-1").select2({
                                                       placeholder: 'Select format',
                                                       allowClear: true
                                                   }).on('select2-open', function () {
                                                       // Adding Custom Scrollbar
                                                       $(this).data('select2').results.addClass('overflow-hidden').perfectScrollbar();
                                                   });

                                               });
									</script>
									
									<select class="form-control" id="s2example-1">
										<option></option>
									 
											<option>Airtel PVR</option>
											<option>Hathway PVR</option>
										 
									 
										 
									</select>
										
										
					  </div>
        </div>
        <div class="col-md-12">
         <div class="form-group">Channel Name<script type="text/javascript">
                                                 jQuery(document).ready(function ($) {
                                                     $("#s2example-2").select2({
                                                         placeholder: 'Select your country...',
                                                         allowClear: true
                                                     }).on('select2-open', function () {
                                                         // Adding Custom Scrollbar
                                                         $(this).data('select2').results.addClass('overflow-hidden').perfectScrollbar();
                                                     });

                                                 });
									</script>
									
									<select class="form-control" id="s2example-2">
										<option></option>
										 
										 
											<option>Aaj tak</option>
											<option>9x</option>
											<option>Star plus</option>
											<option>Sony</option>
									 
									</select>
										
										
					  </div>
        
        </div>
        </div>
        <div class="row">
        <div class="col-md-12">
        <div class="form-group">From Date
          <input type="text" class="form-control datepicker" data-start-date="-2d" data-end-date="+1w">
									
								</div>
        </div>
        <div class="col-md-12">
      <div class="form-group">
									<label class=" control-label" for="field-1">Authentication Code</label>
									
									
										<input type="text" class="form-control" id="field-1" placeholder="Placeholder">
									
								</div>
        </div>
         
        </div>
         
         
         <div class="row">
         	<div class="col-md-2 pull-left text-left">
            <button class="btn btn-info ">Submit</button>
            </div>
         </div>
        
      </div>
    </div>
    
    
    
    
    <!--main-content-ends--> 
    <!-- Main Footer --> 
    <!-- Choose between footer styles: "footer-type-1" or "footer-type-2" --> 
    <!-- Add class "sticky" to  always stick the footer to the end of page (if page contents is small) --> 
    <!-- Or class "fixed" to  always fix the footer to the end of page -->
    <footer class="main-footer sticky footer-type-1">
      <div class="footer-inner"> 
        
        <!-- Add your copyright text here -->
        <div class="footer-text"> &copy; 2014 <strong>Exporter</strong> theme by <a href="#" target="_blank">Gracenote</a> </div>
        
        <!-- Go to Top Link, just add rel="go-top" to any link to add this functionality -->
        <div class="go-up"> <a href="#" rel="go-top"> <i class="fa-angle-up"></i> </a> </div>
      </div>
    </footer>
  </div>
</div>


	<!-- Imported styles on this page -->
	<link rel="stylesheet" href="assets/js/daterangepicker/daterangepicker-bs3.css">
	<link rel="stylesheet" href="assets/js/select2/select2.css">
	<link rel="stylesheet" href="assets/js/select2/select2-bootstrap.css">
	<link rel="stylesheet" href="assets/js/multiselect/css/multi-select.css">

	<!-- Bottom Scripts -->
	<script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/js/TweenMax.min.js"></script>
	<script src="assets/js/resizeable.js"></script>
	<script src="assets/js/joinable.js"></script>
	<script src="assets/js/xenon-api.js"></script>
	<script src="assets/js/xenon-toggles.js"></script>
	<script src="assets/js/moment.min.js"></script>


	<!-- Imported scripts on this page -->
	<script src="assets/js/daterangepicker/daterangepicker.js"></script>
	<script src="assets/js/datepicker/bootstrap-datepicker.js"></script>
	<script src="assets/js/timepicker/bootstrap-timepicker.min.js"></script>
	<script src="assets/js/colorpicker/bootstrap-colorpicker.min.js"></script>
	<script src="assets/js/select2/select2.min.js"></script>
	<script src="assets/js/jquery-ui/jquery-ui.min.js"></script>
	<script src="assets/js/selectboxit/jquery.selectBoxIt.min.js"></script>
	<script src="assets/js/tagsinput/bootstrap-tagsinput.min.js"></script>
	<script src="assets/js/typeahead.bundle.js"></script>
	<script src="assets/js/handlebars.min.js"></script>
	<script src="assets/js/multiselect/js/jquery.multi-select.js"></script>


	<!-- JavaScripts initializations and stuff -->
	<script src="assets/js/xenon-custom.js"></script>

</body>
</html>