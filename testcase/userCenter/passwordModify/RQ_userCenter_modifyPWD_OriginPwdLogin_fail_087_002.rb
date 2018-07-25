#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_modifyPWD_OriginPwdLogin_fail_087_002
# 用例标题: 管理员修改密码后使用原密码登录
# 预置条件: 
#	1.管理员密码已由原密码“123456”修改为“1234567”
#	2.进入系统登录页面
# 测试步骤:
#	1.输入用户名、密码：admin、123456
#	2.点击“登录”按钮
# 预期结果:
#	2.登录失败，提示“用户名或密码错误，请重试！”
# 脚本作者: kangting
# 写作日期: 20161010
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

  def test_RQ_userCenter_modifyPWD_OriginPwdLogin_fail_087_002
	#使用管理员账户登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#进入到密码修改页面
	@driver.userNameToPWDModify
	#检查当前页面存在密码修改模块名，即认为成功跳转到密码修改页面
	assert(@driver.userCenter_modifyPWD_title.when_present($waitTime).present?,"未跳转到密码修改页面")
	#输入原密码：123456
	@driver.userCenter_modifyPWD_originPWDField.set($adminPasswd)
	#输入新密码：1234567
	@driver.userCenter_modifyPWD_newPWDField.set("1234567")
	#确认密码：1234567
	@driver.userCenter_modifyPWD_newPWD_confirmField.set("1234567")
	#点击“确认修改”按钮
	@driver.userCenter_modifyPWD_submmitBtn.click
	
	#使用原密码登录
	@driver.login($adminAccount,$adminPasswd)
	#登录失败，弹出提示“用户名或密码错误，请重试！”
	assert_equal($login_errData_errCode,@driver.login_err_accpwd_errCode.when_present($waitTime).text,"错误！修改密码后，使用原密码登录成功！")
	#还原密码：
	#使用新密码登录
	@driver.login($adminAccount,"1234567")
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#进入到密码修改页面
	@driver.userNameToPWDModify
	#检查当前页面存在原密码输入框，即认为成功跳转到密码修改页面
	assert(@driver.userCenter_modifyPWD_title.when_present($waitTime).present?,"未跳转到密码修改页面")
	#输入原密码：1234567
	@driver.userCenter_modifyPWD_originPWDField.set('1234567')
	#输入新密码：123456
	@driver.userCenter_modifyPWD_newPWDField.set($adminPasswd)
	#确认密码：123456
	@driver.userCenter_modifyPWD_newPWD_confirmField.set($adminPasswd)
	#点击“确认修改”按钮
	@driver.userCenter_modifyPWD_submmitBtn.click
	#回到系统登录页面
	assert(@driver.crowdSys_login_field.when_present($waitTime).present?,"修改密码后，未退出到系统登录页面")
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end