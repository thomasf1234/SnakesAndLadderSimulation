ENV['ENV'] ||= 'development'
Bundler.require(:default, ENV['ENV'])
Dir["app/**/*.rb"].each { |file| require_relative file }
