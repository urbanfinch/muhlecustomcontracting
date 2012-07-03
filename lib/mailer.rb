class Mailer < ActionMailer::Base
  def contact(params)
    @params = params
    
    mail(
      :to      => "chadmuhle@yahoo.com",
      :from    => @params[:email],
      :subject => "Contact from muhlecustomcontracting.com") do |format|
        format.text
        format.html
    end
  end
end