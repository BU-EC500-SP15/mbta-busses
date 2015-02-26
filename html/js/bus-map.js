// utilizing Google Map API to generate a map
var map;

function initialize() {
    var mapOptions = {
        center: {lat: 42.348570, lng: -71.095233},
        zoom: 13,
        mapTypeControl: false
    };
    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
}

// Reva
var route1 = [];
var route15 = [];
var route22 = [];
var route23 = [];
var route28 = [];
var route57 = [];

// Yue
var route32 = [];
var route39 = [];
var route66 = [];
var route71 = [];
var route73 = [];
var route77 = [];
var route111 = [];
var route116 = [];
var route117 = []; 

// called back function that can use parsed data
function createMarker(data, array){
    infowindow = new google.maps.InfoWindow;

    var connectedCoordinates = [];

    for(var i = 0; i < data.length; i++){
        var markerPosition = new google.maps.LatLng(data[i][2], data[i][3]);

        var marker = new google.maps.Marker({
            icon: ('img/bus.png'),
            position: markerPosition,
            map: map,
            title: data[i][1]
        });

        /* var contentString = '<div id="content" style="width:400px; height:300px;">'+
    '<p id="embedly-link" class=\"embedly-card\">'+ data[i][1] + '</>';

        // Add the event listeners to inforwindow
        google.maps.event.addListener(infowindow, 'domready', function () {
            var embedlyLink = document.getElementById('embedly-link');
            embedly.card(embedlyLink);
        });

        google.maps.event.addListener(airPollutionControlMarker, 'click', function() {
            infowindow.setContent(contentString);
            infowindow.open(map, marker);
        }); */

        // connectedCoordinates[i] = markerPosition;
        connectedCoordinates.push(markerPosition);
        array.push(marker);
        // Debugging
        /*
        if(i == 10){
            break;
        }
        */
    }


    // Debug test
    /*
    var flightPlanCoordinates = [
        new google.maps.LatLng(42.363021, -71.058290),
        new google.maps.LatLng(42.357494, -71.056252),
        new google.maps.LatLng(42.350594, -71.075287),
        new google.maps.LatLng(42.356728, -71.057480)
    ];
    */

    /*
    for(var i = 0; i < connectedCoordinates.length; i++){
        console.log(connectedCoordinates[i]);
    }

    for(var i = 0; i < flightPlanCoordinates.length; i++){
        console.log(flightPlanCoordinates[i]);
    }
    */

    var connectedPath = new google.maps.Polyline({
        path: connectedCoordinates,
        geodesic: true,
        strokeColor: '#1f98d9',
        strokeOpacity: 1.0,
        strokeWeight: 5
    });
    
    connectedPath.setMap(map);
}

function parseData(url, array, callback){
    Papa.parse(url, {
        download: true,
        dynamicTyping: true,
        complete: function(results){
            callback(results.data, array);
        }
    });
}

function clearData(array) {
    console.log(array);
    for (var i = 0; i < array.length; i++) {
        array[i].setMap(null);
    }
    array.length = 0;
}

// parseData("data/route57_stops.csv", map);

// list of checkbox listeners for each route
// Reva's data files
$('#route1').change(function() {
    if($('#route1').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/route1_stops.txt", route1, createMarker);
    }
    else{
        clearData(route1);
    }
});

$('#route15').change(function() {
    if($('#route15').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/route15_stops.txt", route15, createMarker);
    }
    else{
        clearData(route15);
    }
});

$('#route22').change(function() {
    if($('#route22').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/route22_stops.txt", route22, createMarker);
    }
    else{
        clearData(route22);
    }
});

$('#route23').change(function() {
    if($('#route23').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/route23_stops.txt", route23, createMarker);
    }
    else{
        clearData(route23);
    }
});

$('#route28').change(function() {
    if($('#route28').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/route28_stops.txt", route28, createMarker);
    }
    else{
        clearData(route28);
    }
});

$('#route57').change(function() {
    if($('#route57').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/GTFS_Ordered_Data/result57/route57_stops.txt", route57, createMarker);
    }
    else{
        clearData(route57);
    }
});


// Yue's data files
$('#route32').change(function() {
    if($('#route32').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/Result_15KeyRoute/result32/route32_stops.txt", route32, createMarker);
    }
    else{
        clearData(route32);
    }
});

$('#route39').change(function() {
    if($('#route39').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/Result_15KeyRoute/result39/route39_stops.txt", route39, createMarker);
    }
    else{
        clearData(route39);
    }
});

$('#route66').change(function() {
    if($('#route66').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/Result_15KeyRoute/result66/route66_stops.txt", route66, createMarker);
    }
    else{
        clearData(route66);
    }
});

$('#route71').change(function() {
    if($('#route71').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/Result_15KeyRoute/result71/route71_stops.txt", route71, createMarker);
    }
    else{
        clearData(route71);
    }
});

$('#route73').change(function() {
    if($('#route73').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/Result_15KeyRoute/result73/route73_stops.txt", route73, createMarker);
    }
    else{
        clearData(route73);
    }
});

$('#route77').change(function() {
    if($('#route77').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/Result_15KeyRoute/result77/route77_stops.txt", route77, createMarker);
    }
    else{
        clearData(route77);
    }
});

$('#route111').change(function() {
    if($('#route111').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/Result_15KeyRoute/result111/route111_stops.txt", route111, createMarker);
    }
    else{
        clearData(route111);
    }
});

$('#route116').change(function() {
    if($('#route116').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/Result_15KeyRoute/result116/route116_stops.txt", route116, createMarker);
    }
    else{
        clearData(route116);
    }
});

$('#route117').change(function() {
    if($('#route117').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/Result_15KeyRoute/result117/route117_stops.txt", route117, createMarker);
    }
    else{
        clearData(route117);
    }
});

// manually grab the CSV file and process data
/*
$(document).ready(function(){
    $.ajax({
        type: "GET",
        url: "data.txt",
        dataType: "text",
        success: function(data){
            processData(data);
        }
    });
});

function processData(text){
    var record_num = 46;
    var textLines = text.split(/\r\n|\n/);
    var entries = textLines[0].split(',');
    var lines = [];

    var headings = entries.splice(0, record_num);
    while (entries.length > 0){
        var tarr = [];
        for(var j = 0; j < record_num; j++){
            tarr.push(headings[j] + ":" + entries.shift());
        }
        lines.push(tarr);
    }
}
*/

// loading the Google Map
google.maps.event.addDomListener(window, 'load', initialize);

// utilizing the d3.js visualization for bus routes
/*
d3.csv("data/shapes.txt", function(d){

	var margin = {top: 10, right: 10, bottom: 20, left: 40},
		width = 500 - margin.left - margin.right,
		height = 500 - margin.top - margin.bottom;

	var x = d3.scale.linear()
    	.domain([-100, 100])
    	.range([-100, width]);

	var y = d3.scale.linear()
    	.domain([0, 100])
    	.range([height, 0]);

    var xAxis = d3.svg.axis()
    	.scale(x)
    	.orient("bottom");

	var yAxis = d3.svg.axis()
    	.scale(y)
    	.orient("left");

    var line = d3.svg.line()
    	.x(function(d) {return x(d.shape_pt_lon); })
    	.y(function(d) {return y(d.shape_pt_lat); });
    	//.x(function(d) {return x(d.x); })
    	//.y(function(d) {return y(d.y); });

    var svg = d3.select("body").append("svg")
    	.datum(d)
    	.attr("width", width + margin.left + margin.right)
    	.attr("height", height + margin.top + margin.bottom)
      .append("g")
    	.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    svg.append("g")
    	.attr("class", "x axis")
    	.attr("transform", "translate(0," + height + ")")
    	.call(xAxis);

	svg.append("g")
    	.attr("class", "y axis")
    	.call(yAxis);

	svg.append("path")
    	.attr("class", "line")
    	.attr("d", line);
    */
    /*
    svg.selectAll(".dot")
    	.data(d)
      .enter().append("circle")
      	.attr("class", "dot")
      	.attr("cx", line.x())
      	.attr("cy", line.y())
      	.attr("r", 3.5);
	*/

    /*
	return {
		shape_id: d.shape_id,
		shape_lat: d.shape_pt_lat,
		shape_lon: d.shape_pt_lon,
		shape_sequence: d.shape_pt_sequence,
		shape_traveled: d.shape_dist_traveled
	};
	*/
//});
