<!doctype html>
<html>
<head>
	<link rel="stylesheet" href="/Visualizations/stylesheets/styles.css">
</head>
<body>

<h1>Thanks for your request!</h1>
<?php
	
	$chartType = $_GET["chart-type"];
	$date = $_GET["date"];
	$route = $_GET["route"];
	$in_out = $_GET["in_out"];

	echo "<p> You chose a/an " . $chartType . " visualization to display data from " . $date . " about the " . $route . " " . $in_out . " bus route.</p>";

	$graph_link = sprintf("%s-%s-%s-%s.html",$chartType,$route,$in_out,$date);
	
	if (($chartType == "lineChart") || ($chartType == "barChart")){
		echo '<a href="/Visualizations/' . $chartType .'s/' . $graph_link . '">Your requested graph</a>';
	}
	else if ($chartType == "avgDiff")
	{
		echo '<a href="/Visualizations/barCharts/' . $graph_link . '">Your requested graph</a>';

	}
	else//headway
	{
		echo '<a href="/Visualizations/headway_lineCharts/' . $graph_link . '">Your requested graph</a>';
	}
?>

</body>
</html>