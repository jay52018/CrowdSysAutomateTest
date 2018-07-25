#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_logout_login_012_001
# 用例标题: 注销后登录
# 预置条件: 
#	1.管理员账号已登录
# 测试步骤:
#	1.点击“注销”
#	2.输入管理员账号：admin和密码：123456
#	3.点击“登录”按钮
# 预期结果:
#	3.登录成功，跳转至任务配置页面
# 脚本作者: kangting
# 写作日期: 20160921
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

  def test_RQ_logout_login_012_001
	#管理员成功登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#注销
	@driver.logout()
	#注销后，再次登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#注销
	@driver.logout()
  end


  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end