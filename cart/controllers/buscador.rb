VQ::Cart.controllers :buscador do
    get :index, map: 'buscador' do
        @items =    Product.all(:name.like => "%#{params[:q]}%", limit: 10)

        render 'buscador/index'
    end
end