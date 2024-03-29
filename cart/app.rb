# encoding: utf-8
module VQ
  class Cart < Padrino::Application
    register LessInitializer
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    #register BootstrapForms

    enable :sessions

    set :fb_id,         '491170457643546'
    set :fb_scope,      'email,user_birthday,read_stream'
    set :tw_id,         'vu08afBLuO0IhopBfIX4Q'
    set :email,         'contacto@sunsetsushidelivery.cl'
    set :banco,         'Banco de Chile'
    set :tipo_cuenta,   'Corriente'
    set :numero_cuenta, '01010101010101'
    set :rut,           '12121212-2'
    set :nombre,        'Nombre dueño'



    use OmniAuth::Builder do
        provider :facebook, VQ::Cart.fb_id, '1d719d758d98e974628cc31e30762b14', :scope => VQ::Cart.fb_scope
        provider :twitter, VQ::Cart.tw_id, 'ZUf1YJ0ccvqj67h3xT30cfNqpFSeB9iBdA1ZDPIE'
    end

    ##
    # Caching support
    #
    # register Padrino::Cache
    # enable :caching
    #
    # You can customize caching store engines:
    #
    # set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', :exception_retry_limit => 1))
    # set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1))
    # set :cache, Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))
    # set :cache, Padrino::Cache::Store::Memory.new(50)
    # set :cache, Padrino::Cache::Store::File.new(Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
    #

    ##
    # Application configuration options
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar'       # Set path for I18n translations (default your_app/locales)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    #layout  '../views/layouts/application.haml'            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #
    #set :views, 'views'
    set :layout_path, 'views/layout'
    ##
    # You can configure for a specified environment like:
    #
    #   configure :development do
    #     set :foo, :bar
    #     disable :asset_stamp # no asset timestamping for dev
    #   end
    #

    ##
    # You can manage errors like:
    #
    #   error 404 do
    #     render 'errors/404'
    #   end
    #
    #   error 505 do
    #     render 'errors/505'
    #   end
    #
  end
end
