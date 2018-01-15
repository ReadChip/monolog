# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  config.site_key  = '6Lc1XEAUAAAAAIHKswLto3WgK5jSbOEM6W_0-1i1'
  config.secret_key = '6Lc1XEAUAAAAAItWP2XhzOjYRRhug9JLwMv7lDBe'
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end