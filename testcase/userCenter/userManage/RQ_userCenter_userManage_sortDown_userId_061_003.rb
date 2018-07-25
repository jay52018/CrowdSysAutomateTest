#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_userManage_sortDown_userName_061_003
# 用例标题: 按照用户名降序排列
# 预置条件: 
#	1.管理员已进入用户管理界面
# 测试步骤:
#	1.在用户列表中点击“用户名”
# 预期结果:
#	1.用户名旁向下的三角符高亮显示，用户列表按照用户名首字符的降序排列
# 脚本作者: kangting
# 写作日期: 20161017
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

  def test_RQ_userCenter_userManage_sortDown_userName_061_003
	#使用管理员账号登录系统
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#进入到用户管理界面
	@driver.userNameToUserManage
	#检查当前页面存在模块名称：用户管理
	assert(@driver.userCenter_userManage_title.when_present($waitTime).present?,"未跳转到用户管理页面")
	#初始化用户名列表数据
	@driver.resore_defaultUser
	#在用户列表中点击“用户名”
	@driver.userCenter_userManage_userList_userId.when_present($waitTime).click
	#检查用户列表中第一列的顺序为：user、admin
	assert_equal($guestAccount,@driver.userCenter_userManage_userListInf_index(0).when_present($waitTime).text,"用户信息列表按照用户名降序排序时错误！第二行第一个不是#{$guestAccount}")
	assert_equal($guestName,@driver.userCenter_userManage_userListInf_index(1).when_present($waitTime).text,"用户信息列表按照用户名降序排序时错误！第二行第一个不是#{$guestName}")
	assert_equal($adminAccount,@driver.userCenter_userManage_userListInf_index(2).when_present($waitTime).text,"用户信息列表按照用户名降序排序时错误！第二行第一个不是#{$adminAccount}")
	assert_equal($adminName,@driver.userCenter_userManage_userListInf_index(3).when_present($waitTime).text,"用户信息列表按照用户名降序排序时错误！第二行第一个不是#{$adminName}")
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end