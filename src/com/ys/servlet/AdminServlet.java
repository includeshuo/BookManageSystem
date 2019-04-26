package com.ys.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ys.bean.User;
import com.ys.dao.BookDao;
import com.ys.dao.UserDao;
import com.ys.dao.impl.BookDaoImpl;
import com.ys.dao.impl.UserDaoImpl;



/**
 * Servlet implementation class AdminServlet
 */
@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public AdminServlet() {
        super();
      
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		//设置编码类型
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		BookDao  bookdao = new BookDaoImpl();
		//这里为了简单，设置了tip，用来区分是修改密码功能，还是修改个人资料的功能，tip=1为修改密码
		int tip = Integer.parseInt(request.getParameter("tip"));
		//获取发起请求页面的文件名称，这个在对应的jsp里面的表单填写，修改完成后就可以直接返回对应的页面
		String url = request.getParameter("url");
		HttpSession session = request.getSession();
		UserDao userdao = new UserDaoImpl();
		
		String userid = (String)session.getAttribute("userid");
		try {
			User user = userdao.findUserByName2(userid);
			//修改密码
			if(tip==1){
				//获取到输入的旧密码，新密码
				String password = request.getParameter("password");
				String password2 = request.getParameter("password2");
				//获取读者数据表中的密码
				String old_password = user.getPassword();
				if(old_password.equals(password)){
					user.setPassword(password2);
					userdao.updateUser(user);
					response.sendRedirect("/BookManageSystem/"+url+".jsp");
				}else{
					out.write("<script type='text/javascript'>alert('password error');location.href='"+url+".jsp';  </script>");
					
				}
					
					
			
			}else{
				//修改个人资料
				//获取输入的信息
				user.setUsername(request.getParameter("name"));
				user.setProfession(request.getParameter("profession"));
				
				
				
				//修改输入的信息到数据表中
				userdao.updateUser(user);
				response.sendRedirect("/BookManageSystem/"+url+".jsp");
			}
		

		} catch (Exception e) {
			
			e.printStackTrace();
		}
	}

}
