require 'bundler'
Bundler.require
require_relative '../dm_config'
require_relative 'import.rb'
Course_Data=DDImporter.new('../excel/Course.xlsx')
Course_Data.open
Course_Data.extract('Sheet1')
dataImport=Course_Data.data_collection
for data in dataImport
  name = data['Course Name'.chomp.downcase.strip].chomp.downcase.strip
  c = Course.first(:name => name)
  if !c
    c = Course.new(:name => name)
    if c.valid?
      c.save
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
