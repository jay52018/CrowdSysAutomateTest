#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_userManage_addInvalidUserId_fail_053_005
# 用例标题: 添加含有特殊字符的用户名
# 预置条件: 
#	1.管理员已进入用户管理界面
# 测试步骤:
#	1.点击“+添加新用户”
#	2.在“用户名”输入框输入：#admin*
#	3.在“用户姓名”输入框输入：新用户
#	4.点击“确定添加”按钮
# 预期结果:
#	1.弹出“添加用户”窗口
#	4.添加失败，提示“请输入正确的用户名”
# 脚本作者: kangting
# 写作日期: 20161012
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

  def test_RQ_userCenter_userManage_addInvalidUserId_fail_053_005
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
	#点击“+添加新用户”
	@driver.userCenter_userManage_addUserBtn.when_present($waitTime).click
	#弹出“添加用户”窗口 
	assert(@driver.userCenter_userManage_addUser_dialog.when_present($waitTime).present?,"添加用户失败，未弹出“添加用户”窗口 ")
	#在“用户名”输入框输入：#admin*
	@driver.userCenter_userManage_addUserIdField.set("#admin*")
	#在“用户姓名”输入框输入：新用户
	@driver.userCenter_userManage_addUserNameField.set($newUserName)
	#点击“确定添加”按钮
	@driver.userCenter_userManage_submitAddUser_btn.click
	#提示“请输入正确的用户名”
	assert_equal($userManage_addUser_invalidUserId_errCode,@driver.userCenter_userManage_addUser_errCode.when_present($waitTime).text,"添加含非法字符的用户名的用户，提示信息异常")
	#关闭“添加用户”窗口
	@driver.close_currWindow_with_X.click
	#用户列表中无用户姓名为“新用户”的用户信息
	assert_equal('false',@driver.userCenter_userManage_userListInf_index(5).present?.to_s,"错误！用户列表中存在用户姓名为#{$newUserName}的用户信息")
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end