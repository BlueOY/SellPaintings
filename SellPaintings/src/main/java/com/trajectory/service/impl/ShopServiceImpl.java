package com.trajectory.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.trajectory.dao.IShopDao;
import com.trajectory.pojo.Order;
import com.trajectory.pojo.Painting;
import com.trajectory.service.IShopService;

@Service("shopService")
public class ShopServiceImpl implements IShopService{
	
	@Resource
	private IShopDao shopDao;

	@Override
	public List<Painting> getPaintings(Map<String, String> param) {
		return shopDao.selectPaintings(param);
	}
	
	@Override
	public Painting selectPaintingDetail(int id) {
		return shopDao.selectPaintingDetail(id);
	}

	@Override
	public void addOrder(Order order) {
		shopDao.insertOrder(order);
	}

	@Override
	public List<Order> getOrders(Map<String, String> param) {
		return shopDao.selectOrders(param);
	}

	@Override
	public void addOrderPaintings(List<Map<String, String>> list) {
		shopDao.insertOrderPaintings(list);
	}

}
