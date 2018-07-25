#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_taskConfig_addPVG_lengthPVGName_fail_132_002
# 用例标题: 添加名称长度大于20的pvg视频服务器
# 预置条件: 
#	1.管理员账号已进入任务配置页面
#	2.已弹出“添加PVG”窗口
# 测试步骤:
#	1.输入长度为21的名称：123456789012345678901
#	2.输入IP地址:172.17.2.32
#	3.输入端口：2100
#	4.输入用户名：admin
#	5.输入密码：admin
#	6.点击“确定”按钮
# 预期结果:
#	1.名称输入失败，输入框只保留前20个字符
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

  def test_RQ_taskConfig_addPVG_lengthPVGName_fail_132_002
	#使用管理员账号登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConf_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#清空多余pvg，保持系统干净
	@driver.clearVideoServer($pvgName)
	#检查左边树列表中应清空的pvg视频服务器，即认为pvg视频服务器删除成功
	assert_equal('false',@driver.taskConfig_treeList_videoName($pvgName).present?.to_s,"清除失败，树列表中仍存在pvg视频服务器")
	#添加pvg视频
	#进入到添加视频服务器窗口
	@driver.taskConfig_more_addCameraServer
	#检查存在窗口中的PVG按钮，认为弹出“添加PVG” 窗口成功
	assert(@driver.taskConfig_addTaskServer_addPvgBtn.when_present($waitTime).present?,"添加pvg失败，未弹出添加pvg窗口")
	#输入必填项：长度大于20的pvg名称、IP、端口号、用户名、密码，点击“确定”
	@driver.taskConfig_addPVG("123456789012345678901",$pvgIP,$pvgPort,$pvgAccount,$pvgPWD)
	#点击“确定”按钮
	@driver.taskConfig_addTaskServer_addPvg_submitBtn.click
	#检查弹出提示：“视频服务器添加成功！”
	assert_equal($taskConfig_addVideoServer_succMessage,@driver.taskConfig_addTaskServer_message.when_present($waitTime).text,'添加pvg视频服务器失败，提示信息异常')
	#检查左边树列表中新增服务器的名称只保留前20位：“12345678901234567890”
	assert(@driver.taskConfig_treeList_videoName("12345678901234567890").when_present($waitTime).present?,'错误！左边树列表中新增的pvg视频服务器名称异常')
	
	#删除pvg，初始化
	@driver.taskConfig_deleteVideoServer("12345678901234567890",0,1)
	#弹出提示删除成功 
	assert_equal($taskConfig_deleteVideoServer_succMessage,@driver.taskConfig_addTaskServer_message.when_present($waitTime).text,"删除pvg视频服务器失败，提示信息异常")
	#检查左边树列表中存在名称为“172.17.2.32”的pvg，即认为pvg视频服务器添加成功
	assert_equal('false',@driver.taskConfig_treeList_videoName($pvgName).present?.to_s,"还原失败，树列表中仍存在pvg视频服务器")

	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end