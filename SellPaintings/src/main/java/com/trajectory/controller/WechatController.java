package com.trajectory.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

@Controller  
@RequestMapping("/wechat")
public class WechatController {
	
	String AppId = "wxe543d69f48e03767";
	String AppSecret = "15033f3f874df703682ce45daa17280c";
	
	@RequestMapping("/getCode")
	public String getCode(HttpServletRequest request){
		String redirect_uri = "http://222.240.170.247/SellPaintings/wechat/getOpenId";
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize"
				+"?appid="+AppId+"&redirect_uri="+redirect_uri+"&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
		return "redirect:"+url;
	}
	
	@RequestMapping("/getOpenId")
	public String getOpenId(HttpServletRequest request) throws ClientProtocolException, IOException{
		String code = request.getParameter("code");
		System.out.println("code="+code);
		
		String url2 = "https://api.weixin.qq.com/sns/oauth2/access_token"
				+"?appid="+AppId+"&secret="+AppSecret+"&code="+code+"&grant_type=authorization_code";
		
		HttpGet get = new HttpGet(url2);
		HttpResponse response = HttpClients.createDefault().execute(get);
		String jsonStr = EntityUtils.toString(response.getEntity(), "utf-8");
		JSONObject jsonTexts = (JSONObject) JSON.parse(jsonStr);
		String openid = "";
		if (jsonTexts.get("openid")!=null) {
			openid = jsonTexts.get("openid").toString();
		}
		
		System.out.println("openid="+openid);
		
		return "redirect:/SellPaintings/page/shop/index.jsp";
	}

}
