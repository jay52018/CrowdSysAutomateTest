#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID:RQ_userCenter_filterTrace_admin_addPVG_073_013
# 用例标题: 过滤管理员的新增PVG视频服务器日志
# 预置条件: 
#	1.使用管理员账号产生新增PVG视频服务器动作
#	2.管理员已进入操作日志界面
# 测试步骤:
#	1.点击“用户”下拉框，勾选“系统管理员”
#	2.点击“动作”下拉框，勾选“新增PVG视频服务器”动作
#	3.进行提交
#	4.查看日志列表
# 预期结果:
#	4.成功过滤，日志列表中只显示系统管理员的新增PVG视频服务器操作日志信息
# 脚本作者: kangting
# 写作日期: 20161221
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

  def test_RQ_userCenter_filterTrace_admin_addPVG_073_013
	#清空所有操作日志
	@driver.mongoDB_clear_operateLog
	#使用管理员账户登录
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
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
	#记录添加PVG视频服务器的时间
	addPvgTime = @driver.time_now
	#检查左边树列表中存在名称为“172.17.2.32”的pvg，即认为pvg视频服务器添加成功
	assert(@driver.taskConfig_treeList_videoName($pvgName).when_present($waitTime).present?,'错误！左边数列表中没有新增的pvg视频服务器')
	
	#删除pvg，初始化
	@driver.taskConfig_deleteVideoServer($pvgName,0,1)
	#弹出提示删除成功 
	assert_equal($taskConfig_deleteVideoServer_succMessage,@driver.taskConfig_addTaskServer_message.when_present($waitTime).text,"删除pvg视频服务器失败，提示信息异常")
	#检查左边树列表中不存在名称为“172.17.2.32”的pvg，即认为pvg视频服务器删除成功
	assert_equal('false',@driver.taskConfig_treeList_videoName($pvgName).present?.to_s,"还原失败，树列表中仍存在pvg视频服务器")
	
	#进入到操作日志界面
	@driver.userNameToTrace
	#检查是否存在模块名：操作日志
	assert(@driver.userCenter_trace_title.when_present($waitTime).present?,"跳转到操作日志界面失败！")
	#过滤系统管理员修改用户信息操作的日志
	@driver.userCenter_filterOperateLog_withUserName('系统管理员')
	@driver.userCenter_filterOperateLog_withAction('新增pvg视频服务器')
	
	#查看操作日志信息列表中的日志是否正确
	#判断操作日志记录时间与实际操作时间的偏差
	operateLog_recordTime = @driver.operateLog_recordTime(0)
	@driver.logTime_operateTime_deviation(addPvgTime,operateLog_recordTime,'addPvgTime')
	#断言操作日志列表中的用户名为：admin
	assert_equal($adminAccount,@driver.userCenter_trace_operateLogList_index(1).when_present($waitTime).text,'用户名与操作日志中不一致！')
	#断言操作日志列表中的用户姓名为：系统管理员
	assert_equal($adminName,@driver.userCenter_trace_operateLogList_index(2).when_present($waitTime).text,'用户姓名与操作日志中不一致！')
	#断言操作日志列表中的动作为：新增pvg视频服务器[172.17.2.32]成功
	assert_equal("新增pvg视频服务器[#{$pvgName}]成功",@driver.userCenter_trace_operateLogList_index(3).when_present($waitTime).text,'动作与操作日志中不一致！')
	
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end