#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_login_succ_001_001
# 用例标题: 管理员账号登录成功
# 预置条件: 
#	1.打开浏览器，进入系统登录界面
# 测试步骤:
#	1.输入正确的管理员账号：admin和密码：123456；
#	2.点击“登录”按钮
# 预期结果:
#	2.登录成功，跳转到“任务配置”页面
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

  def test_RQ_login_succ_001_001
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end