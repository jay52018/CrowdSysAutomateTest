#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_operateLog_user_sortDown_076_004
# 用例标题: 按照用户名降序排序
# 预置条件: 
#	1.使用管理员账号产生登入和注销动作
#	2.管理员已进入操作日志界面
# 测试步骤:
#	1.点击日志列表中的“用户名”两次
#	2.查看日志列表信息
# 预期结果:
#	2.“用户名”旁向下的小三角符号高亮显示，日志列表中的日志信息按照用户名的降序排序
# 脚本作者: kangting
# 写作日期: 20161027
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

  def test_RQ_userCenter_operateLog_user_sortDown_076_004
	#初始化用户，还原系统
	#使用管理员账号登录系统
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#进入到用户管理界面
	@driver.userNameToUserManage
	#检查当前页面存在模块名称：用户管理
	assert(@driver.userCenter_userManage_title.when_present($waitTime).present?,"未跳转到用户管理页面")
	#初始化用户名列表数据
	@driver.resore_defaultUser
	#注销系统，确认:0;取消：1
	@driver.logout()
	
	#清空所有操作日志
	@driver.mongoDB_clear_operateLog	
	#使用普通用户登录
	@driver.login($guestAccount,$guestPasswd)
	#记录登入时间
	first_loginTime = @driver.time_now
	#登录后，检查当前页面存在assert_enterStatusMonitor_element元素，即认为登录成功
	assert(@driver.assert_enterStatusMonitor_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#为了让登录注销时间不相同，等待一秒
	sleep 1
	#注销系统，确认:0;取消：1
	@driver.logout()
	#记录登出时间
	logoutTime = @driver.time_now
	#使用管理员账户登录
	@driver.login($adminAccount,$adminPasswd)
	#记录登入时间
	second_loginTime = @driver.time_now
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"第二次登录失败，未跳转到指定页面")
	#进入到操作日志界面
	@driver.userNameToTrace
	#检查是否存在模块名：操作日志
	assert(@driver.userCenter_trace_title.when_present($waitTime).present?,"跳转到操作日志界面失败！")
	#点击日志列表中的“用户名”
	2.times { @driver.userCenter_trace_sort('用户名').click }
	
	#查看操作日志信息列表中的日志是否正确
	#判断操作日志记录时间与实际操作时间的偏差
	firstLine_operateLog_recordTime = @driver.operateLog_recordTime(0)
	@driver.logTime_operateTime_deviation(first_loginTime,firstLine_operateLog_recordTime,'first_loginTime')
	#断言操作日志列表中的用户名为：user
	assert_equal($guestAccount,@driver.userCenter_trace_operateLogList_index(1).when_present($waitTime).text,'用户名与操作日志中不一致！')
	#断言操作日志列表中的用户姓名为：普通用户
	assert_equal($guestName,@driver.userCenter_trace_operateLogList_index(2).when_present($waitTime).text,'用户姓名与操作日志中不一致！')
	#断言操作日志列表中的动作为：登入成功
	assert_equal('[普通用户]登入成功',@driver.userCenter_trace_operateLogList_index(3).when_present($waitTime).text,'动作与操作日志中不一致！')
	
	#判断操作日志记录时间与实际操作时间的偏差
	secondLine_operateLog_recordTime = @driver.operateLog_recordTime(4)
	@driver.logTime_operateTime_deviation(logoutTime,secondLine_operateLog_recordTime,'logoutTime')
	#断言操作日志列表中的用户名为：user
	assert_equal($guestAccount,@driver.userCenter_trace_operateLogList_index(5).when_present($waitTime).text,'用户名与操作日志中不一致！')
	#断言操作日志列表中的用户姓名为：普通用户
	assert_equal($guestName,@driver.userCenter_trace_operateLogList_index(6).when_present($waitTime).text,'用户姓名与操作日志中不一致！')
	#断言操作日志列表中的动作为：登出成功
	assert_equal('登出成功',@driver.userCenter_trace_operateLogList_index(7).when_present($waitTime).text,'动作与操作日志中不一致！')
	
	#判断操作日志记录时间与实际操作时间的偏差
	thirdLine_operateLog_recordTime = @driver.operateLog_recordTime(8)
	@driver.logTime_operateTime_deviation(second_loginTime,thirdLine_operateLog_recordTime,'second_loginTime')
	#断言操作日志列表中的用户名为：admin
	assert_equal($adminAccount,@driver.userCenter_trace_operateLogList_index(9).when_present($waitTime).text,'用户名与操作日志中不一致！')
	#断言操作日志列表中的用户姓名为：系统管理员
	assert_equal($adminName,@driver.userCenter_trace_operateLogList_index(10).when_present($waitTime).text,'用户姓名与操作日志中不一致！')
	#断言操作日志列表中的动作为：登入成功
	assert_equal('[系统管理员]登入成功',@driver.userCenter_trace_operateLogList_index(11).when_present($waitTime).text,'动作与操作日志中不一致！')
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end