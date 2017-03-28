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
 * ����ͼ�������api�ӿڣ���ȡ���ܻظ�����
 * 
 * @author pamchen-1
 * 
 */

public class TulingApiProcess {

	/**
	 * ����ͼ�������api�ӿڣ���ȡ���ܻظ����ݣ�������ȡ�Լ�������
	 * 
	 * @param content
	 * @return
	 */
	public String getTulingResult(String content) {
		String result = "";
		try {
			/** �˴�Ϊͼ��api�ӿڣ�����key��Ҫ�Լ�ȥע�����룬����11111111���� */
			String APIKEY = "26fefd8c59864138952db54666348713"; 
	        String INFO = URLEncoder.encode(content, "utf-8"); 
			String apiUrl = "http://www.tuling123.com/openapi/api?key="+APIKEY+"&info="+INFO;
			
			String param = apiUrl + URLEncoder.encode(content, "utf-8");
			// ������תΪurl����

			/** ����httpget���� */
			HttpGet request = new HttpGet(param);
		
			HttpResponse response = HttpClients.createDefault()
					.execute(request);
			if (response.getStatusLine().getStatusCode() == 200) {
				result = EntityUtils.toString(response.getEntity());
			}
			/** ����ʧ�ܴ��� */
			if (null == result) {
				return "�Բ�����˵�Ļ�����̫�����ˡ���";
			}

			JSONObject json = JSONObject.parseObject(result);
			// ��code=100000Ϊ�����ο�ͼ�������api�ĵ�
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
	        String question = "���ʲô���֣�";//�����ϴ����ƻ����˵�����
	        //String INFO = URLEncoder.encode("������������", "utf-8"); 
	        String INFO = URLEncoder.encode(question, "utf-8"); 
	        String getURL = "http://www.tuling123.com/openapi/api?key=" + APIKEY + "&info=" + INFO; 
	        URL getUrl = new URL(getURL); 
	        HttpURLConnection connection = (HttpURLConnection) getUrl.openConnection(); 
	        connection.connect(); 
	
	        // ȡ������������ʹ��Reader��ȡ 
	        BufferedReader reader = new BufferedReader(new InputStreamReader( connection.getInputStream(), "utf-8")); 
	        StringBuffer sb = new StringBuffer(); 
	        String line = ""; 
	        while ((line = reader.readLine()) != null) { 
	            sb.append(line); 
	        } 
	        reader.close(); 
	        // �Ͽ����� 
	        connection.disconnect(); 
	        
	        JSONObject json = JSONObject.parseObject(sb.toString());
	        // ��code=100000Ϊ�����ο�ͼ�������api�ĵ�
	     	if (100000 == json.getIntValue("code")) {
	     		result = json.getString("text");
	     	}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
