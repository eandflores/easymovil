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

    def cart_has_product product_id
        session[:cart] = [] if session[:cart].blank?
        existe = false
        session[:cart].each_with_index do |i, k|
            if i[:id].to_i.eql? product_id
                existe = true
            end
        end

        existe
    end
    
end