package com.trajectory.utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class FileUtil {

	public void PrintStreamDemo() {
		try {
			FileOutputStream out = new FileOutputStream("D:/test.txt");
			PrintStream p = new PrintStream(out);
			for (int i = 0; i < 10; i++) {
				p.println("This is " + i + " line");
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}
	

//	public static final String FILE_PATH = "/SellPaintingsResource/";

	// 文件上传
	public static String uploadFile(MultipartFile file, String dirPath) throws IOException {
		String fileName = file.getOriginalFilename();
		File tempFile = new File(dirPath, new Date().getTime()
				+ String.valueOf(fileName));
		if (!tempFile.getParentFile().exists()) {
			tempFile.getParentFile().mkdir();
		}
		if (!tempFile.exists()) {
			tempFile.createNewFile();
		}
		file.transferTo(tempFile);
//		System.out.println("AbsolutePath="+tempFile.getAbsolutePath());
		return tempFile.getName();
	}

//	public static File getFile(String fileName) {
//		return new File(FILE_PATH, fileName);
//	}

}
