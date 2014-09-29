class Course
	include DataMapper::Resource
	property :id, Serial, :message =>'Primary Key should be Unique'
	property :name, String, :required => true,:message => 'Course Name is Mandatory'

	has n,:students, 'Student',
		:parent_key => [:id],
		:child_key => [:course_id]

	has n,:subjects, 'Subject',
		:parent_key => [:id],
		:child_key => [:course_id]

	has n,:lectureserieses, 'LectureSeries',
		:parent_key => [:id],
		:child_key => [:course_id]
end
