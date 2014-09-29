class Enrollment
	include DataMapper::Resource

	belongs_to :lectureseries, 'LectureSeries',
		:parent_key => [:id],
		:child_key => [:lecture_series_id],
		:required => true,
		:key => true

	belongs_to :student, 'Student',
		:parent_key => [:srn],
		:child_key => [:srn],
		:required => true,
		:key =>true
end
