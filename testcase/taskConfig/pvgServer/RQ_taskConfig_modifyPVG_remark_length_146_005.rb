#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_taskConfig_modifyPVG_remark_length_146_005
# 用例标题: 修改pvg视频服务器备注长度超过100个字符
# 预置条件: 
#	1.管理员账号已进入任务配置页面
#	2.已弹出pvg视频服务器“172.17.2.32”的编辑窗口
# 测试步骤:
#	1.将备注修改为11组“0123456789”
#	2.点击“保存”按钮
# 预期结果:
#	1.修改备注失败，只能输入10组“0123456789”
#	2.修改成功，提示：“修改成功！”；备注只保留10组“0123456789”
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

  def test_RQ_taskConfig_modifyPVG_remark_length_146_005
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
	#输入：名称、IP、端口号、用户名、密码
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
	#将备注修改为11组“0123456789”
	@driver.taskConfig_taskServer_remark_textArea.set('01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789')
	#点击“保存”按钮
	@driver.taskConfig_editTaskServer_saveBtn.click
	#检查弹出提示：“修改成功！”
	assert_equal($taskConfig_editPvgServer_succMessage,@driver.taskConfig_addTaskServer_message.when_present($waitTime).text,'修改视频服务器名称，提示信息异常')
	
	#查看备注信息，只保留10组“0123456789”
	@driver.taskConfig_treeList_videoName($pvgName).click
	assert_equal('0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789',@driver.taskConfig_taskServer_remark_textArea.when_present($waitTime).value,'错误，保留的备注超过100个字符！')
	#关闭窗口
	@driver.close_currWindow_with_X.click
	
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