 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.io.OutputStream"%>   
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.*"%>
<% 
  	String title =  "FIS Evergreen Report Page"; 
	ArrayList<String> list = new ArrayList<String>();
	ArrayList<String> tokens = new ArrayList<String>();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%=title%></title>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery.tablesorter/2.9.1/jquery.tablesorter.min.js"></script>
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
<body>

<%!  

String formUrl = null;
/*************************************************************************************************************************************************************/
public ArrayList<String> readHeader(String filePath) throws IOException {
	
	ArrayList<String> strArr = new ArrayList<String>();
	String header = null;
	BufferedReader reader = null;
	StringBuilder sb = null;
	String line = null;
	try {
	 	reader = new BufferedReader(new FileReader(filePath));
    	 sb = new StringBuilder();
    
	} catch (FileNotFoundException fex) {
		fex.printStackTrace();	
	}
	try { 
	    while((line = reader.readLine())!= null){
	    	strArr.add(line);
	    }	   
		reader.close();
	
	} catch (IOException ioe) {
		ioe.printStackTrace();
	}
	
	return strArr;	
}
/*************************************************************************************************************************************************************/
public String  buildHeader( JspWriter out2, ArrayList<String> dataArr   ) throws IOException {
	
	String header = "";
	if (dataArr.size() > 0) {
		for (int k = 0; k < dataArr.size(); k++) {
			header += "<th class=\"b3\" >" + dataArr.get(k) + " </th>";
		}
	}
	return header;
	
}
/*************************************************************************************************************************************************************/
public String  buildCells( JspWriter out2, ArrayList<String> dataArr  ) throws IOException {
	String cells = "";
	
	return cells;
}

/*************************************************************************************************************************************************************/

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

/*************************************************************************************************************************************************************/

%>

<div style="padding-left:20px">
<h3><%=title%></h3>

<%
	String filePath = "C:\\Java_Dev\\props\\headers\\EvergreenHeader.txt";
	ArrayList<String> headerArr = readHeader(filePath);
  
	ArrayList<String> list2 = new ArrayList<String>();
	//list = (ArrayList<String>) session.getAttribute("strArr");
	list2.add("xx");
	
	out.println("listSize=" + list2.size());
	if (list2.size() > 0) {
		/**********************************************************************************************************************************************************/
		// Output Table 
		out.println("<table class=\"tablesorter\" border=\"1\"> <thead> <tr>");
 
		String header = buildHeader(out, headerArr); // build header from file
		out.println(header);
		out.println("</tr></thead>");
		out.println("<tbody id=\"report\">");
		
		
		
		
		buildCells(out, list); // build data cells from file
		//out.println("<tr><td>Item 1</td>");
		out.println("<tr>");
		out.println("<td>Item 2</td>");
		out.println("<td>Item N</td>");

		
		out.println("</tr><tr>");
		out.println("<td>TItem 2</td>");
		out.println("<td>TItem N</td>");
		out.println("</tr></table>"); // Close Table

		
		
		// End Output Table
		/**********************************************************************************************************************************************************/
	} else {
		out.println("No Asset data to display." + "<br>");

	}
	 
%>

</body>
</html>