#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_userManage_editPwd_admin_succ_057_001
# 用例标题: 修改管理员密码为一个6~20字符的新密码
# 预置条件: 
#	1.管理员已进入用户管理界面
# 测试步骤:
#	1.在用户列表中点击用户名为“admin”一栏的“编辑”按钮
#	2.在“修改密码”输入框输入：admin123
#	3.在“确认密码”输入框输入：admin123
#	4.点击“确认修改”按钮
# 预期结果:
#	1.弹出“用户编辑”窗口
#	4.4.修改成功，系统强制退出，回到登录页面
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

  def test_RQ_userCenter_userManage_editPwd_admin_succ_057_001
	#使用管理员账号登录系统
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#进入到用户管理界面
	@driver.userNameToUserManage
	#检查当前页面存在模块名称：用户管理
	assert(@driver.userCenter_userManage_title.when_present($waitTime).present?,"未跳转到用户管理页面")
	#修改admin用户密码为：admin123
	@driver.userManage_modifyUser(0,$adminName,'admin123','admin123')
	#修改密码后，退回到登录页面
	assert(@driver.crowdSys_login_btn.when_present($waitTime).present?,'密码修改失败，未强制退出到登录页面')
	#修改密码后登录
	@driver.login($adminAccount,'admin123')
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	
	#还原
	#进入到用户管理界面
	@driver.userNameToUserManage
	#还原管理员账号的密码
	@driver.userManage_modifyUser(0,$adminName,$adminPasswd,$adminPasswd)
	#修改密码后，退回到登录页面
	assert(@driver.crowdSys_login_btn.when_present($waitTime).present?,'还原密码失败，未强制退出到登录页面')
	
 end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end