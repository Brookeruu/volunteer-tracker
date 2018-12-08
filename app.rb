
require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/project")
require("./lib/volunteer")
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker"})

get '/' do
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:index)
end

post('/') do
  if params["title"]
    title = params["title"]
    project = Project.new(:title => title, :id => nil)
    project.save
  end
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:index)
end


get('/projects') do
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:projects)
end
