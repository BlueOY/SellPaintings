package com.trajectory.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.trajectory.dao.ITestDao;
import com.trajectory.pojo.Test;
import com.trajectory.service.ITestService;

@Service("testService")
public class TestServiceImpl implements ITestService{
	
	@Resource
	private ITestDao testDao;

	@Override
	public Test getTestById(int userId) {
		return testDao.selectByPrimaryKey(userId);
	}

}
