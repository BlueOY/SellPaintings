package com.trajectory.wechat;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import com.alibaba.fastjson.JSONObject;

/**
 * 调用图灵机器人api接口，获取智能回复内容
 * 
 * @author pamchen-1
 * 
 */

public class TulingApiProcess {

	/**
	 * 调用图灵机器人api接口，获取智能回复内容，解析获取自己所需结果
	 * 
	 * @param content
	 * @return
	 */
	public String getTulingResult(String content) {
		String result = "";
		try {
			/** 此处为图灵api接口，参数key需要自己去注册申请，先以11111111代替 */
			String APIKEY = "26fefd8c59864138952db54666348713"; 
	        String INFO = URLEncoder.encode(content, "utf-8"); 
			String apiUrl = "http://www.tuling123.com/openapi/api?key="+APIKEY+"&info="+INFO;
			
			String param = apiUrl + URLEncoder.encode(content, "utf-8");
			// 将参数转为url编码

			/** 发送httpget请求 */
			HttpGet request = new HttpGet(param);
		
			HttpResponse response = HttpClients.createDefault()
					.execute(request);
			if (response.getStatusLine().getStatusCode() == 200) {
				result = EntityUtils.toString(response.getEntity());
			}
			/** 请求失败处理 */
			if (null == result) {
				return "对不起，你说的话真是太高深了……";
			}

			JSONObject json = JSONObject.parseObject(result);
			// 以code=100000为例，参考图灵机器人api文档
			if (100000 == json.getIntValue("code")) {
				result = json.getString("text");
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String getTulingResult2(String content) {
		String result="";
		try{
			String APIKEY = "26fefd8c59864138952db54666348713"; 
	        String question = "你叫什么名字？";//这是上传给云机器人的问题
	        //String INFO = URLEncoder.encode("北京今日天气", "utf-8"); 
	        String INFO = URLEncoder.encode(question, "utf-8"); 
	        String getURL = "http://www.tuling123.com/openapi/api?key=" + APIKEY + "&info=" + INFO; 
	        URL getUrl = new URL(getURL); 
	        HttpURLConnection connection = (HttpURLConnection) getUrl.openConnection(); 
	        connection.connect(); 
	
	        // 取得输入流，并使用Reader读取 
	        BufferedReader reader = new BufferedReader(new InputStreamReader( connection.getInputStream(), "utf-8")); 
	        StringBuffer sb = new StringBuffer(); 
	        String line = ""; 
	        while ((line = reader.readLine()) != null) { 
	            sb.append(line); 
	        } 
	        reader.close(); 
	        // 断开连接 
	        connection.disconnect(); 
	        
	        JSONObject json = JSONObject.parseObject(sb.toString());
	        // 以code=100000为例，参考图灵机器人api文档
	     	if (100000 == json.getIntValue("code")) {
	     		result = json.getString("text");
	     	}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
