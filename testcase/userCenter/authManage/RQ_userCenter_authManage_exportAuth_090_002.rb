#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_exportAuth_090_002
# 用例标题: 导出授权
# 预置条件: 
#	1.管理员用户已进入授权管理界面
# 测试步骤:
#	1.点击“申请授权”按钮
#	2.点击“导出文件”按钮
# 预期结果:
#	2.文件导出成功
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

  def test_RQ_userCenter_exportAuth_090_002
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#进入到授权管理页面
	@driver.userNameToAuthManage
	#检查当前页面存在授权管理标题，即认为成功跳转到授权管理页面
	assert(@driver.userCenter_authManage_title.when_present($waitTime).present?,"未跳转到授权管理页面")
	#点击申请授权按钮申请授权
	@driver.userCenter_authManage_getAuth_btn.when_present($waitTime).click
	#删除下载目录下已存在的授权文件
	userName = `echo %USERNAME%`.chomp
	licensePath = "C:\\Users\\#{userName}\\Downloads\\hardware.zip"
	File.delete(licensePath) if File.exist?(licensePath)
	#判断下载目录中不存在license文件
	assert_equal('false',File.exist?(licensePath).to_s,"删除license文件失败，下载目录中仍有license文件")
	#点击导出文件按钮
	@driver.userCenter_authManage_exportAuth_btn.when_present($waitTime).click
	#等待license文件下载完成
	#~ sleep 4
	#判断是否成功导出授权文件
	Watir::Wait.until{ File.exist?(licensePath)}
	assert(File.exist?(licensePath),"下载目录中无license文件，导出失败！")
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end