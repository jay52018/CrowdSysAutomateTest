﻿#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_taskConfig_strandingAreaDrawing_triggerValue_invalid_234_004
# 用例标题: 设置触发人群滞留事件阈值为非数字
# 预置条件: 
#	1.管理员账号已进入任务配置页面
#	2.已添加名称为“基础视频”的摄像机
#	3.已进入到“基础视频”的详细配置界面
# 测试步骤:
#	1.在触发人群滞留事件阈值输入框输入：a<*><??
# 预期结果:
#	1.输入“a<*><??”失败
# 脚本作者: kangting
# 写作日期: 20161209
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

  def test_RQ_taskConfig_strandingAreaDrawing_triggerValue_invalid_234_004
	#使用管理员账号登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConf_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#在任务列表中点击配置“基础视频”
	@driver.taskConfig_clickTaskName_cameraConf($basicTaskName).when_present($waitTime).click
	#检查存在任务名称：基础视频，即认为成功跳转到任务详细配置页面
	assert_equal($basicTaskName,@driver.taskConfig_cameraConf_cameraName.when_present($waitTime).text,'点击配置失败，未跳转到任务详细配置页面')
	#输入触发滞留事件阈值：a<*><??
	@driver.taskConfig_strandingAreaDraw_triggerThreshold_textField.set('a<*><??')
	#输入“a<*><??”失败
	assert_equal('',@driver.taskConfig_strandingAreaDraw_triggerThreshold_textField.value,'错误！可输入触发滞留事件阈值为非数字')
	#点击“取消”按钮
	@driver.taskConfig_cameraConf_cancelBtn.when_present($waitTime).click
	#回到任务配置页面
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"取消失败，未回到任务配置页面")
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end