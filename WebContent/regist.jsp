<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>注册</title>
</head>
<body>
	<form action="${pageContext.request.contextPath }/regist" method="post">
	${msg }
	<table>
		<tr>
			<td>I&nbsp;&nbsp;D&nbsp;：</td><td><input type="text" name="userid" /></td>
		</tr>
		<tr>
			<td>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码&nbsp;：</td><td><input type="password" name="password" /></td>
		</tr>
		
		<tr>
			<td>用户名:</td> <td><input type="text" name="username"></td>
		</tr>
		
		<tr>
			<td>所在系</td><td><input type="text" name="profession"></td>
		</tr>
		<!-- 等级不能输入 dao层直接输入等级1 -->
		
	</table>
		<input type="submit" value="注册"/><br/>
	</form>
</body>
</html>