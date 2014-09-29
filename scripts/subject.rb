require 'bundler'
Bundler.require
require_relative '../dm_config'
require_relative 'import.rb'
Subject_Data=DDImporter.new('../excel/Subject.xlsx')
Subject_Data.open
Subject_Data.extract('Sheet1')
dataImport=Subject_Data.data_collection
for data in dataImport
  code = data['Subject Code'.chomp.downcase.strip].chomp.downcase.strip
  name = data['Subject Name'.chomp.downcase.strip].chomp.downcase.strip
  semester = data['Semester'.chomp.downcase.strip].to_s.chomp.downcase.strip
  course_name = data['Course'.chomp.downcase.strip].chomp.downcase.strip
  department_name = data['Department'.chomp.downcase.strip].chomp.downcase.strip
  s = Subject.first(:code => code)
  if !s
    s = Subject.new(:code => code,:name => name,:semester => semester)
    c = Course.first(:name => course_name)
    d = Department.first(:name => department_name)
    c.subjects << s
    d.subjects << s
    c.save
    d.save
    if s.valid?
      s.save
    else
      puts "Data is invalid"
      s.errors.each do |error|
        puts error
      end
      puts "Please rerun all data entries from the specified data for Successfull data storage."
      break
    end
  end
end
