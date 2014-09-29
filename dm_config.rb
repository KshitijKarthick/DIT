require 'dm-constraints'
require_relative './models/course'
require_relative './models/department'
require_relative './models/lecture_series'
require_relative './models/enrollment'
require_relative './models/exam'
require_relative './models/faculty'
require_relative './models/score'
require_relative './models/student'
require_relative './models/subject'
require_relative './models/weekly_attendance'





configure :development do
	DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{File.dirname(File.expand_path(__FILE__))}/development.sqlite")
 end
 configure :production do
 	DataMapper.setup(:default, ENV['DATABASE_URL'])
 end

DataMapper.finalize
DataMapper.auto_upgrade!
