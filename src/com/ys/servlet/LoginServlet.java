package com.ys.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ys.bean.User;
import com.ys.dao.UserDao;
import com.ys.dao.impl.UserDaoImpl;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		User user = new User();
		
		user.setUserid(request.getParameter("userid"));
		user.setPassword(request.getParameter("password"));
		
		UserDao us =new UserDaoImpl();
		try {
			User u = us.findUserByNameAndPassword(user);
			HttpSession session = request.getSession();
			if(u!=null) {
				
				request.getSession().setAttribute("userid",""+u.getUserid());
				
				if(u.getStatus()==1) {
					request.getRequestDispatcher("/userindex.jsp").forward(request, response);
				}else {
					//再写管理员界面
					request.getRequestDispatcher("/admin.jsp").forward(request, response);
				}
			}else {
				session.setAttribute("state", "密码错误");
				
				request.getRequestDispatcher("/login.jsp").forward(request, response);
			}
		
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
	}
}

