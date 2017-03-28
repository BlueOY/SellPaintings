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
		// ����΢�ŷ�������Get�����͵�4������
        String signature = request.getParameter("signature");
        String timestamp = request.getParameter("timestamp");
        String nonce = request.getParameter("nonce");
        String echostr = request.getParameter("echostr");
         
        PrintWriter out = response.getWriter();
        if (CheckUtil.checkSignature(signature, timestamp, nonce)) {
            out.print(echostr);        // У��ͨ����ԭ������echostr��������
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
        /** �ж��Ƿ���΢�Ž��뼤����֤��ֻ���״ν�����֤ʱ�Ż��յ�echostr��������ʱ��Ҫ����ֱ�ӷ��� */  
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
