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

var route1 = [];
var secondRoute1 = [];
var connectedCoordinatesRoute1 = [];
var secondConnectedCoordinatesRoute1 = [];
var pathRoute1 = [];
var secondPathRoute1 = [];

var route15 = [];
var secondRoute15 = [];
var connectedCoordinatesRoute15 = [];
var secondConnectedCoordinatesRoute15 = [];
var pathRoute15 = [];
var secondPathRoute15 = [];

var route22 = [];
var secondRoute22 = [];
var connectedCoordinatesRoute22 = [];
var secondConnectedCoordinatesRoute22 = [];
var pathRoute22 = [];
var secondPathRoute22 = [];

var route23 = [];
var secondRoute23 = [];
var connectedCoordinatesRoute23 = [];
var secondConnectedCoordinatesRoute23 = [];
var pathRoute23 = [];
var secondPathRoute23 = [];

var route28 = [];
var secondRoute28 = [];
var connectedCoordinatesRoute28 = [];
var secondConnectedCoordinatesRoute28 = [];
var pathRoute28 = [];
var secondPathRoute28 = [];

var route57 = [];
var secondRoute57 = [];
var connectedCoordinatesRoute57 = [];
var secondConnectedCoordinatesRoute57 = [];
var pathRoute57 = [];
var secondPathRoute57 = [];

var route32 = [];
var secondRoute32 = [];
var connectedCoordinatesRoute32 = [];
var secondConnectedCoordinatesRoute32 = [];
var pathRoute32 = [];
var secondPathRoute32 = [];

var route39 = [];
var secondRoute39 = [];
var connectedCoordinatesRoute39 = [];
var secondConnectedCoordinatesRoute39 = [];
var pathRoute39 = [];
var secondPathRoute39 = [];

var route66 = [];
var secondRoute66 = [];
var connectedCoordinatesRoute66 = [];
var secondConnectedCoordinatesRoute66 = [];
var pathRoute66 = [];
var secondPathRoute66 = [];

var route71 = [];
var secondRoute71 = [];
var connectedCoordinatesRoute71 = [];
var secondConnectedCoordinatesRoute71 = [];
var pathRoute71 = [];
var secondPathRoute71 = [];

var route73 = [];
var secondRoute73 = [];
var connectedCoordinatesRoute73 = [];
var secondConnectedCoordinatesRoute73 = [];
var pathRoute73 = [];
var secondPathRoute73 = [];

var route77 = [];
var secondRoute77 = [];
var connectedCoordinatesRoute77 = [];
var secondConnectedCoordinatesRoute77 = [];
var pathRoute77 = [];
var secondPathRoute77 = [];

var route111 = [];
var secondRoute111 = [];
var connectedCoordinatesRoute111 = [];
var secondConnectedCoordinatesRoute111 = [];
var pathRoute111 = [];
var secondPathRoute111 = [];

var route116 = [];
var secondRoute116 = [];
var connectedCoordinatesRoute116 = [];
var secondConnectedCoordinatesRoute116 = [];
var pathRoute116 = [];
var secondPathRoute116 = [];

var route117 = []; 
var secondRoute117 = [];
var connectedCoordinatesRoute117 = [];
var secondConnectedCoordinatesRoute117 = [];
var pathRoute117 = [];
var secondPathRoute117 = [];

// called back function that can use parsed data
function createMarker(data, array, connected, connectedLine){

    for(var i = 0; i < 23; i++){
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

        var contentString = '<div id="content">'+
        data[i][1] +
        '</div>'

        var infowindow = new google.maps.InfoWindow({
            content: contentString
        });    
    
        // connectedCoordinates[i] = markerPosition;
        connected.push(markerPosition);
        array.push(marker);
        // Debugging
        /*
        if(i == 10){
            break;
        }
        */

        var eventListener = new google.maps.event.addListener(marker, 'click', function() {
            infowindow.setOptions({
                content: contentString
            });
            infowindow.open(map, marker);
        });
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
    // console.log(connectedLine);

    connectedPath = new google.maps.Polyline({
        path: connected,
        geodesic: true,
        strokeColor: '#1f98d9',
        strokeOpacity: 1.0,
        strokeWeight: 5
    });
    
    pathRoute1 = connectedPath;
    pathRoute15 = connectedPath;
    pathRoute22 = connectedPath;
    pathRoute23 = connectedPath;
    pathRoute28 = connectedPath;
    pathRoute57 = connectedPath;
    pathRoute32 = connectedPath;
    pathRoute39 = connectedPath;
    pathRoute66 = connectedPath;
    pathRoute71 = connectedPath;
    pathRoute73 = connectedPath;
    pathRoute77 = connectedPath;
    pathRoute111 = connectedPath;
    pathRoute116 = connectedPath;
    pathRoute117 = connectedPath;

    addLine(connectedPath);
}

function createMarker2(data, array, connected, connectedPath){
    for(var i = 22; i < data.length; i++){
        var markerPosition = new google.maps.LatLng(data[i][2], data[i][3]);

        var marker = new google.maps.Marker({
            icon: ('img/bus.png'),
            position: markerPosition,
            map: map,
            title: data[i][1]
        });

        connected.push(markerPosition);
        array.push(marker);
    }

    connectedPath = new google.maps.Polyline({
        path: connected,
        geodesic: true,
        strokeColor: '#1f98d9',
        strokeOpacity: 1.0,
        strokeWeight: 5
    });
    
    secondPathRoute1 = connectedPath;
    secondPathRoute15 = connectedPath;
    secondPathRoute22 = connectedPath;
    secondPathRoute23 = connectedPath;
    secondPathRoute28 = connectedPath;
    secondPathRoute57 = connectedPath;
    secondPathRoute32 = connectedPath;
    secondPathRoute39 = connectedPath;
    secondPathRoute66 = connectedPath;
    secondPathRoute71 = connectedPath;
    secondPathRoute73 = connectedPath;
    secondPathRoute77 = connectedPath;
    secondPathRoute111 = connectedPath;
    secondPathRoute116 = connectedPath;
    secondPathRoute117 = connectedPath;

    addLine(connectedPath);
}

function parseData(url, array, connected, connectedPath, callback){
    Papa.parse(url, {
        download: true,
        dynamicTyping: true,
        complete: function(results){
            callback(results.data, array, connected, connectedPath);
        }
    });
}

function addLine(connectedPath){
    connectedPath.setMap(map);
}

function clearData(array) {
    // console.log(array);
    for (var i = 0; i < array.length; i++) {
        array[i].setMap(null);
    }
    array = [];
}

function removeMarkersAndLines(route, secondRoute, pathRoute, secondPathRoute){
    clearData(route);
    clearData(secondRoute);
    pathRoute.setMap(null);
    secondPathRoute.setMap(null);
}

// parseData("data/route57_stops.csv", map);

// list of checkbox listeners for each route
$('#route1').change(function() {
    if($('#route1').prop("checked")) {
        // run the function with the csv and a callback
        // pathRoute1 = [];
        // secondPathRoute1 = [];
        parseData("data/result1/stops.txt_transfered_order", route1, connectedCoordinatesRoute1, pathRoute1, createMarker);
        parseData("data/result1/stops.txt_transfered_order", secondRoute1, secondConnectedCoordinatesRoute1, secondPathRoute1, createMarker2);
    }
    else{
        removeMarkersAndLines(route1, secondRoute1, pathRoute1, secondPathRoute1);
    }
});

$('#route15').change(function() {
    if($('#route15').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/result15/stops.txt_transfered_order", route15, connectedCoordinatesRoute15, pathRoute15, createMarker);
        parseData("data/result15/stops.txt_transfered_order", secondRoute15, secondConnectedCoordinatesRoute15, secondPathRoute15, createMarker2);
    }
    else{
        removeMarkersAndLines(route15, secondRoute15, pathRoute15, secondPathRoute15);
    }
});

$('#route22').change(function() {
    if($('#route22').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/result22/stops.txt_transfered_order", route22, connectedCoordinatesRoute22, pathRoute22, createMarker);
        parseData("data/result22/stops.txt_transfered_order", secondRoute22, secondConnectedCoordinatesRoute22, secondPathRoute22, createMarker2);
    }
    else{
        removeMarkersAndLines(route22, secondRoute22, pathRoute22, secondPathRoute22);
    }
});

$('#route23').change(function() {
    if($('#route23').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/result23/stops.txt_transfered_order", route23, connectedCoordinatesRoute23, pathRoute23, createMarker);
        parseData("data/result23/stops.txt_transfered_order", secondRoute23, secondConnectedCoordinatesRoute23, secondPathRoute23, createMarker2);
    }
    else{
        removeMarkersAndLines(route23, secondRoute23, pathRoute23, secondPathRoute23);
    }
});

$('#route28').change(function() {
    if($('#route28').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/result28/stops.txt_transfered_order", route28, connectedCoordinatesRoute28, pathRoute28, createMarker);
        parseData("data/result28/stops.txt_transfered_order", secondRoute28, secondConnectedCoordinatesRoute28, secondPathRoute28, createMarker2);
    }
    else{
        removeMarkersAndLines(route28, secondRoute28, pathRoute28, secondPathRoute28);
    }
});

$('#route57').change(function() {
    if($('#route57').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/result57/stops.txt_transfered_order", route57, connectedCoordinatesRoute57, pathRoute57, createMarker);
        parseData("data/result57/stops.txt_transfered_order", secondRoute57, secondConnectedCoordinatesRoute57, secondPathRoute57, createMarker2);
    }
    else{
        removeMarkersAndLines(route57, secondRoute57, pathRoute57, secondPathRoute57);
    }
});


// Yue's data files
$('#route32').change(function() {
    if($('#route32').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/result32/stops.txt_transfered_order", route32, connectedCoordinatesRoute32, pathRoute32, createMarker);
        parseData("data/result32/stops.txt_transfered_order", secondRoute32, secondConnectedCoordinatesRoute32, secondPathRoute1, createMarker2);
    }
    else{
        removeMarkersAndLines(route32, secondRoute32, pathRoute32, secondPathRoute32);
    }
});

$('#route39').change(function() {
    if($('#route39').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/result39/stops.txt_transfered_order", route39, connectedCoordinatesRoute39, pathRoute39, createMarker);
        parseData("data/result39/stops.txt_transfered_order", secondRoute39, secondConnectedCoordinatesRoute39, secondPathRoute39, createMarker2);
    }
    else{
        removeMarkersAndLines(route39, secondRoute39, pathRoute39, secondPathRoute39);
    }
});

$('#route66').change(function() {
    if($('#route66').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/result66/stops.txt_transfered_order", route66, connectedCoordinatesRoute66, pathRoute66, createMarker);
        parseData("data/result66/stops.txt_transfered_order", secondRoute66, secondConnectedCoordinatesRoute66, secondPathRoute66, createMarker2);
    }
    else{
        removeMarkersAndLines(route66, secondRoute66, pathRoute66, secondPathRoute66);
    }
});

$('#route71').change(function() {
    if($('#route71').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/result71/stops.txt_transfered_order", route71, connectedCoordinatesRoute71, pathRoute71, createMarker);
        parseData("data/result71/stops.txt_transfered_order", secondRoute71, secondConnectedCoordinatesRoute71, secondPathRoute71, createMarker2);
    }
    else{
        removeMarkersAndLines(route71, secondRoute71, pathRoute71, secondPathRoute71);
    }
});

$('#route73').change(function() {
    if($('#route73').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/result73/stops.txt_transfered_order", route73, connectedCoordinatesRoute73, pathRoute73, createMarker);
        parseData("data/result73/stops.txt_transfered_order", secondRoute73, secondConnectedCoordinatesRoute73, secondPathRoute73, createMarker2);
    }
    else{
        removeMarkersAndLines(route73, secondRoute73, pathRoute73, secondPathRoute73);
    }
});

$('#route77').change(function() {
    if($('#route77').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/result77/stops.txt_transfered_order", route77, connectedCoordinatesRoute77, pathRoute77, createMarker);
        parseData("data/result77/stops.txt_transfered_order", secondRoute77, secondConnectedCoordinatesRoute77, secondPathRoute77, createMarker2);
    }
    else{
        removeMarkersAndLines(route77, secondRoute77, pathRoute77, secondPathRoute77);
    }
});

$('#route111').change(function() {
    if($('#route111').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/result111/stops.txt_transfered_order", route111, connectedCoordinatesRoute111, pathRoute111, createMarker);
        parseData("data/result111/stops.txt_transfered_order", secondRoute111, secondConnectedCoordinatesRoute111, secondPathRoute111, createMarker2);
    }
    else{
        removeMarkersAndLines(route111, secondRoute111, pathRoute111, secondPathRoute111);
    }
});

$('#route116').change(function() {
    if($('#route116').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/result116/stops.txt_transfered_order", route116, connectedCoordinatesRoute116, pathRoute116, createMarker);
        parseData("data/result116/stops.txt_transfered_order", secondRoute116, secondConnectedCoordinatesRoute116, secondPathRoute116, createMarker2);
    }
    else{
        removeMarkersAndLines(route116, secondRoute116, pathRoute116, secondPathRoute116);
    }
});

$('#route117').change(function() {
    if($('#route117').prop("checked")) {
        // run the function with the csv and a callback
        parseData("data/result117/stops.txt_transfered_order", route117, connectedCoordinatesRoute117, pathRoute117, createMarker);
        parseData("data/result117/stops.txt_transfered_order", secondRoute117, secondConnectedCoordinatesRoute117, secondPathRoute117, createMarker2);
    }
    else{
        removeMarkersAndLines(route117, secondRoute117, pathRoute117, secondPathRoute117);
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
