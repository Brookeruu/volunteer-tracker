
require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/project")
require("./lib/volunteer")
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker_test"})

get '/' do
  @projects = Project.all
  erb(:index)
end

post('/projects') do
  if params["title"]
    title = params["title"]
    project = Project.new(:title => title, :id => nil)
    project.save
  end
  @id = project.id
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:index)
end


get('/project/:id') do
  @id = params[:id].to_i
  project_id = params["id"].to_i
  @project = Project.find(project_id)
  @volunteers = @project.volunteers
  erb(:projects)
end

post('/project/:id') do
  @id = params[:id].to_i
  project_id = params["id"].to_i
  name = params["name"]
  @project = Project.find(project_id)
  binding.pry
  @volunteer = Volunteer.new(:name => name, :project_id => project_id, :id => nil)
  @volunteer.save
  @volunteers = @project.volunteers
  erb(:projects)
end

get('/volunteer/:id')do
  @volunteer = Volunteer.find(params.fetch("id").to_i)
  @project = Project.find(@volunteer.project_id)
  erb(:volunteer)
end

patch('/volunteer/:id') do
  new_name = params['new_name']
  volunteer = Volunteer.find(params.fetch("id").to_i)
  volunteer.update ({:name => new_name})
  @volunteer = Volunteer.find(params.fetch("id").to_i)
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:volunteer)
end

get('/project/:id/update') do
  @id = params[:id].to_i
  project_id = params["id"].to_i
  @project = Project.find(project_id)
  new_title = params["new_title"]
  @project.update({:title => new_title})
  @volunteers = Volunteer.all
  erb(:update)
end

patch('/project/:id/') do
  @id = params[:id].to_i
  project_id = params["id"].to_i
  @project = Project.find(project_id)
  new_title = params["new_title"]
  @project.update({:title => new_title})
  @volunteers = Volunteer.all
  erb(:projects)
end

get('/project/:id/edit') do
  @id = params[:id].to_i
  project_id = params["id"].to_i
  @project = Project.find(project_id)
  @projects = Project.all
  erb(:edit)
end

delete('/project/:id') do
  # @id = params[:id].to_i
  # project_id = params["id"].to_i
  @project = Project.find(params.fetch("id").to_i)
  @project.delete
  @projects = Project.all
  erb(:index)
end
