#========================================================
#+++++++++++++++++  测试用例信息   ++++++++++++++++
# 用例  ID: RQ_userCenter_userManage_searchUser_fail_051_001
# 用例标题: 搜索比已存在的完整用户名后多一个字符的关键字
# 预置条件: 
#	1.管理员已进入用户管理界面
# 测试步骤:
#	1.在搜索框中输入“普通用户1”
#	2.点击“搜索”
# 预期结果:
#	1.无结果返回
#	2.用户列表无信息显示
# 脚本作者: kangting
# 写作日期: 20161014
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

  def test_RQ_userCenter_userManage_searchUser_fail_051_001
	#使用管理员账号登录系统
	@driver.login($adminAccount,$adminPasswd)
	#登录后，检查当前页面存在assert_enterTaskConfig_element元素，即认为登录成功
	assert(@driver.assert_enterTaskConfig_element.when_present($waitTime).present?,"登录失败，未跳转到指定页面")
	#进入到用户管理界面
	@driver.userNameToUserManage
	#检查当前页面存在模块名称：用户管理
	assert(@driver.userCenter_userManage_title.when_present($waitTime).present?,"未跳转到用户管理页面")
	#初始化用户名列表数据
	@driver.resore_defaultUser
	#在搜索框中输入“普通用户1”
	@driver.userCenter_userManage_filterField.set("普通用户1")
	#无返回包含“普通用户1”关键字的用户
	if @driver.userCenter_userManage_keyWordReturn.present?
		assert_equal('false',@driver.userCenter_userManage_keyWordReturn.present?.to_s,"错误！返回包含“普通用户1”关键字的用户：#{@driver.userCenter_userManage_keyWordReturn.text}")
	end
	#点击“搜索”按钮
	@driver.userCenter_userManage_searchBtn.click
	#检查用户列表中无包含“普通用户1”关键字的用户信息
	assert_equal('false',@driver.userCenter_userManage_userListInf_index(0).present?.to_s,"错误！用户列表中存在用户名为“普通用户1”的用户信息")
	assert_equal('false',@driver.userCenter_userManage_userListInf_index(1).present?.to_s,"错误！用户列表中存在用户姓名为“普通用户1”的用户信息")
	#注销系统，确认:0;取消：1
	@driver.logout()
  end

  def teardown
	#关闭浏览器
	@driver.close_browser
  end
end