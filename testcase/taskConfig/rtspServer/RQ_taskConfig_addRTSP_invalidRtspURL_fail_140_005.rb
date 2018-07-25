#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_taskConfig_addRTSP_invalidRtspURL_fail_140_005
# 用例标题: 添加rtsp路径包含非法字符的rtsp视频服务器
# 预置条件: 
#	1.管理员账号已进入任务配置页面
#	2.已弹出“添加RTSP”窗口
# 测试步骤:
#	1.输入名称：RTSP
#	2.输入RTSP路径：“r￥@&”
#	3.点击“确定”按钮
# 预期结果:
#	3.添加失败，提示：“rtsp路径不正确”
# 脚本作者: kangting
# 写作日期: 20161124
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

  def test_RQ_taskConfig_addRTSP_invalidRtspURL_fail_140_005
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
	@driver.taskConfig_addRtsp($rtspTaskName,'r￥@&')
	#点击“确定”
	@driver.taskConfig_addTaskServer_addRtsp_commitBtn.when_present($waitTime).click
	#检查弹出提示：“rtsp路径不正确”
	assert_equal($taskConfig_addRtsp_URL_errCode,@driver.taskConfig_addTaskServer_errCode.when_present($waitTime).text,'添加名称包含非法字符的rtsp视频，提示信息异常')
	#关闭添加窗口
	@driver.close_currWindow_with_X.when_present($waitTime).click
	#检查窗口关闭
	assert_equal('false',@driver.taskConfig_addTaskServer_addRtsp_commitBtn.present?.to_s,"错误！添加rtsp视频窗口未关闭")
	
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end