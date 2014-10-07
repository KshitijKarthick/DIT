class LectureSeries
	include DataMapper::Resource
	property :id, Serial,:message => 'Primary Key should be Unique'
	property :year, String
	property :section, String, :length => 5,:message =>'Section data should not have greater length than 5'
	property :semester, Integer

	belongs_to :course, 'Course',
	:parent_key => [:id],
	:child_key => [:course_id],
	:required => true

	has n, :exams, 'Exam',
	:parent_key => [:id],
	:child_key => [:lecture_series_id]

	belongs_to :department, 'Department',
	:parent_key => [:id],
	:child_key => [:department_id],
	:required => true

	belongs_to :faculty, 'Faculty',
	:parent_key => [:id],
	:child_key => [:faculty_id],
	:required => true

	belongs_to :subject, 'Subject',
	:parent_key => [:id],
	:child_key => [:subject_id],
	:required => true

	has n,:enrollments, 'Enrollment',
	:parent_key => [:id],
	:child_key => [:lecture_series_id]

	has n,:weeklyattendances, 'WeeklyAttendance',
	:parent_key => [:id],
	:child_key => [:lecture_series_id]
end
