﻿#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_taskConfig_addPVG_fail_131_002
# 用例标题: 不输入必填项添加PVG视频服务器
# 预置条件: 
#	1.管理员账号已进入任务配置页面
#	2.已弹出“添加PVG”窗口
# 测试步骤:
#	1.点击“确定”按钮
# 预期结果:
#	1.添加失败，提示：“名称不能为空！”
# 脚本作者: kangting
# 写作日期: 20161124
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

  def test_RQ_taskConfig_addPVG_fail_131_002
	#使用管理员账号登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConf_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#添加pvg视频
	#进入到添加视频服务器窗口
	@driver.taskConfig_more_addCameraServer
	#检查存在窗口中的PVG按钮，认为弹出“添加PVG” 窗口成功
	assert(@driver.taskConfig_addTaskServer_addPvgBtn.when_present($waitTime).present?,"添加pvg失败，未弹出添加pvg窗口")
	#点击"确定"按钮
	@driver.taskConfig_addTaskServer_addPvg_submitBtn.when_present($waitTime).click
	#检查弹出提示：“名称不能为空！”
	assert_equal($taskConfig_addPvgServer_nullName_errCode,@driver.taskConfig_addTaskServer_errCode.when_present($waitTime).text,'添加名称为空的pvg，提示信息异常')
	#关闭添加窗口
	@driver.close_currWindow_with_X.when_present($waitTime).click
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end