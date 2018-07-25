#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID:RQ_userCenter_operateLog_admin_editUserInfo_073_012
# 用例标题: 过滤管理员的修改用户信息日志
# 预置条件: 
#	1.使用管理员账号产生修改用户信息动作
#	2.管理员已进入操作日志界面
# 测试步骤:
#	1.点击“用户”下拉框，勾选“系统管理员”
#	2.点击“动作”下拉框，勾选“修改用户信息”动作
#	3.进行提交
#	4.查看日志列表
# 预期结果:
#	4.成功过滤，日志列表中只显示系统管理员的修改用户信息操作日志信息
# 脚本作者: kangting
# 写作日期: 20161026
#=========================================================
require 'crowdSysAction'
require_lib($debugLog)

class CrowdSystemTest < MiniTest::Unit::TestCase
	
  def setup
	#实例化driver
	@driver = CrowdAction.new(@dr)
	#打开被测系统
	@driver.open_test_system($testBrowser,$crowdSysURL)
  end

  def test_RQ_userCenter_operateLog_admin_editUserInfo_073_012
	#清空所有操作日志
	@driver.mongoDB_clear_operateLog
	#使用管理员账户登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#进入到用户管理界面
	@driver.userNameToUserManage
	#检查当前页面存在模块名称：用户管理
	assert(@driver.userCenter_userManage_title.when_present($waitTime).present?,"未跳转到用户管理页面")
	#初始化用户名列表数据
	@driver.resore_defaultUser
	#修改user用户的用户姓名为：普通姓名
	@driver.userManage_modifyUser(2,$modifyGuestName)
	#记录修改用户信息的时间
	editUserInfoTime = @driver.time_now
	#提示修改用户信息成功！
	assert_equal($userManage_editUserName_succ,@driver.userCenter_userManage_editUser_succMessage.when_present($waitTime).text,"修改用户失败，修改用户信息成功的提示信息异常")
	#用户列表中user的用户姓名更新为“普通姓名”
	assert_equal($guestAccount,@driver.userCenter_userManage_userListInf_index(2).when_present($waitTime).text,"用户列表中无用户名为#{$guestAccount}的用户信息")
	assert_equal($modifyGuestName,@driver.userCenter_userManage_userListInf_index(3).when_present($waitTime).text,"用户列表中无用户姓名为#{$modifyGuestName}的用户信息")
	
	#进入到操作日志界面
	@driver.userCenter_navig_trace.click
	#检查是否存在模块名：操作日志
	assert(@driver.userCenter_trace_title.when_present($waitTime).present?,"跳转到操作日志界面失败！")
	#过滤系统管理员修改用户信息操作的日志
	@driver.userCenter_filterOperateLog_withUserName('系统管理员')
	@driver.userCenter_filterOperateLog_withAction('修改用户信息')
	
	#查看操作日志信息列表中的日志是否正确
	#判断操作日志记录时间与实际操作时间的偏差
	operateLog_recordTime = @driver.operateLog_recordTime(0)
	@driver.logTime_operateTime_deviation(editUserInfoTime,operateLog_recordTime,'editUserInfoTime')
	#断言操作日志列表中的用户名为：admin
	assert_equal($adminAccount,@driver.userCenter_trace_operateLogList_index(1).when_present($waitTime).text,'用户名与操作日志中不一致！')
	#断言操作日志列表中的用户姓名为：系统管理员
	assert_equal($adminName,@driver.userCenter_trace_operateLogList_index(2).when_present($waitTime).text,'用户姓名与操作日志中不一致！')
	#断言操作日志列表中的动作为：修改用户信息[普通姓名]成功
	assert_equal('修改用户信息[普通姓名]成功',@driver.userCenter_trace_operateLogList_index(3).when_present($waitTime).text,'动作与操作日志中不一致！')
	
	#进入用户管理界面
	@driver.userCenter_navig_userManage.click
	#初始化用户名列表数据
	@driver.resore_defaultUser
	#用户列表中user的用户姓名更新为“普通姓名”
	assert_equal($guestAccount,@driver.userCenter_userManage_userListInf_index(2).when_present($waitTime).text,"还原失败，用户列表中无用户名为#{$guestAccount}的用户信息")
	assert_equal($guestName,@driver.userCenter_userManage_userListInf_index(3).when_present($waitTime).text,"还原失败，用户列表中无用户姓名为#{$modifyGuestName}的用户信息")
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end