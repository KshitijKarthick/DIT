class Student
	include DataMapper::Resource
	property :srn, String, :unique => true, :key => true, :required => true, :message => 'Student with this Usn Already Exists'
	property :first_name, String, :required => true, :message => 'First name is Mandatory'
	property :middle_name, String
	property :last_name, String
	property :phone_number, String, :required => true, :message => 'Phone number is Manadatory'
	property :dob, Date, :required => true, :message => 'Correct Format of DOB should be entered yyyy/dd/mm'
	property :section, String, :required => true, :message => 'Student should have a valid Section'
	property :semester, Integer, :required => true, :message => 'Student should be enrolled under a semester'
	property :sex, String,:required => true, :message => 'Student should have either m or f as the sex.'

	belongs_to :course, 'Course',
		:parent_key => [:id],
		:child_key => [:course_id],
		:required => true

	has n,:scores,'Score',
		:parent_key => [:srn],
		:child_key => [:srn],
		:constraint => :protect

	has n,:weeklyattendances,"WeeklyAttendance",
		:parent_key => [:srn],
		:child_key => [:srn],
		:constraint => :protect

	belongs_to :department, 'Department',
		:parent_key => [:id],
		:child_key => [:department_id],
		:required => true

	def full_name
		fname = self[:first_name]
		if self[:middle_name]
			fname += " " + self[:middle_name]
		end
		if self[:last_name]
			fname+= " " + self[:last_name]
		end
		return fname
	end

end
