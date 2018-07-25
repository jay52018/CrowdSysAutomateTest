#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_importAuth_noFile_fail_092_001
# 用例标题: 未选择文件点击导入
# 预置条件: 
#	1.管理员用户已进入授权管理界面
#	2.点击“导入授权”按钮
# 测试步骤:
#	1.点击“导入”按钮
# 预期结果:
#	1.弹出提示：请选择文件!
# 脚本作者: kangting
# 写作日期: 20161008
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

  def test_RQ_userCenter_importAuth_noFile_fail_092_001
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#进入到授权管理页面
	@driver.userNameToAuthManage
	#检查当前页面存在授权管理标题，即认为成功跳转到授权管理页面
	assert(@driver.userCenter_authManage_title.when_present($waitTime).present?,"未跳转到授权管理页面")
	#点击“导入授权”按钮
	@driver.userCenter_authManage_importAuth_btn.when_present($waitTime).click
	#等待导入授权对话框呈现
	@driver.userCenter_authManage_importAuthFile_dialog.wait_until_present($waitTime)
	@driver.userCenter_authManage_importCommit_btn.wait_until_present($waitTime)
	#判断是否弹出导入授权文件对话框
	assert(@driver.userCenter_authManage_importCommit_btn.present?,"未弹出导入授权文件对话框")
	#点击“导入”
	@driver.userCenter_authManage_importCommit_btn.when_present($waitTime).click
	#弹出提示：请选择文件!
	assert_equal($authManage_noFile_errCode,@driver.userCenter_authManage_importNullFile_errCode.when_present($waitTime).text,"空授权文件导入，提示信息异常")
	#点击“X”关闭窗口
	@driver.close_currWindow_with_X.when_present($waitTime).click
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end