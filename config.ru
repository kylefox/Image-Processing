require 'sprockets'

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'src/'
  environment.append_path 'img/'
  run environment
end

map "/" do
  run lambda { |env|
    [
      200, 
      {
        'Content-Type'  => 'text/html', 
        'Cache-Control' => 'public'
      },
      File.open('index.html', File::RDONLY)
    ]
  }
end