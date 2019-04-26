package com.ys.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.ys.bean.User;
import com.ys.dao.UserDao;
import com.ys.util.DBUtil;
//
public class UserDaoImpl implements UserDao{
	//添加到usertable
	@Override
	public void addUser(User user) throws Exception {
		//JDK7自动停止链接
			Connection conn = null;
			PreparedStatement ps = null;
	     	conn=DBUtil.getConnection();
	     	//status设置为1
	     	 ps = conn.prepareStatement("insert into usertable(user_id,password,user_name,profession,status) values(?,?,?,?,1)");
			 ps.setString(1, user.getUserid());
			 ps.setString(2, user.getPassword());
			 ps.setString(3, user.getUsername());
			 ps.setString(4, user.getProfession());
			
			 ps.executeUpdate();
		
	}
//ID和密码查找 返回User类
	@Override
	public User findUserByNameAndPassword(User user) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		conn=DBUtil.getConnection();
		ps = conn.prepareStatement("select user_id,password,status from usertable where user_id=? and password=?");
		ps.setString(1, user.getUserid());
		ps.setString(2, user.getPassword());
		rs = ps.executeQuery();
		User u = null;
		if(rs.next()) {
			u = new User();
			u.setUserid(rs.getString("user_id"));
			u.setPassword(rs.getString("password"));
			u.setStatus(rs.getInt("status"));
			DBUtil.CloseDB(rs, ps, conn);
		}
		return u;
	}
//ֻ仅ID查找User
	@Override
	public User findUserByName(User user) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		conn=DBUtil.getConnection();
		ps = conn.prepareStatement("select user_id,password,user_name,profession from usertable where user_id=?");
		ps.setString(1, user.getUserid());
		rs = ps.executeQuery();
		User u = null;
		if(rs.next()) {
			u = new User();
			u.setUserid(rs.getString("user_id"));
			u.setPassword(rs.getString("password"));
			u.setUsername(rs.getString("user_name"));
			u.setProfession(rs.getString("profession"));
		}
		DBUtil.CloseDB(rs, ps, conn);
		return u;
	}
	
	@Override
	public User findUserByName2(String userid) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select user_id,password,user_name,profession from usertable where user_id='"+userid+"'";
		conn=DBUtil.getConnection();
		ps = conn.prepareStatement(sql);
		
		rs = ps.executeQuery();
		User u = null;
		if(rs.next()) {
			u = new User();
			u.setUserid(rs.getString("user_id"));
			u.setPassword(rs.getString("password"));
			u.setUsername(rs.getString("user_name"));
			u.setProfession(rs.getString("profession"));
		}
		DBUtil.CloseDB(rs, ps, conn);
		return u;
	}
	//查找所有权限为1的用户，返回一个User类型的arrylist
	@Override
	public ArrayList<User> getListInfo() throws Exception {
		ArrayList<User> user_Array = new ArrayList<User>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		conn=DBUtil.getConnection();
		ps = conn.prepareStatement("select user_id,password,user_name,profession from usertable where status=1");
		rs = ps.executeQuery();
		User u = null;
		while(rs.next()) {
			u = new User();
			u.setUserid(rs.getString("user_id"));
			u.setPassword(rs.getString("password"));
			u.setUsername(rs.getString("user_name"));
			u.setProfession(rs.getString("profession"));
			user_Array.add(u);
					 
			
		}
		DBUtil.CloseDB(rs, ps, conn);
		return user_Array;
	}
	//更新用户信息
	@Override
	public void updateUser(User user) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
     	conn=DBUtil.getConnection();
     	//status����Ϊ1
     	 ps = conn.prepareStatement("update  usertable set password=?,user_name=?,profession=? where user_id=?");
		 
		 ps.setString(1, user.getPassword());
		 ps.setString(2, user.getUsername());
		 ps.setString(3, user.getProfession());
		 ps.setString(4, user.getUserid());
		 ps.executeUpdate();

	}
	@Override
	//删除用户信息
	public void deleteUser(User user) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
     	conn=DBUtil.getConnection();
     	ps = conn.prepareStatement("delete from usertable where user_id=?");
     	ps.setString(1, user.getUserid());
     	ps.executeUpdate();
	}


}
