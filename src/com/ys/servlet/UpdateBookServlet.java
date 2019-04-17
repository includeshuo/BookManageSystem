package com.ys.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ys.bean.Book;
import com.ys.dao.BookDao;
import com.ys.dao.impl.BookDaoImpl;

/**
 * Servlet implementation class UpdateBookServlet
 */
@WebServlet("/UpdateBookServlet")
public class UpdateBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public UpdateBookServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		Book book = new Book();
		BookDao bookdao = new BookDaoImpl();
		book.setBookid( Integer.parseInt(request.getParameter("bookid")));
		book.setBookname(request.getParameter("bookname"));
		book.setBookauthor(request.getParameter("bookauthor"));
		book.setBookpub(request.getParameter("bookpub"));
		book.setBooktype(request.getParameter("booktype"));
		book.setBookcount(Integer.parseInt(request.getParameter("bookcount")));
		try {
			bookdao.updateBook(book);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		response.sendRedirect("/books/admin_book.jsp");
		doGet(request, response);
	}

}
