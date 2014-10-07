require 'bundler'
Bundler.require
require_relative '../dm_config'
require_relative 'import.rb'
$validStudent=Array.new
def dataImport
  puts ""
  puts "Attendance:"
  path=ARGV[1]
  if path == nil
    path='../excel/Attendance.xlsx'
    puts "Default Path has been considered :"+path
  end
  student_Data=DDImporter.new(path)
  student_Data.open
  student_Data.extract('Sheet1')
  dataImport=student_Data.data_collection
  dataImport.each_with_index do |data,index|
    #Sanitizing spreadsheet row
    week_no=data[clean 'Week No']
    faculty_id=data[clean 'Faculty Id']
    section=data[clean 'Section']
    subject_code=data[clean 'Subject Code']
    year=data[clean 'Year']
    srn=data[clean 'Srn']
    classes_held=data[clean 'Classes Held']
    classes_attend=data[clean 'Classes Attend']

    student=Student.get(:srn=>srn)
    if !student
      return "SRN #{srn} on row #{index} does not exist"
    end

    if !Faculty.get(:id => faculty_id)
      return "Faculty with faculty id #{faculty_id} on row #{index} does not exist"
    end

    subject=Subject.first(:code=>subject_code)
    if !subject
      return "Subject with subject code #{subject_code} does not exist"
    end

    lecture=LectureSeries.first(:faculty_id=>faculty_id,:year=>year,:subject_id=>subject.id,:section=>section,:semester=>semester,:course_id=>student.course.id,:department_id=>student.department.id)

    if !lecture
      lecture=LectureSeries.new(:year=>year,:section=>section,:semester=>semester)
      lecture.course=student.course
      lecture.department=student.department
      lecture.faculty=faculty
      lecture.subject=subject
      if !lecture.valid
        return error_concat(lecture)
      end
      lecture.save
    end

    enrollment=Enrollment.first(:lecture_series_id=>lecture.id,:srn=>student.srn)
    if !enrollment
      enrollment=Enrollment.new
      enrollment.student=student
      enrollment.lectureseries=lecture
      if enrollment.valid
        enrollment.save
      else
        return error_concat(enrollment)
      end
    end

    weeklyattendance=WeeklyAttendance.new(:week_number=>week_no,:classes_held=>classes_held,:classes_attended=>classes_attended)
    weeklyattendance.student=student
    weeklyattendance.lectureseries=lecture
    if weeklyattendance.valid
      SaneData.push weeklyattendance
    else
      return error_concat(weeklyattendance)
    end
  end
  return nil
end
def save
  SaneData.each do |data|
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