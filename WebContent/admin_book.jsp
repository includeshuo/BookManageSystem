<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import = "com.ys.dao.UserDao,com.ys.dao.impl.UserDaoImpl,com.ys.bean.Book,com.ys.dao.BookDao,com.ys.dao.impl.BookDaoImpl,com.ys.bean.User" %>
<!DOCTYPE html>
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
                        <a class="navbar-brand" href="/BookManageSystem/admin.jsp"><strong>欢迎使用图书馆管理系统</strong></a>
                        <ul class="nav navbar-nav navbar-right">
                            <li class="dropdown">
                                <a href="#" role="button" class="dropdown-toggle" data-hover="dropdown"> <i class="glyphicon glyphicon-user"></i> 欢迎您， <s:property value="#session.admin.name"/> <i class="caret"></i></a>
                            
                                 <ul class="dropdown-menu">
                                     <li><a href="#updateinfo" data-toggle="modal">个人资料</a></li>
                                      <li role="presentation" class="divider"></li>
                                       <li><a href="#updatepwd" data-toggle="modal">修改密码</a></li>
                                        <li role="presentation" class="divider"></li>
                                    <li><a href="/BookManageSystem/login.jsp">退出</a></li>
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
                                <div class="text-muted bootstrap-admin-box-title">查询</div>
                            </div>
                            <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                                <form class="form-horizontal" action="/BookManageSystem/SelectServlet" method="post">
                                <input type="hidden" name="tip" value="1">
                        			<div class="col-lg-7 form-group">
                                        <label class="col-lg-4 control-label" for="query_bname">图书名称</label>
                                        <div class="col-lg-8">
                                            <input class="form-control" id="bookName" name="name" type="text" value="">
                                            <label class="control-label" for="query_bname" style="display: none;"></label>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 form-group">

                                        <button type="submit" class="btn btn-primary" id="btn_query" onclick="">查询</button>
                                    </div>
                                    <div class="col-lg-3 form-group">

                                        <button type="button" class="btn btn-primary" id="btn_add" data-toggle="modal" data-target="#addModal">添加图书</button>
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
                                <th>图书号</th>
                                <th>图书类型</th>
                                <th>图书名称</th>
                                <th>作者名称</th>
                                 <th>出版社</th>
                                <th>总数量</th>
                                <th>操作</th>
                                
                            </tr>
                            </thead>
                            
                            
                            <!---在此插入信息-->
                             <%
                             ArrayList<Book> bookdata = new ArrayList<Book>();
                             bookdata = (ArrayList<Book>)request.getAttribute("data");
                           if(bookdata==null){
                        	   BookDao bookdao = new BookDaoImpl();
                        	   bookdata = (ArrayList<Book>)bookdao.getListInfo();
                           }
	
  for (Book bean : bookdata){
  %>                 
								<tbody>
								<tr>
	                         	   	<td><%= bean.getBookid() %></td>
	                                <td><%= bean.getBooktype() %></td>
	                                <td><%= bean.getBookname() %></td>
	                                <td><%= bean.getBookauthor() %></td>
	                                <td><%= bean.getBookpub() %></td>  
	                                <td><%= bean.getBookcount() %></td>
<td><button type="button" class="btn btn-warning btn-xs" data-toggle="modal" data-target="#updateModal" 
id="btn_update" onclick="showInfo2(<%= bean.getBookid() %>,<%= bean.getBooktype() %>,<%= bean.getBookname() %>
,<%= bean.getBookauthor() %>,<%= bean.getBookpub() %>,<%= bean.getBookcount() %>)">修改</button>
<button type="button" class="btn btn-danger btn-xs" onclick="deletebook(<%= bean.getBookid() %>)">删除</button>
	</td>  
	</tr>                                          
                          	  </tbody>
                       <%} %> 
                        </table>
                    </div>
                </div>
        </div>
    </div>
    <script type="text/javascript">
    function showInfo2(bid,type,name,autho,press,num) {
        
        document.getElementById("updateBookName").value = name;
        
        document.getElementById("updateAutho").value = autho;
       
        document.getElementById("updatePress").value = press;
        
        document.getElementById("updateBookType").value = type;
        document.getElementById("updateNum").value = num;
        document.getElementById("updateBookId").value = bid;
    }
    function deletebook(bid) {
    	con=confirm("是否删除?"); 
    	if(con==true){
    		location.href = "/BookManageSystem/DeleteBookServlet?bid="+bid;
    	}
    }
    </script>
    
     
                                     <!-- 修改模态框（Modal） -->
                                     <!-------------------------------------------------------------->  
                                
                                        <!-- 修改模态框（Modal） -->
                               <form class="form-horizontal" method="post" action="/BookManageSystem/UpdateBookServlet">   <!--保证样式水平不混乱-->   
									<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
														&times;
													</button>
													<h4 class="modal-title" id="updateModalLabel">
														修改图书信息
													</h4>
												</div>
												<div class="modal-body">
												
										<!---------------------表单-------------------->
										
										<div class="form-group">
											<label for="firstname" class="col-sm-3 control-label">图书号</label>
												<div class="col-sm-7">	
													<input type="text" class="form-control" id="updateBookId" name="bookid"  placeholder="请输入书号">
												<label class="control-label" for="updateBookId" style="display: none;"></label>
												</div>
										</div>
										
											
										 <div class="form-group">
											<label for="firstname" class="col-sm-3 control-label">图书名称</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="updateBookName" name="bookname"  placeholder="请输入图书名称">
												<label class="control-label" for="updateBookName" style="display: none;"></label>
												</div>
										</div>
											
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">图书类型</label>
											<div class="col-sm-7">
												 <select class="form-control" id="updateBookType" name="booktype" >
                                           				 <option value="-1">请选择</option> 
              <option value= %></option>  
               <option >1</option>   
               <option >2</option>     
                                                                     
                                      			  </select>
											<label class="control-label" for="updateBookType" style="display: none;"></label>
											</div>
										</div>
											
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">作者名称</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="updateAutho" name="bookauthor" placeholder="请输入作者名称">
												<label class="control-label" for="updateAutho" style="display: none;"></label>
												</div>
										</div>
										
										
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">出版社</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="updatePress" name="bookpub"  placeholder="请输入出版社">
												<label class="control-label" for="updatePress" style="display: none;"></label>
												</div>
										</div>		
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">总数量</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="updateNum" name="bookcount"  placeholder="请输入总数量">
												<label class="control-label" for="updatePress" style="display: none;"></label>
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
                                 <form class="form-horizontal" method="post" action="/BookManageSystem/AddBookServlet">   <!--保证样式水平不混乱-->   
                                        <!-- 模态框（Modal） -->
									<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
														&times;
													</button>
													<h4 class="modal-title" id="myModalLabel">
														添加新图书
													</h4>
												</div>
												<div class="modal-body">
												
										<!---------------------表单-------------------->
										
										<div class="form-group">
											<label for="firstname" class="col-sm-3 control-label">图书号</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="addISBN" required="required" name="bookid" placeholder="请输入书号">
												<label class="control-label" for="addISBN" style="display: none;"></label>	
												</div>
										</div>
										
										 <div class="form-group">
											<label for="firstname" class="col-sm-3 control-label">图书名称</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="addBookName" required="required" name="bookname"  placeholder="请输入图书名称">
													<label class="control-label" for="addBookName" style="display: none;"></label>	
												</div>
										</div>
											
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">图书类型</label>
											<div class="col-sm-7">
												 <select class="form-control" id="addBookType" name="booktype">
                                           				 <option value="无分类">请选择</option>
                                           				 <option>1</option>
                                           				 <option>2</option>
                                           				 
                                      			  </select>
												<label class="control-label" for="addBookType" style="display: none;"></label>	
											</div>
										</div>
											
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">作者名称</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="addAutho" required="required" name="bookauthor"  placeholder="请输入作者名称">
												<label class="control-label" for="addAutho" style="display: none;"></label>	
												</div>
										</div>
										
										
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">出版社</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="addPress" required="required" name="bookpub"  placeholder="请输入出版社">
												<label class="control-label" for="addPress" style="display: none;"></label>	
												</div>
										</div>
										
										
										<div class="form-group">	
											<label for="firstname" class="col-sm-3 control-label">总数量</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="addNum" required="required" name="bookcount" placeholder="请输入图书总数量">
												<label class="control-label" for="addNum" style="display: none;"></label>	
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
                 
                   <form class="form-horizontal" method="post" action="/BookManageSystem/AdminServlet">   <!--保证样式水平不混乱-->                  
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
								<input type="hidden" name="url" value="admin_book">
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
								<input type="hidden" name="url" value="admin_book">
							<div class="form-group">
								<label for="firstname" class="col-sm-3 control-label">真实姓名</label>
								<div class="col-sm-7">
			<input type="text" class="form-control" id="name" name="name" placeholder="请输入您的真实姓名" value='<% out.write(user.getUsername());%>'>
										<label class="control-label" for="name" style="display: none"></label>			
								</div>
							</div>	
							
							
							
							
							<div class="form-group">
								<label for="firstname" class="col-sm-3 control-label">专业</label>
								<div class="col-sm-7">
			<input type="text" class="form-control" id="profession" name="profession"  placeholder="请输入您的专业" value='<% out.write(user.getProfession());%>'>
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