require 'bundler'
Bundler.require
require_relative '../dm_config'
require_relative 'import.rb'
$validCourse=Array.new

def dataImport
puts ""
puts "Marks:"
path=ARGV[1]
if path == nil
  path='../excel/Marks.xlsx'
  puts "Default Path has been considered :"+path
end
marks_Data=DDImporter.new(path)
marks_Data.open
marks_Data.extract('Sheet1')
dataImport=marks_Data.data_collection

dataImport.each_with_index do |data,index|
  #Sanitizing spreadsheet row
  exam_date=data[clean 'Exam Date']
  exam_type=data[clean 'Exam Type']
  exam_name=data[clean 'Exam Name']
  faculty_id=data[clean 'Faculty Id']
  section=data[clean 'Section']
  semester=data[clean 'Semester']
  subject_code=data[clean 'Subject Code']
  year=data[clean 'Year']
  srn=data[clean 'Srn']
  min_marks=data[clean 'Minimum Marks']
  max_marks=data[clean 'Maximum Marks']
  marks_obtained=data[clean 'Marks Obtained']

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

  exam=Exam.first(:date=>exam_date, :name=> exam_name, :type=>exam_type,:min_marks=>min_marks,:max_marks=>max_marks)
  if !exam
    exam=Exam.new(:date=>exam_date, :name=> exam_name, :type=>exam_type,:min_marks=>min_marks,:max_marks=>max_marks)
    exam.lectureseries=lecture
    if exam.valid
      exam.save
    else
      return error_concat(exam)
    end
  end

  score=Score.new(:marks_obtained=>marks_obtained)
  score.student=student
  score.exam=exam
  if score.valid
    $validMarks.push score
  else
    return error_concat(score)
  end
end
return nil
end
def save
  $validMarks.each do |data|
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