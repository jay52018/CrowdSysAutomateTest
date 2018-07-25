#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_getAuth_090_001
# 用例标题: 申请授权
# 预置条件: 
#	1.管理员用户已进入授权管理界面
# 测试步骤:
#	1.点击“申请授权”按钮
# 预期结果:
#	1.显示成功生成“hardware.info”文件等一系列授权步骤信息
# 脚本作者: kangting
# 写作日期: 20160929
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

  def test_RQ_userCenter_getAuth_090_001
	#使用管理员账户登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#进入到授权管理页面
	@driver.userNameToAuthManage
	#检查当前页面存在授权管理标题，即认为成功跳转到授权管理页面
	assert(@driver.userCenter_authManage_title.when_present($waitTime).present?,"未跳转到授权管理页面")
	#点击申请授权按钮申请授权
	@driver.userCenter_authManage_getAuth_btn.when_present($waitTime).click
	#检查当前页面存在'导出文件'按钮，即认为成功显示生成“hardware.info”文件等一系列授权步骤信息
	assert(@driver.userCenter_authManage_exportAuth_btn.when_present($waitTime).present?,"未生成授权步骤信息")
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end