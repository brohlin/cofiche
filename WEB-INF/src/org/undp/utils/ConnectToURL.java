package org.undp.utils;

import java.net.*;
import java.nio.charset.Charset;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.util.ArrayList;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


import java.io.*;
 
public class ConnectToURL {
 
    // Variables to hold the URL object and its connection to that URL.
    private static URL URLObj;
    private static URLConnection connect;
    
    private static String readAll(Reader rd) throws IOException {
        StringBuilder sb = new StringBuilder();
        int cp;
        while ((cp = rd.read()) != -1) {
          sb.append((char) cp);
        }
        return sb.toString();
      }    
     
    public static void main(String[] args) {
        try {
            // Establish a URL and open a connection to it. Set it to output mode.
            URLObj = new URL("http://intranet.undp.org/");
            connect = URLObj.openConnection();
            connect.setDoOutput(true); 
            System.out.println("L18");
            
        }
        catch (MalformedURLException ex) {
            System.out.println("The URL specified was unable to be parsed or uses an invalid protocol. Please try again.");
            System.exit(1);
        }
        catch (Exception ex) {
            System.out.println("An exception occurred. " + ex.getMessage());
            System.exit(1);
        }
         
         
        try {
            // Create a buffered writer to the URLConnection's output stream and write our forms parameters.
            BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(connect.getOutputStream()));
            
            System.out.println("L34");
            
            writer.write("userNameInput=robert.rohlin@undp.org&passwordInput=JaNis441&submit=loginForm&kmsiInput=true&optionForms=FormsAuthentication");

            
            System.out.println("L38");
            
            writer.close();
            
            System.out.println("L42");
            
            // Now establish a buffered reader to read the URLConnection's input stream.
            BufferedReader reader = new BufferedReader(new InputStreamReader(connect.getInputStream()));
             
            String lineRead = "";
             
            // Read all available lines of data from the URL and print them to screen.
            while ((lineRead = reader.readLine()) != null) {
                System.out.println(lineRead);
            }
             
            reader.close();
            System.out.println("L47");
        }
        catch (Exception ex) {
            System.out.println("There was an error reading or writing to the URL: " + ex.getMessage());
        }
        
        try {
	        InputStream is = new URL("https://intranet.undp.org/_layouts/execsnapshot/ajax/reportdata.aspx?rid=35&rtype=1&year=2016&hq_co=CO&bureau=RBLAC&unit=CUB").openStream();
	        try {
	          BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
	          String jsonText = readAll(rd);
	          String jsonText2 = "{" + jsonText + "}";
	          JSONObject json = new JSONObject(jsonText2);
	          System.out.println(jsonText2);
	          
	          System.out.println(json.toString());
	        } finally {
	          is.close();
	        }	
        } catch (Exception e) {
        	e.printStackTrace();
    	}
    }
}
