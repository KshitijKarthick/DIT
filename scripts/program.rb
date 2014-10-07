require_relative 'import.rb'
def storeData(script)
  require_relative script
  errors=dataImport
  if errors == nil
    save
    puts script.capitalize+' Details are Stored Succesfully.'
    return 0
  else 
    puts errors
    puts ""
    puts script.capitalize+' Details could not be Stored Succesfully.'
    return -1
  end
end
path=ARGV[1]
script=ARGV[0]
clean(script.chomp.downcase.strip)
case script
when 'course'
  storeData(script)
when 'department'
  storeData(script)
when 'student'
  storeData(script)
when 'marks'
  storeData(script)
when 'subject'
  storeData(script)
when 'attendence'
  storeData(script)
when 'faculty'
  storeData(script)
when 'marks'
  storeData(script)
when 'attendance'
  storeData(script)
when 'all'
  status=storeData('course')
  if status == -1
    puts 'Department Details could not be Stored Succesfully.'
    puts 'Subject Details could not be Stored Succesfully.'
    puts 'Faculty Details could not be Stored Succesfully.'
    puts 'Student Details could not be Stored Succesfully.'
    exit -1
  end
  status=storeData('department')
  if status == -1
    puts 'Subject Details could not be Stored Succesfully.'
    puts 'Faculty Details could not be Stored Succesfully.'
    puts 'Student Details could not be Stored Succesfully.'
    exit -1
  end
  status=storeData('subject')
  if status == -1
    puts 'Faculty Details could not be Stored Succesfully.'
    puts 'Student Details could not be Stored Succesfully.'
    exit -1
  end
  status=storeData('faculty')
  if status == -1
    puts 'Student Details could not be Stored Succesfully.'
    exit -1
  end
  status=storeData('student')
  if status == -1
    return -1
  end
else
  puts 'Entered Incorrect Parameters'
end