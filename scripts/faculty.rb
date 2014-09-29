require 'bundler'
Bundler.require
require_relative 'import.rb'
require_relative '../dm_config'
Faculty_Data=DDImporter.new('../excel/Faculty.xlsx')
Faculty_Data.open
Faculty_Data.extract('Sheet1')
dataImport=Faculty_Data.data_collection
for data in dataImport
  name = data['Faculty Name'.chomp.downcase.strip].chomp.downcase.strip
  phone_number = data['Phone Number'.chomp.downcase.strip].to_s.chomp.downcase.strip[/[0-9]*/]
  f = Faculty.first(:name => name,:phone_number => phone_number)
  if !f
    f = Faculty.new(:name => name,:phone_number => phone_number)
    if f.valid?
      f.save
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
