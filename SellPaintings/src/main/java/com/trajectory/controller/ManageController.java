package com.trajectory.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.trajectory.pojo.Painting;
import com.trajectory.service.IManageService;

@Controller  
@RequestMapping("/manage")
public class ManageController {
	
	@Resource
	private IManageService manageService;
	
	@RequestMapping("/login")
	public void login(HttpServletRequest request, HttpServletResponse response) throws IOException{
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		if(username!=null && password!=null){
			if(username.endsWith("admin")){
				if(password.endsWith("admin")){
					Map<String, String> user = new HashMap<String, String>();
					request.getSession().setAttribute("userSession", user);
					out.write("true");
				}else{
					out.write("输入的密码有误");
				}
			}else{
				out.write("不存在的用户名");
			}
		}else{
			out.write("用户名或密码不能为空");
		}
	}
	
	@RequestMapping("/getPaintings")
	public void getPaintings(HttpServletRequest request){
		
	}
	
	@RequestMapping("/addPaintings")
	public void addPaintings(HttpServletRequest request){
		Painting painting = new Painting();
		painting.setTitle(request.getParameter("title"));
		painting.setDescript(request.getParameter("descript"));
		painting.setAuthor(request.getParameter("author"));
		painting.setPaintingTime(request.getParameter("paintingTime"));
		painting.setImageUrl(request.getParameter("imageUrl"));
		manageService.addPaintings(painting);
	}

}
