#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_userManage_addNewUser_succ_052_001
# 用例标题: 添加不存在的用户
# 预置条件: 
#	1.管理员已进入用户管理界面
# 测试步骤:
#	1.点击“+添加新用户”
#	2.在“用户名”输入框输入：who
#	3.在“用户姓名”输入框输入：新用户
#	4.点击“确定添加”按钮
# 预期结果:
#	1.弹出“添加用户”窗口
#	4.添加成功，提示“用户添加成功！”，用户列表中显示新用户信息
# 脚本作者: kangting
# 写作日期: 20161011
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

  def test_RQ_userCenter_userManage_addNewUser_succ_052_001
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
	@driver.userCenter_userManage_addUserBtn.click
	#弹出“添加用户”窗口 
	assert(@driver.userCenter_userManage_addUser_dialog.when_present($waitTime).present?,"未弹出“添加用户”窗口 ")
	#在“用户名”输入框输入：who
	@driver.userCenter_userManage_addUserIdField.set($newUserAccount)
	#在“用户姓名”输入框输入：新用户
	@driver.userCenter_userManage_addUserNameField.set($newUserName)
	#点击“确定添加”按钮
	@driver.userCenter_userManage_submitAddUser_btn.click
	#提示“用户添加成功！”
	assert_equal($userManage_addUser_succMessage,@driver.userCenter_userManage_addUser_succMessage.when_present($waitTime).text,"成功添加用户的提示信息异常")
	#用户列表中有用户名为“who”，用户姓名为“新用户”的用户信息
	assert_equal($newUserAccount,@driver.userCenter_userManage_userListInf_index(4).when_present($waitTime).text,"用户列表中无用户名为#{$newUserAccount}的用户信息")
	assert_equal($newUserName,@driver.userCenter_userManage_userListInf_index(5).when_present($waitTime).text,"用户列表中无用户姓名为#{$newUserName}的用户信息")
	#初始化用户名列表数据
	@driver.resore_defaultUser
	#检验用户列表中无用户名为“who”，用户姓名为“新用户”的用户信息
	assert_equal('false',@driver.userCenter_userManage_userListInf_index(4).present?.to_s,"还原默认值失败！未成功删除新增的用户")
	assert_equal('false',@driver.userCenter_userManage_userListInf_index(5).present?.to_s,"还原默认值失败！未成功删除新增的用户")
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end