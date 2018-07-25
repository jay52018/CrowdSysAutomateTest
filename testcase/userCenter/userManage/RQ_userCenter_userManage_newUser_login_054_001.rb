#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_userManage_newUser_login_054_001
# 用例标题: 新增用户登录验证
# 预置条件: 
#	1.已新增用户名、用户姓名、密码分别为：who、新用户、123456的新用户
# 测试步骤:
#	1.打开浏览器，进入人群系统登录页面
#	2.输入用户名：who 和密码：123456
#	3.点击登录
# 预期结果:
#	3.登录成功，跳转至状态监测页面且显示用户姓名“新用户”
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

  def test_RQ_userCenter_userManage_newUser_login_054_001
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
	#添加用户名为：who 和用户姓名为：新用户 的用户
	@driver.userManage_addNewUser($newUserAccount,$newUserName)
	#提示“用户添加成功！”
	assert_equal($userManage_addUser_succMessage,@driver.userCenter_userManage_addUser_succMessage.when_present($waitTime).text,"用户添加成功提示信息异常")
	#用户列表中有用户名为“who”，用户姓名为“新用户”的用户信息
	assert_equal($newUserAccount,@driver.userCenter_userManage_userListInf_index(4).when_present($waitTime).text,"用户列表中无用户名为#{$newUserAccount}的用户信息")
	assert_equal($newUserName,@driver.userCenter_userManage_userListInf_index(5).when_present($waitTime).text,"用户列表中无用户姓名为#{$newUserName}用户信息")
	#注销系统，进入到登录页面
	@driver.logout()
	#使用新增的账号登录系统
	@driver.login($newUserAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterStatusMonitor_succ元素，即成功跳转到状态检测页面
	assert(@driver.assert_enterStatusMonitor_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面！")
	#登录后，显示用户姓名：新用户
	assert_equal($newUserName,@driver.user_name_link.when_present($waitTime).text,"修改用户姓名后，用户中心入口名未更新同步为：#{$newUserName}")
	#还原默认值，删除新增的用户,确认删除用户信息列表中第三行的用户
	@driver.logout()
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	@driver.userNameToUserManage
	@driver.userManage_deleteUser(4,0)
	#提示：删除成功
	assert_equal($userManage_deleteUser_succMessage,@driver.userCenter_userManage_addUser_succMessage.when_present($waitTime).text,"删除用户成功的提示信息异常")
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