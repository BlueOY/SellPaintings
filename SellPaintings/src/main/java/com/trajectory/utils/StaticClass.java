package com.trajectory.utils;

public class StaticClass {
	
	public static final String IMAGE_BASE_URL = "/SellPaintingsResource/";
	
	public static String totalPriceFormat(int totalPrice){
		if(totalPrice>10000){
			return (totalPrice/10000)+"Íò"+(totalPrice%10000);
		}else{
			return totalPrice+"";
		}
	}

}
