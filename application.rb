require 'rubygems'
require 'sinatra'
require 'pony'

get '/' do
  "Hey there!
   <br />
   It's a good day to <a href=\"/send\">send some emails</a>."
end

get '/send' do
  if 'PRODUCTION' == ENV['ENVIRONMENT']
    Pony.mail({
      :subject => "From Awesomeness Demo #{Time.now}",
      :body => 'Hey there',
      :via => :smtp,
      :to => ENV['MAIL_TO'],
      :from => ENV['MAIL_FROM'],
      :via_options => {
        :address        => ENV['SMTP_HOST'],
        :port           => ENV['SMTP_PORT'],
        :user_name      => ENV['SMTP_USERNAME'],
        :password       => ENV['SMTP_PASSWORD'],
        :authentication => :plain, # :plain, :login, :cram_md5, no auth by default
        :domain         => "localhost.localdomain", # the HELO domain provided by the client to the server
        :openssl_verify_mode => OpenSSL::SSL::VERIFY_NONE,
        :enable_starttls_auto => true
      }
    })
    "Sent (really) to #{ENV['MAIL_TO']}! <a href=\"/\">Back</a>"
  else
    "Sent (kind of)! <a href=\"/\">Back</a>"
  end
end

