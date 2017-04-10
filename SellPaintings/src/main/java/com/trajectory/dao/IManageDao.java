package com.trajectory.dao;

import java.util.List;
import java.util.Map;

import com.trajectory.pojo.Order;
import com.trajectory.pojo.Painting;
import com.trajectory.pojo.User;

public interface IManageDao {

	public void insertPainting(Painting painting);
	public List<Painting> selectPaintings(Map<String, String> params);
	public List<Order> selectOrders(Map<String, String> params);
	public List<Order> selectUserOrders(Map<String, String> params);
	public void updatePainting(Painting painting);
	public Painting selectPaintingDetail(String parseInt);
	public void deletePainting(String id);
	public Order selectOrderDetail(String id);
	public List<User> selectUsers(Map<String, String> params);
	public void recyclePainting(String id);
	public List<Map<String, String>> selectPaintingType();
	public void insertPaintingType(String name);

}
