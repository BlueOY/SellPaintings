package com.trajectory.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.trajectory.pojo.Order;
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
	public void getPaintings(HttpServletRequest request, HttpServletResponse response) throws IOException{
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		int startIndex = 0;
		String startIndexStr = request.getParameter("startIndex");
		if(startIndexStr!=null){
			try{
				startIndex = Integer.parseInt(startIndexStr);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		int endIndex = startIndex+10;
		String endIndexStr = request.getParameter("endIndex");
		if(endIndexStr!=null){
			try{
				endIndex = Integer.parseInt(endIndexStr);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		Map<String, String> params = new HashMap<String, String>();
		params.put("startIndex", startIndex+"");
		params.put("endIndex", endIndex+"");
		List<Painting> list = manageService.getPaintings(params);
		String jsonStr = JSON.toJSONString(list);
		out.write(jsonStr);
		
		System.out.println("jsonStr="+jsonStr);
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
	
	@RequestMapping("/getOrders")
	public void getOrders(HttpServletRequest request, HttpServletResponse response) throws IOException{
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		int startIndex = 0;
		String startIndexStr = request.getParameter("startIndex");
		if(startIndexStr!=null){
			try{
				startIndex = Integer.parseInt(startIndexStr);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		int endIndex = startIndex+10;
		String endIndexStr = request.getParameter("endIndex");
		if(endIndexStr!=null){
			try{
				endIndex = Integer.parseInt(endIndexStr);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		Map<String, String> params = new HashMap<String, String>();
		params.put("startIndex", startIndex+"");
		params.put("endIndex", endIndex+"");
		List<Order> list = manageService.getOrders(params);
		String jsonStr = JSON.toJSONString(list);
		out.write(jsonStr);
		
		System.out.println("jsonStr="+jsonStr);
	}

}
