package com.trajectory.controller;

/**
 * ²Î¿¼×ÊÁÏ£ºhttp://blog.csdn.net/h70614959/article/details/38983567
 */

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.trajectory.utils.FileUtil;

@Controller  
@RequestMapping("/file")
public class FileController {
	
	@RequestMapping("upload")
	public void upload(@RequestParam("imageFile") MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String path = request.getContextPath();
		path = path.replaceAll("/", "\\\\");
		String realPath = request.getServletContext().getRealPath("/");
		realPath = realPath.replace(path, "\\SellPaintingsResource");
		
		String fileName = FileUtil.uploadFile(file, realPath+"image");
		
		response.setContentType("text/html;charset=utf8");
		response.getWriter().write("<script>parent.callbackUploadImage('"+"image/"+fileName+"')</script>");
		
	}

}
