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
  
  helpers do
    def gallery(title)
      original_paths = Dir["#{File.expand_path(File.join(File.dirname(__FILE__), "/public/images/#{title}/originals"))}/**/*"]
      thumbnail_paths = Dir["#{File.expand_path(File.join(File.dirname(__FILE__), "/public/images/#{title}/thumbnails"))}/**/*"]
      
      originals = []
      thumbnails = []
      
      original_paths.each do |path|
        unless File.directory?(path)
          originals.push({
            :position => File.basename(path).split('_')[1].gsub('.png', '').to_i,
            :title => File.basename(path).gsub('.png', '').split('_').drop(0).each{ |x| x.capitalize! }.join(' '),
            :token => "#{File.basename(path).gsub('.md', '').split('_').drop(0).join('_')}"
          })
          originals.sort! { |a,b| a[:position] <=> b[:position] }
        end
      end
      
      thumbnail_paths.each do |path|
        unless File.directory?(path)
          thumbnails.push({
            :position => File.basename(path).split('_')[1].gsub('.png', '').to_i,
            :title => File.basename(path).gsub('.png', '').split('_').drop(0).each{ |x| x.capitalize! }.join(' '),
            :token => "#{File.basename(path).gsub('.md', '').split('_').drop(0).join('_')}"
          })
          thumbnails.sort! { |a,b| a[:position] <=> b[:position] }
        end
      end
      
      return {:originals => originals, :thumbnails => thumbnails}
    end
  end
  
  get '/' do
    redirect '/home'
  end
  
  get '/:section/?' do
    begin
      haml "#{params[:section]}/#{params[:section]}".to_sym
    rescue
      pass
    end
  end
  
  post '/contact/send' do
    Mailer.contact(params[:contact]).deliver
    redirect '/contact'
  end
  
  get '/*' do
    redirect '/'
  end
  
  not_found do
    redirect '/'
  end
end