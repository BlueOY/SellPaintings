package com.trajectory.service;

import java.util.Map;

public interface IUserService {
	
	public Map<String, String> selectByOpenId(String openId);
	public void insertUser(Map<String, String> param);
	public void visitUser(String openId);

}
