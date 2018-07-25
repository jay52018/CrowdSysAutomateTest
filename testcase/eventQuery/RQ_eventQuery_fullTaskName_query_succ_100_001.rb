﻿#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_eventQuery_fullTaskName_query_succ_100_001
# 用例标题: 完整关键字查询存在的摄像机名
# 预置条件: 
#	1.管理员账号已进入事件查询页面
#	2.已启用摄像机名为“基础视频”的摄像机且已产生事件
# 测试步骤:
#	1.在查询输入框输入：基础视频；点选“基础视频”
#	2.点击“查询”按钮
#	3.查看事件列表
# 预期结果:
#	1.查询结果返回包含“基础视频”关键字的摄像机名
#	3.事件列表中只显示摄像机名为“基础视频”的事件
# 脚本作者: kangting
# 写作日期: 20161222
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

  def test_RQ_eventQuery_fullTaskName_query_succ_100_001
	#登录系统
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#进入到事件查询页面
	@driver.event_query.when_present($waitTime).click
	#判断存在“查询”按钮，则进入事件查询页面成功
	assert(@driver.assert_enterEventQuery_element.when_present($waitTime).present?,"进入到事件查询页面失败")
	#在查询输入框中输入：基础视频
	@driver.eventQuery_taskName_textField.set($basicTaskName_space)
	#下拉框返回摄像机名称：基础视频
	assert_equal($basicTaskName,@driver.eventQuery_taskName_return.when_present($waitTime).text,"错误，关键字查询下拉框未返回相应摄像机名称")
	#点击查询按钮
	@driver.eventQuery_query_btn.click
	#事件列表中显示任务“基础视频”的事件
	assert(@driver.eventQuery_eventPicture(1).when_present($waitTime).present?,"查询事件失败，事件列表为空")
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end