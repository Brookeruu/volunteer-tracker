
require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/project")
require("./lib/volunteer")
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker"})

get '/' do
  erb(:index)
end

get('/projects') do
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:projects)
end

post('/projects') do
  # if params[]
end
