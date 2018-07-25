#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_taskConfig_eventAlarmSet_gather_cancel_noStrategy_201_003
# 用例标题: 取消事件报警设置聚集事件闪黄光（即选取0个策略）
# 预置条件: 
#	1.管理员账号已进入任务配置页面
#	2.已添加名称为“基础视频”的摄像机
#	3.已进入到“基础视频”的详细配置界面
# 测试步骤:
#	1.在事件报警设置中，对聚集事件配置“闪黄光”策略
#	2.再次点击“闪黄光”取消对聚集事件配置“闪黄光”策略
# 预期结果:
#	1.聚集一行的“闪黄光”高亮显示
#	2.取消成功，聚集一行“闪黄光”非高亮显示
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

  def test_RQ_taskConfig_eventAlarmSet_gather_cancel_noStrategy_201_003
	#使用管理员账号登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConf_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#在任务列表中点击配置“基础视频”
	@driver.taskConfig_clickTaskName_cameraConf($basicTaskName).when_present($waitTime).click
	#检查存在任务名称：基础视频，即认为成功跳转到任务详细配置页面
	assert_equal($basicTaskName,@driver.taskConfig_cameraConf_cameraName.when_present($waitTime).text,'点击配置失败，未跳转到任务详细配置页面')
	#在事件报警设置中，对聚集事件配置“闪黄光”策略（第二行第三列）
	@driver.taskConfig_eventAlarmSet_btn(2,3).when_present($waitTime).click
	#聚集一行中的“闪黄光”高亮显示
	assert_equal("selected",@driver.taskConfig_eventAlarmSet_btn(2,3).attribute_value(:class),"错误！聚集一行中的闪黄光未高亮显示")
	#再次点击，取消对聚集事件配置“闪黄光”策略
	@driver.taskConfig_eventAlarmSet_btn(2,3).when_present($waitTime).click
	#聚集一行中的“闪黄光”非高亮显示
	assert_equal("",@driver.taskConfig_eventAlarmSet_btn(2,3).attribute_value(:class),"错误！聚集一行中的闪黄光仍然高亮显示")
	#点击“保存”按钮
	@driver.taskConfig_cameraConf_saveBtn.when_present($waitTime).click
	#弹出提示：保存成功！
	assert_equal($taskConfig_configureTask_succMessage,@driver.taskConfig_addTaskServer_message.when_present($waitTime).text,"配置任务失败，提示信息异常")
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end