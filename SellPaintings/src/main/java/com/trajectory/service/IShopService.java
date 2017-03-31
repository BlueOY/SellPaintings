package com.trajectory.service;

import java.util.List;
import java.util.Map;

import com.trajectory.pojo.Order;
import com.trajectory.pojo.Painting;

public interface IShopService {
	
	public List<Painting> getPaintings(Map<String, String> param);
	public Painting selectPaintingDetail(String id);
	public void addOrder(Order order);
	public List<Order> getOrders(Map<String, String> param);
	public void addOrderPaintings(List<Map<String, String>> list);

}
