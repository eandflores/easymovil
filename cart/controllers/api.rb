# encoding: utf-8
VQ::Cart.controllers :api do
    disable :layout
    provides :json

    get :add_cart, map: 'add(/:id)' do
        
        session[:cart] = [] if session[:cart].blank?
        
        unless params[:id].blank?
            exists = false
            session[:cart].each_with_index do |i, k|
                if i[:id].eql? params[:id]
                    session[:cart][k][:quantity] += 1
                    exists = true
                end
            end
            if exists == false # no existe, lo agrego
                session[:cart] << {id: params[:id], quantity: 1}
            end
        end

        {status: 'ok'}.to_json
    end

    get :del_cart, map: '/del(/:id)' do
        session[:cart] = [] if session[:cart].blank?
        
        unless params[:id].blank?
            session[:cart].each_with_index do |i, k|
                if i[:id].eql? params[:id]
                    session[:cart][k][:quantity] -= 1
                    if session[:cart][k][:quantity] == 0
                        session[:cart].delete_at k
                    end
                end
            end
        end

        {status: 'ok'}.to_json
    end
end