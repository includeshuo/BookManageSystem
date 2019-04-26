package com.ys.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.ys.bean.Book;
import com.ys.dao.BookDao;
import com.ys.dao.impl.BookDaoImpl;

/**
 * Servlet implementation class AddBookServlet
 */
@WebServlet("/AddBookServlet")
public class AddBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		Book b = new Book();
		try {
			
			BeanUtils.populate(b, request.getParameterMap());
		} catch (IllegalAccessException e1) {
			e1.printStackTrace();
		} catch (InvocationTargetException e1) {
			e1.printStackTrace();
		}
		
		BookDao book = new BookDaoImpl();
		
		  try {
			  
		     Book result = book.findBookById(b);
			if(result!=null) {
				out.write("<script type='text/javascript'>alert('Book already existed');location.href='/BookManageSystem/admin_book.jsp';  </script>");
				
				
			}else {
				book.addBook(b);
				
				response.sendRedirect("/BookManageSystem/admin_book.jsp");
				  
			}
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		  
	}

}
