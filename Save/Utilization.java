package com.olympus.webreport;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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


import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.Iterator;
import java.util.Properties;
import java.util.Set;

import org.w3c.dom.NodeList;

import com.olympus.util.JButils;

import java.sql.*;

public class Utilization extends HttpServlet {
	
/**********************************************************************************************************/	
	// Service method of servlet
	static Statement stmt = null;
	static Connection con = null;
	static ResultSet res  = null;
	static NodeList  node  = null;
	static String s = null;
	static private PreparedStatement statement;
	
	public static ArrayList<String> getData() throws IOException {
		
		ArrayList<String> strArr = new ArrayList<String>();
		String result = null;
		JButils jutil = new JButils();
		FileInputStream fis = null;
		try {
			fis = new FileInputStream("C:\\Java_Dev\\props\\connection.prop");
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Properties connectionProps = new Properties();
		String s = new String();
		StringBuffer sb = new StringBuffer();


		try {
			connectionProps.load(fis);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		FileReader fr = new FileReader(new File("C:\\Java_Dev\\props\\sql\\utilization.sql"));
		
		// be sure to not have line starting with "--" or "/*" or any other non
		// alphabetical character
		BufferedReader br = new BufferedReader(fr);
		while ((s = br.readLine()) != null) {
			sb.append(s);
		}
		br.close();

		String query2 = new String();
		query2 = sb.toString();
		//System.out.println("Q=" + query2);
		//System.out.println( query2);
		try {
			con = jutil.getConnection(connectionProps);
			if (con != null) {
				//System.out.println("Connected to the database");
//************************************************************************************************************************************************			
				statement = con.prepareStatement(query2);	
				res = jutil.getResultSetPS(statement);
				
				// jsonArr = jutil.resultSetJSON(res);
				strArr = jutil.resultSetArray(res, ":");
				
			
//************************************************************************************************************************************************
		
			} else {
				System.out.println("**** NOT Connected to the database");
			}
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (SQLException se) {
				se.printStackTrace();
			} // end finally try
		}	
		
		return strArr;
	}
	
	/*****************************************************************************************************/
	// Service method
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
	 
		ArrayList<String> strArr = new ArrayList<String>();
		PrintWriter out = res.getWriter();
		res.setContentType("text/plain");
		out.write(" in Service method doGet() ");
	 
		// no parameters at this time
		//String paramName = "custID";
		//String paramValue = req.getParameter(paramName);
		
		 //System.out.println("Servlet " + this.getServletName() + " in doGet() ");
		strArr = getData();
		JButils jutil = new JButils();
		//jutil.printStrArray(strArr);
		

		req.getSession().setAttribute("strArr", strArr);
        req.getRequestDispatcher("/utilization.jsp").forward(req, res);
        
      
       
		 
		 //System.out.println("Exit Servlet " + this.getServletName() + " in doGet() ");
	}
/**********************************************************************************************************/  
 
	@Override
	public void init() throws ServletException {
		System.out.println("Servlet " + this.getServletName() + " has started");
	}
	@Override
	public void destroy() {
		System.out.println("Servlet " + this.getServletName() + " has stopped");
	}
} // End Class