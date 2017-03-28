package com.trajectory.wechat;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *	url:http://222.240.170.247/SellPaintings/wechatServlet.let
 */

@SuppressWarnings("serial")
public class WechatServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 接收微信服务器以Get请求发送的4个参数
        String signature = request.getParameter("signature");
        String timestamp = request.getParameter("timestamp");
        String nonce = request.getParameter("nonce");
        String echostr = request.getParameter("echostr");
         
        PrintWriter out = response.getWriter();
        if (CheckUtil.checkSignature(signature, timestamp, nonce)) {
            out.print(echostr);        // 校验通过，原样返回echostr参数内容
        }
        
        out.close();
        out = null;
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");  
        response.setCharacterEncoding("UTF-8");
        
        System.out.println("post");
  
        String result = "";  
        /** 判断是否是微信接入激活验证，只有首次接入验证时才会收到echostr参数，此时需要把它直接返回 */  
        String echostr = request.getParameter("echostr");  
        if (echostr != null && echostr.length() > 1) {  
            result = echostr;  
        } else {  
        	result = new WechatProcess().processWechatMag(request);
        }  
  
        try {  
            OutputStream os = response.getOutputStream();  
            os.write(result.getBytes("UTF-8"));  
            os.flush();  
            os.close();  
        } catch (Exception e) {  
            e.printStackTrace();  
        }
	}

}
