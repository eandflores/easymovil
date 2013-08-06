VQ::Admin.controllers :carts do
  get :index do
    @current = :index
    @title = "Carts"
    @carts = Cart.all status: Cart::PENDIENTE, order: :id.desc
    render 'carts/index'
  end
  get :index_confeccion do
    @current = :confeccion
    @title = "Carts"
    @carts = Cart.all status: Cart::EN_CONFECCION, order: :id.desc
    render 'carts/index'
  end
  get :index_entregando do
    @current = :entregando
    @title = "Carts"
    @carts = Cart.all status: Cart::ENTREGANDO, order: :id.desc
    render 'carts/index'
  end
  get :index_entregado do
    @current = :entregado
    @title = "Carts"
    @carts = Cart.all status: Cart::ENTREGADO, order: :id.desc
    render 'carts/index'
  end
  get :index_eliminados do
    @current = :eliminados
    @title = "Carts"
    @carts = Cart.all status: Cart::ELIMINADO, order: :id.desc
    render 'carts/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'cart')
    @cart = Cart.new
    render 'carts/new'
  end

  post :create do
    @cart = Cart.new(params[:cart])
    if @cart.save
      @title = pat(:create_title, :model => "cart #{@cart.id}")
      flash[:success] = pat(:create_success, :model => 'Cart')
      params[:save_and_continue] ? redirect(url(:carts, :index)) : redirect(url(:carts, :edit, :id => @cart.id))
    else
      @title = pat(:create_title, :model => 'cart')
      flash.now[:error] = pat(:create_error, :model => 'cart')
      render 'carts/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "cart #{params[:id]}")
    @cart = Cart.get(params[:id].to_i)
    if @cart
      render 'carts/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'cart', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "cart #{params[:id]}")
    @cart = Cart.get(params[:id].to_i)
    if @cart
      if @cart.update(params[:cart])

        deliver(:cart, :status, @cart.account, @cart.account.email, @cart) if [Cart::EN_CONFECCION, Cart::ENTREGANDO].include?(@cart.status)

        flash[:success] = pat(:update_success, :model => 'Cart', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:carts, :index)) :
          redirect(url(:carts, :edit, :id => @cart.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'cart')
        render 'carts/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'cart', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Carts"
    cart = Cart.get(params[:id].to_i)
    if cart
      cart.status = Cart::ELIMINADO
      if cart.save!
        flash[:success] = pat(:delete_success, :model => 'Cart', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'cart')
      end
      redirect url(:carts, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'cart', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Carts"
    unless params[:cart_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'cart')
      redirect(url(:carts, :index))
    end
    ids = params[:cart_ids].split(',').map(&:strip).map(&:to_i)
    carts = Cart.all(:id => ids)
    
    if carts.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Carts', :ids => "#{ids.to_sentence}")
    end
    redirect url(:carts, :index)
  end
end
