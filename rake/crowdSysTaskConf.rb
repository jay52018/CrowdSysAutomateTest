#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_login_succ_001_001
# 用例标题: 管理员账号登录成功
# 预置条件: 1.打开浏览器，进入系统登录界面
# 测试步骤:
#                 1.输入正确的管理员账号：admin和密码：123456；
#	      2.点击“登录”按钮
# 预期结果:
#                 2.登录成功，跳转到“任务配置”页面
# 脚本作者: kangting
# 写作日期: 20160921
#=========================================================
require 'crowdSysAction'
require_lib(1)

class CrowdSystemTest < MiniTest::Unit::TestCase
	
  def setup
	#实例化driver
	@driver = CrowdAction.new(@dr)
	@autoit = WIN32OLE.new('AutoItX3.Control')
	#前置条件
	@driver.precondition()
	#打开被测系统
	@driver.open_test_system($testBrowser,$crowdSysURL)
  end

  def test_RQ_taskConf
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在'摄像机选择框'，即认为登录成功并跳转到任务配置页面
	assert_equal(true,@driver.taskConf_select_camera.exist?,"当前页面不存在摄像机选择框")
	@driver.taskConf_treeList_cameraName("vs800_北区1号通道出口").wait_until_present
	@driver.taskConf_treeList_cameraName("vs800_北区1号通道出口").click
	sleep 2
	@driver.taskConf_treeList_cameraConf.click
	@driver.taskConf_navig_monitorAreaDraw.wait_until_present
	@driver.taskConf_navig_monitorAreaDraw.click
	@driver.taskConf_monitorAreaDraw_shieldAreaDraw_btn.click
	@autoit.MouseMove(200,200)
	@autoit.WinActivate("人群分析系统 - Google Chrome")
	@autoit.ControlClick('人群分析系统 - Google Chrome', '', '', 'left', 1, 784, 475)
	@autoit.ControlClick('人群分析系统 - Google Chrome', '', '', 'left', 1, 1070, 475)
	@autoit.ControlClick('人群分析系统 - Google Chrome', '', '', 'left', 1, 1111, 666)
	@autoit.ControlClick('人群分析系统 - Google Chrome', '', '', 'left', 2, 777, 666)
	@driver.taskConf_navig_monitorHeightDraw.click
	@driver.taskConf_navig_monitorAreaDraw.click
	@driver.taskConf_monitorAreaDraw_endDraw_btn.click
	@driver.taskConf_navig_monitorHeightDraw.click
	@autoit.MouseClickDrag("left", 829, 436, 853, 464)
	@autoit.MouseClickDrag("left", 887, 514, 909, 559)
	@autoit.MouseClickDrag("left", 877, 633, 911, 692)
	@driver.taskConf_navig_denseAreaDraw.click
	@driver.taskConf_denseAreaDraw_selectAll.click
	@driver.taskConf_navig_gatherAreaDraw.click
	@driver.taskConf_gatherAreaDraw_selectAll.click
	@driver.taskConf_navig_strandingAreaDraw.click
	@driver.taskConf_strandingAreaDraw_selectAll.click
	@driver.taskConf_navig_retrogradeAreaConf.click
	@driver.taskConf_retrogradeAreaConf_selectAll.click
	@driver.taskConf_retrogradeAreaConf_directionBtn("东北").click
	sleep 1
	
	#保存配置
	#~ @driver.taskConf_saveBtn.click
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
	#后置条件
	@driver.postcondition()
  end
end