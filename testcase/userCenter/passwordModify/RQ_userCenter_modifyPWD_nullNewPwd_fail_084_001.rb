﻿#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_modifyPWD_nullNewPwd_fail_084_001
# 用例标题: 输入空的新密码
# 预置条件: 
#	1.管理员用户已进入密码修改界面
# 测试步骤:
#	1.输入原密码：123456
#	2.确认密码：0123456
#	3.点击“确认修改”
# 预期结果:
#	3.密码修改失败；提示“密码不能为空！”
# 脚本作者: kangting
# 写作日期: 20161010
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

  def test_RQ_userCenter_modifyPWD_nullNewPwd_fail_084_001
	#使用管理员账户登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#进入到密码修改页面
	@driver.userNameToPWDModify
	#检查当前页面存在密码修改模块名，即认为成功跳转到密码修改页面
	assert(@driver.userCenter_modifyPWD_title.when_present($waitTime).present?,"未跳转到密码修改页面")
	#输入原密码：123456
	@driver.userCenter_modifyPWD_originPWDField.set($adminPasswd)
	#输入确认密码：0123456
	@driver.userCenter_modifyPWD_newPWD_confirmField.set("0123456")
	#点击“确认修改”按钮
	@driver.userCenter_modifyPWD_submmitBtn.click
	#弹出提示：密码不能为空！
	assert_equal($modifyPWD_nullPWD_errCode,@driver.userCenter_navig_modifyPWD_errCode.when_present($waitTime).text,"空新密码修改密码，提示信息异常")
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end