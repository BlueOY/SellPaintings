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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.trajectory.pojo.Order;
import com.trajectory.pojo.Painting;
import com.trajectory.pojo.PaintingType;
import com.trajectory.pojo.User;
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
		
		String type = request.getParameter("type");
		if(type!=null){
			params.put("type", type);
		}
		String paintingType = request.getParameter("paintingType");
		if(paintingType!=null && !"all".equals(paintingType)){
			params.put("paintingType", paintingType);
		}
		
		List<Painting> list = manageService.getPaintings(params);
		String jsonStr = JSON.toJSONString(list);
		out.write(jsonStr);
		
		System.out.println("jsonStr="+jsonStr);
	}
	
	@RequestMapping("/getPaintingType")
	public void getPaintingType(HttpServletRequest request, HttpServletResponse response) throws IOException{
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		List<Map<String, String>> list = manageService.getPaintingType();
		String jsonStr = JSON.toJSONString(list);
		out.write(jsonStr);
		
		System.out.println("paintingType="+jsonStr);
	}
	
	@RequestMapping("/addPaintingType")
	public void addPaintingType(HttpServletRequest request, HttpServletResponse response) throws IOException{
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String name = request.getParameter("name");
		manageService.addPaintingType(name);
		
		out.write("true");
	}
	
	@RequestMapping("/addPaintings")
	public void addPaintings(HttpServletRequest request, HttpServletResponse response, Painting painting) throws IOException{
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
//		Painting painting = new Painting();
//		painting.setTitle(request.getParameter("title"));
//		painting.setDescript(request.getParameter("descript"));
//		painting.setAuthor(request.getParameter("author"));
//		painting.setPaintingTime(request.getParameter("paintingTime"));
//		painting.setImageUrl(request.getParameter("imageUrl"));
		
		String paintingTypeId = request.getParameter("paintingTypeId");
		if(paintingTypeId!=null){
			PaintingType paintingType = new PaintingType();
			paintingType.setId(Integer.parseInt(paintingTypeId));
			painting.setPaintingType(paintingType);
		}
		manageService.addPainting(painting);
		
		out.write("true");
	}
	
	@RequestMapping("/toPaintingDetail")
	public String toPaintingDetail(HttpServletRequest request, Model model){
		String id = request.getParameter("id");
		if(id!=null){
			Painting painting = manageService.selectPaintingDetail(id);
			model.addAttribute("painting", painting);
			
			System.out.println("paintingDetail="+JSON.toJSONString(painting));
		}else{
			model.addAttribute("type", "add");
		}
		return "manage/painting/paintingDetail";
	}
	@RequestMapping("/updatePaintings")
	public void updatePaintings(HttpServletRequest request, HttpServletResponse response, Painting painting) throws IOException{
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String paintingTypeId = request.getParameter("paintingTypeId");
		if(paintingTypeId!=null){
			PaintingType paintingType = new PaintingType();
			paintingType.setId(Integer.parseInt(paintingTypeId));
			painting.setPaintingType(paintingType);
		}
		manageService.updatePainting(painting);
		out.write("true");
		
		System.out.println("painting="+JSON.toJSONString(painting));
	}
	@RequestMapping("/deletePainting")
	public void deletePainting(HttpServletRequest request, HttpServletResponse response) throws IOException{
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String id = request.getParameter("id");
		if(id!=null){
			manageService.deletePainting(id);
			out.write("true");
		}else{
			out.write("id不能为空");
		}
	}
	@RequestMapping("/recyclePainting")
	public void recyclePainting(HttpServletRequest request, HttpServletResponse response) throws IOException{
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String id = request.getParameter("id");
		if(id!=null){
			manageService.recyclePainting(id);
			out.write("true");
		}else{
			out.write("id不能为空");
		}
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
	@RequestMapping("/getUserOrders")
	public void getUserOrders(HttpServletRequest request, HttpServletResponse response) throws IOException{
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
		String user = request.getParameter("user");
		Map<String, String> params = new HashMap<String, String>();
		params.put("startIndex", startIndex+"");
		params.put("endIndex", endIndex+"");
		params.put("user", user);
		List<Order> list = manageService.getUserOrders(params);
		String jsonStr = JSON.toJSONString(list);
		out.write(jsonStr);
		
		System.out.println("jsonStr="+jsonStr);
	}
	
	@RequestMapping("/toOrderDetail")
	public String toOrderDetail(HttpServletRequest request, Model model){
		String id = request.getParameter("id");
		if(id!=null){
			Order order = manageService.selectOrderDetail(id);
			model.addAttribute("order", order);
			
			System.out.println("order="+JSON.toJSONString(order));
		}
		return "manage/order/orderDetail";
	}
	
	@RequestMapping("/getUsers")
	public void getUsers(HttpServletRequest request, HttpServletResponse response) throws IOException{
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
		List<User> userList = manageService.selectUsers(params);
		String jsonStr = JSON.toJSONString(userList);
		out.write(jsonStr);
	}

}
