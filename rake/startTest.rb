require 'mail'
require 'FileUtils'
require 'pathname'
require 'crowdSysENV'
require 'crowdSysAction'
require 'crowdSystem'
require 'uri'
require 'time'
require 'net/ssh'


1.times do


@driver = CrowdAction.new(@dr)
#将服务器时间与客户端时间同步
puts "start synchronizing time ··· ···"
@driver.exec_commond_in_server("yum install -y ntpdate;cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime;ntpdate us.pool.ntp.org;date")
puts "PC time:#{`Echo %Date% %Time%`}"
puts "synchronizing time finished"

curr_time = Time.now.strftime("%Y%m%d%H%M%S")

#保证输出报告开关打开
if $debugLog != ''
	File.open("#{File.dirname(__FILE__)}/../lib/crowdSysENV.rb") do |line|
		buffer = line.read.force_encoding('utf-8').sub(/.debugLog\s*=\s*.*/,"$debugLog = ''")
		File.open("#{File.dirname(__FILE__)}/../lib/crowdSysENV.rb","w") { |fw| fw.write(buffer) }
	end 
end

load "../lib/crowdSysENV.rb"
puts $debugLog



############### 执行用例 ###########
system("rake -q -X")


#方便调试，跑完之后还原日志开关
if $debugLog == ''
	File.open("#{File.dirname(__FILE__)}/../lib/crowdSysENV.rb") do |line|
		buffer = line.read.force_encoding('utf-8').sub(/.debugLog\s*=\s*.*/,"$debugLog = '1'")
		File.open("#{File.dirname(__FILE__)}/../lib/crowdSysENV.rb","w") { |fw| fw.write(buffer) }
	end 
end
load "../lib/crowdSysENV.rb"


#############  备份历史测试报告 #######
if File.exist?($testReportDir+'/index.html')
	Dir.mkdir("#{$testReportDir}/#{curr_time}") if !File.directory?("#{$testReportDir}/#{curr_time}")
	FileUtils.cp $testReportDir+'/index.html',"#{$testReportDir}/#{curr_time}"
	FileUtils.mv( $testReportDir+'/index_new.html', $testReportDir+'/index.html' )
end


############## 开始发送邮件 #########
##获取执行结果数据
File.readlines($testReportDir+'\index.html').each{ |line|	
	$testCaseNum = line.force_encoding('utf-8').scan(/\d+\s*tests/) if line.force_encoding('utf-8')=~/span class=".*">\d+\s*tests/
	$assertionsNum = line.force_encoding('utf-8').scan(/\d+\s*assertions/) if line.force_encoding('utf-8')=~/span class=".*">\s*\d+\sassertions/
	$failuresNum = line.force_encoding('utf-8').scan(/\d+\s*failures/) if line.force_encoding('utf-8')=~/span class=".*">\s*\d+\s*failures/
	$errorsNum = line.force_encoding('utf-8').scan(/\d+\s*errors/) if line.force_encoding('utf-8')=~/span class=".*">\s*\d+\s*errors/
	$skipsNum = line.force_encoding('utf-8').scan(/\d+\s*skips/) if line.force_encoding('utf-8')=~/span class=".*">\s*\d+\s*skips/
	$finishTime = line.force_encoding('utf-8').scan(/finished in .+?s/).to_s.sub('["','').sub('"]','') if line.force_encoding('utf-8')=~/finished in/
	}
	
$pwd = Pathname.new(__FILE__).realpath.dirname
File.readlines("#{$pwd}/startTest.ini").each{ |line|
	@username = line.sub(/.+\s*=\s*/,'').chomp if line=~/username\s*=/
	@passwd = line.sub(/.+\s*=\s*/,'').chomp if line=~/passwd\s*=/
	@smtpaddress = line.sub(/.+\s*=\s*/,'').chomp if line=~/smtpaddress\s*=/
	@port = line.sub(/.+\s*=\s*/,'').chomp if line=~/port\s*=/
	@domain = line.sub(/.+\s*=\s*/,'').chomp if line=~/domain\s*=/
	$from = line.sub(/.+\s*=\s*/,'').chomp if line=~/from\s*=/
	$to = line.sub(/.+\s*=\s*/,'').chomp if line=~/to\s*=/
	}


smtp = { :address => @smtpaddress, :port => @port, :domain => @domain, :user_name => @username, :password => @passwd, :enable_starttls_auto => true, :openssl_verify_mode => 'none' }
Mail.defaults { delivery_method :smtp, smtp }
mail = Mail.new do
  from $from
  to $to
  subject "【#{$crowdSysVersionNum}】Crowd System AutomationTest Reports #{curr_time}."
  body "\n\nAutomation test #{$finishTime}.\n\n\n\n#{$testCaseNum},#{$assertionsNum},#{$failuresNum},#{$errorsNum},#{$skipsNum}\n\n\n\nDetail reports: http://172.17.2.44:9527/reports/index\n\n\n\nSystem under test: #{$crowdSysURL}"
end
mail.deliver!

end

system('pause')
