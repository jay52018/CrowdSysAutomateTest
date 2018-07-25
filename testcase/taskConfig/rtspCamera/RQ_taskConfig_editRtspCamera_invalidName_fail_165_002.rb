#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_taskConfig_editRtspCamera_invalidName_fail_165_002
# 用例标题: 修改rtsp摄像机名称为包含非法字符的名称
# 预置条件: 
#	1.管理员账号已进入任务配置页面
#	2.已添加名称为“RTSP”的rtsp摄像机
# 测试步骤:
#	1.在左边树列表中点击rtsp摄像机“RTSP”的编辑图标
#	2.将名称修改为：“$r@?*”
#	3.点击“保存”按钮
# 预期结果:
#	1.弹出“摄像机配置”窗口；名称默认显示为“RTSP”
#	3.修改失败，提示：“您输入的数据含有非法字符！请重新输入”
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

  def test_RQ_taskConfig_editRtspCamera_invalidName_fail_165_002
	#使用管理员账号登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConf_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#清空视频服务器，保持系统干净
	@driver.clearVideoServer($rtspName)
	#检查左边树列表中应清空的RTSP视频服务器，即认为RTSP视频服务器删除成功
	assert_equal('false',@driver.taskConfig_treeList_videoName($rtspName).present?.to_s,"清除失败，树列表中仍存在RTSP视频服务器")
	
	#添加名称为“RTSP”的rtsp摄像机
	@driver.taskConfig_addRtsp_basicTask
	#输入关键字搜索摄像机
	@driver.taskConfig_keyWord_searchCamera_textField.when_present($waitTime).set($rtspTaskName)
	#检查返回包含关键字的摄像机名
	assert_equal($rtspTaskName,@driver.taskConfig_keyWord_searchCamera_return.when_present($waitTime).text,'输入关键字后，无相应摄像机名返回')
	#点击返回的摄像机名，下发搜索动作
	@driver.taskConfig_keyWord_searchCamera_return.when_present($waitTime).click
	#~ sleep 2
	#左边树列表中的“RTSP”高亮显示
	assert_equal($leftLIst_cameraClassValue,@driver.taskConfig_leftList_searchCamera_attributeClass($rtsp_row).attribute_value(:class),'错误！搜索的摄像机未高亮显示')
	#高亮后，点击编辑小图标
	@driver.taskConfig_editTask_btn($rtsp_row).click

	#将名称修改为“$r@?*”
	20.times { @driver.simlate_sendkeys(:backspace) }
	@driver.simlate_sendkeys("$","r","@","？","*")
	#确认修改
	@driver.curr_time.click
	#弹出提示：您输入的数据含有非法字符！请重新输入
	assert_equal($taskConfig_editRtspCamera_invalidName_errCode,@driver.taskConfig_editCamera_errCode.when_present($waitTime).text,'将摄像机名称修改为含有非法字符的名称，提示信息异常')
	
	#删除rtsp，初始化
	@driver.taskConfig_deleteVideoServer($rtspName,0,1)
	#弹出提示删除成功 
	assert_equal($taskConfig_deleteVideoServer_succMessage,@driver.taskConfig_addTaskServer_message.when_present($waitTime).text,"删除rtsp视频服务器失败，提示信息异常")
	#检查左边树列表中不存在名称为“rtsp视频”的rtsp视频服务器，即认为rtsp视频服务器删除成功
	assert_equal('false',@driver.taskConfig_treeList_videoName($rtspName).present?.to_s,"还原失败，树列表中仍存在rtsp视频服务器")

	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end