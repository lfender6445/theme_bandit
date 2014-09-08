require 'erb'

class Application < Sinatra::Application
  set :views,         proc { File.join(ROOT, 'app/views/') }
  set :public_folder, proc { File.join(ROOT, 'public/') }

  get '/' do
    erb :'templates/index'
  end
end
