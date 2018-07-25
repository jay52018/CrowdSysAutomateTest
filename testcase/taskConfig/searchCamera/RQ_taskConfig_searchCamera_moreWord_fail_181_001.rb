#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_taskConfig_searchCamera_moreWord_fail_181_001
# 用例标题: 关键字搜索比已存在的完整摄像机名后多一个字符的摄像机
# 预置条件: 
#	1.管理员账号已进入任务配置页面
#	2.已添加名称为“camera_1”的摄像机
# 测试步骤:
#	1.在左边树列表上的搜索框中输入关键字：camera_12
#	2.下发搜索动作
# 预期结果:
#	1.下拉框显示：无
#	2.左边树列表显示默认值
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

  def test_RQ_taskConfig_searchCamera_moreWord_fail_181_001
	#使用管理员账号登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConf_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#输入关键字搜索摄像机
	@driver.taskConfig_keyWord_searchCamera_textField.when_present($waitTime).set('camera_12')
	#检查返回“无”
	assert_equal('无',@driver.taskConfig_keyWord_searchCamera_return.when_present($waitTime).text,'输入关键字后，应返回无')
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end