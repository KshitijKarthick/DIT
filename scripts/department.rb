require 'bundler'
Bundler.require
require_relative 'import.rb'
require_relative '../dm_config'
$validDepartment=Array.new
def dataImport
  puts ""
  puts "Department:"
  path=ARGV[1]
  if path == nil
    path='../excel/Department.xlsx'
    puts "Default Path has been considered :"+path
  end
  department_Data=DDImporter.new(path)
  department_Data.open
  department_Data.extract('Sheet1')
  dataImport=department_Data.data_collection
  for data in dataImport
    name = data[clean('Department Name')]
    d = Department.first(:name => name)
    if !d
      d = Department.new(:name => name)
      if d.valid?
        $validDepartment.push d
      else
        return error_concat(d)
      end
    end
  end
  return nil
end
def save
  $validDepartment.each do |data|
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
