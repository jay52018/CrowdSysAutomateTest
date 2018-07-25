#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_operateLog_admin_getAuth_073_021
# 用例标题: 过滤管理员的申请授权日志
# 预置条件: 
#	1.使用管理员账号产生申请授权动作
#	2.管理员已进入操作日志界面
# 测试步骤:
#	1.点击“用户”下拉框，勾选“系统管理员”
#	2.点击“动作”下拉框，勾选“申请授权”动作
#	3.进行提交
#	4.查看日志列表
# 预期结果:
#	4.成功过滤，日志列表中只显示系统管理员的申请授权操作日志信息
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

  def test_RQ_userCenter_operateLog_admin_getAuth_073_021
	#清空所有操作日志
	@driver.mongoDB_clear_operateLog
	#使用管理员账户登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#进入到授权管理页面
	@driver.userNameToAuthManage
	#检查当前页面存在授权管理标题，即认为成功跳转到授权管理页面
	assert(@driver.userCenter_authManage_title.when_present($waitTime).present?,"未跳转到授权管理页面")
	#点击申请授权按钮申请授权
	@driver.userCenter_authManage_getAuth_btn.when_present($waitTime).click
	#记录申请授权时间
	getAuthTime = @driver.time_now
	#检查当前页面存在'导出文件'按钮，即认为成功显示生成“hardware.info”文件等一系列授权步骤信息
	assert(@driver.userCenter_authManage_exportAuth_btn.when_present($waitTime).present?,"未生成授权步骤信息")
	
	#进入到操作日志界面
	@driver.userNameToTrace
	#检查是否存在模块名：操作日志
	assert(@driver.userCenter_trace_title.when_present($waitTime).present?,"跳转到操作日志界面失败！")
	#过滤系统管理员申请授权操作的日志
	@driver.userCenter_filterOperateLog_withUserName('系统管理员')
	@driver.userCenter_filterOperateLog_withAction('申请授权')
	sleep 2
	#查看操作日志信息列表中的日志是否正确
	#判断操作日志记录时间与实际操作时间的偏差
	operateLog_recordTime = @driver.operateLog_recordTime(0)
	@driver.logTime_operateTime_deviation(getAuthTime,operateLog_recordTime,'getAuthTime')
	#断言操作日志列表中的用户名为：admin
	assert_equal($adminAccount,@driver.userCenter_trace_operateLogList_index(1).when_present($waitTime).text,'用户名与操作日志中不一致！')
	#断言操作日志列表中的用户姓名为：系统管理员
	assert_equal($adminName,@driver.userCenter_trace_operateLogList_index(2).when_present($waitTime).text,'用户姓名与操作日志中不一致！')
	#断言操作日志列表中的动作为：申请授权成功
	assert_equal('申请授权成功',@driver.userCenter_trace_operateLogList_index(3).when_present($waitTime).text,'动作与操作日志中不一致！')
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end