<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="Xenon Boostrap Admin Panel" />
    <meta name="author" content="Laborator.co" />
    <title>Xenon - Form Validation</title>
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Arimo:400,700,400italic" id="style-resource-1">
    <link rel="stylesheet" href="http://themes.laborator.co/xenon/assets/css/fonts/linecons/css/linecons.css" id="style-resource-2">
    <link rel="stylesheet" href="http://themes.laborator.co/xenon/assets/css/fonts/fontawesome/css/font-awesome.min.css" id="style-resource-3">
    <link rel="stylesheet" href="http://themes.laborator.co/xenon/assets/css/bootstrap.css" id="style-resource-4">
    <link rel="stylesheet" href="http://themes.laborator.co/xenon/assets/css/xenon-core.css" id="style-resource-5">
    <link rel="stylesheet" href="http://themes.laborator.co/xenon/assets/css/xenon-forms.css" id="style-resource-6">
    <link rel="stylesheet" href="http://themes.laborator.co/xenon/assets/css/xenon-components.css" id="style-resource-7">
    <link rel="stylesheet" href="http://themes.laborator.co/xenon/assets/css/xenon-skins.css" id="style-resource-8">
    <link rel="stylesheet" href="http://themes.laborator.co/xenon/assets/css/custom.css" id="style-resource-9">
    <script src="http://themes.laborator.co/xenon/assets/js/jquery-1.11.1.min.js"></script>
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]> <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script> <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script> <![endif]-->
    <!-- TS1508044689: Xenon - Boostrap Admin Template created by Laborator -->
</head>
<body class="page-body">
    <!-- TS150804468917608: Xenon - Boostrap Admin Template created by Laborator / Please buy this theme and support the updates -->
    <!-- TS150804468919810: Xenon - Boostrap Admin Template created by Laborator / Please buy this theme and support the updates -->
    
    <div class="page-container">
        <!-- TS15080446891034: Xenon - Boostrap Admin Template created by Laborator / Please buy this theme and support the updates -->
        
        <div class="main-content">
            <!-- TS150804468912982: Xenon - Boostrap Admin Template created by Laborator / Please buy this theme and support the updates -->
            <nav class="navbar user-info-navbar fixed" role="navigation">
                <ul class="user-info-menu left-links list-inline list-unstyled">
                    <li class="hidden-sm hidden-xs"><a href="#" data-toggle="sidebar"><i class="fa-bars"></i></a></li>
                    <li class="dropdown hover-line"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa-envelope-o"></i><span class="badge badge-green">15</span> </a>
                        <ul class="dropdown-menu messages">
                            <!-- TS150804468918082: Xenon - Boostrap Admin Template created by Laborator / Please buy this theme and support the updates -->
                            <li>
                                <ul class="dropdown-menu-list list-unstyled ps-scrollbar">
                                    <li class="active"><a href="#"><span class="line"><strong>Luc Chartier</strong> <span class="light small">- yesterday</span> </span><span class="line desc small">This ain’t our first item, it is the best of the rest.
                                    </span></a></li>
                                    <li class="active"><a href="#"><span class="line"><strong>Salma Nyberg</strong> <span class="light small">- 2 days ago</span> </span><span class="line desc small">Oh he decisively impression attachment friendship so if everything.
                                    </span></a></li>
                                    <li><a href="#"><span class="line">Hayden Cartwright
                                        <span class="light small">- a week ago</span> </span><span class="line desc small">Whose her enjoy chief new young. Felicity if ye required likewise so doubtful.
                                        </span></a></li>
                                    <li><a href="#"><span class="line">Sandra Eberhardt
                                        <span class="light small">- 16 days ago</span> </span><span class="line desc small">On so attention necessary at by provision otherwise existence direction.
                                        </span></a></li>
                                    <!-- Repeated -->
                                    <li class="active"><a href="#"><span class="line"><strong>Luc Chartier</strong> <span class="light small">- yesterday</span> </span><span class="line desc small">This ain’t our first item, it is the best of the rest.
                                    </span></a></li>
                                    <li class="active"><a href="#"><span class="line"><strong>Salma Nyberg</strong> <span class="light small">- 2 days ago</span> </span><span class="line desc small">Oh he decisively impression attachment friendship so if everything.
                                    </span></a></li>
                                    <li><a href="#"><span class="line">Hayden Cartwright
                                        <span class="light small">- a week ago</span> </span><span class="line desc small">Whose her enjoy chief new young. Felicity if ye required likewise so doubtful.
                                        </span></a></li>
                                    <li><a href="#"><span class="line">Sandra Eberhardt
                                        <span class="light small">- 16 days ago</span> </span><span class="line desc small">On so attention necessary at by provision otherwise existence direction.
                                        </span></a></li>
                                </ul>
                            </li>
                            <li class="external"><a href="http://themes.laborator.co/xenon/ui/mailbox-main/"><span>All Messages</span> <i class="fa-link-ext"></i></a></li>
                        </ul>
                    </li>
                    <li class="dropdown hover-line"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa-bell-o"></i><span class="badge badge-purple">7</span> </a>
                        <ul class="dropdown-menu notifications">
                            <!-- TS15080446893714: Xenon - Boostrap Admin Template created by Laborator / Please buy this theme and support the updates -->
                            <li class="top">
                                <p class="small">
                                    <a href="#" class="pull-right">Mark all Read</a>
                                    You have <strong>3</strong> new notifications.
                                </p>
                            </li>
                            <li>
                                <ul class="dropdown-menu-list list-unstyled ps-scrollbar">
                                    <li class="active notification-success"><a href="#"><i class="fa-user"></i><span class="line"><strong>New user registered</strong> </span><span class="line small time">30 seconds ago
                                    </span></a></li>
                                    <li class="active notification-secondary"><a href="#"><i class="fa-lock"></i><span class="line"><strong>Privacy settings have been changed</strong> </span><span class="line small time">3 hours ago
                                    </span></a></li>
                                    <li class="notification-primary"><a href="#"><i class="fa-thumbs-up"></i><span class="line"><strong>Someone special liked this</strong> </span><span class="line small time">2 minutes ago
                                    </span></a></li>
                                    <li class="notification-danger"><a href="#"><i class="fa-calendar"></i><span class="line">John cancelled the event
                                    </span><span class="line small time">9 hours ago
                                    </span></a></li>
                                    <li class="notification-info"><a href="#"><i class="fa-database"></i><span class="line">The server is status is stable
                                    </span><span class="line small time">yesterday at 10:30am
                                    </span></a></li>
                                    <li class="notification-warning"><a href="#"><i class="fa-envelope-o"></i><span class="line">New comments waiting approval
                                    </span><span class="line small time">last week
                                    </span></a></li>
                                </ul>
                            </li>
                            <li class="external"><a href="#"><span>View all notifications</span> <i class="fa-link-ext"></i></a></li>
                        </ul>
                    </li>
                    <li class="dropdown hover-line language-switcher"><a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <img src="http://themes.laborator.co/xenon/assets/images/flags/flag-uk.png" alt="flag-uk" />
                        English
                    </a>
                        <ul class="dropdown-menu languages">
                            <li><a href="#">
                                <img src="http://themes.laborator.co/xenon/assets/images/flags/flag-al.png" alt="flag-al" />
                                Shqip
                            </a></li>
                            <li class="active"><a href="#">
                                <img src="http://themes.laborator.co/xenon/assets/images/flags/flag-uk.png" alt="flag-uk" />
                                English
                            </a></li>
                            <li><a href="#">
                                <img src="http://themes.laborator.co/xenon/assets/images/flags/flag-de.png" alt="flag-de" />
                                Deutsch
                            </a></li>
                            <li><a href="#">
                                <img src="http://themes.laborator.co/xenon/assets/images/flags/flag-fr.png" alt="flag-fr" />
                                Fran&ccedil;ais
                            </a></li>
                            <li><a href="#">
                                <img src="http://themes.laborator.co/xenon/assets/images/flags/flag-br.png" alt="flag-br" />
                                Portugu&ecirc;s
                            </a></li>
                            <li><a href="#">
                                <img src="http://themes.laborator.co/xenon/assets/images/flags/flag-es.png" alt="flag-es" />
                                Espa&ntilde;ol
                            </a></li>
                        </ul>
                    </li>
                </ul>
                <ul class="user-info-menu right-links list-inline list-unstyled">
                    <li class="search-form">
                        <form name="userinfo_search_form" method="get" action="http://themes.laborator.co/xenon/extra/search/">
                            <input type="text" name="s" class="form-control search-field" placeholder="Type to search..." />
                            <button type="submit" class="btn btn-link"><i class="linecons-search"></i></button>
                        </form>
                    </li>
                    <li class="dropdown user-profile"><a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <img src="http://themes.laborator.co/xenon/assets/images/user-4.png" alt="user-image" class="img-circle img-inline userpic-32" width="28" />
                        <span>John Smith
                            <i class="fa-angle-down"></i></span></a>
                        <ul class="dropdown-menu user-profile-menu list-unstyled">
                            <li><a href="#edit-profile"><i class="fa-edit"></i>
                                New Post
                            </a></li>
                            <li><a href="#settings"><i class="fa-wrench"></i>
                                Settings
                            </a></li>
                            <li><a href="#profile"><i class="fa-user"></i>
                                Profile
                            </a></li>
                            <li><a href="#help"><i class="fa-info"></i>
                                Help
                            </a></li>
                            <li class="last"><a href="http://themes.laborator.co/xenon/extra/lockscreen/"><i class="fa-lock"></i>
                                Logout
                            </a></li>
                        </ul>
                    </li>
                    <li><a href="#" data-toggle="chat"><i class="fa-comments-o"></i></a></li>
                </ul>
            </nav>
            <!-- TS150804468911185: Xenon - Boostrap Admin Template created by Laborator / Please buy this theme and support the updates -->
            <!-- TS15080446897938: Xenon - Boostrap Admin Template created by Laborator / Please buy this theme and support the updates -->
            <div class="page-title">
                <div class="title-env">
                    <h1 class="title">Form Validation</h1>
                    <p class="description">Plain text boxes, select dropdowns and other basic form elements</p>
                </div>
                <div class="breadcrumb-env">
                    <ol class="breadcrumb bc-1">
                        <li><a href="http://themes.laborator.co/xenon/dashboard/variant-1/"><i class="fa-home"></i>Home</a> </li>
                        <li><a href="http://themes.laborator.co/xenon/forms/native/">Forms</a> </li>
                        <li class="active"><strong>Form Validation</strong> </li>
                    </ol>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="panel-title">
                        Input validation
                    </div>
                    <small class="text-small pull-right" style="padding-top: 5px;"><code>data-validate="rule1,rule2,...,ruleN"</code> </small>
                </div>
                <div class="panel-body">
                    <form role="form" id="form1" method="post" class="validate">
                        <div class="form-group">
                            <label class="control-label">Required Field + Custom Message</label>
                            <input type="text" class="form-control" name="name" data-validate="required" data-message-required="This is custom message for required field." placeholder="Required Field" />
                        </div>
                        <div class="form-group">
                            <label class="control-label">Email Field</label>
                            <input type="text" class="form-control" name="email" data-validate="email" placeholder="Email Field" />
                        </div>
                        <div class="form-group">
                            <label class="control-label">Input Min Field</label>
                            <input type="text" class="form-control" name="min_field" data-validate="number,minlength[4]" placeholder="Numeric + Minimun Length Field" />
                        </div>
                        <div class="form-group">
                            <label class="control-label">Input Max Field</label>
                            <input type="text" class="form-control" name="max_field" data-validate="maxlength[2]" placeholder="Maximum Length Field" />
                        </div>
                        <div class="form-group">
                            <label class="control-label">Numeric Field</label>
                            <input type="text" class="form-control" name="number" data-validate="number" placeholder="Numeric Field" />
                        </div>
                        <div class="form-group">
                            <label class="control-label">URL Field</label>
                            <input type="text" class="form-control" name="url" data-validate="required,url" placeholder="URL" />
                        </div>
                        <div class="form-group">
                            <label class="control-label">Credit Card Field</label>
                            <input type="text" class="form-control" name="creditcard" data-validate="required,creditcard" placeholder="Credit Card" />
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-success">Validate</button>
                            <button type="reset" class="btn btn-white">Reset</button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- TS15080446895970: Xenon - Boostrap Admin Template created by Laborator / Please buy this theme and support the updates -->
            <!-- Main Footer -->
            <footer class="main-footer sticky footer-type-1">
                <div class="footer-inner">
                    <div class="footer-text">
                        &copy; 2017 
                        <strong>Xenon</strong>
                        theme by <a href="http://laborator.co" target="_blank">Laborator</a> - <a href="http://themeforest.net/item/xenon-bootstrap-admin-theme/9059661?ref=Laborator" target="_blank">Purchase for only <strong>24$</strong></a>
                    </div>
                    <div class="go-up"><a href="#" rel="go-top"><i class="fa-angle-up"></i></a></div>
                </div>
            </footer>
        </div>
        <!-- TS15080446895878: Xenon - Boostrap Admin Template created by Laborator / Please buy this theme and support the updates -->
        <div id="chat" class="fixed">
            <div class="chat-inner">
                <h2 class="chat-header"><a href="#" class="chat-close" data-toggle="chat"><i class="fa-plus-circle rotate-45deg"></i></a>
                    Chat
                    <span class="badge badge-success is-hidden">0</span> </h2>
                <script type="text/javascript">
                    // Here is just a sample how to open chat conversation box
                    jQuery(document).ready(function ($) {
                        var $chat_conversation = $(".chat-conversation");
                        $(".chat-group a").on('click', function (ev) {
                            ev.preventDefault();
                            $chat_conversation.toggleClass('is-open');
                            $(".chat-conversation textarea").trigger('autosize.resize').focus();
                        });
                        $(".conversation-close").on('click', function (ev) {
                            ev.preventDefault();
                            $chat_conversation.removeClass('is-open');
                        });
                    });
                </script>
                <div class="chat-group"><strong>Favorites</strong> <a href="#"><span class="user-status is-online"></span><em>Catherine J. Watkins</em></a> <a href="#"><span class="user-status is-online"></span><em>Nicholas R. Walker</em></a> <a href="#"><span class="user-status is-busy"></span><em>Susan J. Best</em></a> <a href="#"><span class="user-status is-idle"></span><em>Fernando G. Olson</em></a> <a href="#"><span class="user-status is-offline"></span><em>Brandon S. Young</em></a> </div>
                <div class="chat-group"><strong>Work</strong> <a href="#"><span class="user-status is-busy"></span><em>Rodrigo E. Lozano</em></a> <a href="#"><span class="user-status is-offline"></span><em>Robert J. Garcia</em></a> <a href="#"><span class="user-status is-offline"></span><em>Daniel A. Pena</em></a> </div>
                <div class="chat-group"><strong>Other</strong> <a href="#"><span class="user-status is-online"></span><em>Dennis E. Johnson</em></a> <a href="#"><span class="user-status is-online"></span><em>Stuart A. Shire</em></a> <a href="#"><span class="user-status is-online"></span><em>Janet I. Matas</em></a> <a href="#"><span class="user-status is-online"></span><em>Mindy A. Smith</em></a> <a href="#"><span class="user-status is-busy"></span><em>Herman S. Foltz</em></a> <a href="#"><span class="user-status is-busy"></span><em>Gregory E. Robie</em></a> <a href="#"><span class="user-status is-busy"></span><em>Nellie T. Foreman</em></a> <a href="#"><span class="user-status is-busy"></span><em>William R. Miller</em></a> <a href="#"><span class="user-status is-idle"></span><em>Vivian J. Hall</em></a> <a href="#"><span class="user-status is-offline"></span><em>Melinda A. Anderson</em></a> <a href="#"><span class="user-status is-offline"></span><em>Gary M. Mooneyham</em></a> <a href="#"><span class="user-status is-offline"></span><em>Robert C. Medina</em></a> <a href="#"><span class="user-status is-offline"></span><em>Dylan C. Bernal</em></a> <a href="#"><span class="user-status is-offline"></span><em>Marc P. Sanborn</em></a> <a href="#"><span class="user-status is-offline"></span><em>Kenneth M. Rochester</em></a> <a href="#"><span class="user-status is-offline"></span><em>Rachael D. Carpenter</em></a> </div>
            </div>
            <!-- conversation template -->
            <div class="chat-conversation">
                <div class="conversation-header">
                    <a href="#" class="conversation-close">&times;
                    </a><span class="user-status is-online"></span><span class="display-name">Arlind Nushi</span> <small>Online</small>
                </div>
                <ul class="conversation-body">
                    <li><span class="user">Arlind Nushi</span> <span class="time">09:00</span>
                        <p>Are you here?</p>
                    </li>
                    <li class="odd"><span class="user">Brandon S. Young</span> <span class="time">09:25</span>
                        <p>This message is pre-queued.</p>
                    </li>
                    <li><span class="user">Brandon S. Young</span> <span class="time">09:26</span>
                        <p>Whohoo!</p>
                    </li>
                    <li class="odd"><span class="user">Arlind Nushi</span> <span class="time">09:27</span>
                        <p>Do you like it?</p>
                    </li>
                </ul>
                <div class="chat-textarea">
                    <textarea class="form-control autogrow" placeholder="Type your message"></textarea>
                </div>
            </div>
        </div>
    </div>
    <!-- TS15080446899479: Xenon - Boostrap Admin Template created by Laborator / Please buy this theme and support the updates -->
    <div class="footer-sticked-chat">
        <script type="text/javascript">
            function toggleSampleChatWindow() {
                var $chat_win = jQuery("#sample-chat-window");
                $chat_win.toggleClass('open');
                if ($chat_win.hasClass('open')) {
                    var $messages = $chat_win.find('.ps-scrollbar');
                    if ($.isFunction($.fn.perfectScrollbar)) {
                        $messages.perfectScrollbar('destroy');
                        setTimeout(function () {
                            $messages.perfectScrollbar();
                            $chat_win.find('.form-control').focus();
                        }, 300);
                    }
                }
                jQuery("#sample-chat-window form").on('submit', function (ev) {
                    ev.preventDefault();
                });
            }
            jQuery(document).ready(function ($) {
                $(".footer-sticked-chat .chat-user, .other-conversations-list a").on('click', function (ev) {
                    ev.preventDefault();
                    toggleSampleChatWindow();
                });
                $(".mobile-chat-toggle").on('click', function (ev) {
                    ev.preventDefault();
                    $(".footer-sticked-chat").toggleClass('mobile-is-visible');
                });
            });
        </script>
        <ul class="chat-conversations list-unstyled">
            <li class="browse-more"><a href="#" class="chat-user"><i class="linecons-comment"></i><span>3</span> </a>
                <ul class="other-conversations-list">
                    <li><a href="#">Catherine J. Watkins
                        <span>&times;</span> </a></li>
                    <li><a href="#">Nicholas R. Walker
                        <span>&times;</span> </a></li>
                    <li><a href="#">Susan J. Best
                        <span>&times;</span> </a></li>
                </ul>
            </li>
            <li id="sample-chat-window"><a href="#" class="chat-user"><span class="user-status is-online"></span>
                Art Ramadani
            </a><span class="badge badge-purple">4</span>
                <div class="conversation-window">
                    <a href="#" class="chat-user"><span class="close">&times;</span> <span class="user-status is-online"></span>
                        Art Ramadani
                    </a>
                    <ul class="conversation-messages ps-scrollbar ps-scroll-down">
                        <li class="time">Friday 13, October '17</li>
                        <li>
                            <div class="user-info"><a href="#">
                                <img src="http://themes.laborator.co/xenon/assets/images/user-1.png" width="30" height="30" alt="user-image" />
                            </a></div>
                            <div class="message-entry">
                                <p>Hello John, how are you?</p>
                            </div>
                        </li>
                        <li class="me">
                            <div class="message-entry">
                                <p>Hi Art, I am fine :) How about you?</p>
                            </div>
                            <div class="user-info"><a href="#">
                                <img src="http://themes.laborator.co/xenon/assets/images/user-4.png" width="30" height="30" alt="user-image" />
                            </a></div>
                        </li>
                        <li>
                            <div class="user-info"><a href="#">
                                <img src="http://themes.laborator.co/xenon/assets/images/user-1.png" width="30" height="30" alt="user-image" />
                            </a></div>
                            <div class="message-entry">
                                <p>Warmth his law design say are person. Pronounce suspected in belonging conveying ye repulsive.</p>
                            </div>
                        </li>
                        <li class="me">
                            <div class="message-entry">
                                <p>Comfort reached gay perhaps chamber his six detract besides add. Moonlight newspaper.</p>
                                <p>Timed voice share led his widen noisy young.</p>
                                <p>His six detract besides add moonlight newspaper.</p>
                            </div>
                            <div class="user-info"><a href="#">
                                <img src="http://themes.laborator.co/xenon/assets/images/user-4.png" width="30" height="30" alt="user-image" />
                            </a></div>
                        </li>
                        <li>
                            <div class="user-info"><a href="#">
                                <img src="http://themes.laborator.co/xenon/assets/images/user-1.png" width="30" height="30" alt="user-image" />
                            </a></div>
                            <div class="message-entry">
                                <p>Hello John, how are you?</p>
                            </div>
                        </li>
                        <li class="me">
                            <div class="message-entry">
                                <p>Hi Art, I am fine :) How about you?</p>
                            </div>
                            <div class="user-info"><a href="#">
                                <img src="http://themes.laborator.co/xenon/assets/images/user-4.png" width="30" height="30" alt="user-image" />
                            </a></div>
                        </li>
                        <li>
                            <div class="user-info"><a href="#">
                                <img src="http://themes.laborator.co/xenon/assets/images/user-1.png" width="30" height="30" alt="user-image" />
                            </a></div>
                            <div class="message-entry">
                                <p>Hello John, how are you?</p>
                            </div>
                        </li>
                        <li class="time">Today 05:10</li>
                        <li class="me">
                            <div class="message-entry">
                                <p>Hi Art, I am fine :) How about you?</p>
                            </div>
                            <div class="user-info"><a href="#">
                                <img src="http://themes.laborator.co/xenon/assets/images/user-4.png" width="30" height="30" alt="user-image" />
                            </a></div>
                        </li>
                    </ul>
                    <form method="post" class="chat-form">
                        <input type="text" class="form-control" placeholder="Enter your message..." />
                    </form>
                </div>
            </li>
            <li><a href="#" class="chat-user"><span class="user-status is-idle"></span>
                Ylli Pylla
            </a></li>
            <li><a href="#" class="chat-user"><span class="user-status is-busy"></span>
                Arlind Nushi
            </a></li>
        </ul>
        <a href="#" class="mobile-chat-toggle"><i class="linecons-comment"></i><span class="num">6</span> <span class="badge badge-purple">4</span> </a>
    </div>
    <script src="http://themes.laborator.co/xenon/assets/js/bootstrap.min.js" id="script-resource-1"></script>
    <script src="http://themes.laborator.co/xenon/assets/js/TweenMax.min.js" id="script-resource-2"></script>
    <script src="http://themes.laborator.co/xenon/assets/js/resizeable.js" id="script-resource-3"></script>
    <script src="http://themes.laborator.co/xenon/assets/js/joinable.js" id="script-resource-4"></script>
    <script src="http://themes.laborator.co/xenon/assets/js/xenon-api.js" id="script-resource-5"></script>
    <script src="http://themes.laborator.co/xenon/assets/js/xenon-toggles.js" id="script-resource-6"></script>
    <script src="http://themes.laborator.co/xenon/assets/js/jquery-validate/jquery.validate.min.js" id="script-resource-7"></script>
    <!-- JavaScripts initializations and stuff -->
    <script src="http://themes.laborator.co/xenon/assets/js/xenon-custom.js" id="script-resource-8"></script>
    <script>
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),
            m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');
        ga('create', 'UA-28991003-3', 'auto');
        ga('send', 'pageview');
    </script>
</body>
</html>
