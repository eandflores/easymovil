# encoding: utf-8
VQ::Cart.controllers :user do

    get :facebook_callback, map: '/auth/facebook/callback' do
        content_type 'application/json'
        omniauth = request.env["omniauth.auth"]

        @user = Account.find_uid(omniauth["uid"])
        @user = Account.new_from_omniauth(omniauth) if @user.nil?

        session[:current_user_id] = @user.id

        flash[:notice] = "Conectado correctamente"

        #@user.attributes.to_json
        redirect url('/')
    end

    get :facebook_callback_failed, :map => "/auth/failure" do
        flash[:error] = "Error logging with facebook.com #{params[:message]}"

        redirect url("/")
    end

    get :logout, map: 'logout' do
        session.clear

        flash[:notice] = "Desconexión satisfactoria"

        redirect url('/')
    end

end