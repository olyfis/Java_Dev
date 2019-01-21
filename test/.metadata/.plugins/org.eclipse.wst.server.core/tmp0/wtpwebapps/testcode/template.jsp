<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.io.OutputStream"%>   
<%@ page import="java.io.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="java.util.*"%>
<!-- <%@ page import="org.json.simple.*"%> -->

    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Olympus FIS </title>

<style><%@include file="includes/css/appstyles.css"%></style>
<!-- ********************************************************************************************************************************************************* -->

<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery.tablesorter/2.9.1/jquery.tablesorter.min.js"></script>


</head>
<body>
<h3>Olympus FIS Salesforce Lead Query Result Set</h3> <BR>
<!-- ********************************************************************************************************************************************************* -->
<%!  
public String TableHeader(){
	String thead = null;
	String color1 = "#5DADE2";
	String style1 = "font-family: sans-serif; color: white;";	  
	//thead = "<tr bgcolor=" + color1 +  "style=" + style1 + ">";
	thead = "<tr class=\"b\" "  +  "style=" + style1 + ">";
	//thead += "<th class=\"b\">App Number</th>";
	thead += "<th>Lead ID</th>";
	thead += "<th class=\"c\">First Name</th>";
	thead += "<th>Last Name</th>";

	thead += "</tr>";	
	return thead;
} 
/****************************************************************************************************************************************************************/


%>


</body>
</html>