class Score
	include DataMapper::Resource
	property :marks_obtained, String

	belongs_to :student, 'Student',
		:parent_key => [:srn],
		:child_key => [:srn],
		:required => true,
		:key => true

	belongs_to :exam, 'Exam',
		:parent_key => [:id],
		:child_key => [:exam_id],
		:required => true,
		:key => true
end
