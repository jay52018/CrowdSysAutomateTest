
#-------------------公共-------------------#

#调试日志输出开关
$debugLog = '1'
#测试浏览器 firefox (firefox :ff, internet_explorer :ie , :chrome, :phantomjs)
$testBrowser = :chrome
#人群系统地址
$crowdSysURL = 'http://172.17.3.54:555'
#人群系统版本号
$crowdSysVersionNum = "V2.3.0.1038"
#服务端主机的用户名
$server_hostName = 'root'
#服务端主机的密码
$server_hostPWD = 'root'
#测试报告标题
$testReportTitle = "CrowdSysAutoTestResults(#{Time.now.strftime("%m%d%H%M")})"
#测试报告目录
$testReportDir = 'C:\AutoTest\rails\testReport\app\views\reports'
#工程目录
$projectDir = File.expand_path(".", __FILE__).scan(/.+crowdSystem-1.0.0/).join(',')
#等待元素出现的超时时间
$waitTime = 4
#授权文件路径
$authPath = 'C:\\Ruby22-x64\\lib\\ruby\\gems\\2.2.0\\gems\\crowdSystem-1.0.0\\temp\\authFile\\'
#操作日志记录时间偏差
$logTime_deviation = 30
#基础视频的名称
$basicTaskName = "基础视频"
#查询基础视频时需加一个空格才有返回值
$basicTaskName_space = "基础视频 "


#-----------------账号密码----------------#

#人群系统登录管理员账号
$adminAccount = 'admin'
#人群系统登录管理员密码
$adminPasswd = '123456'
#人群系统管理员姓名
$adminName = "系统管理员"
#修改管理员姓名
$modifyAdminName = "管理员姓名"
#人群系统登录普通账号
$guestAccount = 'user'
#人群系统登录普通密码
$guestPasswd = '123456'
#人群系统普通账户姓名
$guestName = "普通用户"
#修改普通姓名
$modifyGuestName = "普通姓名"
#新增用户普通账号
$newUserAccount = 'who'
#新增用户用户姓名
$newUserName = "新用户"
#新增用户普通密码
$newUserPassWd = ''

#--------------------pvg--------------------#

#PVG的名称
$pvgName = '172.17.3.39'
#pvg视频服务器在左边树列表中所在的行数
$pvgServer_row = 1
#PVG的IP
$pvgIP = '172.17.3.39'
#PVG的端口
$pvgPort = '2100'
#PVG的用户名
$pvgAccount = 'admin'
#PVG的密码
$pvgPWD = 'admin'
#固定pvg视频服务器在左边树列表中所在的行数
$pvgName_basic_row = 1

#--------------------rtsp-------------------#

#rtsp视频服务器的名称
$rtspName = "rtsp视频"
#rtsp视频服务器在左边树列表中所在的行数
$rtspServer_row = 2
#新增一路rtsp任务的名称
$rtspTaskName = 'RTSP'
#"RTSP"视频在左边树列表中所在的行数
$rtsp_row = 3
#rtsp的URL
$rtspURL = "rtsp://10.0.10.200:8557/H264"

#-------------------mongoDB-----------------#

#mongoDB需要操作的数据库
$mongoDB = 'sensenets1'
#mongoDB port
$mongoDBport = '9062'
#mongoDB需要操作的集合
$mongoColl = :OperateLog

#-------------------任务配置----------------#

#任务详细配置中的安全级别分档表格数据
$safetySettingData = 
"安全级别 最小值 最大值
很安全 80 100
安全 60 80
不安全 40 60
很不安全 0 40"

#任务配置页面，左边树列表中的摄像机高亮显示后的class值
$leftLIst_cameraClassValue = 'level1 curSelectedNode'

#标准视频的名称
$standardTaskName = "标准视频"
#标准视频在左边树列表中所在的行数
$standardTask_row = 4

#带下划线的摄像机名称
$cameraName_specialCharacter = 'camera_1'
#带下划线的摄像机在左边树列表中所在的行数
$specialCharacterTask_row = 8

#定义错误码

#------------------------------------登录----------------------------------------#

#空账号登录，返回的错误码
$login_nullAcc_errCode  = '用户名不能为空！'
#错误账号或密码登录，返回的错误码
$login_errData_errCode  = '用户名或密码错误，请重试！'
#空密码登录，返回的错误码
$login_nullPwd_errCode  = '密码不能为空！'

#----------------------------用户管理（添加新用户）------------------------------#

#在用户管理界面，添加新用户成功后返回的提示信息
$userManage_addUser_succMessage = '用户添加成功！'
#在用户管理界面，添加重复的用户名，返回的错误码
$userManage_addUser_sameUser_errCode = '用户名不能重复！'
#在用户管理界面，添加重复的用户姓名，返回的错误码
$userManage_addUser_sameUserName_errCode = '用户姓名不能重复！'
#在用户管理界面，添加用户名为空的用户，返回的错误码
$userManage_addUser_NullUserId_errCode = '用户名不能为空'
#在用户管理界面，添加用户姓名为空的用户，返回的错误码
$userManage_addUser_NullUserName_errCode = '用户姓名不能为空'
#在用户管理界面，添加用户名含非法字符的用户，返回的错误码
$userManage_addUser_invalidUserId_errCode = '请输入正确的用户名'
#在用户管理界面，添加用户姓名含非法字符的用户，返回的错误码
$userManage_addUser_invalidUserName_errCode = '用户姓名含非法字符'
#在用户管理界面，添加用户名长度不合法的用户，返回的错误码
$userManage_addUser_longUserId_errCode = '用户名长度应在1-20个字符之间'
#在用户管理界面，添加用户姓名长度不合法的用户，返回的错误码
$userManage_addUser_longUserName_errCode = '长度应限制在20个字符内'

#--------------------------用户管理（删除/编辑用户）----------------------------#

#在用户管理界面，删除用户成功后返回的提示信息
$userManage_deleteUser_succMessage = '删除用户成功'
#在用户管理界面，修改用户信息成功后返回的提示信息
$userManage_editUserName_succ = '修改用户信息成功！'
#在用户管理界面，修改用户的用户姓名为空，返回的错误码
$userManage_editUser_NullUserName_errCode = '用户姓名不能为空'
#在用户管理界面，修改用户的用户姓名为包含非法字符的名称，返回的错误码
$userManage_editUser_invalidUserName_errCode = '用户姓名含非法字符'
#在用户管理界面，修改用户的密码为不合法长度的密码，返回的错误码
$userManage_editUser_lengthPWD_errCode = '密码长度应限制在6-20个字符之间'
#在用户管理界面，修改用户的密码，确认密码与新密码不一致返回的错误码
$userManage_editUser_diffPWD_errCode = '请输入相同的密码'
#在用户管理界面，修改用户的密码为包含非法字符的密码，返回的错误码
$userManage_editUser_invalidPWD_errCode = '密码含非法字符'
#在用户管理界面，修改用户的密码，新密码与原密码相同，返回的错误码
$userManage_editUser_samePWD_errCode = '不能与原密码相同'

#---------------------------------授权管理--------------------------------------#

#在授权管理界面，导入空文件点击“导入”时返回的错误码
$authManage_noFile_errCode = '请选择文件!' 
#在授权管理界面，导入授权文件成功后，返回的提示信息
$authManage_authSucc_message = '授权成功！'

#---------------------------------密码修改--------------------------------------#

#在密码修改界面，修改密码成功后返回的提示信息
$modifyPWD_succ_message = '密码修改成功！'
#在密码修改界面，确认密码与新密码不一致时返回的错误码
$modifyPWD_diffPWD_errCode = '请输入相同的密码!'
#在密码修改界面，原密码/新密码长度长度不合法时返回的错误码
$modifyPWD_lengthPWD_errCode = '密码长度应在6到20位!'
#在密码修改界面，任一密码输入框为空，提交时返回的错误码
$modifyPWD_nullPWD_errCode = '密码不能为空!'
#在密码修改界面，任一密码包含特殊字符，提交时返回的错误码
$modifyPWD_invalidPWD_errCode = '密码包含特殊字符！'

#------------------------------添加视频服务器-----------------------------------#

#任务配置页面，添加视频服务器（pvg）成功返回的提示信息
$taskConfig_addVideoServer_succMessage = '视频服务器添加成功！'
#任务配置页面，删除视频服务器（pvg/rtsp）成功返回的提示信息
$taskConfig_deleteVideoServer_succMessage = '视频服务器删除成功！'

#任务配置页面，添加已存在的pvg视频服务器返回的错误码
$taskConfig_addPvgServer_exist_errCode = '该视频服务器已添加！'
#任务配置页面，添加名称为空的pvg视频服务器返回的错误码
$taskConfig_addPvgServer_nullName_errCode = '名称不能为空！'
#任务配置页面，添加名称包含非法字符的pvg视频服务器返回的错误码
$taskConfig_addPvgServer_invalidName_errCode = '名称格式不正确，请修改！'
#任务配置页面，添加IP地址为空的pvg视频服务器返回的错误码
$taskConfig_addPvgServer_nullIP_errCode = 'IP地址不能为空！'
#任务配置页面，添加IP地址格式不正确的pvg视频服务器返回的错误码
$taskConfig_addPvgServer_invalidIP_errCode = 'ip地址格式不正确，请修改！'
#任务配置页面，添加IP地址或端口号错误的pvg视频服务器返回的错误码
$taskConfig_addPvgServer_errIP_or_errPort_errCode = 'IP地址或端口错误！'
#任务配置页面，添加空端口号的pvg视频服务器返回的错误码
$taskConfig_addPvgServer_nullPort_errCode = '端口不能为空！'
#任务配置页面，添加端口号为非法格式的pvg视频服务器返回的错误码
$taskConfig_addPvgServer_invalidPort_errCode = '端口格式不正确，请修改！'
#任务配置页面，添加用户名为空的pvg视频服务器返回的错误码
$taskConfig_addPvgServer_nullAccout_errCode = '用户名不能为空！'
#任务配置页面，添加用户名或密码错误的pvg视频服务器返回的错误码
$taskConfig_addPvgServer_errAccout_or_errPWD_errCode = '用户名或密码错误！'
#任务配置页面，添加密码为空的pvg视频服务器返回的错误码
$taskConfig_addPvgServer_nullPWD_errCode = '密码不能为空！'

#任务配置页面，添加rtsp视频成功，返回的提示信息
$taskConfig_addRtsp_succMessage = '视频添加成功！'
#任务配置页面，添加已存在的rtsp视频，返回的错误码
$taskConfig_addRtsp_exist_errCode = '该视频已添加！'
#任务配置页面，添加名称为空的rtsp视频，返回的错误码
$taskConfig_addRtsp_nullName_errCode = '视频名称不能为空！'
#任务配置页面，添加名称包含非法字符的rtsp视频，返回的错误码
$taskConfig_addRtsp_invalidName_errCode = '名称格式不正确，请修改！'
#任务配置页面，添加错误URL的rtsp视频，返回的所有错误码
$taskConfig_addRtsp_URL_errCode = 'rtsp路径不正确'

#-----------------------------编辑视频服务器-----------------------------------#

#任务配置页面，同步pvg视频服务器成功返回的提示信息 
$taskConfig_editPvgServer_update_succMessage = '视频服务器刷新成功！'
#任务配置页面，修改pvg视频服务器成功返回的提示信息
$taskConfig_editPvgServer_succMessage = '修改成功！'
#任务配置页面，将pvg视频服务器名称修改为包含非法字符的名称，返回的错误码
$taskConfig_editPvgServer_invalidName_errCode = '名称格式不正确，请修改！'
#任务配置页面，将pvg视频服务器名称修改为空，返回的错误码
$taskConfig_editPvgServer_nullName_errCode = '名称不能为空！'

#任务配置页面，将rtsp视频服务器名称修改为空，返回的错误码
$taskConfig_editRtspServer_nullName_errCode = '视频名称不能为空！'
#任务配置页面，将rtsp视频服务器名称修改为包含非法字符的名称，返回的错误码
$taskConfig_editRtspServer_invalidName_errCode = '名称格式不正确，请修改！'
#任务配置页面，修改rtsp视频服务器任意信息成功后返回的提示信息
$taskConfig_editRtspServer_succMessage = '修改成功！'

#--------------------------------编辑摄像机------------------------------------#

#任务配置页面，将pvg摄像机名称修改为空，返回的错误码
$taskConfig_editPvgCamera_nullName_errCode = '摄像机的名称不能为空'
#任务配置页面，将pvg摄像机名称修改为含非法字符的名称，返回的错误码
$taskConfig_editPvgCamera_invalidName_errCode = '您输入的数据含有非法字符！请重新输入'

#任务配置页面，将rtsp摄像机名称修改为空，返回的错误码
$taskConfig_editRtspCamera_nullName_errCode = '摄像机的名称不能为空'
#任务配置页面，将rtsp摄像机名称修改为含非法字符的名称，返回的错误码
$taskConfig_editRtspCamera_invalidName_errCode = '您输入的数据含有非法字符！请重新输入'
#任务配置页面，将rtsp摄像机路径修改为空，返回的错误码
$taskConfig_editRtspCamera_nullURL_errCode = 'rtsp路径不正确'
#任务配置页面，将rtsp摄像机路径修改为错误的路径，返回的错误码
$taskConfig_editRtspCamera_errURL_errCode = 'rtsp路径不正确'

#-------------------------------任务详细配置-----------------------------------#

#任务配置页面，编辑左边树列表中的摄像机，修改成功后返回的提示信息
$taskConfig_editCamera_succMessage = '修改成功！'

#-------------------------------任务详细配置-----------------------------------#

#任务详细配置页面，配置任务保存成功后的提示信息
$taskConfig_configureTask_succMessage = '保存成功！'
#任务详细配置页面，设置触发过密事件阈值不正确，返回的错误码
$taskConfig_configureTask_dense_errTriggerThreshold_errCode = '触发人群过密事件阈值必须大于0%且小于100%！'
#任务详细配置页面，设置触发过密事件阈值为空，返回的错误码
$taskConfig_configureTask_dense_nullTriggerThreshold_errCode = '触发人群过密事件阈值不能为空 ！'
#任务详细配置页面，设置触发聚集事件阈值大于10000，返回的错误码
$taskConfig_configureTask_gather_errTriggerThreshold_errCode = '触发人群聚集事件阈值不能大于10000！'
#任务详细配置页面，设置触发聚集事件阈值等于0，返回的错误码
$taskConfig_configureTask_gather_lessTriggerThreshold_errCode = '触发人群聚集事件阈值不能为空 ！'
#任务详细配置页面，设置触发聚集事件阈值为空，返回的错误码
$taskConfig_configureTask_gather_nullTriggerThreshold_errCode = '触发人群聚集事件阈值不能为空 ！'
#任务详细配置页面，设置触发聚集事件阈值大于10000，返回的错误码
$taskConfig_configureTask_stranding_errTriggerThreshold_errCode = '触发人群滞留事件阈值不能大于36000秒！'
#任务详细配置页面，设置触发聚集事件阈值等于0，返回的错误码
$taskConfig_configureTask_stranding_lessTriggerThreshold_errCode = '触发人群滞留事件阈值不能为空！'
#任务详细配置页面，设置触发聚集事件阈值为空，返回的错误码
$taskConfig_configureTask_stranding_nullTriggerThreshold_errCode = '触发人群滞留事件阈值不能为空！'


#---------------安全级别---------------#

#很安全的最大值大于100
$taskConfig_safetySetting_verySafeMax_errCode = '很安全最大值必须为100！'
$taskConfig_safetySetting_verySafeMin_errCode = '第1行最大值不能小于等于最小值！'
$taskConfig_safetySetting_verySafeMin_safeMax_diff_errCode = '第1行的最小值必须等于第2行的最大值！'
$taskConfig_safetySetting_safeMin_errCode = '第2行最大值不能小于等于最小值！'
$taskConfig_safetySetting_safeMin_unsafeMax_diff_errCode = '第2行的最小值必须等于第3行的最大值！'
$taskConfig_safetySetting_unsafeMin_errCode = '第3行最大值不能小于等于最小值！'
$taskConfig_safetySetting_unsafeMin_veryUnsafeMax_diff_errCode = '第3行的最小值必须等于第4行的最大值！'
$taskConfig_safetySetting_veryUnsafeMin_errCode = '第4行最大值不能小于等于最小值！'







