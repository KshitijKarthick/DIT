class WeeklyAttendance
  include DataMapper::Resource
  property :week_number, Integer, :required => true, :key => true, :message => 'Week Number is a Required Field'
  property :classes_held, Integer, :required => true , :message => 'Classes Held in that Week No is a Mandatory Field'
  property :classes_attended, Integer, :required => true, :message => 'Classes Attended by that Student is a Mandatory Field'

  belongs_to :student, 'Student',
    :parent_key => [:srn],
    :child_key => [:srn],
    :required => true,
    :key => true

  belongs_to :lectureseries, 'LectureSeries',
    :parent_key => [:id],
    :child_key => [:lecture_series_id],
    :required => true,
    :key => true
end
