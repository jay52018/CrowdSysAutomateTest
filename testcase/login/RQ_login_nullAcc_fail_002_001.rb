#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_login_nullAcc_fail_002_001
# 用例标题: 空用户登录
# 预置条件: 
#	1.打开浏览器，进入系统登录界面
# 测试步骤:
#	1.直接点击“登录”按钮    
# 预期结果:
#	1.登录失败，弹出提示：用户名不能为空！
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

  def test_RQ_login_nullAcc_fail_002_001
	#防止焦点丢失，先选择浏览器控件
	@driver.crowdSys_login_field.when_present($waitTime).click
	#不输入账号密码，点击登录
	@driver.crowdSys_login_btn.when_present($waitTime).click
	#登录失败，提示用户名不能为空！
	assert_equal($login_nullAcc_errCode,@driver.login_null_accpwd_errCode.when_present($waitTime).text,"空账号登录，提示信息异常")
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end