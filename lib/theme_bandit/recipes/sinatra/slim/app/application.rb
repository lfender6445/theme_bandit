require 'slim'

class Application < Sinatra::Application
  set :views,         proc { File.join(ROOT, 'app/views/') }
  set :public_folder, proc { File.join(ROOT, 'public/') }

  get '/' do
    slim :'templates/index'
  end
end
