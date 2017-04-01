package com.trajectory.dao;

import java.util.List;
import java.util.Map;

import com.trajectory.pojo.Order;
import com.trajectory.pojo.Painting;

public interface IManageDao {

	public void insertPainting(Painting painting);
	public List<Painting> selectPaintings(Map<String, String> params);
	public List<Order> selectOrders(Map<String, String> params);
	public void updatePainting(Painting painting);
	public Painting selectPaintingDetail(String parseInt);
	public void deletePainting(String id);
	public Order selectOrderDetail(String id);

}
