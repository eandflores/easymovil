VQ::Cart.helpers do

    def current_user_id
        session[:current_user_id]
    end

    def current_user
        nil if session[:current_user_id].blank?

        Account.get current_user_id
    end

    def store_location
        session[:last_url] = uri
    end

    def redirect_back_or_default default = '/'
        tmp = session[:last_url]
        session[:last_url] = nil
        redirect tmp.blank? ? default : tmp
    end
    
end