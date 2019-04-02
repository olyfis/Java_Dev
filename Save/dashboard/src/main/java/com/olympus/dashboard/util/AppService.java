package com.olympus.dashboard.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.NoSuchFileException;

import org.springframework.stereotype.Service;
 

//create Business Service
@Service
public class AppService {
	
	/*************************************************************************************************************************************************************/
	public AppService() {	 
	}
	/*************************************************************************************************************************************************************/

	static public String returnLastModifyDate(String param ) throws IOException {
		String date1 = null;
		 System.out.println("Param:"  + param);
		try {
			File file = new File("D:/tomcat-9.0.10/apache-tomcat-9.0.10/webapps/fisAssetServlet/dashsc/dashsc.html");
			//File file = new File("c:/temp/jb1.txt");
			date1 = GetFileAttrs.getFileDate(file);
			System.out.println("Date:" + date1);
			return date1;

		} catch (NoSuchFileException e) {
			System.out.println("Date not available." );
			return "Date not available.";
		}
	}
	/*************************************************************************************************************************************************************/

	 
}