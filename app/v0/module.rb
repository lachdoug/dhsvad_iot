require 'sinatra/base'
require 'sinatra/extension'
require 'sinatra/json'
# require 'rest-client'
require 'byebug'
require "sinatra/activerecord"
require "active_support"
# require 'sinatra/custom_logger'
# require 'logger'

class V0 < Sinatra::Base

  register Sinatra::ActiveRecordExtension
  # helpers Sinatra::CustomLogger

  ## For debugging
  ##----------------------------------------------------------------------------

  before do
    if Sinatra::Base.development?
      puts 'Request'
      puts request.request_method
      puts request.path_info
      puts params.inspect
    end
  end


  ##############################################################################
  ## Settings
  ##############################################################################

  enable :sessions

  set dump_errors: true # Sinatra::Base.development?
  set public_folder: 'public'
  set session_secret: ENV['SECRET_KEY_BASE']
  set user_inactivity_timeout: ( ENV['INACTIVITY_TIMEOUT'] || 30 ).to_f * 60
  set user_name: ENV['USER_NAME'] || "admin"
  set user_password: ENV['USER_PASSWORD'] || "password"
  set map_app: ( ENV['APP_MODE'] == 'map' )

  ## Logging

  # configure :development, :production do
  #   logger = Logger.new(File.open("#{root}/log/#{environment}.log", 'a'))
  #   logger.level = Logger::DEBUG if development?
  #   set :logger, logger
  # end

  ## support _method DELETE/PUT
  use Rack::MethodOverride

  ##############################################################################
  ## CLIENT
  ##############################################################################

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

  ##############################################################################
  ## Errors
  ##############################################################################

  class NonFatalError < StandardError
    def initialize(message, status_code=500)
      @message = message
      @status_code = status_code
    end
    attr_reader :status_code, :message
  end

  class AuthError < NonFatalError

  end

  ##############################################################################
  ## API
  ##############################################################################

  ## Load-up the controllers, models & services
  ##----------------------------------------------------------------------------

  require_relative 'api/api'
  register Api::Controllers

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

  # ## Navbar
  # ##----------------------------------------------------------------------------
  #
  # def navbar
  #   erb :navbar
  # end

  ## Authenticate
  ##----------------------------------------------------------------------------

def view template

  erb template, layout: ( settings.map_app ? :map_layout : :power_layout )

end


  helpers do
    def protected!
      return if authorized?
      headers['WWW-Authenticate'] = 'Basic'
      halt 401, "Not signed in.\n"
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == [ settings.user_name, settings.user_password ]
    end
  end





  before do
    protected!
    section = request.path_info.split("/")[1]
    halt 404 if settings.map_app && section && section != 'map'
    halt 404 if !settings.map_app && section && section == 'map'
    # authenticate_user
    # begin
    #   no_auth? || authenticate_user
    #   # halt 401 if is_control_panel? && !current_user.is_admin?
    # end
  end

  # def is_control_panel?
  #   request.path_info.split("/")[1] == "control_panel"
  # end

  # def no_auth?
  #   # request.path_info == '/' ||
  #   # request.path_info == '/sign_in' ||
  #   request.path_info == '/user/password/success'
  # end

  # attr_reader :current_user
  #
  # def authenticate_user
  #   user = Api::Models::User.new session, settings
  #   if user.authenticated?
  #     @current_user = user
  #   else
  #     session.clear
  #     @current_user = nil
  #   end
  # end

  ## Set core resources
  ##----------------------------------------------------------------------------


  ## View helpers
  helpers do
        def fa( type, text=nil )
          "<i class='fa fa-#{type}'></i>#{ text ? ' ' + text : nil }"
        end
  end

  # ## Error handling
  # ##----------------------------------------------------------------------------
  #
  # ## 400 Fatal: General client error
  # ## 401 Non-fatal: Authentication failed
  # ## 404 Fatal: Bad route
  # ## 405 Non-fatal: Action not allowed (route is recognised, but action cannot be performed)
  # ## 406 Fatal: Params not acceptable (route is recognised, but params incomplete or invalid)
  # ## 500 Fatal: General server error
  # ## 503 Non-fatal: System busy or unavailable

  set show_exceptions: false

  error do |error|
    content_type :json
    if error.is_a?(NonFatalError)
      # if error.status_code == 401
      #   redirect '/sign_in', alert: error.message
      # else
        redirect '/user/portal', alert: error.message
      # end
    else
      [ 500, { error: { message: "Server error." } }.to_json ]
    end
  end

  not_found do
    404
  end



end
