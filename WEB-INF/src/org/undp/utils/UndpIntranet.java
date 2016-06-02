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

public class UndpIntranet {

	@SuppressWarnings("unused")
	private static String readUrl(String urlString) throws Exception {
	    BufferedReader reader = null;
	    try {
	        URL url = new URL(urlString);
	        reader = new BufferedReader(new InputStreamReader(url.openStream(), Charset.forName("UTF-8")));
	        StringBuffer buffer = new StringBuffer();
	        int read;
	        char[] chars = new char[1024];
	        while ((read = reader.read(chars)) != -1)
	            buffer.append(chars, 0, read); 

	        return buffer.toString();
	    } finally {
	        if (reader != null)
	            reader.close();
	    }
	}
	
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
    
	String _jsonp = "";
	String _json = "";
	StringBuffer _out = new StringBuffer(4096);
	_out.append("<table id=\"senior_management_listing\" class=\"table table-hover separador-top separador-bottom\" >");
	_out.append("<tbody>");
	_out.append("<tr>");
	_out.append("<th>Senior Management</th>");
	_out.append("</tr>");
		  
	try {  
		_jsonp = readUrl("http://secure.undp.org/public-components/?comp=co-info&SectionTab=SeniorManagementListing&callback=?&unit_code=CUB");
		_json = _jsonp.substring(_jsonp.indexOf("(") + 1, _jsonp.lastIndexOf(")"));
	} catch (Exception ex) {
		ex.printStackTrace();
	}
		
	JSONObject json = new JSONObject(_json);
    JSONObject data = json.getJSONObject("data");
    JSONArray code = new JSONArray(data.get("code").toString());
    JSONArray email = new JSONArray(data.get("email").toString());
    JSONArray first_name = new JSONArray(data.get("first_name").toString());
    JSONArray last_name = new JSONArray(data.get("last_name").toString());
    JSONArray phone_number = new JSONArray(data.get("phone_number").toString());
    JSONArray position_title = new JSONArray(data.get("position_title").toString());
    
    int _recordcount = Integer.parseInt(json.get("recordcount").toString());
    
    _out.append("<tr>");

    for (int i=0;i<_recordcount;i++){
		_out.append("<td><strong>" + position_title.getString(i) + "</strong><br>" + last_name.getString(i) + ", " + first_name.getString(i) + "&nbsp; <a href=\"mailto:" + email.getString(i) + "\"><img src=\"/cofiche/assets/images/send.gif\"></a>&nbsp;&nbsp;<small>" + phone_number.getString(i) + "</small><br></td></tr>");
		System.out.println( "i = " + i + ": " + code.getString(i) );
		
	}    
    
	_out.append("</tbody>");
	_out.append("</table>");
	
	System.out.println(_out.toString());
    
    if (code != null) {
        for (int i=0;i<code.length();i++){
    		
    		System.out.println(code.get(i).toString());   		
        	
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

  public final static String getSeniorManagementListing(String aCountry)  throws IOException, JSONException {
	    
		String _jsonp = "";
		String _json = "";
		StringBuffer _out = new StringBuffer(4096);
		_out.append("<table id=\"senior_management_listing\" class=\"table table-hover separador-top separador-bottom\" >");
		_out.append("<tbody>");
		_out.append("<tr>");
		_out.append("<th>Senior Management</th>");
		_out.append("</tr>");
			  
		try {  
			_jsonp = readUrl("http://secure.undp.org/public-components/?comp=co-info&SectionTab=SeniorManagementListing&callback=?&unit_code=" + aCountry);
			_json = _jsonp.substring(_jsonp.indexOf("(") + 1, _jsonp.lastIndexOf(")"));
		} catch (Exception ex) {
			ex.printStackTrace();
		}
			
		JSONObject json = new JSONObject(_json);
	    JSONObject data = json.getJSONObject("data");
	    JSONArray code = new JSONArray(data.get("code").toString());
	    JSONArray email = new JSONArray(data.get("email").toString());
	    JSONArray first_name = new JSONArray(data.get("first_name").toString());
	    JSONArray last_name = new JSONArray(data.get("last_name").toString());
	    JSONArray phone_number = new JSONArray(data.get("phone_number").toString());
	    JSONArray position_title = new JSONArray(data.get("position_title").toString());
	    
	    int _recordcount = Integer.parseInt(json.get("recordcount").toString());

	    for (int i=0;i<_recordcount;i++){
	    	
	    	if ( last_name.getString(i).trim().length()>0 ) {
	    		_out.append("<tr><td><strong>" + position_title.getString(i) + "</strong><br>" + last_name.getString(i).toUpperCase() + ", " + first_name.getString(i).toUpperCase() + "&nbsp; <a href=\"mailto:" + email.getString(i) + "\"><img src=\"/cofiche/assets/images/send.gif\"></a>&nbsp;&nbsp;<small>" + phone_number.getString(i) + "</small><br></td></tr>");
	    		// System.out.println( "i = " + i + ": " + code.getString(i) );
	    	}
			
		}    
	    
		_out.append("</tbody>");
		_out.append("</table>");
		
		System.out.println(_out.toString());
	    
	    if (code != null) {
	        for (int i=0;i<code.length();i++){
	    		
	    		System.out.println(code.get(i).toString());   		
	        	
	        }
	    }
	    
	    return _out.toString();
  }
  
  public final static String getFocalPointListing(String aCountry)  throws IOException, JSONException {
	    
		String _jsonp = "";
		String _json = "";
		StringBuffer _out = new StringBuffer(4096);
		_out.append("<table id=\"focal_point_listing\" class=\"table table-hover separador-top separador-bottom\" >");
		_out.append("<tbody>");
		_out.append("<tr>");
		_out.append("<th>Focal Points</th>");
		_out.append("</tr>");
			  
		try {  
			_jsonp = readUrl("http://secure.undp.org/public-components/?comp=co-info&SectionTab=FocalPointListing&callback=?&unit_code=" + aCountry);
			_json = _jsonp.substring(_jsonp.indexOf("(") + 1, _jsonp.lastIndexOf(")"));
		} catch (Exception ex) {
			ex.printStackTrace();
		}
			
		JSONObject json = new JSONObject(_json);
	    JSONObject data = json.getJSONObject("data");
	    JSONArray code = new JSONArray(data.get("code").toString());
	    JSONArray email = new JSONArray(data.get("email").toString());
	    JSONArray first_name = new JSONArray(data.get("first_name").toString());
	    JSONArray last_name = new JSONArray(data.get("last_name").toString());
	    JSONArray phone_number = new JSONArray(data.get("phone_number").toString());
	    JSONArray position_title = new JSONArray(data.get("position_title").toString());
	    
	    int _recordcount = Integer.parseInt(json.get("recordcount").toString());

	    for (int i=0;i<_recordcount;i++){
	    	
	    	if ( last_name.getString(i).trim().length()>0 ) {
	    		_out.append("<tr><td><strong>" + position_title.getString(i) + "</strong><br>" + last_name.getString(i).toUpperCase() + ", " + first_name.getString(i).toUpperCase() + "&nbsp; <a href=\"mailto:" + email.getString(i) + "\"><img src=\"/cofiche/assets/images/send.gif\"></a>&nbsp;&nbsp;<small>" + phone_number.getString(i) + "</small><br></td></tr>");
	    		// System.out.println( "i = " + i + ": " + code.getString(i) );
	    	}
			
		}    
	    
		_out.append("</tbody>");
		_out.append("</table>");
		
		System.out.println(_out.toString());
	    
	    if (code != null) {
	        for (int i=0;i<code.length();i++){
	    		
	    		System.out.println(code.get(i).toString());   		
	        	
	        }
	    }
	    
	    return _out.toString();
  }

  public final static String getStaffListing(String aCountry)  throws IOException, JSONException {
	    
		String _jsonp = "";
		String _json = "";
		StringBuffer _out = new StringBuffer(4096);
		_out.append("<table id=\"staff_listing\" class=\"table table-hover separador-top separador-bottom\" >");
		_out.append("<tbody>");
		_out.append("<tr><th colspan=\"3\">All Staff</th>");
		_out.append("<tr><td><strong>Name, grade and nationality</strong></td><td><strong>Title and department</strong></td><td><strong>Telephone and e-mail</strong></td></tr>");

			  
		try {  
			_jsonp = readUrl("http://secure.undp.org/public-components/?comp=co-info&SectionTab=StaffListing&callback=?&unit_code=" + aCountry);
			_json = _jsonp.substring(_jsonp.indexOf("(") + 1, _jsonp.lastIndexOf(")"));
		} catch (Exception ex) {
			ex.printStackTrace();
		}
			
		JSONObject json = new JSONObject(_json);
	    JSONObject data = json.getJSONObject("data");
	    JSONArray deptid = new JSONArray(data.get("deptid").toString());
	    JSONArray deptid_descr = new JSONArray(data.get("deptid_descr").toString());
	    JSONArray email = new JSONArray(data.get("email").toString());
	    JSONArray first_name = new JSONArray(data.get("first_name").toString());
	    JSONArray grade = new JSONArray(data.get("grade").toString());
	    JSONArray jobtitle = new JSONArray(data.get("jobtitle").toString());
	    JSONArray last_name = new JSONArray(data.get("last_name").toString());
	    JSONArray nationality = new JSONArray(data.get("nationality").toString());
	    JSONArray phone_number = new JSONArray(data.get("phone_number").toString());
	    
	    System.out.println("L270");
	    int _recordcount = Integer.parseInt(json.get("recordcount").toString());

	    String _deptid = "";
	    
	  
	    
	    for (int i=0;i<_recordcount;i++){
	    	
	    	try { _deptid = deptid.getString(i); } catch (Exception ex) { _deptid = Integer.toString(deptid.getInt(i)); }

	    	if ( last_name.getString(i).trim().length()>0 ) {
	    		_out.append("<tr>");
	    		_out.append("<td>" + last_name.getString(i) + ", " + first_name.getString(i) + "<br><small>" + grade.getString(i) + " - " + nationality.getString(i) + "</small></td>");
	    		_out.append("<td>" + jobtitle.getString(i) + "<br><small>" + deptid_descr.getString(i) + " (" + _deptid + ")</small></td>");
	    		_out.append("<td>" + phone_number.getString(i) + "<br><a href=\"mailto:" + email.getString(i) + "\">" + email.getString(i) + "</a></td>");
	    		_out.append("</tr>");
	    	}	    
	    	
	    	System.out.println(last_name.getString(i));
	    	
		} 
	   
	    
		_out.append("</tbody>");
		_out.append("</table>");
	    
	    return _out.toString();
  }
  
  
}