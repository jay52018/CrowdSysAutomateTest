#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_taskConfig_editPVGCamera_invalidName_fail_162_002
# 用例标题: 修改pvg摄像机名称为包含非法字符的名称
# 预置条件: 
#	1.管理员账号已进入任务配置页面
#	2.已添加名称为“camera_1”的pvg摄像机
# 测试步骤:
#	1.在左边树列表中点击摄像机“camera_1”的编辑图标
#	2.将名称修改为：“$pv?*d@d”
#	3.点击“保存”按钮
# 预期结果:
#	1.弹出“摄像机配置”窗口；名称默认显示为：“camera_1”
#	3.修改失败，提示：“您输入的数据含有非法字符！请重新输入”
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

  def test_RQ_taskConfig_editPVGCamera_invalidName_fail_162_002
	#使用管理员账号登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConf_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#为了能定位到左边树列表中摄像机旁的修改小图标，使其高亮显示
	@driver.taskConfig_leftList_hoverCamera($specialCharacterTask_row).when_present($waitTime).hover
	#高亮后，点击编辑小图标
	@driver.taskConfig_editTask_btn($specialCharacterTask_row).when_present($waitTime).click
	#将名称修改为"pv?*d@d"
	20.times { @driver.simlate_sendkeys(:backspace) }
	@driver.simlate_sendkeys("$","p","v","？","*","d","@","d")
	#确认修改
	@driver.curr_time.click
	#弹出提示：您输入的数据含有非法字符！请重新输入
	assert_equal($taskConfig_editPvgCamera_invalidName_errCode,@driver.taskConfig_editCamera_errCode.when_present($waitTime).text,'将摄像机名称修改为空，提示信息异常')
	
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end