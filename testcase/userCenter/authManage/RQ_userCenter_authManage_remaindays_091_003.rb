#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_auth_remaindays_091_003
# 用例标题: 授权剩余天数范围判断
# 预置条件: 
#	1.管理员用户已进入授权管理界面（已授权）
# 测试步骤:
#	1.查看授权剩余天数显示条
# 预期结果:
#	1.显示条中的授权剩余天数在0-365天之间
# 脚本作者: kangting
# 写作日期: 20161008
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

  def test_RQ_userCenter_auth_remaindays_091_003
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#进入到授权管理页面
	@driver.userNameToAuthManage
	#检查当前页面存在授权管理标题，即认为成功跳转到授权管理页面
	assert(@driver.userCenter_authManage_title.when_present($waitTime).present?,"未跳转到授权管理页面")
	#获取授权剩余天数
	remainday = @driver.userCenter_authManage_remainDays.when_present($waitTime).text.to_i
	#判断剩余天数是否在0-365天之间
	assert((0..365).member?(remainday),"剩余天数不在0-365天之间！")
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end