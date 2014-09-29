require 'bundler'
Bundler.require
require_relative '../dm_config'
require_relative 'import.rb'
Student_Data=DDImporter.new('../excel/Student.xlsx')
Student_Data.open
Student_Data.extract('Sheet1')
dataImport=Student_Data.data_collection
for data in dataImport
  srn = data['SRN'.chomp.downcase.strip].chomp.downcase.strip
  first_name = data['First Name'.chomp.downcase.strip].chomp.downcase.strip
  middle_name = data['Middle Name'.chomp.downcase.strip].to_s.chomp.downcase.strip
  last_name = data['Last Name'.chomp.downcase.strip].to_s.chomp.downcase.strip
  phone_number = data['Phone Number'.chomp.downcase.strip].to_s.chomp.downcase.strip[/[0-9]*/]
  dob = data['DOB'.chomp.downcase.strip].to_s.chomp.downcase.strip
  section = data['Section'.chomp.downcase.strip].chomp.downcase.strip
  semester = data['Semester'.chomp.downcase.strip].to_s.chomp.downcase.strip
  sex = data['Sex'.chomp.downcase.strip].chomp.downcase.strip
  course_name = data['Course'.chomp.downcase.strip].chomp.downcase.strip
  department_name = data['Department'.chomp.downcase.strip].chomp.downcase.strip
  s = Student.get(srn)
  if !s
    s = Student.new(:srn => srn,:first_name => first_name,:middle_name => middle_name,:last_name => last_name,:phone_number => phone_number,:dob => dob,:section => section,:semester => semester,:sex => sex)
    c = Course.first(:name => course_name)
    d = Department.first(:name => department_name)
    c.students << s
    d.students << s
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
