package com.trajectory.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
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
import com.trajectory.service.IUserService;

/**
 * ²Î¿¼×ÊÁÏ£ºhttp://blog.csdn.net/qq_24800377/article/details/53437040
 */

@Controller  
@RequestMapping("/wechat")
public class WechatController {
	
	@Resource
	private IUserService userService;
	
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
		
		request.getSession().setAttribute("openId", openid);
		
		Map<String, String> map = userService.selectByOpenId(openid);
		if(map==null){
			Map<String, String> param = new HashMap<String, String>();
			param.put("openId", openid);
			userService.insertUser(param);
		}else{
			userService.visitUser(openid);
		}
		
		return "redirect:/page/shop/index.jsp";
	}

}
