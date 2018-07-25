#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_taskConfig_deletePVG_withoutReserveEvents_145_002
# 用例标题: 删除pvg视频服务器不保留事件
# 预置条件: 
#	1.管理员账号已进入任务配置页面
#	2.已添加名称为172.17.2.32和IP为172.17.2.32的PVG视频服务器
# 测试步骤:
#	1.在左边树列表中点击pvg视频服务器名称：“172.17.2.32”
#	2.点击“删除”按钮
#	3.点击“确定”按钮
#	4.点击“否”按钮
# 预期结果:
#	1.弹出pvg编辑窗口
#	2.弹出提示对话框：确定删除改视频服务器？
#	3.弹出提示对话框：是否保留相关的状态和事件信息？
#	4.弹出提示：视频服务器删除成功，在“事件查询”中不能查阅到相关的状态和事件信息
# 脚本作者: kangting
# 写作日期: 20161125
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

  def test_RQ_taskConfig_deletePVG_withoutReserveEvents_145_002
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
	
	#删除pvg
	#在左边树列表中点击视频服务器
	@driver.taskConfig_treeList_videoName($pvgName).click
	#弹出视频服务器编辑窗口
	assert(@driver.taskConfig_editTaskServer_dialog_title.when_present($waitTime).present?,'未弹出pvg编辑窗口')
	#点击删除按钮
	@driver.taskConfig_editTaskServer_deleteBtn.when_present($waitTime).click
	#弹出提示对话框：确定删除改视频服务器？
	assert(@driver.taskConfig_editTaskServer_confirmDialog_X.when_present($waitTime).present?,'未弹出删除pvg确认提示框')
	#点击确定 0 , 取消 1
	@driver.taskConfig_editTaskServer_delete_confirmBtn(0).when_present($waitTime).click
	#弹出提示对话框：是否保留相关的状态和事件信息？
	assert(@driver.taskConfig_editTaskServer_dialog_title.when_present($waitTime).present?,'未弹出确认保留事件对话框')
	#保留事件 是 0 , 否 1
	@driver.taskConfig_editTaskServer_delete_confirmBtn(1).when_present($waitTime).click
	#弹出提示：视频服务器删除成功
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