#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_taskConfig_modifyPVG_invalidPVGName_fail_146_002
# 用例标题: 修改pvg视频服务器名称为包含非法字符的名称
# 预置条件: 
#	1.管理员账号已进入任务配置页面
#	2.已弹出pvg视频服务器“172.17.2.32”的编辑窗口
# 测试步骤:
#	1.将名称修改为：“-*pvg?”
#	2.点击“保存”按钮
# 预期结果:
#	2.修改失败，提示：“名称格式不正确，请修改！”
# 脚本作者: kangting
# 写作日期: 20161128
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

  def test_RQ_taskConfig_modifyPVG_invalidPVGName_fail_146_002
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
	#输入必填项：pvg名称、IP、端口号、用户名、密码
	@driver.taskConfig_addPVG($pvgName,$pvgIP,$pvgPort,$pvgAccount,$pvgPWD)
	#点击“确定”按钮
	@driver.taskConfig_addTaskServer_addPvg_submitBtn.click
	#检查弹出提示：“视频服务器添加成功！”
	assert_equal($taskConfig_addVideoServer_succMessage,@driver.taskConfig_addTaskServer_message.when_present($waitTime).text,'添加pvg视频服务器失败，提示信息异常')
	#检查左边树列表中存在名称为“172.17.2.32”的pvg，即认为pvg视频服务器添加成功
	assert(@driver.taskConfig_treeList_videoName($pvgName).when_present($waitTime).present?,'错误！左边树列表中没有新增的pvg视频服务器')
	
	#点击左边树列表中名称为172.17.2.32的pvg视频服务器
	@driver.taskConfig_treeList_videoName($pvgName).click
	#弹出pvg编辑窗口，名称默认显示为“172.17.2.32”
	assert_equal($pvgName,@driver.taskConfig_editTaskServer_serverName_textField.when_present($waitTime).value,"弹出#{$pvgName}的编辑窗口，名称未默认显示为#{$pvgName}")
	#将名称修改为：“-*pvg?”
	@driver.taskConfig_editTaskServer_serverName_textField.set('-*pvg?')
	#点击“保存”按钮
	@driver.taskConfig_editTaskServer_saveBtn.click
	#检查弹出提示：“名称格式不正确，请修改！”
	assert_equal($taskConfig_editPvgServer_invalidName_errCode,@driver.taskConfig_editTaskServer_errCode.when_present($waitTime).text,'将pvg视频服务名称修改为包含非法字符的名称，提示信息异常')
	#关闭添加窗口
	@driver.close_currWindow_with_X.click
	#验证窗口关闭
	assert_equal('false',@driver.taskConfig_editTaskServer_serverName_textField.present?.to_s,"关闭编辑视频服务器窗口失败")
	
	#删除pvg，初始化
	@driver.taskConfig_deleteVideoServer($pvgName,0,1)
	#弹出提示删除成功 
	assert_equal($taskConfig_deleteVideoServer_succMessage,@driver.taskConfig_addTaskServer_message.when_present($waitTime).text,"删除pvg视频服务器失败，提示信息异常")
	#检查左边树列表中不存在名称为“172.17.2.32”的pvg，即认为pvg视频服务器删除成功
	assert_equal('false',@driver.taskConfig_treeList_videoName($pvgName).present?.to_s,"还原失败，树列表中仍存在pvg视频服务器")

	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end