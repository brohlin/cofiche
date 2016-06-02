package org.undp.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class JsonReader {

  private static String readAll(Reader rd) throws IOException {
    StringBuilder sb = new StringBuilder();
    int cp;
    while ((cp = rd.read()) != -1) {
      sb.append((char) cp);
    }
    return sb.toString();
  }

  public static JSONObject readJsonFromUrl(String url) throws IOException, JSONException {
    InputStream is = new URL(url).openStream();
    try {
      BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
      String jsonText = readAll(rd);
      JSONObject json = new JSONObject(jsonText);
      
      
      return json;
    } finally {
      is.close();
    }
  }

  public static void main(String[] args) throws IOException, JSONException {
    JSONObject json = readJsonFromUrl("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=cuba&sort=newest&api-key=2392098bb064a18196ac9dd0dbe0c98e%3A10%3A73595495");
    
    
    // System.out.println(json.toString());
    // System.out.println(json.get("status"));
    // System.out.println(json.get("copyright"));
    // System.out.println(json.get("response"));
    
    JSONObject response = json.getJSONObject("response");
    // JSONArray  multimedia;
    JSONArray  docs = new JSONArray(response.get("docs").toString());
    // System.out.println(response.get("docs"));
        
    if (docs != null) {
        for (int i=0;i<docs.length();i++){
    		
    		JSONObject docsObject = docs.getJSONObject(i);
    		System.out.println(docsObject.get("web_url"));
    		System.out.println(docsObject.get("snippet"));
    		// System.out.println(docsObject.get("lead_paragraph"));
    		System.out.println(docsObject.get("source"));
    		System.out.println(docsObject.get("pub_date"));
    		System.out.println(docsObject.get("headline"));
        	
        	
    		JSONArray multimedia = new JSONArray(docsObject.get("multimedia").toString());
        	if (multimedia != null) {
                for (int j=0;j<multimedia.length();j++) {
                	JSONObject multimediaObject = multimedia.getJSONObject(j);   
                	
                	if (multimediaObject.get("url").toString().contains("thumbStandard")) {
                		System.out.println("http://www.nytimes.com/" + multimediaObject.get("url"));
                	}
                	
                }
        	}
        	
        	System.out.println("");
    		
        	
        }
    }
        
  }
  
 
  
  public static ArrayList<String> readJsonFromUrlToArrayList(String url) throws IOException, JSONException {
		InputStream is = new URL(url).openStream();
		try {
		    BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
		    String jsonText = readAll(rd);
		    JSONArray  json = new JSONArray(jsonText);
		
		    ArrayList<String> listdata = new ArrayList<String>();
		
		    if (json != null) {
		        for (int i=0;i<json.length();i++){
		            listdata.add(json.get(i).toString());
		        }
		    }
		    return listdata;
		} finally {
		    is.close();
		}
  }
 
  public static JSONArray getNYTimesArticles(String aCountry) throws IOException, JSONException {
	    JSONObject json = readJsonFromUrl("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=" + aCountry + "&sort=newest&api-key=2392098bb064a18196ac9dd0dbe0c98e%3A10%3A73595495");
	    
	    
	    // System.out.println(json.toString());
	    // System.out.println(json.get("status"));
	    // System.out.println(json.get("copyright"));
	    // System.out.println(json.get("response"));
	    
	    JSONObject response = json.getJSONObject("response");
	    
	    JSONArray  docs = new JSONArray(response.get("docs").toString());
	    // System.out.println(response.get("docs"));
	        
	    return docs;
  }
  
}