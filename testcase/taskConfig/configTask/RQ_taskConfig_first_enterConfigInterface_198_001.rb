#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_taskConfig_first_enterConfigInterface_198_001
# 用例标题: 初次配置一路摄像机播放视频截图进入绘制界面
# 预置条件: 
#	1.管理员账号已进入任务配置页面
#	2.已添加名称为“标准视频”的摄像机
# 测试步骤:
#	1.点击左边树列表中的“标准视频”名称
#	2.播放视频，点击“截图”按钮
# 预期结果:
#	1.播放“标准视频”的单路原始视频
#	2.跳转到“标准视频”的详细任务配置界面
# 脚本作者: kangting
# 写作日期: 20170204
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

  def test_RQ_taskConfig_first_enterConfigInterface_198_001
	#使用管理员账号登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConf_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#在左边树列表中，点击“标准视频”摄像机
	@driver.taskConfig_treeList_videoName($standardTaskName).when_present($waitTime).click
	#进入到任务配置截图页面
	assert(@driver.taskconfig_screenshot_btn.when_present($waitTime).present?,'无截图按钮，进入到截图页面失败')
	
	#使“播放”图标呈现
	@driver.taskConfig_capture_img.hover
	#点击“播放”，播放原始视频
	@driver.taskconfig_cameraPlay_btn.when_present($waitTime).click
	#为了给校验视频播放时间
	sleep 1
	#点击“截图按钮”
	@driver.taskconfig_screenshot_btn.when_present($waitTime).click
	#检查存在任务名称：标准视频，即认为成功跳转到任务详细配置页面
	assert_equal($standardTaskName,@driver.taskConfig_cameraConf_cameraName.when_present($waitTime).text,'点击截图失败，未跳转到任务详细配置页面')
	
	#点击“取消”
	@driver.taskConfig_cameraConf_cancelBtn.when_present($waitTime).click
	#检查窗口关闭
	assert_equal('false',@driver.taskconfig_screenshot_btn.present?.to_s,'退出截图页面失败')
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end