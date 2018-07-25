#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_userManage_searchUser_fullName_succ_050_001
# 用例标题: 搜索已存在的完整用户关键字
# 预置条件: 
#	1.管理员已进入用户管理界面
# 测试步骤:
#	1.在搜索框中输入“admin”
#	2.点击“搜索”
# 预期结果:
#	1.搜索结果返回包含“admin”关键字的用户
#	2.在用户列表中显示包含“admin”关键字的用户信息
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

  def test_RQ_userCenter_userManage_searchUser_fullName_succ_050_001
	#使用管理员账号登录系统
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#进入到用户管理界面
	@driver.userNameToUserManage
	#检查当前页面存在模块名称：用户管理
	assert(@driver.userCenter_userManage_title.when_present($waitTime).present?,"未跳转到用户管理页面")
	#在搜索框中输入“admin”
	@driver.userCenter_userManage_filterField.set($adminAccount)
	#检查是否返回包含“admin”关键字的用户
	assert_match($adminAccount,@driver.userCenter_userManage_keyWordReturn.when_present($waitTime).text,"未返回包含“admin”关键字的用户")
	#点击“搜索”按钮
	@driver.userCenter_userManage_searchBtn.click
	#检查用户列表中是否过滤出包含“admin”关键字的用户信息
	assert_equal($adminAccount,@driver.userCenter_userManage_userListInf_index(0).when_present($waitTime).text,"用户列表中无用户名为#{$adminAccount}的用户信息")
	assert_equal($adminName,@driver.userCenter_userManage_userListInf_index(1).when_present($waitTime).text,"用户列表中无用户姓名为#{$adminName}的用户信息")
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end