#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_taskConfig_searchCamera_exist_succ_180_001
# 用例标题: 完整关键字搜索存在的摄像机
# 预置条件: 
#	1.管理员账号已进入任务配置页面
#	2.已添加名称为“camera_1”的摄像机
# 测试步骤:
#	1.在左边树列表上的搜索框中输入关键字：camera_1
#	2.下发搜索动作
# 预期结果:
#	1.下拉框显示包含关键字“camera_1”的任务
#	2.在左边树列表中“camera_1”高亮显示
# 脚本作者: kangting
# 写作日期: 20161207
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

  def test_RQ_taskConfig_searchCamera_exist_succ_180_001
	#使用管理员账号登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConf_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#输入关键字搜索摄像机
	@driver.taskConfig_keyWord_searchCamera_textField.when_present($waitTime).set($cameraName_specialCharacter)
	#检查返回包含关键字的摄像机名
	assert_equal($cameraName_specialCharacter,@driver.taskConfig_keyWord_searchCamera_return.when_present($waitTime).text,'输入关键字后，无相应摄像机名返回')
	#点击返回的摄像机名，下发搜索动作
	@driver.taskConfig_keyWord_searchCamera_return.when_present($waitTime).click
	#左边树列表中的“camera_1”高亮显示
	assert_equal($leftLIst_cameraClassValue,@driver.taskConfig_leftList_searchCamera_attributeClass($specialCharacterTask_row).attribute_value(:class),'错误！搜索的摄像机未高亮显示')
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end