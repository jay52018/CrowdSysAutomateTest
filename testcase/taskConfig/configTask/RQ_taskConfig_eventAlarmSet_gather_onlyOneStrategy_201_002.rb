#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_taskConfig_eventAlarmSet_gather_onlyOneStrategy_201_002
# 用例标题: 事件报警设置聚集事件仅可选取一个策略
# 预置条件: 
#	1.管理员账号已进入任务配置页面
#	2.已添加名称为“基础视频”的摄像机
#	3.已进入到“基础视频”的详细配置界面
# 测试步骤:
#	1.在事件报警设置中，对聚集事件配置“闪橙光”策略
#	2.对聚集事件再配置“闪黄光”策略
# 预期结果:
#	1.聚集一行的“闪橙光”高亮显示
#	2.聚集一行的“闪黄光”高亮显示，上次设置的“闪橙光”由高亮变为非高亮
# 脚本作者: kangting
# 写作日期: 20161206
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

  def test_RQ_taskConfig_eventAlarmSet_gather_onlyOneStrategy_201_002
	#使用管理员账号登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConf_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#在任务列表中点击配置“基础视频”
	@driver.taskConfig_clickTaskName_cameraConf($basicTaskName).when_present($waitTime).click
	#检查存在任务名称：基础视频，即认为成功跳转到任务详细配置页面
	assert_equal($basicTaskName,@driver.taskConfig_cameraConf_cameraName.when_present($waitTime).text,'点击配置失败，未跳转到任务详细配置页面')
	#在事件报警设置中，对聚集事件配置“闪橙光”策略（第二行第二列）
	@driver.taskConfig_eventAlarmSet_btn(2,2).when_present($waitTime).click
	#聚集一行中的“闪橙光”高亮显示
	assert_equal("selected",@driver.taskConfig_eventAlarmSet_btn(2,2).attribute_value(:class),"错误！聚集一行中的闪橙光未高亮显示")
	#对聚集事件再配置“闪黄光”策略
	@driver.taskConfig_eventAlarmSet_btn(2,3).when_present($waitTime).click
	#聚集一行中的“闪橙光”非高亮显示
	assert_equal("",@driver.taskConfig_eventAlarmSet_btn(2,2).attribute_value(:class),"错误！聚集一行中的闪橙光仍然高亮显示")
	#聚集一行中的“闪黄光”高亮显示
	assert_equal("selected",@driver.taskConfig_eventAlarmSet_btn(2,3).attribute_value(:class),"错误！聚集一行中的闪黄光未高亮显示")

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