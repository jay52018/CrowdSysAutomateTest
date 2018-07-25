#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_login_errAcc_fail_002_004
# 用例标题: 错误账号登录
# 预置条件: 
#	1.打开浏览器，进入系统登录界面
# 测试步骤:
#	1.输入错误的管理员账号：Admin@和正确的密码：123456
#	2.按回车键
# 预期结果:
#	2.登录失败，弹出提示框：“用户名或密码错误，请重试！”
# 脚本作者: kangting
# 写作日期: 20160922
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

  def test_RQ_login_errAcc_fail_002_004
	#输入错误账号
	@driver.crowdSys_login_field.set('Admin@')
	@driver.crowdSys_passwd_field.set($adminPasswd)
	#~ sleep 0.2
	#点击登录按钮
	@driver.crowdSys_login_btn.when_present($waitTime).click
	#登录失败，提示用户名或密码错误，请重试！
	assert_equal($login_errData_errCode,@driver.login_err_accpwd_errCode.when_present($waitTime).text,"错误账号登录，提示信息异常")
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end