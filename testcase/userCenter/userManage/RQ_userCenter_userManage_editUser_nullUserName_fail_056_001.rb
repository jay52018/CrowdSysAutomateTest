#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_userManage_editUser_nullUserName_fail_056_001
# 用例标题: 修改为空的用户姓名
# 预置条件: 
#	1.管理员已进入用户管理界面
# 测试步骤:
#	1.在用户列表中点击用户名为“user”一栏的“编辑”按钮
#	2.删除用户姓名
#	3.点击“确认修改”按钮
# 预期结果:
#	1.弹出“用户编辑”窗口
#	2.修改失败，提示“用户姓名不能为空”
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

  def test_RQ_userCenter_userManage_editUser_nullUserName_fail_056_001
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
	#在用户列表中点击用户名为“user”一栏的“编辑”按钮，即第2个“编辑”按钮
	@driver.userCenter_userManage_editUser_btn(2).click
	#弹出用户编辑窗口
	assert(@driver.userCenter_userManage_editUserNameField.when_present($waitTime).present?,"编辑用户失败，未弹出用户编辑窗口！")
	#“用户姓名”输入框中默认显示“普通用户”
	assert_equal($guestName,@driver.userCenter_userManage_editUserNameField.when_present($waitTime).value,"用户姓名”输入框中显示错误")
	#清除已存在的用户姓名
	@driver.userCenter_userManage_editUserNameField.clear
	#点击“确认修改”按钮
	@driver.userCenter_userManage_modifyCommit_btn.click
	#提示用户姓名不能为空
	assert_equal($userManage_editUser_NullUserName_errCode,@driver.userCenter_userManage_editUser_errCode.when_present($waitTime).text,"修改为空的用户姓名的提示信息异常")
	#关闭窗口
	@driver.close_currWindow_with_X.click
	#注销系统，确认:0;取消：1
	@driver.logout()
 end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end