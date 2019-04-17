package com.ys.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ys.bean.Book;
import com.ys.bean.User;
import com.ys.dao.BookDao;
import com.ys.dao.UserDao;
import com.ys.dao.impl.BookDaoImpl;
import com.ys.dao.impl.UserDaoImpl;



/**
 * Servlet implementation class BorrowServlet
 */
@WebServlet("/BorrowServlet")
public class BorrowServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BorrowServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//设置编码类型
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		BookDao bookdao = new BookDaoImpl();
		//为了区分借书和还书的功能，设置tip，tip为1，表示借书
		int tip = Integer.parseInt(request.getParameter("tip"));
		if(tip==1){
			//获取图书id
			Book bookid = new Book();
			Book book = new Book();
			bookid.setBookid(Integer.parseInt(request.getParameter("bookid")));
			 try {
				book = bookdao.findBookById(bookid);
			} catch (Exception e1) {
				
				e1.printStackTrace();
			}
			HttpSession session = request.getSession();
			User user = new User();
			//获取到存入session的aid读者id
			String userid = (String)session.getAttribute("userid");
			UserDao admindao = new UserDaoImpl();
			//通过userid获取到读者的信息
			try {
				user = admindao.findUserByName2(userid);
				bookdao.borrowBook(book, user);
			} catch (Exception e) {
				
				e.printStackTrace();
			}
			//将借阅记录存入数据表
			
			response.sendRedirect("/BookManageSystem/select.jsp");
		}else{
			
			/**
			 * 还书在管理员和读者界面都有，为了区分，设置了show字段，show为1表示读者界面
			 */
			Book book = new Book();
			book.setBookid(Integer.parseInt(request.getParameter("bookid")));
			int show = Integer.parseInt(request.getParameter("show"));
			//调用还书函数，改变status字段
			try {
				bookdao.returnBook(book);
			} catch (Exception e) {
				
				e.printStackTrace();
			};
			if(show==1){
				response.sendRedirect("/BookManageSystem/borrow.jsp");
			}else{
				response.sendRedirect("/books/admin_borrow.jsp");
			}
			
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
