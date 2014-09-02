require 'slim'

class Application < Sinatra::Application

  set :views,         Proc.new { File.join(ROOT, 'app/views/') }
  set :public_folder, Proc.new { File.join(ROOT, 'public/') }

  get '/' do
    slim :'templates/index'
  end

end

