#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_modifyPWD_succ_080_001
# 用例标题: 管理员账号修改密码
# 预置条件: 
#	1.管理员用户已进入密码修改界面
# 测试步骤:
#	1.输入原密码：123456
#	2.输入新密码：admin123*@
#	3.确认密码：admin123*@
#	4.点击“确认修改”
# 预期结果:
#	4.密码修改成功，系统强制退出，回到登录页面
# 脚本作者: kangting
# 写作日期: 20161009
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

  def test_RQ_userCenter_modifyPWD_succ_080_001
	#使用管理员账户登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#进入到密码修改页面
	@driver.userNameToPWDModify
	#检查当前页面存在密码修改模块名，即认为成功跳转到密码修改页面
	assert(@driver.userCenter_modifyPWD_title.when_present($waitTime).present?,"未跳转到密码修改页面")
	#输入原密码、新密码、确认密码，点击“确认修改”，修改密码为：admin123*@
	@driver.userCenter_modifyPWD($adminPasswd,'admin123*@','admin123*@')
	#回到登录页面
	assert(@driver.crowdSys_login_btn.when_present($waitTime).present?,'修改密码失败，未退出到登录页面')
	
	#使用管理员账户登录
	@driver.login($adminAccount,'admin123*@')
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	
	#还原密码：
	#进入到密码修改页面
	@driver.userNameToPWDModify
	#检查当前页面存在密码修改模块名，即认为成功跳转到密码修改页面
	assert(@driver.userCenter_modifyPWD_title.when_present($waitTime).present?,"未跳转到密码修改页面")
	#输入原密码、新密码、确认密码，点击“确认修改”，还原密码为：123456
	@driver.userCenter_modifyPWD('admin123*@',$adminPasswd,$adminPasswd)
	#回到登录页面
	assert(@driver.crowdSys_login_btn.when_present($waitTime).present?,'还原密码失败，未退出到登录页面')
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end