#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_userManage_deleteUser_succ_059_001
# 用例标题: 删除用户
# 预置条件: 
#	1.管理员已进入用户管理界面
# 测试步骤:
#	1.在用户列表中点击用户名为“user”一栏的“编辑”按钮
#	2.点击“删除用户”按钮
#	3.点击“确定”
# 预期结果:
#	1.弹出“用户编辑”窗口
#	2.弹出提示对话框
#	3.提示“删除用户成功”，用户列表中无user用户信息
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

  def test_RQ_userCenter_userManage_deleteUser_succ_059_001
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
	#删除“user”用户
	@driver.userManage_deleteUser(2,0)
	#提示：删除成功
	assert_equal($userManage_deleteUser_succMessage,@driver.userCenter_userManage_addUser_succMessage.when_present($waitTime).text,"删除用户成功的提示信息异常")
	#检验用户列表中无用户名为“user”，用户姓名为“普通用户”的用户信息
	assert_equal('false',@driver.userCenter_userManage_userListInf_index(2).present?.to_s,"删除失败！仍存在user用户")
	assert_equal('false',@driver.userCenter_userManage_userListInf_index(3).present?.to_s,"删除失败！仍存在user用户")
	#还原初始用户
	@driver.userManage_addNewUser($guestAccount,$guestName)
	#提示“用户添加成功！”
	assert_equal($userManage_addUser_succMessage,@driver.userCenter_userManage_addUser_succMessage.when_present($waitTime).text,"添加用户成功的提示信息异常")
	#用户列表中有用户名为“user”，用户姓名为“普通用户”的用户信息
	assert_equal($guestAccount,@driver.userCenter_userManage_userListInf_index(2).when_present($waitTime).text,"用户列表中无用户名为#{$guestAccount}的用户信息")
	assert_equal($guestName,@driver.userCenter_userManage_userListInf_index(3).when_present($waitTime).text,"用户列表中无用户姓名为#{$guestName}的用户信息")
	#注销系统，确认:0;取消：1
	@driver.logout()
 end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end