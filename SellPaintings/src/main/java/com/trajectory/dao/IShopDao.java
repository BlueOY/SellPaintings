package com.trajectory.dao;

import java.util.List;
import java.util.Map;

import com.trajectory.pojo.Order;
import com.trajectory.pojo.Painting;

public interface IShopDao {

	public List<Painting> selectPaintings(Map<String, String> param);
	public Painting selectPaintingDetail(String id);
	public void insertOrder(Order order);
	public List<Order> selectOrders(Map<String, String> param);
	public void insertOrderPaintings(List<Map<String, String>> list);

}
