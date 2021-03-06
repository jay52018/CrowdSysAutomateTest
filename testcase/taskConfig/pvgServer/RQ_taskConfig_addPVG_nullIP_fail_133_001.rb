﻿#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_taskConfig_addPVG_nullIP_fail_133_001
# 用例标题: 添加IP地址为空的pvg视频服务器
# 预置条件: 
#	1.管理员账号已进入任务配置页面
#	2.已弹出“添加PVG”窗口
# 测试步骤:
#	1.输入名称：172.17.2.32
#	2.输入端口：2100
#	3.输入用户名：admin
#	4.输入密码：admin
#	5.点击“确定”按钮
# 预期结果:
#	5.添加失败，提示：“IP地址不能为空！”
# 脚本作者: kangting
# 写作日期: 20161122
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

  def test_RQ_taskConfig_addPVG_nullIP_fail_133_001
	#使用管理员账号登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConf_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#添加pvg视频
	#进入到添加视频服务器窗口
	@driver.taskConfig_more_addCameraServer
	#检查存在窗口中的PVG按钮，认为弹出“添加PVG” 窗口成功
	assert(@driver.taskConfig_addTaskServer_addPvgBtn.when_present($waitTime).present?,"添加pvg失败，未弹出添加pvg窗口")
	#输入：名称、端口号、用户名、密码
	@driver.taskConfig_addPVG($pvgName,'',$pvgPort,$pvgAccount,$pvgPWD)
	#点击“确定”按钮
	@driver.taskConfig_addTaskServer_addPvg_submitBtn.click
	#检查弹出提示：“IP地址不能为空！”
	assert_equal($taskConfig_addPvgServer_nullIP_errCode,@driver.taskConfig_addTaskServer_errCode.when_present($waitTime).text,'添加IP地址为空的pvg，提示信息异常')
	#关闭添加窗口
	@driver.close_currWindow_with_X.when_present($waitTime).click
	#验证窗口关闭
	assert_equal('false',@driver.taskConfig_addTaskServer_addPvgBtn.present?.to_s,"关闭添加视频服务器窗口失败")
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end