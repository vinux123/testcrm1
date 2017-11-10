<!DOCTYPE html>
<html lang="en">
<head>
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
</head>
<body class="page-body">
    <div class="page-container">
        <div class="main-content">
            <script type="text/javascript">
                var sample_notification;
                jQuery(document).ready(function ($) {
                    // Notifications
                    window.clearTimeout(sample_notification);
                    // Average Sales Chart
                    var doughnut1_data_source = [
                    { region: "Asia", val: 4119626293 },
                    { region: "Africa", val: 1012956064 },
                    { region: "Northern America", val: 344124520 },
                    { region: "Latin America and the Caribbean", val: 590946440 },
                    { region: "Europe", val: 727082222 },
                    { region: "Oceania", val: 35104756 },
                    { region: "Oceania 1", val: 727082222 },
                    { region: "Oceania 3", val: 727082222 },
                    { region: "Oceania 4", val: 727082222 },
                    { region: "Oceania 5", val: 727082222 },
                    ], timer;
                    $("#sales-avg-chart div").dxPieChart({
                        dataSource: doughnut1_data_source,
                        tooltip: {
                            enabled: false,
                            format: "millions",
                            customizeText: function () {
                                return this.argumentText + "<br/>" + this.valueText;
                            }
                        },
                        size: {
                            height: 90
                        },
                        legend: {
                            visible: false
                        },
                        series: [{
                            type: "doughnut",
                            argumentField: "region"
                        }],
                        palette: ['#5e9b4c', '#6ca959', '#b9f5a6'],
                    });
                });
            </script>
            <div class="row">
                <div class="col-sm-3">
                    <div class="chart-item-bg">
                        <div class="chart-label chart-label-small">
                            <div class="h4 text-secondary text-bold" data-count="this" data-from="0.00" data-to="320.45" data-decimal="," data-duration="2">0</div>
                            <span class="text-small text-upper text-muted">Avg. of Sales</span> </div>
                        <div id="sales-avg-chart" style="height: 134px; position: relative;">
                            <div style="position: absolute; top: 25px; right: 0; left: 40%; bottom: 0"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="page-loading-overlay">
        <div class="loader-2"></div>
    </div>
    <script src="http://themes.laborator.co/xenon/assets/js/bootstrap.min.js" id="script-resource-1"></script>
    <script src="http://themes.laborator.co/xenon/assets/js/TweenMax.min.js" id="script-resource-2"></script>
    <script src="http://themes.laborator.co/xenon/assets/js/resizeable.js" id="script-resource-3"></script>
    <script src="http://themes.laborator.co/xenon/assets/js/joinable.js" id="script-resource-4"></script>
    <script src="http://themes.laborator.co/xenon/assets/js/xenon-api.js" id="script-resource-5"></script>
    <script src="http://themes.laborator.co/xenon/assets/js/xenon-toggles.js" id="script-resource-6"></script>
    <script src="http://themes.laborator.co/xenon/assets/js/xenon-widgets.js" id="script-resource-7"></script>
    <script src="http://themes.laborator.co/xenon/assets/js/devexpress-web-14.1x/js/globalize.min.js" id="script-resource-8"></script>
    <script src="http://themes.laborator.co/xenon/assets/js/devexpress-web-14.1x/js/dx.chartjs.js" id="script-resource-9"></script>
    <script src="http://themes.laborator.co/xenon/assets/js/toastr/toastr.min.js" id="script-resource-10"></script>
    <script src="http://themes.laborator.co/xenon/assets/js/xenon-custom.js" id="script-resource-11"></script>
</body>
</html>
