#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_login_nullPWD_fail_002_002
# 用例标题: 管理员账号空密码登录
# 预置条件: 
#	1.打开浏览器，进入系统登录界面
# 测试步骤:
#	1.输入正确的管理员账号：admin
#	2.点击“登录”按钮
# 预期结果:
#	2.登录失败，弹出提示：密码不能为空！
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

  def test_RQ_login_nullPWD_fail_002_002
	#空密码登录
	@driver.login($adminAccount,'')
	#登录失败，提示密码不能为空！
	assert_equal($login_nullPwd_errCode,@driver.login_null_accpwd_errCode.when_present($waitTime).text,"空密码登录时，提示信息异常")
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end