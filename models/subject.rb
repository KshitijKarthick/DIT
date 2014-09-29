class Subject
	include DataMapper::Resource
	property :id, Serial
	property :code, String, :unique => true, :required => true, :message => 'Subject Code is a Mandatory and unique field'
	property :name, String, :required => true, :message => 'Subject Name is a Mandatory Field'
	property :semester, Integer, :required => true, :message => 'Semester is a Mandatory Field'

	belongs_to :course, 'Course',
		:parent_key => [:id],
		:child_key => [:course_id],
		:required => true

	belongs_to :department, 'Department',
		:parent_key => [:id],
		:child_key => [:department_id],
		:required => true

	has n,:lectureserieses,'LectureSeries',
		:parent_key => [:id],
		:child_key => [:subject_id]
end
