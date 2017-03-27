package com.trajectory.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.trajectory.dao.IManageDao;
import com.trajectory.pojo.Painting;
import com.trajectory.service.IManageService;

@Service("manageService")
public class ManageServiceImpl implements IManageService{
	
	@Resource
	private IManageDao manageDao;

	@Override
	public void addPaintings(Painting painting) {
		manageDao.insertPaintings(painting);
	}

}
