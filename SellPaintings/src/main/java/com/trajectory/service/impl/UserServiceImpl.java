package com.trajectory.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.trajectory.dao.IUserDao;
import com.trajectory.service.IUserService;

@Service("userService")
public class UserServiceImpl implements IUserService{
	
	@Resource
	private IUserDao userDao;

	@Override
	public Map<String, String> selectByOpenId(String openId) {
		return userDao.selectByOpenId(openId);
	}

	@Override
	public void insertUser(Map<String, String> param) {
		userDao.insertUser(param);
	}

	@Override
	public void visitUser(String openId) {
		userDao.visitUser(openId);
	}

}
