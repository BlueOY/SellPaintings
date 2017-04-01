package com.trajectory.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
import com.trajectory.service.IShopService;

@Controller  
@RequestMapping("/shop")
public class ShopController {
	
	@Resource
	private IShopService shopService;
	
	@RequestMapping("/getPaintingsList")
	public void getPaintingsList(HttpServletRequest request, HttpServletResponse response) throws IOException{
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
		List<Painting> list = shopService.getPaintings(params);
		String jsonStr = JSON.toJSONString(list);
		out.write(jsonStr);
	}
	
	@RequestMapping("/toPaintingDetail")
	public String toPaintingDetail(HttpServletRequest request, Model model){
		String id = request.getParameter("id");
		if(id!=null){
			Painting painting = shopService.selectPaintingDetail(id);
			model.addAttribute("painting", painting);
		}
		return "shop/detail";
	}
	
	@RequestMapping("/toShoppingCart")
	public String toShoppingCart(HttpServletRequest request, Model model){
		String type = request.getParameter("type");
		String id = request.getParameter("id");
		if(type==null || "add".equals(type)){
			if(id!=null){
				Painting painting = shopService.selectPaintingDetail(id);
				@SuppressWarnings("unchecked")
				List<Painting> paintingsList = (List<Painting>)request.getSession().getAttribute("paintingsList");
				if(paintingsList==null){
					paintingsList = new ArrayList<Painting>();
				}
				if(!ifExist(paintingsList, id)){
					paintingsList.add(painting);
				}
				request.getSession().setAttribute("paintingsList", paintingsList);
			}
		}else if("delete".equals(type)){
			if(id!=null){
				@SuppressWarnings("unchecked")
				List<Painting> paintingsList = (List<Painting>)request.getSession().getAttribute("paintingsList");
				delete(paintingsList, id);
			}
		}else if("deleteAll".equals(type)){
			@SuppressWarnings("unchecked")
			List<Painting> paintingsList = (List<Painting>)request.getSession().getAttribute("paintingsList");
			paintingsList.clear();
		}
//		return "shop/shoppingCart";
		return "redirect:/page/shop/shoppingCart.jsp";
	}
	
	private boolean ifExist(List<Painting> paintingsList, String id){
		for(Painting painting : paintingsList){
			if(id.equals(painting.getId()+"")){
				return true;
			}
		}
		return false;
	}
	private boolean delete(List<Painting> paintingsList, String id){
		for(Painting painting : paintingsList){
			if(id.equals(painting.getId()+"")){
				paintingsList.remove(painting);
				return true;
			}
		}
		return false;
	}
	
	@RequestMapping("/submitOrder")
	public void submitOrder(HttpServletRequest request, Order order, PrintWriter out){
		String userOpenId = (String)request.getSession().getAttribute("openId");
		if(userOpenId==null){
			out.write("openId is null");
			return;
		}
		order.setUser(userOpenId);
		shopService.addOrder(order);
		String paintingIds = request.getParameter("paintingIds");
		String[] paintingIdArr = paintingIds.split(",");
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		for(String paintingId : paintingIdArr){
			Map<String, String> temp = new HashMap<String, String>();
			temp.put("orderId", order.getId()+"");
			temp.put("paintingId", paintingId);
			list.add(temp);
		}
		shopService.addOrderPaintings(list);
		out.write("true");
		@SuppressWarnings("unchecked")
		List<Painting> paintingsList = (List<Painting>)request.getSession().getAttribute("paintingsList");
		paintingsList.clear();
		
		System.out.println("paintingIds="+paintingIds);
	}
	
	@RequestMapping("/toOrderList")
	public String toOrderList(HttpServletRequest request, Model model){
		String userOpenId = (String)request.getSession().getAttribute("openId");
		if(userOpenId==null){
			return "";
		}
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
		params.put("user", userOpenId);
		List<Order> list = shopService.getOrders(params);
		model.addAttribute("orderList", list);
		
		return "shop/orderList";
	}

}
