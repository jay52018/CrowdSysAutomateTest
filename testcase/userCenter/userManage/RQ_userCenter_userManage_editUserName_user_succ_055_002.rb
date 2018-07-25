#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_userManage_editUserName_user_succ_055_002
# 用例标题: 修改普通用户姓名
# 预置条件: 
#	1.管理员已进入用户管理界面
# 测试步骤:
#	1.在用户列表中点击用户名为“user”一栏的“编辑”按钮
#	2.将用户姓名改为“普通姓名”
#	3.点击“确认修改”按钮
# 预期结果:
#	1.弹出“用户编辑”窗口
#	2.“用户姓名”输入框中默认显示“普通用户”
#	3.修改成功，提示“修改用户信息成功”，用户列表中user用户姓名更新为“普通姓名”
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

  def test_RQ_userCenter_userManage_editUserName_user_succ_055_002
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
	#修改user用户的用户姓名为：普通姓名
	@driver.userManage_modifyUser(2,$modifyGuestName)
	#提示修改用户信息成功！
	assert_equal($userManage_editUserName_succ,@driver.userCenter_userManage_editUser_succMessage.when_present($waitTime).text,"修改用户失败，修改用户信息成功的提示信息异常")
	#用户列表中user的用户姓名更新为“普通姓名”
	assert_equal($guestAccount,@driver.userCenter_userManage_userListInf_index(2).when_present($waitTime).text,"用户列表中无用户名为#{$guestAccount}的用户信息")
	assert_equal($modifyGuestName,@driver.userCenter_userManage_userListInf_index(3).when_present($waitTime).text,"用户列表中无用户姓名为#{$modifyGuestName}的用户信息")
	#还原普通用户的用户姓名
	@driver.userManage_modifyUser(2,$guestName)
	#提示修改用户信息成功！
	assert_equal($userManage_editUserName_succ,@driver.userCenter_userManage_editUser_succMessage.when_present($waitTime).text,"还原普通用户姓名失败！")
	#用户列表中user的用户姓名还原为“普通用户”
	assert_equal($guestAccount,@driver.userCenter_userManage_userListInf_index(2).when_present($waitTime).text,"还原失败，用户列表中无用户名为#{$guestAccount}的用户信息")
	assert_equal($guestName,@driver.userCenter_userManage_userListInf_index(3).when_present($waitTime).text,"还原失败，用户列表中无用户姓名为#{$guestName}的用户信息")
	#注销系统，确认:0;取消：1
	@driver.logout()
 end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end