#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_userManage_editPwd_diffPWD_fail_058_003
# 用例标题: 新密码与确认密码不一致
# 预置条件: 
#	1.管理员已进入用户管理界面
# 测试步骤:
#	1.在用户列表中点击用户名为“admin”一栏的“编辑”按钮
#	2.在“修改密码”输入框输入：1234567
#	3.在“确认密码”输入框输入：123456
#	4.点击“确认修改”按钮
# 预期结果:
#	1.弹出“用户编辑”窗口
#	4.修改失败，提示“请输入相同的密码”
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

  def test_RQ_userCenter_userManage_editPwd_diffPWD_fail_058_003
	#使用管理员账号登录系统
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#进入到用户管理界面
	@driver.userNameToUserManage
	#检查当前页面存在模块名称：用户管理
	assert(@driver.userCenter_userManage_title.when_present($waitTime).present?,"未跳转到用户管理页面")
	#修改admin用户密码，新密码与确认密码不一致：
	@driver.userManage_modifyUser(0,$adminName,'1234567','123456')
	#修改失败，提示“请输入相同的密码”
	assert_equal($userManage_editUser_diffPWD_errCode,@driver.userCenter_userManage_editUser_errCode.when_present($waitTime).text,"确认密码与新密码不一致的提示信息异常")
	@driver.close_currWindow_with_X.click
	#注销系统，确认:0;取消：1
	@driver.logout()
 end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end