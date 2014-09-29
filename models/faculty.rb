class Faculty
  include DataMapper::Resource
  property :id, Serial,:message => 'Primary Key should be Unique'
  property :name, String, :required => true,:message => 'Faculty Name is a Mandatory Field'
  property :phone_number, String

  has n,:lectureserieses,'LectureSeries',
  	:parent_key => [:id],
  	:child_key => [:faculty_id]
end
