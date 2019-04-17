package com.ys.servlet;

import java.io.IOException;
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
@WebServlet("/addbook")
public class AddBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

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
			  request.setAttribute("msg", "图书已经存在");
		     Book result = book.findBookById(b);
			if(result!=null) {
				request.getRequestDispatcher("/addbook.jsp").forward(request, response);
				
			}else {
				book.addBook(b);
				
				  response.getWriter().write("添加成功");
				  response.setHeader("refresh","1;url="+request.getContextPath()+"/addbook.jsp");
			}
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		  
	}

}
