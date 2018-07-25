#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_userManage_editPwd_user_succ_057_002
# 用例标题: 修改普通用户密码为一个6~20字符的新密码
# 预置条件: 
#	1.管理员已进入用户管理界面
# 测试步骤:
#	1.在用户列表中点击用户名为“user”一栏的“编辑”按钮
#	2.在“修改密码”输入框输入：user123
#	3.在“确认密码”输入框输入：user123
#	4.点击“确认修改”按钮
# 预期结果:
#	1.弹出“用户编辑”窗口
#	4.修改成功，提示“修改用户信息成功”
# 脚本作者: kangting
# 写作日期: 20161014
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

  def test_RQ_userCenter_userManage_editPwd_user_succ_057_002
	#使用管理员账号登录系统
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#进入到用户管理界面
	@driver.userNameToUserManage
	#检查当前页面存在模块名称：用户管理
	assert(@driver.userCenter_userManage_title.when_present($waitTime).present?,"未跳转到用户管理页面")
	#将user用户的密码修改为“user123”
	@driver.userManage_modifyUser(2,$guestName,'user123','user123')
	#提示修改用户信息成功！
	assert_equal($userManage_editUserName_succ,@driver.userCenter_userManage_editUser_succMessage.when_present($waitTime).text,"修改用户成功提示信息异常")
	#注销系统
	@driver.logout()
	#使用新密码登录
	@driver.login($guestAccount,'user123')
	#登录后，检查当前页面存在assert_enterStatusMonitor_element元素，即认为登录成功
	assert(@driver.assert_enterStatusMonitor_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#还原
	@driver.logout()
	#断言注销成功
	assert(@driver.crowdSys_login_btn.when_present($waitTime).present?,"注销失败，当前页面没有登录按钮")
	#使用管理员账号登录系统
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"第二次登录失败，未跳转到指定页面")
	#进入到用户管理界面
	@driver.userNameToUserManage
	#还原普通用户账号的密码
	@driver.userManage_modifyUser(2,$guestName,$guestPasswd,$guestPasswd)
	#提示修改用户信息成功！
	assert_equal($userManage_editUserName_succ,@driver.userCenter_userManage_editUser_succMessage.when_present($waitTime).text,"还原普通用户密码失败！")
	#注销系统，确认:0;取消：1
	@driver.logout()
 end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end