#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_logout_succ_010_001
# 用例标题: 管理员注销
# 预置条件: 
#	1.管理员账号已登录
# 测试步骤:
#	1.点击“注销”
#	2.点击“确定”按钮
# 预期结果:
#	1.弹出“提示”对话框
#	2.注销成功，跳转至登录页面
# 脚本作者: kangting
# 写作日期: 20160921
#=========================================================
require 'crowdSysAction'
require_lib('$debugLog')

class CrowdSystemTest < MiniTest::Unit::TestCase
	
  def setup
	#实例化driver
	@driver = CrowdAction.new(@dr)
	#打开被测系统
	@driver.open_test_system($testBrowser,$crowdSysURL)
  end

  def test_RQ_logout_succ_010_001
	#管理员成功登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#注销系统，确认:0;取消：1
	@driver.logout()
	#注销成功，跳转到登录页面，当前存在用户框
	assert(@driver.crowdSys_login_field.when_present($waitTime).present?,"注销失败，未跳转到登录页面")
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end