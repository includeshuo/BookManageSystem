<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加图书</title>
</head>
<body>
	<form action="${pageContext.request.contextPath }/addbook" method="post">
	${msg }
	<table>
		<tr>
			<td>ISBN：</td><td><input type="text" name="bookid" /></td>
		</tr>
		<tr>
			<td>书籍名称：</td><td><input type="text" name="bookname" /></td>
		</tr>
		
		<tr>
			<td>作者:</td> <td><input type="text" name="bookauthor"></td>
		</tr>
		
		<tr>
			<td>出版社</td><td><input type="text" name="bookpub"></td>
		</tr>
		<tr>
			<td>类别</td><td><input type="text" name="booktype"></td>
		</tr>
		<tr>
			<td>数量</td><td><input type="text" name="bookcount"></td>
		</tr>
	
		
	</table>
		<input type="submit" value="添加"/><br/>
	</form>
</body>
</html>