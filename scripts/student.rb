require 'bundler'
Bundler.require
require_relative '../dm_config'
require_relative 'import.rb'
$validStudent=Array.new
def dataImport
  puts ""
  puts "Student:"
  path=ARGV[1]
  if path == nil
    path='../excel/Student.xlsx'
    puts "Default Path has been considered :"+path
  end
  student_Data=DDImporter.new(path)
  student_Data.open
  student_Data.extract('Sheet1')
  dataImport=student_Data.data_collection
  for data in dataImport
    srn = data[clean('SRN')]
    first_name = data[clean('First Name')]
    middle_name = data[clean('Middle Name')]
    last_name = data[clean('Last Name')]
    phone_number = data[clean('Phone Number')]
    dob = data[clean('DOB')]
    section = data[clean('Section')]
    semester = data[clean('Semester')]
    sex = clean(data[clean('Sex')])[/[mf]/]
    if sex == nil 
      return "Error! Sex should be m or f cannot be left blank"
    end
    course_name = data[clean('Course')]
    department_name = data[clean('Department')]
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
        $validStudent.push s
      else
        return error_concat(s)
      end
    end
  end
  return nil
end
def save
  $validStudent.each do |data|
    data.save
  end
end
def error_concat(obj)
  e = "The following errors were encountered\n"
  obj.errors.each do |error|
    e+="\n"+error
  end
  e+="\n"+"None of the Records were saved."
  return e
end
