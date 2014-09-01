class Application < Sinatra::Application
  include Slim::Render

  set :views,         Proc.new { File.join(ROOT, 'app/views/') }
  set :public_folder, Proc.new { File.join(ROOT, 'public/') }

  get '/' do
    slim :'templates/index', layout: :'layouts/application'
  end

end

