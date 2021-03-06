<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import = "com.ys.bean.User,com.ys.dao.UserDao,com.ys.dao.impl.UserDaoImpl" %>
<!DOCTYPE HTML >
<html lang="zh-CN" class="ax-vertical-centered">
<head>
	<meta charset="UTF-8">
	<title>图书馆管理系统</title>
	    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="static/css/bootstrap.min.css">
	    <link rel="stylesheet" href="static/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="static/css/bootstrap-admin-theme.css">
        <link rel="stylesheet" href="static/css/bootstrap-admin-theme.css">
        <script src="static/jQuery/jquery-3.1.1.min.js"></script>
        <script src="static/js/bootstrap.min.js"></script>
        
            <script src="static/js/bootstrap-dropdown.min.js"></script>                    
              <script src="static/ajax-lib/ajaxutils.js"></script>
            <script src="static/js/adminUpdateInfo.js"></script>
             <script src="static/js/adminUpdatePwd.js"></script>
       
</head>



<script src="static/js/jquery.min.js"></script>
<script src="static/js/bootstrap.min.js"></script>


<body class="bootstrap-admin-with-small-navbar">
<%
User user = new User();
String userid = (String)session.getAttribute("userid");
UserDao ud = new UserDaoImpl();
user = ud.findUserByName2(userid);

%>
    <nav class="navbar navbar-inverse navbar-fixed-top bootstrap-admin-navbar bootstrap-admin-navbar-under-small" role="navigation">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="collapse navbar-collapse main-navbar-collapse">
                        <a class="navbar-brand" href="/admin/admin.jsp"><strong>欢迎使用图书馆管理系统</strong></a>
                        <ul class="nav navbar-nav navbar-right">
                            <li class="dropdown">
                                <a href="#" role="button" class="dropdown-toggle" data-hover="dropdown"> <i class="glyphicon glyphicon-user"></i> 欢迎您， ${userid} <i class="caret"></i></a>
                            
                                 <ul class="dropdown-menu">
                                     <li><a href="#updateinfo" data-toggle="modal">个人资料</a></li>
                                      <li role="presentation" class="divider"></li>
                                       <li><a href="#updatepwd" data-toggle="modal">修改密码</a></li>
                                        <li role="presentation" class="divider"></li>
                                     <!-- href="#identifier"  来指定要切换的特定的模态框（带有 id="identifier"）。-->  
                                    <li><a href="/books/login.jsp">退出</a></li>
                                </ul>
                                
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <div class="container">
        <!-- left, vertical navbar & content -->
        <div class="row">
            <!-- left, vertical navbar -->
            <div class="col-md-2 bootstrap-admin-col-left">
                <ul class="nav navbar-collapse collapse bootstrap-admin-navbar-side">
                   
                    <li>
                        <a href="/BookManageSystem/admin_book.jsp"><i class="glyphicon glyphicon-chevron-right"></i> 图书管理</a>
                    </li>
                    <li>
                        <a href="/BookManageSystem/admin_user.jsp"><i class="glyphicon glyphicon-chevron-right"></i> 读者管理</a>
                    </li>
                   
                    <li>
                        <a href="/BookManageSystem/admin_borrow.jsp"><i class="glyphicon glyphicon-chevron-right"></i> 图书借阅信息</a>
                    </li>
                    <li>
                        <a href="/BookManageSystem/admin_history.jsp"><i class="glyphicon glyphicon-chevron-right"></i> 图书归还信息</a>
                    </li>
                </ul>
                
            </div>

            <!-- content -->
            <div class="col-md-10">
                
                
              <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default bootstrap-admin-no-table-panel">
                            <div class="panel-heading">
                                <div class="text-muted bootstrap-admin-box-title">读者管理</div>
                            </div>
                            <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                                <form class="form-horizontal" action="/books/selectServlet" method="post">
                        
                                    <div class="col-lg-3 form-group">

                                        <button type="button" class="btn btn-primary" id="btn_add" data-toggle="modal" data-target="#addModal">添加读者</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                
                
                <div class="row">
                    <div class="col-lg-12">
                        <table id="data_list" class="table table-hover table-bordered" cellspacing="0" width="100%">
                            <thead>
                            <tr>
                                <th>账号</th>
                                <th>姓名</th>
                                <th>专业</th>
                                <th>密码</th>
                                
                                <th>操作</th>
                                
                            </tr>
                            </thead>
                            
                            
                            <!---在此插入信息-->
                             <%
                             ArrayList<User> data2 = new ArrayList<User>();
                             data2 = (ArrayList<User>)request.getAttribute("data");
                           if(data2==null){
                        	   
                        	   data2 = (ArrayList<User>)ud.getListInfo();
                           }
	
  for (User bean : data2){
  %>                 
								<tbody>
								<tr>
	                         	   	<td><%= bean.getUserid() %></td>
	                                <td><%= bean.getUsername() %></td>
	                                <td><%= bean.getProfession() %></td>
	                                <td><%= bean.getPassword() %></td>
	                                
<td><button type="button" class="btn btn-warning btn-xs" data-toggle="modal" data-target="#updateModal" 
id="btn_update" onclick="showInfo2('<%= bean.getUserid() %>','<%= bean.getUsername() %>','<%= bean.getProfession() %>'
,'<%= bean.getPassword() %>')">修改</button>
<button type="button" class="btn btn-danger btn-xs" onclick="deleteuser('<%= bean.getUserid() %>')">删除</button>
	</td>                   </tr>                         
                          	  </tbody>
                       <%} %> 
                        </table>
                    </div>
                </div>
        </div>
    </div>
    <script type="text/javascript">
    function showInfo2(aid,username,profession,password) {
        document.getElementById("updateuserid").value = aid;
        
        document.getElementById("updateusername").value = username;
        
        document.getElementById("updateemail").value = profession;
       
        document.getElementById("updatepassword").value = password;
       
    }
    function deleteuser(aid) {
    	con=confirm("是否删除?"); 
    	
    	if(con==true){
    		location.href = "/BookManageSystem/DeleteUserServlet?userid="+aid;
    	}
    }
    </script>
    
     
                                     <!-- 修改模态框（Modal） -->
                                     <!-------------------------------------------------------------->  
                                
                                        <!-- 修改模态框（Modal） -->
                               <form class="form-horizontal" method="post" action="/BookManageSystem/UpdateUserServlet">   <!--保证样式水平不混乱-->   
									<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
														&times;
													</button>
													<h4 class="modal-title" id="updateModalLabel">
														修改读者信息
													</h4>
												</div>
												<div class="modal-body">
												
										<!---------------------表单-------------------->
										
										
										
											
										 <div class="form-group">
											<label for="firstname" class="col-sm-3 control-label">姓名</label>
												<div class="col-sm-7">
												<input type="hidden" id="updateuserid" name="userid">
													<input type="text" class="form-control" id="updateusername" name="username"  placeholder="">
												<label class="control-label" for="updateusername" style="display: none;"></label>
												</div>
										</div>
											
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">专业</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="updateemail" name="profession" placeholder="">
												<label class="control-label" for="updateemail" style="display: none;"></label>
												</div>
										</div>
										
										
												
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">密码</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="updatepassword" name="password"  placeholder="">
												<label class="control-label" for="updatepassword" style="display: none;"></label>
												</div>
										</div>
										
											
										</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-default" data-dismiss="modal">关闭
													</button>
													<button type="submit" class="btn btn-primary" >
														修改
													</button>
												</div>
											</div><!-- /.modal-content -->
										</div><!-- /.modal -->
									</div>
	
                                 </form>
                                   <!-------------------------------------------------------------->
 
    
    
    
    
    
    
     <!--------------------------------------添加的模糊框------------------------>  
                                 <form class="form-horizontal" method="post" action="/BookManageSystem/RegistServlet">   <!--保证样式水平不混乱-->   
                                        <!-- 模态框（Modal） -->
									<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
														&times;
													</button>
													<h4 class="modal-title" id="myModalLabel">
														添加新读者
													</h4>
												</div>
												<div class="modal-body">
												
										<!---------------------表单-------------------->
										
										<div class="form-group">
											<label for="firstname" class="col-sm-3 control-label">账号</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" name="userid" id="addISBN" required="required" placeholder="请输入账号">
												<label class="control-label" for="addISBN" style="display: none;"></label>	
												</div>
										</div>
										
										 <div class="form-group">
											<label for="firstname" class="col-sm-3 control-label">姓名</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" name="username" id="addBookName" required="required"  placeholder="请输入姓名">
													<label class="control-label" for="addBookName" style="display: none;"></label>	
												</div>
										</div>
											
								
											
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">专业</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" name="profession" id="updateemail" required="required"  placeholder="请输入专业">
												<label class="control-label" for="updateemail" style="display: none;"></label>	
												</div>
										</div>
										
										
										
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">密码</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" name="password" id="addPress" required="required"   placeholder="请输入密码">
												<label class="control-label" for="addPress" style="display: none;"></label>	
												</div>
										</div>
										
										
										
										
										<!---------------------表单-------------------->
									</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-default" data-dismiss="modal">关闭
													</button>
													<button type="submit" class="btn btn-primary" >
														添加
													</button>
												</div>
											</div><!-- /.modal-content -->
										</div><!-- /.modal -->
									</div>

                                 </form>	
 								<!--------------------------------------添加的模糊框------------------------>  
 
 
    
    
    
    
    
<!-------------------------------------------------------------->  
                 
                   <form class="form-horizontal" method="post" action="/books/AdminServlet">   <!--保证样式水平不混乱-->                  
                                     <!-- 模态框（Modal） -->
				<div class="modal fade" id="updatepwd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
									&times;
								</button>
								<h4 class="modal-title" id="myModalLabel">
									修改密码
								</h4>
							</div>
							<div class="modal-body">
							 
								<!--正文-->
								<input type="hidden" name="tip" value="1">
								<input type="hidden" name="url" value="admin_user">
							<div class="form-group">
								<label for="firstname" class="col-sm-3 control-label">原密码</label>
								<div class="col-sm-7">
									<input type="password" class="form-control" name="password" id="oldPwd"  placeholder="请输入原密码">
										<label class="control-label" for="oldPwd" style="display: none"></label>				
								</div>
							</div>	
							
							<div class="form-group">
								<label for="firstname" class="col-sm-3 control-label">新密码</label>
								<div class="col-sm-7">
									<input type="password" class="form-control" name="password2" id="newPwd"  placeholder="请输入新密码">
										<label class="control-label" for="newPwd" style="display: none"></label>			
								</div>
							</div>	
							
								<!--正文-->
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">关闭
								</button>
								<button type="submit" class="btn btn-primary" >
									修改
								</button>
							</div>
						</div><!-- /.modal-content -->
					</div><!-- /.modal -->
				</div>

				</form>	
                                   <!-------------------------------------------------------------->
                                   
                                   <!-------------------------个人资料模糊框------------------------------------->  
                 
                   <form class="form-horizontal" method="post" action="/BookManageSystem/AdminServlet">   <!--保证样式水平不混乱-->                  
                                     <!-- 模态框（Modal） -->
				<div class="modal fade" id="updateinfo" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
									&times;
								</button>
								<h4 class="modal-title" id="ModalLabel">
									个人资料
								</h4>
							</div>
							
							<div class="modal-body">
							 
								<!--正文-->
								<input type="hidden" name="tip" value="2">
								<input type="hidden" name="url" value="admin_user">
							<div class="form-group">
								<label for="firstname" class="col-sm-3 control-label">真实姓名</label>
								<div class="col-sm-7">
			<input type="text" class="form-control" id="name" name="name" placeholder="请输入您的真实姓名" value='<% out.write(user.getUsername());%>'>
										<label class="control-label" for="name" style="display: none"></label>			
								</div>
							</div>	
							
						
							
						
						<div class="form-group">
								<label for="firstname" class="col-sm-3 control-label">部门</label>
								<div class="col-sm-7">
			<input type="text" class="form-control" id="profession" name="profession"  placeholder="请输入您的部门" value='<% out.write(user.getProfession());%>'>
											<label class="control-label" for="profession" style="display: none"></label>				
								</div>
							</div>
							
								<!--正文-->
								
								
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">关闭
								</button>
								<button type="submit" class="btn btn-primary" >
									修改
								</button>
							</div>
						</div><!-- /.modal-content -->
					</div><!-- /.modal -->
				</div>

				</form>	
                                   <!-------------------------------------------------------------->
    
    
    
    
    
    <div class="modal fade" id="modal_info" tabindex="-1" role="dialog" aria-labelledby="addModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="infoModalLabel">提示</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-12" id="div_info"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="btn_info_close" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
 </div>   
    
    
    
    
</body>
</html>