require 'sinatra/base'
require 'sinatra/extension'
require 'sinatra/json'
require 'byebug'
require "sinatra/activerecord"
require "active_support"


class V0 < Sinatra::Base

  register Sinatra::ActiveRecordExtension

  ## Debugging
  ##----------------------------------------------------------------------------

  before do
    if Sinatra::Base.development?
      puts 'Request'
      puts request.request_method
      puts request.path_info
      puts params.inspect
      request.body.rewind
      puts request.body.read
    end
  end


  ## Settings
  ##----------------------------------------------------------------------------

  ENV['APP_MODE'] = ENV['APP_MODE'] || ( Sinatra::Base.development? ? 'map' : false )

  enable :sessions

  set dump_errors: true # Sinatra::Base.development?
  set show_exceptions: false
  set public_folder: 'public'
  set session_secret: ENV['SECRET_KEY_BASE']
  set user_name: ( ENV['APP_MODE'] ? 'lorenzo' : nil ) || ENV['USER_NAME'] || "admin"
  set user_password: ( ENV['APP_MODE'] ? 'password' : nil ) || ENV['USER_PASSWORD'] || "password"
  set map_app: ENV['APP_MODE']

  ## support _method DELETE/PUT
  ##----------------------------------------------------------------------------
  use Rack::MethodOverride

  ## Assets
  ##----------------------------------------------------------------------------

  def application_js_files
    Dir.glob( [ "#{self.class.root}/views/assets/javascript/**/*.js" ] ).map do |file|
      File.read file
    end.join("\n")
  end

  def application_css_files
    Dir.glob( [ "#{self.class.root}/views/assets/css/**/*.css" ] ).map do |file|
      File.read file
    end.join("\n")
  end

  ## Errors
  ##----------------------------------------------------------------------------

  error do |error|
    content_type :json
    [ 500, { error: { message: "Server error. #{error.message}" } }.to_json ]
  end

  not_found do
    404
  end

  class NonFatalError < StandardError
    def initialize(message, status_code=500)
      @message = message
      @status_code = status_code
    end
    attr_reader :status_code, :message
  end

  class AuthError < NonFatalError

  end

  ## Controllers, models & services
  ##----------------------------------------------------------------------------

  require_relative 'api/api'
  register Api::Controllers

  ## Views
  ##----------------------------------------------------------------------------

  def view template
    erb template, layout: ( settings.map_app ? :map_layout : :power_layout )
  end

  ## Helpers
  ##----------------------------------------------------------------------------

  helpers Api::Helpers

  ## Flash messages
  ##----------------------------------------------------------------------------

  def redirect(route, opts={})
    session[:flash] =
      if opts[:notice]
        { notice: opts[:notice] }
      elsif  opts[:alert]
        { alert: opts[:alert] }
      end
    super route
  end

  def flash
    return @flash if @flash
    @flash = session[:flash] || {}
    session[:flash] = nil
    @flash
  end

  ## Authenticate
  ##----------------------------------------------------------------------------

  helpers do
    def protected!
      return if authorized?
      headers['WWW-Authenticate'] = 'Basic'
      halt 401, "Not signed in.\n"
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)

puts "Trying to auth: #{ [ @auth.provided?, @auth.basic?, @auth.credentials, [ settings.user_name, settings.user_password ], @auth.credentials == [ settings.user_name, settings.user_password ] ] }"

      @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [ settings.user_name, settings.user_password ]
    end
  end

  before do
    protected!
    section = request.path_info.split("/")[1]
    halt 404 if settings.map_app && section && section != 'map'
    halt 404 if !settings.map_app && section && section == 'map'
  end


end
