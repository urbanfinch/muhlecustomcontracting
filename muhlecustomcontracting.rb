require File.dirname(__FILE__) + '/bootstrap.rb'

class MuhleCustomContracting < Sinatra::Base
  
  configure do
    set :root,    File.dirname(__FILE__)
    set :views,   File.join(Sinatra::Application.root, 'views')
    set :haml,    { :format => :html5, :layout => :'layouts/muhlecustomcontracting' }
    
    if production?
      ActionMailer::Base.smtp_settings = {
        :address => "smtp.sendgrid.net",
        :port => '25',
        :authentication => :plain,
        :user_name => ENV['SENDGRID_USERNAME'],
        :password => ENV['SENDGRID_PASSWORD'],
        :domain => ENV['SENDGRID_DOMAIN'],
      }
      ActionMailer::Base.view_paths = File.join(Sinatra::Application.root, 'views')
    else
      ActionMailer::Base.delivery_method = :file
      ActionMailer::Base.file_settings = { :location => File.join(Sinatra::Application.root, 'tmp/emails') }
      ActionMailer::Base.view_paths = File.join(Sinatra::Application.root, 'views')
    end
  end
  
  get '/' do
    redirect '/home'
  end
  
  get '/:section/?' do
    haml "#{params[:section]}/#{params[:section]}".to_sym
  end
  
  post '/contact/send' do
    Mailer.contact(params[:contact]).deliver
    redirect '/contact'
  end
  
  get '/*' do
    redirect '/'
  end
end