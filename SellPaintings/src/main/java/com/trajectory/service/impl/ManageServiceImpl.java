package com.trajectory.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.trajectory.dao.IManageDao;
import com.trajectory.pojo.Order;
import com.trajectory.pojo.Painting;
import com.trajectory.pojo.User;
import com.trajectory.service.IManageService;

@Service("manageService")
public class ManageServiceImpl implements IManageService{
	
	@Resource
	private IManageDao manageDao;

	@Override
	public void addPainting(Painting painting) {
		manageDao.insertPainting(painting);
	}

	@Override
	public List<Painting> getPaintings(Map<String, String> params) {
		return manageDao.selectPaintings(params);
	}

	@Override
	public List<Order> getOrders(Map<String, String> params) {
		return manageDao.selectOrders(params);
	}
	@Override
	public List<Order> getUserOrders(Map<String, String> params) {
		// TODO Auto-generated method stub
		return manageDao.selectUserOrders(params);
	}

	@Override
	public void updatePainting(Painting painting) {
		manageDao.updatePainting(painting);
	}

	@Override
	public Painting selectPaintingDetail(String parseInt) {
		return manageDao.selectPaintingDetail(parseInt);
	}

	@Override
	public void deletePainting(String id) {
		manageDao.deletePainting(id);
	}

	@Override
	public Order selectOrderDetail(String id) {
		return manageDao.selectOrderDetail(id);
	}

	@Override
	public List<User> selectUsers(Map<String, String> params) {
		return manageDao.selectUsers(params);
	}

}
