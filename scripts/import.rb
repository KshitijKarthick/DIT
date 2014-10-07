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
    header.map! {|header_name|clean header_name}
    2.upto(file.last_row) do |i|
      row = Hash[[header, file.row(i)].transpose]
      # row.delete "id"
      row.keys.each do |key|
        row[key]=clean row[key]
      end
      @data_collection.push(row)
    end
  end
end

def clean(data)
  if data.class == Date
    return data
  end
  if data.class == String
    return data.chomp.downcase.strip
  elsif data.class == Fixnum
    return data.to_s.chomp.downcase.strip
  elsif data.class == Float
      return data.to_i
    #elsif data.class == NilClass
    #  return ''
    #
  end
end