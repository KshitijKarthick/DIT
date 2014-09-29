require 'roo'
class DDImporter
  attr_accessor :file
  attr_accessor :data_collection
  def initialize(path)
    @path = path
  end

  def open
    @file = Roo::Excelx.new(@path)
  end
  def extract(sheet_name)
    @file.default_sheet = sheet_name
    @data_collection=Array.new
    header = file.row 1
    header.map! {|header_name| header_name.chomp.downcase.strip}
    2.upto(file.last_row) do |i|
      row = Hash[[header, file.row(i)].transpose]
      # row.delete "id"
      @data_collection.push(row)
    end
  end
end
