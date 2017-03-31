package com.trajectory.service;

import java.util.List;
import java.util.Map;

import com.trajectory.pojo.Order;
import com.trajectory.pojo.Painting;

public interface IManageService {
	
	public void addPaintings(Painting painting);
	public List<Painting> getPaintings(Map<String, String> params);
	public List<Order> getOrders(Map<String, String> params);
	public void updatePaintings(Painting painting);
	public Painting selectPaintingDetail(String parseInt);
	public void deletePainting(String id);

}
