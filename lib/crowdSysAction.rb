require "crowdSystem"
require 'crowdSysENV'

###########################################################
##########################加载库############################
def require_lib(arg='')
	require 'crowdSystem'
	require 'crowdSysENV'
	require 'minitest/autorun'
	require 'watir'
	require 'Watir-WebDriver'
	require 'minitest/reporters'
	require 'win32ole'
	require 'mongo'
	require 'uri'
	require 'time'
	require 'net/ssh'
	#报告输出开关，调试脚本时需要将其屏蔽。否则无法看到日志输出
	Minitest::Reporters.use! [Minitest::Reporters::HtmlReporter.new(:title => $testReportTitle,:reports_dir => $testReportDir,:output_filename => 'index_new.html')] if arg == ''
end


#############################################################
######################封装方法################################
class CrowdAction
  include CrowdElement
  
  def initialize(dr)
	@dr ||= dr
  end
  
 #打开测试系统
 #入参：浏览器类型；系统地址
  def open_test_system(testBrowser,crowdSysURL)
    @dr = Watir::Browser.new testBrowser
	@dr.driver.manage.timeouts.implicit_wait = 3
	@dr.window.maximize()
    @dr.goto crowdSysURL
	crowdSys_passwd_field.wait_until_present($waitTime)
  end

 #还原用户初始值；删除用户列表中除第一行的所有用户。为了保证用例执行前，系统是正确、干净的。
  def resore_defaultUser
	n = 0
	for i in 0..10
		#判断编辑按钮是否存在
		if userCenter_userManage_editUser_btn(n).exist?
			if n == 2
				#若n=2，即第2个编辑按钮存在，点击
				userCenter_userManage_editUser_btn(n).click
				userCenter_userManage_editUserNameField.wait_until_present($waitTime)
				#点击删除按钮，删除用户
				userCenter_userManage_editUser_deleteBtn.when_present($waitTime).click
				#点击删除确认提示框的确认按钮
				userCenter_userManage_deleteUser_confirm_btn(0).when_present($waitTime).click
				userCenter_userManage_addUser_succMessage.wait_until_present($waitTime)
				# puts "第#{i}次的编辑按钮是#{n}"
			n = 0
			end
		end
	n += 2
	end
    userManage_addNewUser($guestAccount,$guestName)
  end
  
 #清除所有操作日志
  def mongoDB_clear_operateLog
	client = Mongo::Client.new([ "#{URI.parse($crowdSysURL).host}:#{$mongoDBport}" ], :database => $mongoDB, :server_selection_timeout=>3)
	collection = client[$mongoColl]
	collection.delete_many()
	raise "clear_operateLog fail,operateLog count: #{collection.count()}" if collection.count() != 0		
  end
  
  #在后台服务器执行一些操作
  def exec_commond_in_server(commond)
	# 通过start方法链接到远程主机
	session = Net::SSH.start(URI.parse($crowdSysURL).host,$server_hostName,:password => $server_hostPWD) do |ssh|
	# 需要执行的命令
    result = ssh.exec!(commond)
    puts result
	end
  end
  
  #清空视频服务器，保证系统干净
  #入参：serverName 输入要删除的视频服务器的名称
  #调用方式：@driver.clearVideoServer('serverName') 表示删除名称为serverName的视频服务器
  def clearVideoServer(serverName)
	if taskConfig_treeList_videoName(serverName).present?
	#在左边树列表中点击视频服务器
	taskConfig_treeList_videoName(serverName).click
	#等待编辑窗口呈现
	taskConfig_editTaskServer_dialog_title.wait_until_present($waitTime)
	#点击删除按钮
	taskConfig_editTaskServer_deleteBtn.when_present($waitTime).click
	#点击确定 0 , 取消 1
	taskConfig_editTaskServer_delete_confirmBtn(0).when_present($waitTime).click
	#等待窗口呈现
	taskConfig_editTaskServer_dialog_title.wait_until_present($waitTime)
	#保留事件 是 0 , 否 1
	taskConfig_editTaskServer_delete_confirmBtn(1).when_present($waitTime).click
	#等待删除提示弹出
	taskConfig_addTaskServer_message.wait_until_present($waitTime)
	end
  end 
  
#############################################################
######################登录注销################################ 

  #登录人群系统，入参：用户名，密码
  def login(username,password)
	crowdSys_login_btn.wait_until_present($waitTime)
    crowdSys_login_field.set(username)
    crowdSys_passwd_field.set(password)
	#等待密码输完，再进行下一步
	break while password == crowdSys_passwd_field.value
	# crowdSys_login_field.focus
	crowdSys_login_btn.click
	# simlate_sendkeys(:enter)
	#登录后等待页面全部加载完，等待一秒
	#~ sleep 1
  end
  
  #登出人群系统确认对话框。确认：0   取消：1
  def logout(arg=0)
	logout_link.when_present($waitTime).click
	logout_confirm_btn(arg).when_present($waitTime).click
  end


#############################################################
######################用户中心################################

######################操作日志################################

  #获取当前客户端时间
  def time_now
	Time.now
  end

  #获取操作日志记录时间
  #入参：index 表示日期在列表中所在的位置 line=0，4，8，···，n 表示从第1行到第n行操作日志列表中的时间
  #调用方式：@driver.operateLog_recordTime(4) 表示日志列表中第二行的日期
  def operateLog_recordTime(index)
	Time.parse(userCenter_trace_operateLogList_index(index).when_present($waitTime).text)
  end
  
  #判断操作日志记录时间与实际操作时间的偏差
  #入参：operateTime 输入获取的实际操作时间 比如：在执行导入授权动作之后，获取导入授权的时间：importAuthTime = Time.now.strftime("%Y%m%d%H%M%S").to_i
  #      logTime 输入操作日志记录的时间 
  #      operate 输入操作+Time，方便查看debug记录 比如：importAuthTime
  #例子：@driver.logTime_operateTime_deviation(importAuthTime,logTime,'importAuthTime') 表示判断操作日志记录的导入授权的时间与实际操作的时间的偏差
  def logTime_operateTime_deviation(operateTime,logTime,operate='operateTime')
	#将时间转换成时间戳，避免跨分钟相减
	if (operateTime.to_f.to_i - logTime.to_f.to_i).abs > $logTime_deviation
		raise "操作日志时间记录偏差大于:#{$logTime_deviation}.\n#{operate}:#{operateTime.strftime("%Y-%m-%d %H:%M:%S")}.\noperateLog_recordTime:#{logTime.strftime("%Y-%m-%d %H:%M:%S")}."
    end
  end


######################用户管理################################

  #从用户中心入口（用户姓名）进入到操作日志界面
  def userNameToTrace
	user_name_link.when_present($waitTime).click
	userCenter_navig_trace.when_present($waitTime).click
	userCenter_trace_title.wait_until_present($waitTime)
  end
  
  #在日志管理界面，通过用户和动作过滤日志
  #入参：userName  用户姓名，通过输入的用户姓名过滤操作日志；可填入单个或多个
  #调用方式：@driver.userCenter_filterOperateLog_withUserName("系统管理员","普通用户") 过滤系统管理员和普通用户登入操作的日志
  def userCenter_filterOperateLog_withUserName(*userName)
	userCenter_user_selectList.when_present($waitTime).click
	userName.each do |x|
	userCenter_select_checkBox(x).when_present($waitTime).click
	end
	#点击日志管理模块名，确认下拉框勾选操作
	userCenter_trace_title.click
  end

  #在日志管理界面，通过动作过滤日志
  #入参：action   动作，通过输入的动作过滤操作日志；可填入单个或多个
  #调用方式：@driver.userCenter_filterOperateLog_withAction("登入","登出") 过滤系统登入和登出操作的日志
  def userCenter_filterOperateLog_withAction(*action)
	userCenter_action_selectList.when_present($waitTime).click
	sleep 1
	action.each do |x|
	userCenter_select_checkBox(x).when_present($waitTime).click
	end
	#点击日志管理模块名，确认下拉框勾选操作
	userCenter_trace_title.click
  end  
  
  #从用户中心入口（用户姓名）进入到用户管理界面
  def userNameToUserManage
	user_name_link.when_present($waitTime).click
	userCenter_trace_title.wait_until_present($waitTime)
	userCenter_navig_userManage.when_present($waitTime).click
	userCenter_userManage_title.wait_until_present($waitTime)
  end
  
  #在用户管理界面，添加新用户
  #入参：arg1 输入要添加的用户名 ； arg1 输入要添加的用户姓名
  #例子：@driver.userManage_addNewUser("new","newuser") 
  def userManage_addNewUser(arg1,arg2)
	userCenter_userManage_addUserBtn.click
	userCenter_userManage_addUserIdField.set(arg1)
	userCenter_userManage_addUserNameField.set(arg2)
	userCenter_userManage_submitAddUser_btn.click
	userCenter_userManage_addUser_succMessage.wait_until_present($waitTime)
  end
  
  #在用户管理界面，编辑-删除用户
  #入参：arg1 可输入 0 2 4 6 8 10 对应用户信息列表从上到下的第 1 2 3 4 5 6 个编辑按钮
  #      arg2 删除用户提示框，确认：0 取消：1 ；默认arg=0
  def userManage_deleteUser(arg1,arg2=0)
	userCenter_userManage_editUser_btn(arg1).when_present($waitTime).click
	userCenter_userManage_editUserNameField.wait_until_present($waitTime)
	userCenter_userManage_editUser_deleteBtn.when_present($waitTime).click
	userCenter_userManage_deleteUser_confirm_btn(arg2).when_present($waitTime).click
	userCenter_userManage_addUser_succMessage.wait_until_present($waitTime) if arg2 == 0
  end  
  
  #在用户管理界面，编辑-修改用户
  #入参：editBtn    可输入 0 2 4 6 8 10 对应用户信息列表从上到下的第 1 2 3 4 5 6 个编辑按钮
  #      userName   输入要修改的用户姓名（可选）
  #      newPWD     输入新密码（可选）
  #      confirmPWD 输入确认密码（可选）
  #例子：@driver.userManage_modifyUser(2,"普通姓名",'','12131')
  def userManage_modifyUser(editBtn,userName=nil,newPWD=nil,confirmPWD=nil)
	userCenter_userManage_editUser_btn(editBtn).click
	userCenter_userManage_editUserNameField.set(userName)
	userCenter_userManage_editPWDField.set(newPWD)
	userCenter_userManage_PWDConfirmField.set(confirmPWD)
	userCenter_userManage_modifyCommit_btn.click
  end
  
######################密码修改################################

  #从用户中心入口（用户姓名）进入到密码修改界面
  def userNameToPWDModify
	user_name_link.when_present($waitTime).click
	userCenter_trace_title.wait_until_present($waitTime)
	userCenter_navig_modifyPWD.when_present($waitTime).click
	userCenter_modifyPWD_title.wait_until_present($waitTime)
  end
  
  #在密码修改界面，输入原密码、新密码、确认密码，点击“确认修改”按钮，修改管理员用户密码
  def userCenter_modifyPWD(originPWD,newPWD,confirmPWD)
	#输入原密码：123456
	userCenter_modifyPWD_originPWDField.set(originPWD)
	#输入新密码：admin123*@
	userCenter_modifyPWD_newPWDField.set(newPWD)
	#确认密码：admin123*@
	userCenter_modifyPWD_newPWD_confirmField.set(confirmPWD)
	#点击“确认修改”按钮
	userCenter_modifyPWD_submmitBtn.click
  end 
  
######################授权管理################################

  #从用户中心入口（用户姓名）进入到授权管理界面
  def userNameToAuthManage
	user_name_link.when_present($waitTime).click
	userCenter_trace_title.wait_until_present($waitTime)
	userCenter_navig_authManage.when_present($waitTime).click
	userCenter_authManage_title.wait_until_present($waitTime)
  end
  

  
#############################################################
######################任务配置################################

  #从“更多”入口进入到添加视频服务器窗口
  def taskConfig_more_addCameraServer
	taskConfig_more_btn.when_present($waitTime).click
	taskConfig_addTaskServer_btn.when_present($waitTime).click 
  end 
  
  #输入必填项，添加pvg视频服务器
  #入参：pvgName     输入pvg名称
  #      pvgIP       输入pvgIP
  #      pvgPort     输入pvg端口号
  #      pvgAccount  输入pvg用户名
  #      pvgPWD      输入pvg密码
  #调用方式：@driver.taskConfig_addPVG('pvg','10.0.2.55','2100','admin','admin')
  def taskConfig_addPVG(pvgName,pvgIP,pvgPort,pvgAccount,pvgPWD)
	#输入pvg名称
	taskConfig_addTaskServer_pvgName_textfield.when_present($waitTime).set(pvgName)
	#输入pvg的IP
	taskConfig_addTaskServer_pvgIP_textfield.set(pvgIP)
	#输入pvg端口号
	taskConfig_addTaskServer_pvgPort_textfield.set(pvgPort)
	#输入用户名
	taskConfig_addTaskServer_pvgUserName_textfield.set(pvgAccount)
	#输入密码
	taskConfig_addTaskServer_pvgPWD_textfield.set(pvgPWD)
  end
  
  #输入必填项，添加rtsp视频服务器
  #入参：rtspTaskName 输入rtsp视频的名称
  #      rtspURL      输入rtsp的url地址
  #调用方式：@driver.taskConfig_addRtsp('rtspTaskName',"rtsp://10.12:H264")
  def taskConfig_addRtsp(rtspTaskName,rtspURL)
	#点选“RTSP”
	taskConfig_addTaskServer_addRtspBtn.when_present($waitTime).click
	#等待输入框呈现
	taskConfig_addTaskServer_rtspName_textfield.wait_until_present($waitTime)
	#输入rtsp名称
	taskConfig_addTaskServer_rtspName_textfield.set(rtspTaskName)
	#输入rtsp路径
	taskConfig_addTaskServer_rtspUrl_textfield.set(rtspURL)
  end
  
  #删除视频服务器
  #入参：serverName 输入要删除的视频服务器的名称
  #      arg1       删除确认提示框 0代表确定按钮 1代表取消按钮
  #      arg2       保留事件提示框 0代表是(保留) 1代表否(不保留)
  def taskConfig_deleteVideoServer(serverName,arg1,arg2=nil)
	#在左边树列表中点击视频服务器
	taskConfig_treeList_videoName(serverName).click
	#等待编辑窗口呈现
	taskConfig_editTaskServer_dialog_title.wait_until_present($waitTime)
	#点击删除按钮
	taskConfig_editTaskServer_deleteBtn.when_present($waitTime).click
	#点击确定 0 , 取消 1
	taskConfig_editTaskServer_delete_confirmBtn(arg1).when_present($waitTime).click
	#等待窗口呈现
	taskConfig_editTaskServer_dialog_title.wait_until_present($waitTime)
	#保留事件 是 0 , 否 1
	taskConfig_editTaskServer_delete_confirmBtn(arg2).when_present($waitTime).click
  end
  
  #添加规定的一个pvg视频服务器，此pvg视频服务器有需要的基础摄像机，步骤是从点击“更多”开始，到添加pvg视频服务器成功
  def taskConfig_addPVG_basicTask
	#点击“更多”
	taskConfig_more_btn.when_present($waitTime).click
	#点击“+添加视频”
	taskConfig_addTaskServer_btn.when_present($waitTime).click
	#等待窗口中的PVG按钮呈现
	taskConfig_addTaskServer_addPvgBtn.wait_until_present($waitTime)
	#输入必填项：pvg名称、IP、端口号、用户名、密码
	taskConfig_addPVG($pvgName,$pvgIP,$pvgPort,$pvgAccount,$pvgPWD)
	#点击“确定”按钮
	taskConfig_addTaskServer_addPvg_submitBtn.click
	#等待提示：“视频服务器添加成功！”呈现
	taskConfig_addTaskServer_message.wait_until_present($waitTime)
  end
  
  #添加规定的一个rtsp视频，步骤是从点击“更多”开始，到添加rtsp摄像机成功
  def taskConfig_addRtsp_basicTask
	#点击“更多”
	taskConfig_more_btn.when_present($waitTime).click
	#点击“+添加视频”
	taskConfig_addTaskServer_btn.when_present($waitTime).click
	#等待窗口中的PVG按钮呈现
	taskConfig_addTaskServer_addPvgBtn.wait_until_present($waitTime)
	#点选“RTSP”
	taskConfig_addTaskServer_addRtspBtn.when_present($waitTime).click
	#等待输入框呈现
	taskConfig_addTaskServer_rtspName_textfield.wait_until_present($waitTime)
	#输入rtsp名称
	taskConfig_addTaskServer_rtspName_textfield.set($rtspTaskName)
	#输入rtsp路径
	taskConfig_addTaskServer_rtspUrl_textfield.set($rtspURL)
	#点击“确定”按钮
	taskConfig_addTaskServer_addRtsp_commitBtn.click
	#等待提示：“视频服务器添加成功！”呈现
	taskConfig_addTaskServer_message.wait_until_present($waitTime)
  end
  
  #在任务配置页面，关键字搜索左边树列表中的摄像机
  #入参：taskName 输入要搜索的摄像机的名称或关键字
  def taskConfig_searchCamera(taskName)
	#输入关键字搜索摄像机
	taskConfig_keyWord_searchCamera_textField.set(taskName)
	#等待返回包含关键字的摄像机名呈现
	taskConfig_keyWord_searchCamera_return.wait_until_present($waitTime)
	#点击返回的摄像机名，下发搜索动作
	taskConfig_keyWord_searchCamera_return.when_present($waitTime).click
	#点击“摄像机”文字，收回下拉框再次下发搜索动作
	taskConfig_camera_text.when_present($waitTime).click
	# taskConfig_leftList_searchCamera($rtsp_row).wait_until_present
  end

  ############预留扩展接口###################
  def precondition()
  end
	
  def postcondition()
  end
  ##########################################
  
end