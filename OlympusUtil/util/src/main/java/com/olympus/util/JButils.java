package com.olympus.util;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.util.ArrayList;
import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.Iterator;
import java.util.Properties;
import java.util.*;


import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.json.simple.*;
import org.json.*;

public class JButils {

	/**********************************************************************************************************/
	// Service method of servlet
	static Statement stmt = null;
	static Connection con = null;
	static ResultSet res = null;
	static NodeList node = null;
	static String s = null;
	static private PreparedStatement statement;
	
	/**********************************************************************************************************/
	public static String[] splitStr(String string, String delimiter){
		 String[] result  = string.split(delimiter);
		 int array_length = result.length;

		 for(int i =0; i < array_length ; i++){
		  result[i]=result[i].trim();
		 }
		 return result;
	}

	/**********************************************************************************************************/
	public static ResultSet getResultSet(Connection conn, String query) throws SQLException {

		stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(query);
		return (rs);
	}
//************************************************************************************************************************************************			

	public static ResultSet getResultSetPS(PreparedStatement stmt) throws SQLException {
		ResultSet rs = stmt.executeQuery();

		return (rs);
	}

	/**********************************************************************************************************/

	public static ArrayList<String> resultSetArray(ResultSet rs, String sep) throws SQLException {

		ArrayList<String> arrStr = new ArrayList<String>();
		ArrayList<String> xData = new ArrayList<String>();
		String outDataLine = "";
		ResultSetMetaData rsmd = rs.getMetaData();
		int numColumns = rsmd.getColumnCount();
		int columnsNumber = rsmd.getColumnCount();
		while (rs.next()) {
			for (int i = 1; i <= columnsNumber; i++) {
				if (i > 1) {
					// System.out.print(";");
					outDataLine += sep;
				}
				String columnValue = rs.getString(i);
				outDataLine += columnValue;
			}
			// System.out.println(outDataLine);
			arrStr.add(outDataLine);
			// System.out.println("");
			outDataLine = "";
		}
		return arrStr;
	}

//************************************************************************************************************************************************			
	public static Connection getConnection(Properties connectionProps) throws SQLException {
		Connection conn = null;

		String myHost = (String) connectionProps.get("myHost");
		String myAccount = (String) connectionProps.get("myAccount");
		String uid = (String) connectionProps.get("userID");
		String pw = (String) connectionProps.get("passWord");
		String dbClass = (String) connectionProps.get("dbClass");
		String dbmsType = (String) connectionProps.get("dbmsType");
		String dbPort = (String) connectionProps.get("port");
		String passWord = pw.trim();
		String userID = uid.trim();
		/*
		 * System.out.println("dbmsType: " + dbmsType + "--");
		 * System.out.println("dbClass: " + dbClass + "--");
		 * System.out.println("myHost: " + myHost + "--"); System.out.println("userID: "
		 * + userID + "--"); System.out.println("passWord: " + passWord + "--");
		 */
		try {
			if (dbmsType.equals("UNIDATA")) {
				Class.forName(dbClass);
				// Class.forName("com.rs.u2.jdbc.UniJDBCDriver");
				String url = "jdbc:rs-u2://" + myHost + "/" + myAccount + ";" + "dbmstype=" + dbmsType; // generate URL
				conn = DriverManager.getConnection(url, userID, passWord);
				// System.out.println("URL: " + url);
			} else if (dbmsType.equals("rapport")) {
				Class.forName(dbClass);
				String url = "jdbc:sqlserver://" + myHost + ":" + dbPort + ";" + "databaseName=" + dbmsType + ";user="
						+ userID + ";password=" + passWord + ";"; // generate URL
				conn = DriverManager.getConnection(url, userID, passWord);
			}

			if (conn == null) {
				System.out.println(" %%% Returned null connection");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return conn;
	}

//************************************************************************************************************************************************			

	public static java.sql.Date getCurrentDate() {
		java.util.Date today = new java.util.Date();
		return new java.sql.Date(today.getTime());
	}

//************************************************************************************************************************************************			

	/*********************************************************************************************************************************/
	public static JSONArray resultSetJSON(ResultSet rs, String tagKey, String tagVal) throws SQLException {

		JSONArray json = new JSONArray();
		JSONObject obj = new JSONObject();
		ResultSetMetaData rsmd = rs.getMetaData();

		obj.put(tagKey, tagVal);
		int numColumns = rsmd.getColumnCount();
		while (rs.next()) {
			for (int i = 1; i < numColumns + 1; i++) {
				String column_name = rsmd.getColumnName(i);

				switch (rsmd.getColumnType(i)) {
				case java.sql.Types.ARRAY:
					obj.put(column_name, rs.getArray(column_name));
					break;
				case java.sql.Types.BIGINT:
					obj.put(column_name, rs.getInt(column_name));
					break;
				case java.sql.Types.BOOLEAN:
					obj.put(column_name, rs.getBoolean(column_name));
					break;
				case java.sql.Types.BLOB:
					obj.put(column_name, rs.getBlob(column_name));
					break;
				case java.sql.Types.DOUBLE:
					obj.put(column_name, rs.getDouble(column_name));
					break;
				case java.sql.Types.FLOAT:
					obj.put(column_name, rs.getFloat(column_name));
					// obj.put(column_name, rs.getString(column_name));

					break;
				case java.sql.Types.INTEGER:
					obj.put(column_name, rs.getInt(column_name));
					break;
				case java.sql.Types.NVARCHAR:
					obj.put(column_name, rs.getNString(column_name));
					break;
				case java.sql.Types.VARCHAR:
					obj.put(column_name, rs.getString(column_name));
					// System.out.println("VARCHAR:" + rsmd.getColumnType(i) + "VAL=" +
					// obj.toString(column_name, rs.getString(column_name))+ "--" );
					break;
				case java.sql.Types.TINYINT:
					obj.put(column_name, rs.getInt(column_name));
					break;
				case java.sql.Types.SMALLINT:
					obj.put(column_name, rs.getInt(column_name));
					break;
				case java.sql.Types.DATE:
					// obj.put(column_name, rs.getDate(column_name) );
					obj.put(column_name, rs.getString(column_name));

					// System.out.println("DATETYPE:" + rsmd.getColumnType(i) + "VAL=" +
					// obj.toString(column_name, rs.getString(column_name))+ "--" );
					break;
				case java.sql.Types.TIMESTAMP:
					// obj.put(column_name, rs.getTimestamp(column_name));
					obj.put(column_name, rs.getString(column_name));
					break;
				default:
					obj.put(column_name, rs.getObject(column_name));
					break;
				}

			}
			// json.put(obj);
			System.out.println("Adding Object: " + obj.toString() + "---");
			json.add(obj);
		}
		// System.out.println("Returning Array: " + json.toString() + "---");
		return (json);
	}

	/*********************************************************************************************************************************/

	public static void displayJsonArray(JSONArray jsonArr) {

		Iterator<Object> iterator = jsonArr.iterator();
		// Set<String> keys = jsonObject.keySet();
		while (iterator.hasNext()) {

			Object obj = iterator.next();
			if (obj instanceof JSONObject) {
				Set<String> keys = ((JSONObject) obj).keySet();
				// System.out.println("%%%%%%%%% KEYS %%%%%%%%" + keys.toString() + "keyNum=" +
				// keys.size());
				for (String key : keys) {
					// System.out.println(key + ":" + jsonObject.get(key));
					System.out.println("*******Key: " + key + " -> " + ((JSONObject) obj).get(key));
				}
				// System.out.println("*******" + ((JSONObject) obj).get("CUST_ID"));
			}
		}
	}

	/*********************************************************************************************************************************/

	public static String displayResults(ResultSet rs) throws SQLException {
		String result = null;
		JSONObject root = new JSONObject();

		int i = 1;
		System.out.println("Display results");
		root.put("recs", "recs");
		JSONArray jsonArr = new JSONArray();
		while (rs.next()) {
			JSONObject row = new JSONObject();
			row.put("ID", rs.getString("ID"));
			row.put("UATB_SC_BRANCH", rs.getString("UATB_SC_BRANCH"));
			row.put("UATB_SC_CUST_NAME", rs.getString("UATB_SC_CUST_NAME"));
			row.put("INSURANCE_CODE", rs.getString("INSURANCE_CODE"));
			row.put("UATB_SC_ACTIV_DATE", rs.getString("UATB_SC_ACTIV_DATE"));
			row.put("EQUIPMENT_COST", rs.getString("EQUIPMENT_COST"));
			row.put("INSUR_EFFECTIVE_DATE", rs.getString("INSUR_EFFECTIVE_DATE"));
			row.put("INSUR_EXPIRE_DATE", rs.getString("INSUR_EXPIRE_DATE"));
			jsonArr.add(row);

			System.out.println("" + i + ":" + rs.getString("ID") + ":" + rs.getString("UATB_SC_BRANCH") + ":" + ":"
					+ rs.getString("UATB_SC_CUST_NAME") + ":" + rs.getString("INSURANCE_CODE")
					+ rs.getString("UATB_SC_ACTIV_DATE") + ":" + rs.getString("EQUIPMENT_COST") + ":"
					+ rs.getString("INSUR_EFFECTIVE_DATE") + ":" + rs.getString("INSUR_EXPIRE_DATE"));

			// result += "" + rs.getString("ID") + ":" + rs.getString("UATB_SC_BRANCH");
		}

		root.put("jsonArr", jsonArr);
		// System.out.println(root.toJSONString());

		result = root.toJSONString();
		System.out.println(result);
		return result;
	}

	/*********************************************************************************************************************************/
	// method to print array
	public static void printStrArray(ArrayList<String> strArr) {

		for (String str : strArr) { // iterating ArrayList
			System.out.println("DATA:" + str + "---");
		}
		// System.out.println(names[index]);
	}

	/*********************************************************************************************************************************/
	public static NodeList getXMLNodeList(String fileName, String elemName) {
		ArrayList<String> strData = new ArrayList<String>();
		NodeList nList = null;
		try {
			File fXmlFile = new File(fileName);
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();

			// System.out.println("Root element :" +
			// doc.getDocumentElement().getNodeName());
			nList = doc.getElementsByTagName(elemName);
			// System.out.println("----------------------------");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return nList;
	}

	/*********************************************************************************************************************************/
	public static void displayXMLNodeList(NodeList nList) {
		String tagName = null;
		String appID = null;
		String eTag = null;
		String eTagValue = null;

		for (int temp = 0; temp < nList.getLength(); temp++) {
			Node nNode = nList.item(temp);
			System.out.println("\nCurrent Element : " + nNode.getNodeName());
			if (nNode.getNodeType() == Node.ELEMENT_NODE) {
				Element eElement = (Element) nNode;
				NodeList nodes = eElement.getChildNodes();
				for (int j = 0; j < nodes.getLength(); j++) {
					Node n = nodes.item(j);
					if (n.getNodeType() == Node.ELEMENT_NODE) {
						Element eName = (Element) n;
						eTag = eName.getTagName();
						eTagValue = eName.getTextContent();
						// System.out.println("\nCurrent Element TagName : " + tagName + ":" +
						// eName.getTagName() + ":" + eName.getTextContent());
						// System.out.println(eName.geName.getTagName()etTagName() + ":" +
						// eName.getTextContent());
						System.out.println(eTag + ":" + eTagValue);
					}
				}
				// appID = eElement.getElementsByTagName(tagName).item(0).getTextContent();
				// System.out.println("ID:" + appID + "---");
			}
		}
	}
	/*********************************************************************************************************************************/
	/*********************************************************************************************************************************/
	/*********************************************************************************************************************************/

	/*********************************************************************************************************************************/
//method to print array
	/*********************************************************************************************************************************/
	public static void printStrArray(ArrayList<String> strArr, String tag) {
		for (String str : strArr) { // iterating ArrayList
			System.out.println(tag + str);
		}
		// System.out.println(names[index]);
	}

	/*****************************************************************************************************/
// getBody method
	/*****************************************************************************************************/
	public static String readInput(InputStream inputStream) {
		String result = "";
		try {
			BufferedReader in = new BufferedReader(new InputStreamReader(inputStream));
			String inputLine;
			while ((inputLine = in.readLine()) != null) {
				result += inputLine;
				result += "\n";
			}
			in.close();
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
		return result;
	}

	/*********************************************************************************************************************************/
	public static ArrayList<String> readInputFile(String fileName) {
		ArrayList<String> data = new ArrayList<String>();
		
		File txt = new File(fileName);
		Scanner scan;
		try {
			scan = new Scanner(txt);
			while(scan.hasNextLine()){
			    data.add(scan.nextLine());
			}
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		System.out.println("Data=" + data.toString());
		
		
		return data;
	}
	
	

	/*********************************************************************************************************************************/

	/*************************************************************************************************************************************************************/
// displayHash -- display Hashtable
	/*************************************************************************************************************************************************************/

	public static void displayHash(Hashtable hashtable) {

		Enumeration names = null;
		String key = null;

		names = hashtable.keys();
		while (names.hasMoreElements()) {
			key = (String) names.nextElement();
			System.out.println("Key:" + key + " -> Value:" + hashtable.get(key));
		}

	}

}