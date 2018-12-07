class Volunteer
  attr_reader :name, :id, :project_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @project_id = attributes.fetch(:project_id)
  end

  def ==(other)
    @name ==other.name && @id == other.id
  end

  def self.all
    volunteers = []
    volunteer_list = DB.exec("SELECT * FROM volunteers;")
    volunteer_list.each do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id")
      volunteers.push(Volunteer.new(:name => name, :id => id))
    end
    volunteers
  end


end
