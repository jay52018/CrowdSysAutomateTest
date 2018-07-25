#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_taskConfig_modifyRtsp_rtspName_succ_147_001
# 用例标题: 修改rtsp视频服务器名称
# 预置条件: 
#	1.管理员账号已进入任务配置页面
#	2.已配置启用地址为：“rtsp://10.0.10.200:8557/H264”，名称为“RTSP”的rtsp任务
# 测试步骤:
#	1.点击左边树列表中的“rtsp视频”
#	2.将名称修改为：“rtsp视频总称”
#	3.点击“保存”按钮
# 预期结果:
#	1.弹出“rtsp视频”编辑窗口，默认显示名称：rtsp视频
#	3.修改成功，弹出提示：“修改成功！”；左边树列表中的rtsp视频名显示为：“rtsp视频总称”
# 脚本作者: kangting
# 写作日期: 20161129
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

  def test_RQ_taskConfig_modifyRtsp_rtspName_succ_147_001
	#使用管理员账号登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConf_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#清空视频服务器，保持系统干净
	@driver.clearVideoServer($rtspName)
	#检查左边树列表中应清空的RTSP视频服务器，即认为RTSP视频服务器删除成功
	assert_equal('false',@driver.taskConfig_treeList_videoName($rtspName).present?.to_s,"清除失败，树列表中仍存在RTSP视频服务器")
	
	#添加rtsp视频
	#进入到添加视频服务器窗口
	@driver.taskConfig_more_addCameraServer
	#检查存在窗口中的PVG按钮，认为弹出添加视频服务器窗口成功
	assert(@driver.taskConfig_addTaskServer_addPvgBtn.when_present($waitTime).present?,"未弹出添加视频服务器窗口")
	#输入必填项，添加rtsp视频服务器
	@driver.taskConfig_addRtsp($rtspTaskName,$rtspURL)
	#点击“确定”
	@driver.taskConfig_addTaskServer_addRtsp_commitBtn.click
	#检查弹出提示：“视频添加成功！”
	assert_equal($taskConfig_addRtsp_succMessage,@driver.taskConfig_addTaskServer_message.when_present($waitTime).text,'添加rtsp视频服务器失败，提示信息异常')
	#检查左边树列表中存在名称为“RTSP”的rtsp视频任务
	assert(@driver.taskConfig_treeList_videoName($rtspName).when_present($waitTime).present?,'错误！左边数列表中没有新增的rtsp视频任务')
	
	#点击左边树列表中的“rtsp视频”
	@driver.taskConfig_treeList_videoName($rtspName).click
	#弹出rtsp视频服务器编辑窗口
	assert_equal($rtspName,@driver.taskConfig_editTaskServer_dialog_title.when_present($waitTime).text,'rtsp视频服务器窗口异常')
	#将名称修改为“rtsp视频总称”
	@driver.taskConfig_editTaskServer_serverName_textField.when_present($waitTime).set('rtsp视频总称')
	#点击“保存”按钮
	@driver.taskConfig_editTaskServer_saveBtn.click
	#弹出提示：修改成功！
	assert_equal($taskConfig_editRtspServer_succMessage,@driver.taskConfig_addTaskServer_message.when_present($waitTime).text,'修改rtsp视频服务器失败，提示信息异常')
	
	#删除rtsp，初始化
	@driver.taskConfig_deleteVideoServer("rtsp视频总称",0,1)
	#弹出提示删除成功 
	assert_equal($taskConfig_deleteVideoServer_succMessage,@driver.taskConfig_addTaskServer_message.when_present($waitTime).text,"删除rtsp视频服务器失败，提示信息异常")
	#检查左边树列表中不存在名称为“rtsp视频”的rtsp视频服务器，即认为rtsp视频服务器删除成功
	assert_equal('false',@driver.taskConfig_treeList_videoName("rtsp视频总称").present?.to_s,"还原失败，树列表中仍存在rtsp视频服务器")

	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end