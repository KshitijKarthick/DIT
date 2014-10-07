require 'bundler'
Bundler.require
require_relative 'import.rb'
require_relative '../dm_config'
$validFaculty=Array.new
def dataImport
  puts ""
  puts "Faculty:"
  path=ARGV[1]
  if path == nil
    path='../excel/Faculty.xlsx'
    puts"Default Path has been considered :"+path
  end
  faculty_Data=DDImporter.new(path)
  faculty_Data.open
  faculty_Data.extract('Sheet1')
  dataImport=faculty_Data.data_collection
  for data in dataImport
    name = data[clean('Faculty Name')]
    phone_number = data[clean('Phone Number')]
    f = Faculty.first(:name => name,:phone_number => phone_number)
    if !f
      f = Faculty.new(:name => name,:phone_number => phone_number)
      if f.valid?
        $validFaculty.push f
      else
        return error_concat(f)
      end
    end
  end
  return nil
end
def save
  $validFaculty.each do |data|
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

