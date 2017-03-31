package com.trajectory.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.trajectory.service.ITestService;

@Controller  
@RequestMapping("/test")
public class TestController {
	
	@Resource
	private ITestService testService;
	
	@RequestMapping("/showTest")
	public String toIndex(HttpServletRequest request, Model model){
		String id = request.getParameter("id");
		com.trajectory.pojo.Test test = this.testService.getTestById(id);
		model.addAttribute("test", test);
		return "jsp/showTest";
	}
	
	@RequestMapping("/testJson")
	public void testJson(HttpServletRequest request, PrintWriter out){
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("key", "value");
		jsonObject.put("≤‚ ‘", "≤‚ ‘");
		out.write(jsonObject.toJSONString());
		System.out.println(jsonObject.toJSONString());
	}
	@RequestMapping("/testJson2")
	public void testJson(HttpServletRequest request, HttpServletResponse response) throws IOException{
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("key", "value");
		jsonObject.put("≤‚ ‘", "≤‚ ‘");
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.write(jsonObject.toJSONString());
		System.out.println(jsonObject.toJSONString());
	}
	
	@RequestMapping("/testObject")
	@ResponseBody
	public com.trajectory.pojo.Test testObject(HttpServletRequest request){
		com.trajectory.pojo.Test test = new com.trajectory.pojo.Test();
		test.setId(1);
		test.setName("≤‚ ‘");
		return test;
	}

}
