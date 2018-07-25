#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_taskConfig_addExistRtsp_fail_140_001
# 用例标题: 添加已存在的rtsp视频服务器
# 预置条件: 
#	1.管理员账号已进入任务配置页面
#	2.已存在路径为“rtsp://10.0.10.200:8557/H264”，名称为“RTSP”的RTSP视频
#	3.已弹出“添加RTSP”窗口
# 测试步骤:
#	1.输入名称：RTSP02
#	2.输入RTSP路径：rtsp://10.0.10.200:8557/H264
#	3.点击“确定”按钮
# 预期结果:
#	3.添加失败，提示“该视频已添加！”
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

  def test_RQ_taskConfig_addExistRtsp_fail_140_001
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
	
	#再次添加此rtsp视频
	#进入到添加视频服务器窗口
	@driver.taskConfig_more_addCameraServer
	#检查存在窗口中的PVG按钮，认为弹出添加视频服务器窗口成功
	assert(@driver.taskConfig_addTaskServer_addPvgBtn.when_present($waitTime).present?,"第二次弹出添加视频服务器窗口失败")
	#输入必填项，添加rtsp视频服务器
	@driver.taskConfig_addRtsp("RTSP02",$rtspURL)
	#点击“确定”
	@driver.taskConfig_addTaskServer_addRtsp_commitBtn.click
	#检查弹出提示：“该视频已添加！”
	assert_equal($taskConfig_addRtsp_exist_errCode,@driver.taskConfig_addTaskServer_message.when_present($waitTime).text,'添加已存在的rtsp视频的提示信息异常')
	#关闭添加窗口
	@driver.close_currWindow_with_X.when_present($waitTime).click
	#检查窗口关闭
	assert_equal('false',@driver.taskConfig_addTaskServer_addRtsp_commitBtn.present?.to_s,"错误！添加rtsp视频窗口未关闭")
	
	#删除rtsp，初始化
	@driver.taskConfig_deleteVideoServer($rtspName,0,1)
	#弹出提示删除成功 
	assert_equal($taskConfig_deleteVideoServer_succMessage,@driver.taskConfig_addTaskServer_message.when_present($waitTime).text,"删除pvg视频服务器失败，提示信息异常")
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