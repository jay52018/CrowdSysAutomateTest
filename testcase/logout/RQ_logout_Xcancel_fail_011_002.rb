#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_logout_Xcancel_fail_011_002
# 用例标题: 管理员点击“X”取消注销
# 预置条件: 
#	1.管理员账号已登录
# 测试步骤:
#	1.点击“注销”
#	2.点击“提示”对话框的“X”
# 预期结果:
#	1.弹出“提示”对话框
#	 2.未注销，停留在任务配置页面
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

  def test_RQ_logout_Xcancel_fail_011_002
	#管理员成功登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#点击'注销'
	@driver.logout_link.when_present($waitTime).click
	#等待提示框出现
	assert(@driver.logout_confirm_btn(0).when_present($waitTime).present?,"注销提示框未弹出")
	#点击'X'取消注销
	@driver.close_currWindow_with_X.click
	#注销中断，停留在assert_enterTaskConfig_element元素所在页面
	assert(@driver.assert_enterTaskConfig_element.present?,"取消注销后，未停留在指定页面")
	#注销
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end