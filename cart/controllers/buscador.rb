VQ::Cart.controllers :buscador do
    get :index, map: 'buscador' do
        @items =    Product.all(:name.like => "%#{params[:q]}%") + 
                    Product.all(:description.like => "%#{params[:q]}%") 

        render 'buscador/index'
    end
end