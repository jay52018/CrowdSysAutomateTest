﻿#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_userManage_editPwd_longPWD_fail_058_002
# 用例标题: 将密码修改为由21个字符组成的密码
# 预置条件: 
#	1.管理员已进入用户管理界面
# 测试步骤:
#	1.在用户列表中点击用户名为“admin”一栏的“编辑”按钮
#	2.在“修改密码”输入框输入21个：a
#	3.在“确认密码”输入框输入21个：a
#	4.点击“确认修改”按钮
# 预期结果:
#	1.弹出“用户编辑”窗口
#	4.修改失败，提示“密码长度应限制在6-20个字符之间”
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

  def test_RQ_userCenter_userManage_editPwd_longPWD_fail_058_002
	#使用管理员账号登录系统
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#进入到用户管理界面
	@driver.userNameToUserManage
	#检查当前页面存在模块名称：用户管理
	assert(@driver.userCenter_userManage_title.when_present($waitTime).present?,"未跳转到用户管理页面")
	#将admin用户的密码修改为21个“a”
	@driver.userManage_modifyUser(0,$adminName,'aaaaaaaaaaaaaaaaaaaaa','aaaaaaaaaaaaaaaaaaaaa')
	#修改失败，提示“密码长度应限制在6-20个字符之间”
	assert_equal($userManage_editUser_lengthPWD_errCode,@driver.userCenter_userManage_editUser_errCode.when_present($waitTime).text,"修改密码大于20位，提示信息异常")
	@driver.close_currWindow_with_X.click
	#注销系统，确认:0;取消：1
	@driver.logout()
 end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end