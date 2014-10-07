require 'bundler'
Bundler.require
require_relative '../dm_config'
require_relative 'import.rb'
$validSubject=Array.new
def dataImport
  puts ""
  puts "Subject:"
  path=ARGV[1]
  if path == nil
    path='../excel/Subject.xlsx'
    puts "Default Path has been considered :"+path
  end
  subject_Data=DDImporter.new(path)
  subject_Data.open
  subject_Data.extract('Sheet1')
  dataImport=subject_Data.data_collection
  for data in dataImport
    code = data[clean('Subject Code')]
    name = data[clean('Subject Name')]
    semester = data[clean('Semester')]
    course_name = data[clean('Course')]
    department_name = data[clean('Department')]
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
        $validSubject.push s
      else
        return error_concat(s)
      end
    end
  end
  return nil
end
def save
  $validSubject.each do |data|
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

