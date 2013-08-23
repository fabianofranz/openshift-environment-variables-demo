require 'rubygems'
require 'sinatra'
require 'pony'

get '/' do
  "Hey there!
    <br /><br />Why not to <a href=\"/send\">send some emails</a>?"
end

get '/send' do
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
  "Sent! #{ENV['SMTP_HOST']}" 
end

get '/agent' do
  "you're using #{request.user_agent}"
end
