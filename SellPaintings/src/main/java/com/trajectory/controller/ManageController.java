package com.trajectory.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.trajectory.pojo.Painting;
import com.trajectory.service.IManageService;

@Controller  
@RequestMapping("/manage")
public class ManageController {
	
	@Resource
	private IManageService manageService;
	
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
