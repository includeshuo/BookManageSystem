package com.ys.servlet;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.ys.bean.User;
import com.ys.dao.UserDao;
import com.ys.dao.impl.UserDaoImpl;

@WebServlet("/RegistServlet")
public class RegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		
		User u = new User();
//		u.setId(request.getParameter("id"));
//		u.setPassword(request.getParameter("password"));
//		u.setUsername(request.getParameter("username"));
	
		try {
						
			BeanUtils.populate(u, request.getParameterMap());
		} catch (IllegalAccessException e1) {
			e1.printStackTrace();
		} catch (InvocationTargetException e1) {
			e1.printStackTrace();
		}
		
		UserDao us = new UserDaoImpl();
		
		
		try {
			
			request.setAttribute("msg", "用户名重复");
			User result = us.findUserByName(u);
			if(result!=null) {
				request.getRequestDispatcher("/regist.jsp").forward(request, response);
				
			}else {
				us.addUser(u);
				
				response.sendRedirect("/BookManageSystem/admin_user.jsp");
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		
	}

	}


