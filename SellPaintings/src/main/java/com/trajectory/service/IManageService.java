package com.trajectory.service;

import java.util.List;
import java.util.Map;

import com.trajectory.pojo.Order;
import com.trajectory.pojo.Painting;
import com.trajectory.pojo.User;

public interface IManageService {
	
	public void addPainting(Painting painting);
	public List<Painting> getPaintings(Map<String, String> params);
	public List<Order> getOrders(Map<String, String> params);
	public List<Order> getUserOrders(Map<String, String> params);
	public void updatePainting(Painting painting);
	public Painting selectPaintingDetail(String parseInt);
	public void deletePainting(String id);
	public Order selectOrderDetail(String id);
	public List<User> selectUsers(Map<String, String> params);

}
