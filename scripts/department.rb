require 'bundler'
Bundler.require
require_relative 'import.rb'
require_relative '../dm_config'
Department_Data=DDImporter.new('../excel/Department.xlsx')
Department_Data.open
Department_Data.extract('Sheet1')
dataImport=Department_Data.data_collection
for data in dataImport
  name = data['Department Name'.chomp.downcase.strip].chomp.downcase.strip
  d = Department.first(:name => name)
  if !d
    d = Department.new(:name => name)
    if d.valid?
      d.save
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
