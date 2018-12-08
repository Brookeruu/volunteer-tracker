require ('spec_helper')
require ('volunteer')

class Project
  attr_reader :title, :id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end


  def save
    project_list = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = project_list.first.fetch("id").to_i
  end


  def ==(other)
    self.title.==(other.title).&(self.id.==(other.id))
  end


  def self.all
    project_list = []
    projects = DB.exec("SELECT * FROM projects;")
    projects.each do |project|
      title = project.fetch("title")
      id = project.fetch("id").to_i
      project_list.push(Project.new(:title => title, :id => id))
    end
    project_list
  end


  def self.find(id)
    project_id = DB.exec("SELECT * FROM projects WHERE id = #{id};")
    title = project_id.first.fetch("title")
    Project.new({:title => title, :id => id})
  end


  # def volunteers
  #   projects_volunteers = []
  #   volunteers = DB.exec("SELECT volunteer_id WHERE project_id = #{self.id};")
  #     volunteers.each do |volunteer|
  #       volunteer_id = volunteer.fetch("volunteer_id").to_i
  #       volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{volunteer_id};")
  #       name = volunteer.first.fetch("name")
  #       projects_volunteers.push(Volunteer.new({:name => name, :id => volunteer_id}))
  #     end
  #     projects_volunteers
  # end


  def volunteers
    list_volunteers = []
    volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{self.id};")
    volunteers.each do |volunteer|
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id").to_i
      list_volunteers.push(Volunteer.new({:name => name, :project_id => project_id,}))
    end
    list_volunteers
  end


  def update(attributes)
    @title = attributes.fetch(:title, @title)
    @id = self.id
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")

    attributes.fetch(:volunteer_ids, []).each do |volunteer_id|
      DB.exec("INSERT INTO volunteers (project_id, volunteer_id) VALUES (#{self.id}, #{volunteer_id});")
    end
  end


  def delete
    DB.exec("DELETE FROM projects WHERE id =#{self.id};")
  end


end
