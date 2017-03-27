package com.trajectory.utils;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintStream;

public class FileUtil {
	
	public void PrintStreamDemo(){
        try {
            FileOutputStream out=new FileOutputStream("D:/test.txt");
            PrintStream p=new PrintStream(out);
            for(int i=0;i<10;i++){
                p.println("This is "+i+" line");
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

}
