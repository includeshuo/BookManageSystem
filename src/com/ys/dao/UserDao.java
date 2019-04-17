package com.ys.dao;

import java.util.ArrayList;

import com.ys.bean.User;

public interface UserDao {
	//添加用户
	public void addUser(User user )throws Exception;
	//通过用户名，密码查找用户信息 返回User类
	public User findUserByNameAndPassword(User user)throws Exception;
	//通过ID查找用户信息
	public User findUserByName (User user)throws Exception;
	//同上 传入的是Stirng类型
	public User findUserByName2 (String userid)throws Exception;
	
	//arrylist
	public ArrayList<User> getListInfo() throws Exception;
	//修改信息
	public void updateUser(User user)throws Exception;
	//删除信息
	public void deleteUser(User user)throws Exception;
}
