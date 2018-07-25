#定义人群系统元素模块组件
module CrowdElement
  def initialize(dr)
	@dr = dr 
  end

################################################################################
###↓↓↓######################   登 录 元 素   #############################↓↓↓###
################################################################################

  #人群系统主页登录框
  #元素名："用户名输入框"
  def crowdSys_login_field
	@dr.text_field(:id,"username")
  end
  
  #人群系统主页密码框
  #元素名："密码输入框"
  def crowdSys_passwd_field
	@dr.text_field(:id,"password1")
  end
  
  #人群系统登录按钮
  #元素名：登录
  def crowdSys_login_btn
	@dr.element(:id,"login")
  end
  
  #人群系统输入错误账号或密码的返回信息
  def login_err_accpwd_errCode
	@dr.element(:xpath,('//div[@class="layui-layer-content layui-layer-padding"]'))
  end

  #人群系统空账号或空密码登录失败的返回信息
  #调用此接口需要确保没有弹出该提示框：检测到新的视频播放控件，请点击此处下载
  def login_null_accpwd_errCode
	@dr.element(:xpath,("//div[@class='layui-layer-content']"))
  end


################################################################################
###↓↓↓######################   注 销 元 素   #############################↓↓↓###
################################################################################

  #注销人群系统
  #元素名：注销
  def logout_link
	@dr.element(:id,"loginOutBtn") 
  end

  #注销人群系统btn。确认：0 ；取消：1
  #元素名：确认/取消
  #入参：0 ，1
  #调用方式：@driver.logout_confirm_btn(1)
  def logout_confirm_btn(arg)
	@dr.element(:class,"layui-layer-btn#{arg}")
  end
  
  
  

################################################################################
###↓↓↓######################   公 共 元 素   #############################↓↓↓###
################################################################################

  #人群系统显示的当前时间
  def curr_time
	@dr.element(:id,"headTime") 
  end
  
  #人群系统当前标题（位于浏览器标签栏）
  def curr_title
	@dr.title 
  end
  
  #关闭测试浏览器
  def close_browser
	@dr.close
  end

  #用户中心入口
  def user_name_link
	@dr.element(:id,"userName")
  end

  #点击‘x’关闭当前窗口，各窗口通用
  #元素名：x
  def close_currWindow_with_X
	@dr.element(:xpath,("//*[@class='layui-layer-setwin']/a"))
  end

  #所有弹出的对话框
  def popup_dialog
	@dr.element(:class,"layui-layer-title")
  end
 


  #模拟击键
  #入参包括但不限于：[:null,:cancel,:help,:backspace,:tab,:clear,:return,:enter,:shift,:left_shift,
  ### :control,:left_control,:alt,:left_alt,:pause,:escape,:space,:page_up,:page_down,:end,:home,
  ### :left,:arrow_left,:up,:arrow_up,:right,:arrow_right,:down,:arrow_down,:insert,:delete,:semicolon,
  ### :equals,:numpad0,:numpad1,:numpad2,:numpad3,:numpad4,:numpad5,:numpad6,:numpad7,:numpad8,:numpad9,
  ### :multiply,:add,:separator,:subtract,:decimal,:divide,:f1,:f2,:f3,:f4,:f5,:f6,:f7,:f8,:f9,:f10,:f11,
  ### :f12,:meta(windows键),:command]
  ### 发送组合键，如：ctrl + a     simlate_sendkeys([:control,"a"])
  def simlate_sendkeys(*arg)
	@dr.send_keys arg
  end


#############################################################
######################特殊元素################################ 
  
  #特殊元素：登录后，防止需求变更，登录后检查的元素不存在，或位置变更
  #当前页面存在的任意一个元素即可，暂为任务配置页面的摄像机选择框
  
  # 1.任务配置页面的检查元素 摄像机选择框
  def assert_enterTaskConfig_element
    @dr.element(:class,"search-title")
  end
 
  # 2.状态监测页面的检查元素 切换缩略图显示
  def assert_enterStatusMonitor_element
	@dr.element(:class,"btn-table")
  end
  
  # 3.事件查询页面的检查元素 查询按钮
  def assert_enterEventQuery_element
	@dr.element(:id,"querySubmit")
  end
	
  #任务配置页面，在左边树列表中的摄像机，此元素主要为了使用.hover方法，使其高亮后显示“预览”和“编辑”按钮
  #元素名称：左边树列表中的摄像机
  #入参：目标摄像机在列表中的行数，从pvg服务器名开始为第一行
  #调用方式：@driver.taskConfig_leftList_searchCamera()
  #说明：暂用到第4行的“标准视频”和第3行的“camera_1”
  def taskConfig_leftList_hoverCamera(row)
	@dr.element(:id,"camaraTree_#{row}")
  end
  
  #任务配置页面，左边树列表中的摄像机，此元素是为了判断元素是否高亮，高亮时此元素的class会由level1变为level1 curSelectedNode
  #元素名称：执行关键字搜索摄像机后，在左边树列表中显示的摄像机
  #入参：目标摄像机在列表中的行数，从pvg服务器名开始为第一行
  #调用方式：@driver.taskConfig_leftList_searchCamera_attributeClass(row)
  def taskConfig_leftList_searchCamera_attributeClass(row)
	@dr.element(:id,"camaraTree_#{row}_a")
  end 
  
  
  
  
################################################################################
###↓↓↓######################   用 户 中 心   #############################↓↓↓###
################################################################################


#-----------------↓↓↓↓↓--------------------------  操作日志  ----------------------------↓↓↓↓↓----------------#

  #导航栏的操作日志菜单
  #元素名称：操作日志
  def userCenter_navig_trace
	@dr.element(:id,"logControllerButton")
  end

  #操作日志模块名
  #元素名称：操作日志
  def userCenter_trace_title
	@dr.element(:class,"m-log-title")
  end
  
  #按照近一天、近一周、近一月过滤操作日志
  #元素名称：近一天||近一周||近一月
  #入参：近一天||近一周||近一月
  #调用方式：@driver.userCenter_nearlyDay_trace("近一天")
  def userCenter_nearlyDay_trace(arg)
	@dr.link(:text,arg)
  end

  #设置开始时间
  #元素名称：开始时间设置框
  def userCenter_startTime_trace
	@dr.text_field(:id,"startDate")
  end
  
  #设置结束时间
  #元素名称：结束时间设置框
  def userCenter_endTime_trace
	@dr.text_field(:id,"endDate")
  end
  
  
  #操作日志通过用户下拉框查询
  #元素名称：用户下拉框
  def userCenter_user_selectList
	@dr.select_list(:id,"userList")
  end


  #操作日志通过动作下拉框查询
  #元素名称：动作下拉框
  def userCenter_action_selectList
	@dr.select_list(:id,"actionList")
  end

  #操作日志通过勾选全选（用户或动作）过滤
  #元素名称：全选
  def userCenter_selectAll_checkBox
	@dr.element(:id,"checkAll_userList")
  end
  
  #操作日志通过勾选用户或动作过滤
  #元素名称：用户名||动作
  #入参：用户姓名；比如"系统管理员"，"普通用户" || 动作；比如"登入"，"登出"
  #调用方式：@driver.userCenter_nearlyDay_trace("普通用户")
  def userCenter_select_checkBox(arg)
	@dr.element(:class=>"node_name",:text=>arg)
  end
  
  #操作日志信息列表
  #元素名称：日期||用户名||用户姓名||动作
  #入参：元素的索引位置，从0开始,从左往右，再从上到下：@driver.userCenter_trace_operateLogList_index(1)表示第一行的用户名
  def userCenter_trace_operateLogList_index(arg)
	@dr.element(:class=>"logmanage-grid",:index=>arg)
  end
  
  #操作日志列表排序
  #元素名称：列名
  #入参：操作日志列表的列名；比如"日期"，"用户名"
  #调用方式：@driver.userCenter_trace_sort("用户名")
  def userCenter_trace_sort(arg)
	@dr.element(:class=>"ui-jqgrid-sortable",:text=>arg)
  end


#-----------------↓↓↓↓↓--------------------------  用户管理  ----------------------------↓↓↓↓↓----------------#

  #导航栏的用户管理菜单
  #元素名称：用户管理
  def userCenter_navig_userManage
	@dr.element(:id,"userControllerButton")
  end
  
  #用户管理模块名
  #元素名称：用户管理
  def userCenter_userManage_title
	@dr.element(:class,"m-user-title")
  end

  #通过输入用户名搜索用户
  #元素名称：用户名输入框
  def userCenter_userManage_filterField
	@dr.text_field(:id,"user-data-remote")
  end
  
  #关键字搜索返回值
  #元素名称：关键字返回值
  def userCenter_userManage_keyWordReturn
	@dr.element(:class,"eac-item")
  end

  #点击搜索按钮搜索
  #元素名称：搜索
  def userCenter_userManage_searchBtn
	@dr.element(:id,"userQueryButton")
  end

#-------------------------------------------------------------
  
  #用户信息列表中的用户名和用户姓名
  #元素名称：用户名||用户姓名
  #入参：@driver.userCenter_userManage_userListInf("admin")
  def userCenter_userManage_userListInf(arg)
	@dr.element(:class=>"usermanage-grid",:title=>arg)
  end 
  
  #用户信息列表中某一位置的用户名和用户姓名
  #元素名称：用户名||用户姓名
  #入参：元素的索引位置，从左往右，从上到下。从0开始：@driver.userCenter_userManage_userListInf_index(1)表示第一行第二列的用户姓名
  def userCenter_userManage_userListInf_index(arg)
	@dr.element(:class=>"usermanage-grid",:index=>arg)
  end 

#-------------------------------------------------------------
  
  #用户信息列表中列头名：“用户名”
  #元素名称：用户名
  def userCenter_userManage_userList_userId
	@dr.element(:id,"jqgh_listUserDataGrid_uid")
  end
  
  #用户信息列表中列头名：“用户姓名”
  #元素名称：用户姓名
  def userCenter_userManage_userList_userName
	@dr.element(:id,"jqgh_listUserDataGrid_uname")
  end
  
  #添加新用户
  #元素名称：+添加新用户
  def userCenter_userManage_addUserBtn
	@dr.element(:id,"addUserButton")
  end  
  
  #添加用户弹出框
  #元素名称：添加用户
  def userCenter_userManage_addUser_dialog
	@dr.element(:class,"layui-layer-title")
  end 


  #输入新增的用户名
  #元素名称：用户名
  def userCenter_userManage_addUserIdField
	@dr.text_field(:id,"uid")
  end

  #输入新增的用户姓名
  #元素名称：用户姓名
  def userCenter_userManage_addUserNameField
	@dr.text_field(:id,"uname")
  end


  #确认添加用户按钮
  #元素名称：确认添加
  def userCenter_userManage_submitAddUser_btn
	@dr.button(:id,"addUserButton")
  end

  #添加用户成功后，提示添加用户成功
  #元素名称：用户添加成功！
  def userCenter_userManage_addUser_succMessage
	@dr.element(:xpath,("//*[@class='layui-layer layui-layer-dialog layui-layer-border layui-layer-msg layui-layer-hui layer-anim']/div"))
  end
  
  #添加用户时，弹出的所有错误信息
  #元素名称：用户名不能为空 等等
  def userCenter_userManage_addUser_errCode
	@dr.element(:xpath,("//*[@class='layui-layer layui-layer-tips  layer-anim']/div"))
  end

  #对用户进行编辑
  #元素名称：编辑
  #入参：arg = 0 2 4 6 8 10分别对应从上到下的第1 - 6 个编辑按钮，以此类推
  #调用方式：@driver.userCenter_userManage_editUser_btn(0)  --表示点击第一个编辑按钮
  def userCenter_userManage_editUser_btn(arg)
	@dr.element(:text=>"编辑",:index=>arg)
  end

  #修改用户姓名框
  #元素名称：用户姓名
  def userCenter_userManage_editUserNameField
	@dr.text_field(:id,"uname")
  end

  #修改用户密码
  #元素名称：修改密码
  def userCenter_userManage_editPWDField
	@dr.text_field(:id,"pwd")
  end

  #修改用户密码确认密码
  #元素名称：确认密码
  def userCenter_userManage_PWDConfirmField
	@dr.text_field(:id,"pwd-comfirm")
  end
  
  #编辑用户确认修改按钮
  #元素名称：确认修改
  def userCenter_userManage_modifyCommit_btn
	@dr.button(:id,"modifyButton")
  end

  #编辑用户中删除用户按钮
  #元素名称：删除用户
  def userCenter_userManage_editUser_deleteBtn
	@dr.element(:id,"deleteButton")
  end
  
  #删除用户提示框；确认：0 ；取消：1
  #元素名：确认/取消
  #入参：0 ，1
  #调用方式：@driver.userCenter_userManage_deleteUser_confirm_btn(1)
  def userCenter_userManage_deleteUser_confirm_btn(arg)
	@dr.element(:class,"layui-layer-btn#{arg}")
  end
  
  #编辑用户成功后，提示修改用户成功
  #元素名称：修改用户信息成功！
  def userCenter_userManage_editUser_succMessage
	@dr.element(:xpath,("//*[@class='layui-layer layui-layer-dialog layui-layer-border layui-layer-msg layui-layer-hui layer-anim']/div"))
  end
  
  #编辑用户时，弹出的所有错误信息
  #元素名称：用户姓名不能为空 等等
  def userCenter_userManage_editUser_errCode
	@dr.element(:xpath,("//*[@class='layui-layer layui-layer-tips  layer-anim']/div"))
  end




#-----------------↓↓↓↓↓--------------------------  密码修改  ----------------------------↓↓↓↓↓----------------#
  

  #导航栏的密码修改菜单
  #元素名称：密码修改
  def userCenter_navig_modifyPWD
	@dr.element(:id,"pwdControllerButton")
  end
  
  #密码修改模块名
  #元素名称：密码修改
  def userCenter_modifyPWD_title
	@dr.element(:class,"m-pwd-title")
  end

  #原密码输入框
  #元素名称：输入原密码
  def userCenter_modifyPWD_originPWDField
	@dr.text_field(:id,"originPwd")
  end

  #新密码输入框
  #元素名称：输入新密码
  def userCenter_modifyPWD_newPWDField
	@dr.text_field(:id,"pwd1")
  end

  #确认密码输入框
  #元素名称：确认新密码
  def userCenter_modifyPWD_newPWD_confirmField
	@dr.text_field(:id,"pwd2")
  end
  
  #修改密码提交按钮
  #确定修改
  def userCenter_modifyPWD_submmitBtn
	@dr.element(:id,"modifyPwdButton")
  end

  #修改密码时弹出的所有错误信息
  #元素名称：密码修改失败，请重试！， 等等
  def userCenter_navig_modifyPWD_errCode
	@dr.element(:xpath,("//div[@class='layui-layer-content']"))
  end




#-----------------↓↓↓↓↓--------------------------  授权管理  ----------------------------↓↓↓↓↓----------------#
  
  
  #导航栏的授权管理菜单
  #元素名称：授权管理
  def userCenter_navig_authManage
	@dr.element(:id,"authControllerButton")
  end

  #授权管理模块名
  #元素名称：授权管理
  def userCenter_authManage_title
	@dr.element(:class,"m-auth-title")
  end
  
  #授权管理的申请授权按钮
  #元素名称：申请授权
  def userCenter_authManage_getAuth_btn
	@dr.element(:class,"renewalButton")
  end
  
  #申请授权后的导出文件按钮
  #元素名称：导出文件
  def userCenter_authManage_exportAuth_btn
	@dr.element(:class,"exportButton")
  end
  
  #授权管理的导入授权按钮
  #元素名称：导入授权
  def userCenter_authManage_importAuth_btn
	@dr.element(:class,"importAuthButton")
  end

  #导入授权后的弹出框标题
  #元素名称：导入授权文件
  def userCenter_authManage_importAuthFile_dialog
	@dr.element(:class,"layui-layer-title")
  end
  
  #授权管理的选择按钮
  #元素名称：选择
  def userCenter_authManage_selectAuth_btn
	@dr.link(:text,"选择")
  end
  
  #授权管理选择license后的导入按钮
  #元素名称：导入
  def userCenter_authManage_importCommit_btn
	@dr.link(:id,"importAuthButton")
  end

  #授权管理剩余的授权天数
  #元素名称：授权剩余天数
  def userCenter_authManage_remainDays
	@dr.element(:class,"number-day")
  end

  #授权管理导入文件时错误提示信息
  #元素名称：请选择文件!
  def userCenter_authManage_importNullFile_errCode
	@dr.element(:xpath,("//*[@class='layui-layer layui-layer-tips  layer-anim']/div"))
  end

  #授权后返回信息
  #元素名称：授权成功! || 授权失败！
  def userCenter_authManage_authResult_returnMessage
	# @dr.element(:xpath,("//div[@class="layui-layer-content"]"))
	@dr.element(:id=>"",:class=>"layui-layer-content")
  end


################################################################################
###↓↓↓######################   状 态 监 测   #############################↓↓↓###
################################################################################
  #进入状态监测页面
  #元素名称：状态监测
  def status_monitor
	@dr.link(:text,"状态监测")
  end

  #状态监测页面列表的第一列表头：相机名称
  #元素名称：相机名称
  def statusMonitor_channelName
	@dr.element(:id,"jqgh_dataGrid_channelName")
  end  
  
  #状态监测页面列表的第二列表头：现场图片
  #元素名称：现场图片
  def statusMonitor_channelImage
	@dr.element(:id,"jqgh_dataGrid_imageUrl")
  end  
  
  #状态监测页面列表的第三列表头：人数
  #元素名称：人数
  def statusMonitor_peopleCount
	@dr.element(:id,"jqgh_dataGrid_peopleCount")
  end  
  
  #状态监测页面列表的第四列表头：密度
  #元素名称：密度
  def statusMonitor_density
	@dr.element(:id,"jqgh_dataGrid_intensity")
  end  
  
  #状态监测页面列表的第五列表头：安全级别
  #元素名称：安全级别
  def statusMonitor_safetyIndex
	@dr.element(:id,"jqgh_dataGrid_safetyIndex")
  end  
  
  #状态监测页面列表的第六列表头：报警
  #元素名称：报警
  def statusMonitor_alarmEvents
	@dr.element(:id,"jqgh_dataGrid_eventsTotal")
  end
  
  #状态监测页面的切换缩略图显示入口
  #元素名称：切换缩略图显示
  def statusMonitor_thumbnail
	@dr.element(:class,"btn-table")
  end
  
  #状态监测页面的切换列表显示入口
  #元素名称：切换列表显示
  def statusMonitor_list
	@dr.element(:class,"btn-list")
  end
	
  #状态监测页面由相机名称进入选择相机的统计分析页面入口
  #元素名称：单路相机的统计分析页面入口
  #入参：相机名称
  #调用方式：@driver.status_taskNameToAnalysis_link("H264_720P_05")
  def statusMonitor_taskNameToAnalysis_link(taskName)
	@dr.element(:text=>taskName)
  end
  
  #点击相机图片，播放四分屏
  #元素名称：相机图片
  
  
  #状态监测页面的“报警”列，查看最近20条报警链接
  #元素名称：报警数量
  def statusMonitor_viewEvents_link
	@dr.element(:class=>"m-list-eventstotal")
  end
  
  #状态监测页面，进入缩略图显示界面，查看最近20条报警的链接
  #元素名称：报警次数
  def statusMonitor_thumbnail_viewEvents_link
	@dr.element(:text,"报警次数")
  end

################################################################################
###↓↓↓######################   统 计 分 析   #############################↓↓↓###
################################################################################
  #进入统计分析页面
  def statistics_analysis
	@dr.link(:text,"统计分析")
  end
  
  #点击摄像机下拉点选框，选择摄像机
  #元素名称：摄像机下拉点选框
  def statistic_analysis_task_selectList
	@dr.element(:id,"channelIds")
  end
  
  #点选下拉框中的摄像机任务
  #元素名称：摄像机任务名称
  #入参：0-N 表示从上到下的的摄像机
  #调用方式：@driver.statistic_analysis_taskName_select(1).click 表示点选第二个摄像机
  def statistic_analysis_taskName_select(arg)
	@dr.element(:class=>"node_name",:index=>arg)
  end
  
  #查看人数统计
  #元素名称：人数统计
  def statistic_analysis_population_Btn
	@dr.element(:id,"population")
  end
  
  #查看人员密度统计
  #元素名称：人员密度统计
  def statistic_analysis_density_Btn
	@dr.element(:id,"density")
  end

  #查看安全系数统计
  #元素名称：安全系数统计
  def statistic_analysis_safetyMargin_Btn
	@dr.element(:id,"safety")
  end

  #查看事件类型统计
  #元素名称：事件类型统计
  def statistic_analysis_eventType_Btn
	@dr.element(:id,"eventType")
  end
  
  #按照近一天、近一周、近一月查看统计分析数据
  #元素名称：近一天||近一周||近一月
  #入参：近一天||近一周||近一月
  #调用方式：@driver.userCenter_nearlyDay_trace("近一天")
  def statistic_analysis_nearlyDay_btn(arg)
	@dr.link(:text,arg)
  end
  
  #设置开始时间
  #元素名称：开始时间设置框
  def statistic_analysis_startTime_field
	@dr.text_field(:id,"startDate")
  end
  
  #设置结束时间
  #元素名称：结束时间设置框
  def statistic_analysis_endTimeTime_field
	@dr.text_field(:id,"endDate")
  end
  
  #下载图片按钮
  #元素名称：保存为图片
  
  #导出Excel文件按钮
  #元素名称：导出
  def statistic_analysis_export_submitBtn
	@dr.element(:id,"exportSubmit")
  end
   
  #导出Excel文件确认提示框
  #元素名称：确定/取消 0 / 1
  #入参：0 、1  确定/取消
  #调用方式：
  def statistic_analysis_exportBtn_confirmBtn
	@dr.element(:class,"layui-layer-btn#{arg}")
  end
  
################################################################################
###↓↓↓######################   事 件 查 询   #############################↓↓↓###
################################################################################
  #进入事件查询页面
  def event_query
	@dr.link(:text,"事件查询")
  end

  #通过输入摄像机名称或关键字查询事件
  #元素名称：摄像机名称或关键字输入框
  def eventQuery_taskName_textField
	@dr.text_field(:id,"data-remote")
  end
  
  #在查询框输入关键字后的返回值
  #元素名称：在查询框中输入关键字后返回的摄像机名称
  def eventQuery_taskName_return
	@dr.element(:class,"eac-item")
  end
  
  #查询事件按钮
  #元素名称：查询
  def eventQuery_query_btn
	@dr.element(:id,"querySubmit")
  end 
  
  #点击事件图片放大并查看事件详细信息
  #元素名称：事件图片
  #入参：0-N 表示从左至右的事件图片 
  #调用方式：@driver.eventQuery_eventPicture(1).click  表示点击第一列从左往右第二张图片
  def eventQuery_eventPicture(arg)
	@dr.element(:class=>"bor",:index=>arg)
  end 
  
  #关闭放大的事件图片
  #元素名称：X
  def eventQuery_eventPicture_close_withX
	@dr.element(:xpath,("//*[@class='layui-layer-setwin']/a"))
  end
  
  #事件列表中事件的总个数
  #事件总个数
  def eventQuery_eventNumber
	@dr.element(:id,"ui-paging-info")
  end 
  
  #按时间先后排序
  #元素名称：按时间先后
  def eventQuery_event_sort
	@dr.element(:id,"btn-time-sort")
  end 
  
  #批量删除事件
  #元素名称：批量删除
  def eventQuery_deleteEvent
	@dr.element(:id,"event-manager")
  end 
  
  #批量删除事件的全选
  #元素名称：全选
  def eventQuery_deleteEvent_selectAll
	@dr.element(:xpath,"//*[@id='check-all-event']/span[1]")
  end 
  
  #批量删除事件的取消按钮
  #元素名称：取消
  def eventQuery_deleteEvent_cancelBtn
	@dr.element(:id,"event-manager-finish")
  end 
  
  #批量删除事件的删除按钮
  #元素名称：删除 
  def eventQuery_deleteEvent_deleteBtn
	@dr.element(:id,"delete-event-item")
  end 
  
  #批量删除事件确认删除按钮
  #元素名称：确认/删除  0/1 
  #入参：0 、1  确认0  删除1
  #调用方式：@driver.eventQuery_deleteEvent_deleteConfirm_btn(0).click  表示确认删除事件
  def eventQuery_deleteEvent_deleteConfirm_btn(arg)
	@dr.element(:class,"layui-layer-btn#{arg}")
  end 
  
  #批量删除事件错误信息
  #元素名称：请选择事件！
  def eventQuery_deleteEvent_errCode
	@dr.element(:id,"layui-layer1")
  end 
  
  #批量删除事件成功的返回信息
  #元素名称：删除成功！
  def eventQuery_deleteEvent_succCode
	@dr.element(:id,"layui-layer2")
  end 
  
################################################################################
###↓↓↓######################   任 务 配 置   #############################↓↓↓###
################################################################################
  #任务配置页面入口
  def task_config
	@dr.link(:text,"任务配置")
  end

  #摄像机
  def taskConfig_camera_text
	@dr.element(:class,"search-title")
  end
  
  #摄像机选择下拉框
  #元素名称：点击选择摄像机
  def taskConfig_camera_selectList
	@dr.select_list(:id,"task")
  end
  
  #勾选摄像机选择下拉框中的全选
  #元素名称：全选
  def taskConfig_camera_selectList_selectAll
	@dr.element(:id,"checkAll_task")
  end 

  #勾选摄像机选择下拉框中的摄像机
  #元素名称：摄像机名
  #入参：arg 输入摄像机所在行数，arg=1 表示第一行
  #调用方式：@driver.taskConfig_camera_selectList_task(1).click 表示勾选下拉框中的第一个摄像机任务
  def taskConfig_camera_selectList_task(arg)
	@dr.element(:id,"comboBox_task_#{arg}_span")
  end 
  
  #状态下拉框
  #元素名称：状态
  def taskConfig_status_selectList
	@dr.select_list(:id,"status")
  end 
  
  #勾选状态下拉框中的三种状态：全部、启用、暂停
  #元素名称：全部、启用、暂停
  #入参：全部||启用||暂停
  #调用方式：@driver.taskConfig_status_selectList_options("启用").click 
  def taskConfig_status_selectList_options(arg)
	@dr.element(:class=>"ui-select-item",:text=>"#{arg}")
  end 
  
  #在右边任务列表中点击摄像机名称（点击配置）进入到任务详细配置界面
  #元素名称：点击配置
  #入参：摄像机名称
  #调用方式：@driver.taskConfig_clickTaskName_cameraConf("vs800_北区1号通道出口").click 
  def taskConfig_clickTaskName_cameraConf(taskName)
	@dr.element(:class=>'info-content showtask',:title=>"#{taskName}")
  end 
  
  #告警类型 ：过密 聚集 滞留 混乱 逆行
  
  
  #启用/暂停已配置的任务
  #元素名称：启用/暂停开关按钮
  #入参：0-N 表示从上到下的启用/暂停开关按钮 0 表示第一个
  #调用方式：@driver.taskConfig_turnOn_turnOff_btn(1).click  表示点击第二个任务的启用/暂停开关按钮，启用/暂停任务
  def taskConfig_turnOn_turnOff_btn(arg)
	@dr.element(:class=>"ui-switchbutton-handle",:index=>arg)
  end 
  
  #点击图片显示四分屏
  
  #任务配置页面，更多按钮入口
  #元素名称：更多
  def taskConfig_more_btn
	@dr.element(:text,"更多")
  end
  
  #任务配置页面，导入坐标入口
  #元素名称：导入坐标
  def taskConfig_importCoordinate_link
	@dr.element(:id,"importCoordinate")
  end
  
  #任务配置页面，导入坐标窗口中的选择按钮
  #元素名称：选择
  def taskConfig_importCoordinate_selectBtn
	@dr.element(:class,"a-import")
  end 
  
  #任务配置页面，导入坐标窗口中的导入按钮
  #元素名称：导入
  def taskConfig_importCoordinate_importBtn
	@dr.element(:id,"importButton")
  end 
  
  #任务配置页面，导出坐标入口
  #元素名称：导出坐标
  def taskConfig_exportCoordinate_link
	@dr.element(:id,"exportCoordinate")
  end 
  
  #添加视频服务器
  #元素名称：+添加视频 
  def taskConfig_addTaskServer_btn
	@dr.element(:id,"addPVGServer")
  end 
  
  #添加视频框中的PVG按钮
  #元素名称：PVG
  def taskConfig_addTaskServer_addPvgBtn
	@dr.element(:xpath,"//*[@id='videoType']/ul/li[1]/a")
  end 
  
  #添加pvg时，pvg名称输入框
  #元素名称：名称
  def taskConfig_addTaskServer_pvgName_textfield
	@dr.text_field(:name,"name")
  end 
  
  #添加pvg时，pvg的IP地址输入框
  #元素名称：IP地址
  def taskConfig_addTaskServer_pvgIP_textfield
	@dr.text_field(:id,"IpAddress")
  end 
  
  #添加pvg时，pvg的端口输入框
  #元素名称：端口
  def taskConfig_addTaskServer_pvgPort_textfield
	@dr.text_field(:id,"port")
  end 
  
  #添加pvg时，pvg用户名输入框
  #元素名称：用户名
  def taskConfig_addTaskServer_pvgUserName_textfield
	@dr.text_field(:name,"uid")
  end 
  
  #添加pvg时，pvg密码输入框
  #元素名称：密码 
  def taskConfig_addTaskServer_pvgPWD_textfield
	@dr.text_field(:name,"pwd")
  end 
  
  #添加/编辑视频服务器的备注文本区域
  #元素名称：备注
  def taskConfig_taskServer_remark_textArea
	@dr.textarea(:class,"ui-textarea")
  end 
  
  #添加pvg，取消按钮
  #元素名称：取消
  def taskConfig_addTaskServer_addPvg_cancelBtn
	@dr.button(:id,"closeDialog")
  end 
  
  #添加pvg，确定按钮
  #元素名称：确定 
  def taskConfig_addTaskServer_addPvg_submitBtn
	@dr.button(:id,"savePvgServer")
  end 
  
  #添加视频框中的RTSP按钮
  #元素名称：RTSP
  def taskConfig_addTaskServer_addRtspBtn
	@dr.element(:xpath,"//*[@id='videoType']/ul/li[2]/a")
  end 
  
  #添加rtsp时，rtsp名称输入框
  #元素名称：名称
  def taskConfig_addTaskServer_rtspName_textfield
	@dr.text_field(:id,"rtspName")
  end 
  
  #添加rtsp时，rtsp路径输入框
  #元素名称：rtsp路径
  def taskConfig_addTaskServer_rtspUrl_textfield
	@dr.text_field(:id,"rtspUrl")
  end
  
  #添加rtsp,取消按钮 
  #元素名称：取消 
  def taskConfig_addTaskServer_addRtsp_cancelBtn
	@dr.button(:id,"closeDialog")
  end 
  
  #添加rtsp，确定按钮
  #元素名称：确定
  def taskConfig_addTaskServer_addRtsp_commitBtn
	@dr.button(:id,"saveRtspVideo")
  end 
  
  #添加pvg或rtsp视频时，必填输入框返回的所有错误信息码
  #元素名称：名称不能为空！|| rtsp路径不正确 等等
  def taskConfig_addTaskServer_errCode
	@dr.element(:id,"layui-layer3")
  end 
  
  #添加视频成功/失败时返回的错误信息||删除或保存摄像机任务成功返回的信息
  #元素名称：视频服务器添加成功！||该视频服务器已添加！||IP地址或端口号错误！||用户名或密码错误！||任务删除成功！等等
  def taskConfig_addTaskServer_message
	@dr.element(:xpath,('//*[@class="layui-layer-content layui-layer-padding"]'))
  end 
  
  #左边树列表上的关键字搜索输入框
  #元素名称：输入关键字
  def taskConfig_keyWord_searchCamera_textField
	@dr.text_field(:id,'data-remote')
  end 
  
  #在左边树列表上的关键字搜索输入框中输入关键字后返回的摄像机名
  #元素名称：输入关键字返回的摄像机名称
  def taskConfig_keyWord_searchCamera_return
	@dr.element(:class,"eac-item")
  end 
  
  #左边树列表中的视频服务器以及摄像机
  #元素名称：视频服务器名称或摄像机的名称（左边树列表中）
  #入参：视频服务器名称或摄像机名称 
  #调用方法：@driver.taskConfig_treeList_videoName("172.17.2.32").click 点击pvg视频服务器，弹出pvg修改窗口
  def taskConfig_treeList_videoName(arg)
	@dr.element(:class=>"node_name",:text=>arg)
  end
  

  #点击左边树列表中的视频服务器或者摄像机的修改小图标，弹出的窗口名称；删除视频服务器或摄像机弹出的是否保留事件窗口
  #元素名称：172.17.2.32||rtsp视频||本地视频||摄像机配置
  def taskConfig_editTaskServer_dialog_title
	@dr.element(:class,'layui-layer-title')
  end 
  
  #编辑视频服务器窗口中的名称输入框
  #元素名称：名称
  def taskConfig_editTaskServer_serverName_textField
	@dr.text_field(:id,'serverName')
  end 
  
  #编辑PVG视频服务器窗口中的同步按钮
  #元素名称：同步
  def taskConfig_editPvgServer_refreshBtn
	@dr.element(:id,'refreshVideoServer')
  end 
  
  #编辑视频服务器窗口中的删除按钮（pvg，rtsp）
  #元素名称：删除
  def taskConfig_editTaskServer_deleteBtn
	@dr.element(:id,"deleteVideoServer")
  end 
  
  #删除视频服务器或摄像机提示框中的确认/取消按钮
  #元素名称：确认/取消
  #入参：0/1 确认0  取消1
  def taskConfig_editTaskServer_delete_confirmBtn(arg)
	@dr.element(:class,"layui-layer-btn#{arg}")
  end 
  
  #删除视频服务器的确认对话框以及保留事件对话框的“X”
  #元素名称：X （关闭窗口）
  def taskConfig_editTaskServer_confirmDialog_X
	@dr.element(:xpath,'//*[@class="layui-layer layui-layer-dialog  layer-anim"]/span/a')
  end 
  
  #编辑视频服务器窗口中的保存按钮
  #元素名称：保存
  def taskConfig_editTaskServer_saveBtn
	@dr.element(:id,'updateServerName')
  end 
  
  #编辑视频服务器窗口中的取消按钮
  #元素名称：取消
  def taskConfig_editTaskServer_cancelBtn
	@dr.element(:id,'closeDialog')
  end 
  
  #同步视频服务器成功后弹出的提示信息
  #元素名称：视频服务器刷新成功！
  def taskConfig_editTaskServer_refreshServer_succMessage
	@dr.element(:xpath,('//*[@class="layui-layer layui-layer-dialog layui-layer-border layui-layer-msg layui-layer-hui layer-anim"]'))
  end 
  
  #编辑视频服务器的所有错误信息
  #元素名称：名称格式不正确，请修改！||视频名称不能为空！
  def taskConfig_editTaskServer_errCode
	@dr.element(:xpath,('//*[@class="layui-layer layui-layer-tips  layer-anim"]/div'))
  end 
  
  #在左边树列表中，收缩视频服务器列表（pvg||rtsp）
  #元素名称：switch，收缩视频服务器
  #入参：row 输入要收缩的视频服务器在左边树列表中所在的行数（行数指的是所有视频服务器都收缩后的行数，不算摄像机）
  #调用方式：@driver.taskConfig_videoServer_switch(1).click 表示收缩/展开左边树列表中位于第一行的视频服务器
  def taskConfig_videoServer_switch(row)
	@dr.element(:id,"camaraTree_#{row}_switch")
  end 
  
  #左边树列表中摄像机的编辑小图标，点击弹出摄像机的编辑窗口
  #元素名称：摄像机编辑小图标
  #入参：row 输入要编辑的摄像机在左边树列表中所在的行数
  #调用方式：@driver.taskConfig_editTask_btn(3).click 点击左边树列表中第3行的摄像机的编辑小图标，弹出此摄像机的编辑窗口
  def taskConfig_editTask_btn(row)
	@dr.element(:id,"editName_camaraTree_#{row}")
  end 
  
  # 摄像机（pvg||rtsp）编辑窗口中的名称输入框
  # 元素名称：名称
  # def taskConfig_editCameraDialog_nameTextField
	# @dr.text_field(:id,'channelName')
  # end 
  
  # 摄像机（pvg||rtsp）编辑窗口中的保存按钮
  # 元素名称：保存
  # def taskConfig_editCameraDialog_saveBtn
	# @dr.button(:id,'updateChannel')
  # end 
  
  # 摄像机（pvg||rtsp）编辑窗口中的取消按钮
  # 元素名称：取消
  # def taskConfig_editCameraDialog_cancelBtn
	# @dr.button(:id,'closeDialog')
  # end 
  
  # rtsp摄像机编辑窗口中的URL输入框
  # 元素名称：路径
  # def taskConfig_editRtspCameraDialog_URLTextField
	# @dr.text_field(:id,'rtspUrl')
  # end 
  
  # rtsp摄像机编辑窗口中的删除按钮
  # 元素名称：删除
  # def taskConfig_editRtspCameraDialog_deleteBtn
	# @dr.button(:id,'deleteChannel')
  # end 
  
  #编辑摄像机成功后，返回的提示信息
  #元素名称：修改成功！
  def taskConfig_editCamera_succMessage
	@dr.element(:xpath,('//*[@class="layui-layer-content layui-layer-padding"]'))
  end 
  
  #编辑摄像机的名称或者地址，所有返回的错误码
  #元素名称：摄像机的名称不能为空||您输入的数据含有非法字符！请重新输入||rtsp路径不正确 等
  def taskConfig_editCamera_errCode
	@dr.element(:xpath,('//*[@class="layui-layer layui-layer-tips  layer-anim"]/div'))
  end
  
  #初次配置任务截图界面的默认图片
  #元素名称：任务默认图片
  def taskConfig_capture_img
	@dr.element(:xpath,'//*[@id="capture-player"]/img')
  end
  
  #初次配置任务点击播放按钮播放原始视频
  #元素名称：原始视频播放按钮
  def taskconfig_cameraPlay_btn
	@dr.element(:class,'hover-video-image')
  end
  
  #任务详细配置页面的截图按钮
  #元素名称：截图
  def taskconfig_screenshot_btn
	@dr.element(:id,'sc-capture')
  end 
  
  #摄像机详细配置页面中显示的被配置摄像机名称
  #元素名称：摄像机名称
  def taskConfig_cameraConf_cameraName
	@dr.element(:class,"m-title")
  end 
  
  #摄像机详细配置页面中的删除按钮，删除任务
  #元素名称：删除
  def taskConfig_cameraConf_deleteTaskBtn
	@dr.element(:id,"delTaskBtn")
  end 
  
  #删除任务的确认/取消按钮
  #元素名称：确认（0）/取消（1）
  #入参：0/1  确认/取消
  #调用方式：@driver.taskConfig_cameraConf_deletetaskConfigirmBtn(0).click 确认删除任务
  def taskConfig_cameraConf_deletetaskConfigirmBtn(arg)
	@dr.element(:class,"layui-layer-btn#{arg}")
  end 
  
  #摄像机详细配置页面中的取消按钮，取消配置任务
  #元素名称：取消
  def taskConfig_cameraConf_cancelBtn
	@dr.element(:id,'cancelTaskConfigBtn')
  end 
  
  #摄像机详细配置页面中的保存按钮，保存配置后的任务
  #元素名称：保存
  def taskConfig_cameraConf_saveBtn
	@dr.link(:id,"saveTaskBtn")
  end 
  
  #摄像机详细配置页面中的恢复至上次配置按钮，恢复至上次配置任务的数据
  #元素名称：恢复至上次配置
  def taskConfig_cameraConf_restore_btn
	@dr.link(:id,"useLastConfigBtn")
  end 
  
  #摄像机详细配置页面中的事件报警设置，点选各个事件的报警联动
  #元素名称：闪红光、闪黄光、闪橙光、声音报警
  #入参： row 表示行数 从1开始
  #       col 表示列数 从1开始
  #调用方式：@driver.taskConfig_eventAlarmSet_btn(1,2).click 表示点选第一行第二列的“闪黄光”报警
  def taskConfig_eventAlarmSet_btn(row,col)
	@dr.element(:xpath,"//*[@id='eventLinkConfig']/div[#{row}]/div/ul/li[#{col}]")
  end 
  
  #摄像机详细配置页面中的安全级别分档，整个表格中的数据
  #元素名称:安全级别分档
  def taskConfig_safetySetting_table
    @dr.element(:id,'safetySetting')
  end 
  
  #摄像机详细配置页面中的安全级别分档，各个级别的最大值与最小值
  #元素名称：安全级别，最大值||最小值
  #入参： arg 输入要定位的值，比如：arg=80 表示列表中 级别为很安全的最小值 80 这个元素
  #调用方式：@driver.taskConfig_safetySetting_data(80).click 表示点击最小值80 之后可输入要更改的数值
  def taskConfig_safetySetting_data(arg)
	@dr.element(:class=>'number',:text=>"#{arg}")
  end 
  
  #摄像机详细配置页面中的安全级别分档，所有错误提示信息
  #元素名称：很安全最大值必须为100！||第1行最大值不能小于等于最小值！等等
  def taskConfig_safetySetting_errCode
	@dr.element(:xpath,('//*[@class="layui-layer layui-layer-tips  layer-anim"]/div'))
  end 
  
  #摄像机详细配置页面中过密、聚集、滞留、逆行、混乱事件监控开关
  #元素名称：启用||关闭
  #入参：0 （过密）|| 1 （聚集）|| 2 （滞留）|| 3 （逆行）|| 4 （混乱）
  #调用方式：@driver.taskConfig_cameraConf_turnOn_turnOff_event(2).click  表示 启用/关闭 监控滞留事件
  def taskConfig_cameraConf_turnOn_turnOff_event(arg)
	@dr.element(:class=>"ui-switchbutton-handle",:index=>arg)
  end 
  
  #摄像机详细配置页面中，设置触发事件阈值错误弹出的提示信息；或设置任务保存成功返回的提示信息
  #元素名称：保存成功！||触发人群过密事件阈值必须大于0%且小于100%！等
  def taskConfig_cameraConf_message
	@dr.element(:xpath,('//*[@class="layui-layer-content layui-layer-padding"]'))
  end 
  
#--------↓↓↓---------------------------- 监控区域绘制 -----------------------↓↓↓--------#
  #摄像机详细配置页面导航栏的监控区域绘制
  #元素名称：监控区域绘制
  def taskConfig_navig_monitorAreaDraw
	@dr.link(:text,"监控区域绘制")
  end
  
  #摄像机详细配置页面监控区域添加区域按钮
  #元素名称：添加区域
  def taskConfig_monitorAreaDraw_startDraw_btn
	@dr.link(:id,"sc-start")
  end 
  
  #摄像机详细配置页面监控区域绘制btn
  #元素名称：屏蔽区域绘制
  def taskConfig_monitorAreaDraw_shieldAreaDraw_btn
	@dr.link(:id,"sc-start")
  end

  #摄像机详细配置页面监控区域结束绘制按钮（需要先点击绘制）
  #元素名称：结束绘制
  def taskConfig_monitorAreaDraw_endDraw_btn
	@dr.link(:text,"结束绘制")
  end
  
  #摄像机详细配置页面监控区域全部清空按钮
  #元素名称：全部清空
  def taskConfig_monitorAreaDraw_clearAll_btn
	@dr.link(:id,"sc-clear")
  end
  
  
#--------↓↓↓---------------------------- 监控高度绘制 -----------------------↓↓↓--------#
  #摄像机详细配置页面导航栏的监控高度绘制
  #元素名称：监控高度绘制
  def taskConfig_navig_monitorHeightDraw
	@dr.link(:text,"监控高度绘制")
  end
  
  #摄像机详细配置页面高度绘制区域的重新选取按钮
  #元素名称：重新选取
  def taskConfig_monitorHeightDraw_restore
	@dr.link(:id,"sc-clear-people")
  end
  
#--------↓↓↓---------------------------- 过密区域绘制 -----------------------↓↓↓--------#
  #摄像机详细配置页面导航栏的过密区域绘制
  #元素名称：过密区域绘制
  def taskConfig_navig_denseAreaDraw
	@dr.link(:text,"过密区域绘制")
  end

  #摄像机详细配置页面过密区域绘制的添加区域按钮
  #元素名称：添加区域
  def taskConfig_denseAreaDraw_startBtn
	@dr.link(:id,"sc-start3")
  end 
  
  #摄像机详细配置页面过密区域绘制的全部清空按钮
  #元素名称：全部清空
  def taskConfig_denseAreaDraw_clearBtn
	@dr.link(:id,"sc-clear3")
  end 
  
  #摄像机详细配置页面过密区域绘制的全选
  #元素名称：全选
  def taskConfig_denseAreaDraw_selectAll
	@dr.link(:id,"sc-check3")
  end
  
  #摄像机详细配置页面过密区域绘制触发人群过密事件阈值输入框
  #元素名称：触发人群过密事件阈值（人群面积占比）
  def taskConfig_denseAreaDraw_triggerThreshold_textField
	@dr.text_field(:id,"crowdThresh")
  end 

#--------↓↓↓---------------------------- 聚集区域绘制 -----------------------↓↓↓--------#
  #摄像机详细配置页面导航栏的聚集区域绘制
  #元素名称：聚集区域绘制
  def taskConfig_navig_gatherAreaDraw
	@dr.link(:text,"聚集区域绘制")
  end

  #摄像机详细配置页面聚集区域绘制的添加区域按钮
  #元素名称：添加区域
  def taskConfig_gatherAreaDraw_startBtn
	@dr.link(:id,"sc-start4")
  end 
  
  #摄像机详细配置页面聚集区域绘制的全部清空按钮
  #元素名称：全部清空
  def taskConfig_gatherAreaDraw_clearBtn
	@dr.link(:id,"sc-clear4")
  end 
  
  #摄像机详细配置页面聚集区域绘制的全选
  #元素名称：全选
  def taskConfig_gatherAreaDraw_selectAll
	@dr.link(:id,"sc-check4")
  end
  
  #摄像机详细配置页面聚集区域绘制触发人群聚集事件阈值输入框
  #元素名称：触发人群聚集事件阈值
  def taskConfig_gatherAreaDraw_triggerThreshold_textField
	@dr.text_field(:id,"gatherThresh")
  end 

#--------↓↓↓---------------------------- 滞留区域绘制 -----------------------↓↓↓--------#
  #摄像机详细配置页面导航栏的滞留区域绘制
  #元素名称：滞留区域绘制
  def taskConfig_navig_strandingAreaDraw
	@dr.link(:text,"滞留区域绘制")
  end

  #摄像机详细配置页面滞留区域绘制的添加区域按钮
  #元素名称：添加区域
  def taskConfig_strandingAreaDraw_startBtn
	@dr.link(:id,"sc-start1")
  end 
  
  #摄像机详细配置页面滞留区域绘制的全部清空按钮
  #元素名称：全部清空
  def taskConfig_strandingAreaDraw_clearBtn
	@dr.link(:id,"sc-clear1")
  end
  
  #摄像机详细配置页面滞留区域绘制的全选
  #元素名称：全选
  def taskConfig_strandingAreaDraw_selectAll
	@dr.link(:id,"sc-check1")
  end
  
  #摄像机详细配置页面滞留区域绘制触发人群滞留事件阈值输入框
  #元素名称：触发人群滞留事件阈值
  def taskConfig_strandingAreaDraw_triggerThreshold_textField
	@dr.text_field(:id,"retentionTime")
  end 

#--------↓↓↓---------------------------- 逆行区域设置 -----------------------↓↓↓--------#
  #摄像机详细配置页面导航栏的逆行区域设置
  #元素名称：逆行区域设置
  def taskConfig_navig_retrogradeAreaConf
	@dr.link(:text,"逆行区域设置")
  end
  
  #摄像机详细配置页面逆行区域绘制的添加区域按钮
  #元素名称：添加区域
  def taskConfig_retrogradeAreaConf_startBtn
	@dr.link(:id,"sc-start2")
  end 
  
  #摄像机详细配置页面逆行区域绘制的全部清空按钮
  #元素名称：全部清空
  def taskConfig_retrogradeAreaConf_clearBtn
	@dr.link(:id,"sc-clear2")
  end

  #摄像机详细配置页面逆行区域设置的全选
  #元素名称：全选
  def taskConfig_retrogradeAreaConf_selectAll
	@dr.link(:id,"sc-check2")
  end
  
  #摄像机详细配置页面逆行区域设置的方位选择
  #元素名称：北；东北；东；东南；南；西南；西；西北
  #入参：北；东北；东；东南；南；西南；西；西北
  #调用方式：@driver.taskConfig_retrogradeAreaConf_directionBtn("东北")
  def taskConfig_retrogradeAreaConf_directionBtn(arg)
	@dr.link(:text,arg)
  end




end #end module

