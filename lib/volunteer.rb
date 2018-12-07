class Volunteer
  attr_reader :name, :id, :project_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @project_id = attributes.fetch(:project_id)
  end

  def ==(other)
    self.name.==(other.name).&(self.id.==(other.id))
    # @name ==other.name && @id == other.id && @project_id == (other.project_id)
  end

  def self.all
    volunteers = []
    volunteer_list = DB.exec("SELECT * FROM volunteers;")
    volunteer_list.each do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id").to_i
      project_id = volunteer.fetch("project_id").to_i
      volunteers.push(Volunteer.new(:name => name, :id => id, :project_id => project_id))
    end
    volunteers
  end


  def save
    volunteer_list = DB.exec("INSERT INTO volunteers (name) VALUES ('#{@name}') RETURNING id;")
    @id = volunteer_list.first.fetch("id").to_i
  end

end
