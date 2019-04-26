$(function () {
	
	
    $('#login_submit').click(function () {
        if (!validLogin()) {
            return;
        }
		
		
	var postdata = "paperNO="+$.trim($("#userid").val())+"&pwd="+ $.trim($("#password").val());
	ajax(
    		  {
			  	method:'POST',
	    		url:'readerLoginAction_login.action',
				params: postdata,
	    		callback:function(data) {
					if (data == 1) {
	                    window.location.href = "reader.jsp";
	                } else if (data == -1) {
	                    showInfo("账号不存在");
	                } else if (data == -2) {
	                    showInfo("密码错误");
	                } else {
	                    showInfo("登录失败，请重试");
	                }
								
				}
			}
			   
    	);
			
		
	});
	
		
		
		var alert = $('.alert');
	    var formWidth = $('.bootstrap-admin-login-form').innerWidth();
	    var alertPadding = parseInt($('.alert').css('padding'));
	    if (isNaN(alertPadding)) {
	        alertPadding = parseInt($(alert).css('padding-left'));
	    }
	    $('.alert').width(formWidth - 2 * alertPadding);

});

function validLogin() {
    var flag = true;

    var userid = $.trim($("#userid").val());
    if (userid == "") {
        $('#userid').parent().addClass("has-error");
        $('#userid').next().text("请输入账号");
        $("#userid").next().show();
        flag = false;
    } else if (userid.length<2 || userid.length > 15) {
        $("#userid").parent().addClass("has-error");
        $("#userid").next().text("账号长度必须在2~15之间");
        $("#userid").next().show();
        flag = false;
    } else {
        $('#userid').parent().removeClass("has-error");
        $('#userid').next().text("");
        $("#userid").next().hide();
    }

    var password = $.trim($("#password").val());
    if (password == "") {
        $('#password').parent().addClass("has-error");
        $('#password').next().text("请输入密码");
        $("#password").next().show();
        flag = false;
    } else if (password.length<3||password.length > 15) {
        $("#password").parent().addClass("has-error");
        $("#password").next().text("密码长度必须在3~15之间");
        $("#password").next().show();
        flag = false;
    } else {
        $('#password').parent().removeClass("has-error");
        $('#password').next().text("");
        $("#password").next().hide();
    }
    return flag;
}

function showInfo(msg) {
    $("#div_info").text(msg);
    $("#modal_info").modal('show');
}