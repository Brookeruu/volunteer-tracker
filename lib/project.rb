require ('spec_helper')

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


end
