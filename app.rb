
require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/project")
require("./lib/volunteer")
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker_test"})

get '/' do
  @projects = Project.all
  @volunteers = Volunteer.all
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


get('/projects/:id') do
  @id = params[:id].to_i
  project_id = params["id"].to_i
  @projects = Project.find(project_id)
  @volunteers = Volunteer.all
  erb(:projects)
end

get('/projects/:id/update') do
  @id = params[:id].to_i
  project_id = params["id"].to_i
  @projects = Project.find(project_id)
  new_title = params["new_title"]
  @projects.update({:title => new_title})
  @volunteers = Volunteer.all
  erb(:update)
end

patch('/projects/:id/') do
  @id = params[:id].to_i
  project_id = params["id"].to_i
  @projects = Project.find(project_id)
  new_title = params["new_title"]
  @projects.update({:title => new_title})
  @volunteers = Volunteer.all
  erb(:projects)
end

delete('/projects/update') do
  @id = params[:id].to_i
  project_id = params["id"].to_i
  @project = Project.find(project_id)
  @project.delete
  @projects = Project.all
  erb(:index)
end
