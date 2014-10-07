require 'bundler'
Bundler.require
require_relative '../dm_config'
require_relative 'import.rb'
$validCourse=Array.new
def dataImport
  puts ""
  puts "Course:"
  path=ARGV[1]
  if path == nil
    path='../excel/Course.xlsx'
    puts "Default Path has been considered :"+path
  end
  course_Data=DDImporter.new(path)
  course_Data.open
  course_Data.extract('Sheet1')
  dataImport=course_Data.data_collection
  for data in dataImport
    name = data[clean('Course Name')]
    c = Course.first(:name => name)
    if !c
      c = Course.new(:name => name)
      if c.valid?
        $validCourse.push c
      else
        puts "test"
        return error_concat(c)
      end
    end
  end
  return nil
end
def save
  $validCourse.each do |data|
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

