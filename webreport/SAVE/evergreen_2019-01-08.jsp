<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.io.OutputStream"%>   
<%@ page import="java.io.File"%>
<%@ page import="java.util.ArrayList"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Olympus FIS Evergreen Data Report</title>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery.tablesorter/2.9.1/jquery.tablesorter.min.js"></script>
<!--  <script type="text/javascript" src="includes/js/tablesort.js"></script> -->

<script type="text/javascript" src="includes/js/tableFilter.js"></script>
<style><%@include file="includes/css/reports.css"%></style>
<style><%@include file="includes/css/table.css"%></style>
<style><%@include file="includes/css/header.css"%></style>

<!-- ********************************************************************************************************************************************************* -->

<script>


$(function() {

  // call the tablesorter plugin
  $("table").tablesorter({
    theme: 'blue',
    // initialize zebra striping of the table
    widgets: ["zebra"],
    // change the default striping class names
    // updated in v2.1 to use widgetOptions.zebra = ["even", "odd"]
    // widgetZebra: { css: [ "normal-row", "alt-row" ] } still works
    widgetOptions : {
      zebra : [ "normal-row", "alt-row" ]
    }
  });

});	
		
	
    </script>
	
	
</head>
<!-- ********************************************************************************************************************************************************* -->
<body style="font-family: sans-serif; color: black; font-size: 1;">
 <%@include  file="includes/header.html" %>
 
 
 
<div style="padding-left:20px">
  <h3>FIS Evergreen Report Page</h3>
  
  </div>
  
  <!-- ********************************************************************************************************************************************************* -->
  
 <%
 /*
String hdrValue =  (String) session.getAttribute("hrd");
String formUrl =  "/webreport/excelreport?hdr=" + hdrValue;
ArrayList<String> sArr = (ArrayList<String>) session.getAttribute("strArr");

String strTok = String.join(",", sArr);

*/
%> 
  

  <!-- ********************************************************************************************************************************************************* -->



<!-- ********************************************************************************************************************************************************* -->

<!--  ************************************************************************************************************************************************ -->

<!--  ************************************************************************************************************************************************ -->






<%!  
public String TableHeader(){
	String thead = null;
	String color1 = "#5DADE2";
	String style1 = "font-family: sans-serif; color: white;";	  
	//thead = "<tr bgcolor=" + color1 +  "style=" + style1 + ">";
	thead = "<tr class=\"b\" "  +  "style=" + style1 + ">";
	//thead += "<th class=\"b\">App Number</th>";
	thead += "<th>Application ID</th>";
	thead += "<th class=\"c\">Customer Name</th>";
	thead += "<th>Booking Date</th>";
	thead += "</tr>";	
	return thead;
} 
%>
<!-- ********************************************************************************************************************************************************* -->
<script>
/*
	var data = ${jsonStr}
	for (var i=0; i<data.length; i++) {
		document.write(data[i] + <BR>)
	}
*/
</script>
<%
	//String  s1  = (String) session.getAttribute("APP_ID"); 
String xDataItem = null;
String color1 = "plum";
String style1 = "font-family: sans-serif; color: white;";
String rowEven = "#D7DBDD";
String rowOdd = "AEB6BF";
String excel = null;

//retrieve your list from the request, with casting 
ArrayList<String> list = new ArrayList<String>();
String rowColor = null;
list = (ArrayList<String>) session.getAttribute("strArr");
//excel = ( String) session.getAttribute("excel");

request.setAttribute("strArr", list);

//System.out.println("EVG_JSP: ExcelVal=" + excel);
//out.println("listSize=" + list.size());
	if (list.size() > 0 ) {
		out.println("<table class=\"tablesorter\" border=\"1\"> <thead> <tr>");
		out.println(TableHeader());
		out.println("</tr></thead>");
		out.println("<tbody id=\"report\">");
	%>
 
<input id="search" type="text" placeholder="Enter Text to Filter...">
<h5></h5>	
	<% 
		
		for (int i = 0; i < list.size(); i++) {
	rowColor = (i % 2 == 0) ? rowEven : rowOdd;
	out.println("<tr bgcolor=" + rowColor + ">");
	
	xDataItem = list.get(i);
	String token_list[] = xDataItem.split(":");
	for (int x = 0; x < token_list.length; x++) {
		out.println("<td class=\"odd\">" + token_list[x] + "</td>");
	}
	out.println("</tr>");
		}	

		out.println("</tbody></table> ");
/*
		if (! excel.isEmpty()  && !excel.equalsIgnoreCase("null") ) { // check if box checked
			System.out.println("***^^^*** EVG_JSP: ExcelVal=" + excel + "  sz=" + excel.length());
			//out.println("<jsp:include page=\"/writeexcel\" flush=\"true\" />  ");	
		}

*/
	} else {
		out.println("No Asset data to display." + "<br>");
	}
%>

<!-- ********************************************************************************************************************************************************* -->	


</body>
</html>