require 'rubygems'
require 'sinatra'

get '/' do
  "Hey there.
    <br /><br />Wny not to <a href=\"/mail\">send some emails</a>?"
end

get '/mailer' do
  Pony.mail({
    :to => 'ffranz@redhat.com',
    :subject => "From Awesomeness Demo #{Time.now}",
    :body => 'Hey there',
    :via => :smtp,
    :via_options => {
      :address        => ENV['SMTP_HOST'],
      :port           => ENV['SMTP_PORT'],
      :user_name      => ENV['SMTP_USERNAME'],
      :password       => ENV['SMTP_PASSWORD'],
      :authentication => :plain, # :plain, :login, :cram_md5, no auth by default
      :domain         => "localhost.localdomain" # the HELO domain provided by the client to the server
    }
  })
end

get '/agent' do
  "you're using #{request.user_agent}"
end
