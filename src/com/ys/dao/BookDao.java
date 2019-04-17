package com.ys.dao;

import java.util.ArrayList;
import com.ys.bean.Book;
import com.ys.bean.BookHistory;
import com.ys.bean.User;


public interface BookDao {
		//添加图书
		public void addBook(Book book )throws Exception;
		//通过ISBN号查找单个图书  返回Book类型
		public Book findBookById(Book book) throws Exception;
		//获取所有书籍 并返回一个ArrayList
		public ArrayList<Book> getListInfo() throws Exception;
		//修改图书信息
		public void updateBook(Book book)throws Exception;
		//删除图书
		public void deleteBook(Book book)throws Exception;
		//根据传入的Status 查找正在借阅或已经归还的书
		public ArrayList<BookHistory> get_HistoryListInfo(int status,User u) throws Exception;
		public ArrayList<BookHistory> get_HistoryListInfo2(BookHistory h) throws Exception;
		//用户查找图书，根据输入的名称，使用like进行模糊查询，然后返回一个ArrayList数组类型
		public ArrayList<Book> getLikeList(Book book) throws Exception;
		//图书借阅函数，根据传入图书id，user当前登录用户的信息，在借阅记录数据表中新插入一条记录
		public void borrowBook(Book book,User user )throws Exception;
		//还书功能的函数，根据传入的hid借阅记录id，讲status字段的值改为0，并将还书日期改变为当前日期
		//改一下 根据传入的图书id进行select
		public void returnBook(Book book)throws Exception;
}
