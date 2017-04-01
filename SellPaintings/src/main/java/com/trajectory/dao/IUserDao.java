package com.trajectory.dao;

import java.util.Map;

public interface IUserDao {

	public Map<String, String> selectByOpenId(String openId);
	public void insertUser(Map<String, String> param);
	public void visitUser(String openId);

}
