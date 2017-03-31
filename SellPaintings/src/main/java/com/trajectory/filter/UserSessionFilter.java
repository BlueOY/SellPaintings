package com.trajectory.filter;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

import com.alibaba.fastjson.JSONObject;

/**
 * ������
 * �ο����ϣ�http://blog.csdn.net/tolcf/article/details/38535739
 * ��������������������http://blog.csdn.net/chenleixing/article/details/44573495
 * ����������������http://blog.csdn.net/xiaoyaotan_111/article/details/53817918
 */

public class UserSessionFilter extends OncePerRequestFilter{
	
	private final boolean DEBUG = true;

	@Override
	protected void doFilterInternal(HttpServletRequest request,
			HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		// ��ȡ�����url
		String url = request.getRequestURI();
		
		//���˵�һЩͼƬ��js��css�ļ�
		boolean chek = chek(url);
		if(!chek){
			filterChain.doFilter(request, response);
			return;
		}
		
		if(DEBUG){
			Map<String, String[]> parameter = request.getParameterMap();
			String jStr = JSONObject.toJSONString(parameter);
			
			System.out.println("������ UserSessionFilter��url="+url);
			System.out.println("������ UserSessionFilter��parameter="+jStr);
			
			filterChain.doFilter(request, response);
		}else{
		// �����ص�url
		String[] notFilter = new String[] {"/index.jsp","selectExiteUser"};
		boolean doFilter = notFilter(notFilter, url);
		if (doFilter) {
			Object obj = request.getSession().getAttribute("userSession");
			if (null == obj) {
				// ���session�в����ڵ�¼��ʵ�壬�򵯳�����ʾ���µ�¼
				PrintWriter out = response.getWriter();
				String loginPage = request.getContextPath() + "/index.jsp";
				StringBuilder builder = new StringBuilder();
				builder.append("<script type=\"text/javascript\">");
				builder.append("window.top.location.href='");
				builder.append(loginPage);
				builder.append("';");
				builder.append("</script>");
				out.print(builder.toString());
			} else {
				filterChain.doFilter(request, response);
			}
		} else {
			filterChain.doFilter(request, response);
		}
		}
	}
	
	/**
	 * @param notFilter �����ص�url
	 * @param url�������url
	 * @return false�������� true������
	 */
	public boolean chek(String url) {
		// url��css��js��β�Ĳ���������
		String[] notFilter = {".css", ".js", ".jpg", ".png", ".gif"};
		for (String s : notFilter) {
			if (url.endsWith(s)) {
				return false;
			}
		}
		return true;
	}
	
	public boolean notFilter(String[] notFilter, String url){
		// ����notFilter�е��κ�һ���򲻽�������
		for (String s : notFilter) {
			if (url.indexOf(s) != -1) {
				return false;
			}
		}
		return true;
	}

}
