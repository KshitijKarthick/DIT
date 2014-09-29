class Exam
	include DataMapper::Resource
	property :id, Serial
	property :date, Date, :required => true,:message => 'Date is Mandatory Field in the Format yyyy/dd/mm'
	property :type, String, :required => true,:message => 'Exam Type is Mandatory Field - Internal, External, Assignment ...'
	property :min_marks,Integer, :required => true,:message => 'Minimum Marks for clearing the Exam is a Mandatory Field'
	property :max_marks,Integer, :required => true,:message => 'Maximum Marks for the Exam is a Mandatory Field'
	property :name, String, :required => true,:message => 'Exam Name is a Mandatory Field - 1st Internal ...'

	belongs_to :lectureseries, 'LectureSeries',
		:parent_key => [:id],
		:child_key => [:lecture_series_id],
		:required => true

	has n,:scores, 'Score',
		:parent_key => [:id],
		:child_key => [:exam_id]
end
