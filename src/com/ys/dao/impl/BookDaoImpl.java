package com.ys.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;

import com.ys.bean.Book;
import com.ys.bean.BookHistory;
import com.ys.bean.User;
import com.ys.dao.BookDao;
import com.ys.util.DBUtil;

public class BookDaoImpl implements BookDao{
    //添加图书
	@Override
	public void addBook(Book book) throws Exception {
		//JDK7自动关闭
		Connection conn = null;
		PreparedStatement ps = null;
     	conn=DBUtil.getConnection();
   	 ps = conn.prepareStatement("insert into book(book_id,book_name,book_author,book_pub,book_type,book_count) values(?,?,?,?,?,?)");
	 ps.setInt(1, book.getBookid());
	 ps.setString(2,book.getBookname() );
	 ps.setString(3,book.getBookauthor() );
	 ps.setString(4,book.getBookpub() );
	 ps.setString(5, book.getBooktype());
	 ps.setInt(6,book.getBookcount() );
	
	 ps.executeUpdate();
	 
		
	}
	//查找单个图书
	@Override
	public Book findBookById(Book book) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		conn=DBUtil.getConnection();
		ps = conn.prepareStatement("select * from book where book_id=?");
		ps.setInt(1, book.getBookid());
		
		rs = ps.executeQuery();
		Book b= null;
		if(rs.next()) {
			b = new Book();
			b.setBookid(rs.getInt("book_id"));
			b.setBookname(rs.getString("book_name"));
			b.setBookauthor(rs.getString("book_author"));
			b.setBookpub(rs.getString("book_pub"));
			b.setBooktype(rs.getString("book_type"));
			b.setBookcount(rs.getInt("book_count"));	
		}
		DBUtil.CloseDB(rs, ps, conn);
		return b;
	}
	//查所有图书返回arraylist
	@Override
	public ArrayList<Book> getListInfo() throws Exception {
		ArrayList<Book> book_Array = new ArrayList<Book>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		conn=DBUtil.getConnection();
		ps = conn.prepareStatement("select * from book");
		rs = ps.executeQuery();
		Book b = null;
		while(rs.next()) {
			b = new Book();
			 b.setBookid(rs.getInt("book_id"));
			b.setBookname(rs.getString("book_name"));
			b.setBookauthor(rs.getString("book_author"));
			b.setBookpub(rs.getString("book_pub"));
			b.setBooktype(rs.getString("book_type"));
			b.setBookcount(rs.getInt("book_count"));
			book_Array.add(b);
					 
		}
		DBUtil.CloseDB(rs, ps, conn);
		return book_Array;
	}
	//修改图书信息
	@Override
	public void updateBook(Book book) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
		conn=DBUtil.getConnection();
		ps = conn.prepareStatement("update book set book_id=?, book_name=?,	book_author=?,book_pub=?,book_type=?,book_count=? where book_id=? ");
		ps.setInt(1, book.getBookid());
		 ps.setString(2,book.getBookname() );
		 ps.setString(3,book.getBookauthor() );
		 ps.setString(4,book.getBookpub() );
		 ps.setString(5, book.getBooktype());
		 ps.setInt(6,book.getBookcount() );
		 ps.setInt(7, book.getBookid());
		ps.executeUpdate();
	}
	//删除图书
	@Override
	public void deleteBook(Book book) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
		conn=DBUtil.getConnection();
		//未测试
		ps = conn.prepareStatement("delete from book where book_id=?");
		ps.setInt(1, book.getBookid());
		ps.executeUpdate();
	}
	//根据传入的Status和当前登录的ID 查找正在借阅或已经归还的书
	@Override
	public ArrayList<BookHistory> get_HistoryListInfo(int status, User u) throws Exception {
		ArrayList<BookHistory> tag_Array = new ArrayList<BookHistory>();
		Connection conn = null;
		PreparedStatement ps = null;
		conn=DBUtil.getConnection();
		ResultSet rs = null;
		ps = conn.prepareStatement("select * from borrowhistory where user_id=? and status=?");
		ps.setString(1, u.getUserid());
		ps.setInt(2,status);
		rs = ps.executeQuery();
		BookHistory bh =null;
		while(rs.next()) {
			bh = new BookHistory();
			bh.setHid(rs.getInt("hid"));
			bh.setUserid(rs.getString("user_id"));		
			bh.setUsername(rs.getString("user_name"));
			bh.setBookid(rs.getInt("book_id"));
			bh.setBookname(rs.getString("book_name"));
			bh.setBegintime(rs.getString("begin_time"));
			bh.setEndtime(rs.getString("end_time"));
			bh.setStatus(rs.getInt("status"));
			tag_Array.add(bh);
		}
		DBUtil.CloseDB(rs, ps, conn);
		return tag_Array;
	}
	//只传入status
	@Override
	public ArrayList<BookHistory> get_HistoryListInfo2(int status) throws Exception {
		ArrayList<BookHistory> tag_Array = new ArrayList<BookHistory>();
		Connection conn = null;
		PreparedStatement ps = null;
		conn=DBUtil.getConnection();
		ResultSet rs = null;
		ps = conn.prepareStatement("select * from borrowhistory where status=?");
		ps.setInt(1,status);
		rs = ps.executeQuery();
		BookHistory bh =null;
		while(rs.next()) {
			bh = new BookHistory();
			bh.setHid(rs.getInt("hid"));
			bh.setUserid(rs.getString("user_id"));		
			bh.setUsername(rs.getString("user_name"));
			bh.setBookid(rs.getInt("book_id"));
			bh.setBookname(rs.getString("book_name"));
			bh.setBegintime(rs.getString("begin_time"));
			bh.setEndtime(rs.getString("end_time"));
			bh.setStatus(rs.getInt("status"));
			tag_Array.add(bh);
		}
		DBUtil.CloseDB(rs, ps, conn);
		return tag_Array;
		
	}
	//用户查找图书，根据输入的名称，使用like进行模糊查询，然后返回一个ArrayList数组类型
	@Override
	public ArrayList<Book> getLikeList(Book book) throws Exception {
		ArrayList<Book> tag_Array = new ArrayList<Book>();
		Connection conn = null;
		PreparedStatement ps = null;
		conn=DBUtil.getConnection();
		ResultSet rs = null;
		//这样改不知道行不行
		ps = conn.prepareStatement("select * from book where book_name like '%\"+?+\"%'");
		ps.setString(1, book.getBookname());
		rs = ps.executeQuery();
		Book b = null;
		if(rs.next()) {
		b = new Book();
		b.setBookid(rs.getInt("book_id"));
		b.setBookname(rs.getString("book_name"));
		b.setBookauthor(rs.getString("book_author"));
		b.setBookpub(rs.getString("book_pub"));
		b.setBooktype(rs.getString("book_type"));
		b.setBookcount(rs.getInt("book_count"));
		tag_Array.add(b);
	}
		DBUtil.CloseDB(rs, ps, conn);
		return tag_Array;
	}
	//借书功能
	//反正不管输入的啥 封装到bean，这里重新按ID查书 所有信息返回到b中
	@Override
	public void borrowBook(Book book, User user) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
     	Book b = new Book();
     	b=this.findBookById(book);
     			//生成日期的功能
     			Calendar c = Calendar.getInstance();
     			int year = c.get(Calendar.YEAR);  
     			int month = c.get(Calendar.MONTH)+1;   
     			int day = c.get(Calendar.DATE);  
     			//生成借阅开始日期
     			String begintime = ""+year+"-"+month+"-"+day;
     			month = month + 1;
     			//生成截止还书日期
     			String endtime = ""+year+"-"+month+"-"+day;
     			
     			
     			conn=DBUtil.getConnection();
     			ps = conn.prepareStatement("insert into borrowhistory (user_id,user_name,book_name,book_id,begin_time,end_time,status) values(?,?,?,?,?,?,?) ");
     			ps.setString(1,user.getUserid());
     			ps.setString(2,user.getUsername());
     			ps.setString(3,b.getBookname());
     			ps.setInt(4,b.getBookid());
     			ps.setString(5, begintime);
     			ps.setString(6, endtime);
     			ps.setInt(7, 1);
     			int rs=0;
     			//返回执行成功条数
     			rs = ps.executeUpdate();
	}
	@Override
	public void returnBook(int hid) throws Exception {
				//生成日期
				Calendar c = Calendar.getInstance();
				int year = c.get(Calendar.YEAR);  
				int month = c.get(Calendar.MONTH)+1;   
				int day = c.get(Calendar.DATE); 
				//生成还书日期
				String endtime = ""+year+"-"+month+"-"+day;
				
				
				
				Connection conn = null;
				PreparedStatement ps = null;
				conn=DBUtil.getConnection();
				//先加上转译不行再删
				ps = conn.prepareStatement("update borrowhistory set end_time=?,status=? where hid=?");
				ps.setString(1, endtime);
				ps.setInt(2, 0);
				ps.setInt(3, hid);
				ps.executeUpdate();
	}
	
}
