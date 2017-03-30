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
 * 过滤器
 * 参考资料：http://blog.csdn.net/tolcf/article/details/38535739
 * 过滤器与拦截器的区别：http://blog.csdn.net/chenleixing/article/details/44573495
 * 过滤器与拦截器：http://blog.csdn.net/xiaoyaotan_111/article/details/53817918
 */

public class UserSessionFilter extends OncePerRequestFilter{
	
	private final boolean DEBUG = true;

	@Override
	protected void doFilterInternal(HttpServletRequest request,
			HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		// 获取请求的url
		String url = request.getRequestURI();
		if(DEBUG){
			filterChain.doFilter(request, response);
			Map<String, String[]> parameter = request.getParameterMap();
			String jStr = JSONObject.toJSONString(parameter);
			
			System.out.println("UserSessionFilter："+url+"\nparameter="+jStr);
		}else{
		// 不拦截的url
		String[] notFilter = new String[] {"/index.jsp","selectExiteUser"};
		if (url.indexOf("UniqueduHome") != -1) {
			boolean doFilter = chek(notFilter, url);
			if (doFilter) {
				Object obj = request.getSession().getAttribute("userSession");
				if (null == obj) {
					// 如果session中不存在登录者实体，则弹出框提示重新登录
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
		} else {
			filterChain.doFilter(request, response);
		}
		}
	}
	
	/**
	 * @param notFilter 不拦截的url
	 * @param url：请求的url
	 * @return false：不拦截 true：拦截
	 */
	public boolean chek(String[] notFilter, String url) {
		// url以css和js结尾的不进行拦截
		if (url.endsWith(".css") || url.endsWith(".js")) {
			return false;
		}
		// 含有notFilter中的任何一个则不进行拦截
		for (String s : notFilter) {
			if (url.indexOf(s) != -1) {
				return false;
			}
		}
		return true;
	}

}
