class Mailer < ActionMailer::Base
  def contact(params)
    @params = params
    
    mail(
      :to      => "recipient@muhlecustomcontracting.com",
      :from    => "mailer@muhlecustomcontracting.com",
      :subject => "Contact from muhlecustomcontracting.com") do |format|
        format.text
        format.html
    end
  end
end