VQ::Admin.controllers :products do
  get :index do
    @title = "Products"
    @products = Product.all
    render 'products/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'product')
    @product = Product.new
    render 'products/new'
  end

  post :create do
    params[:product][:subcategory_id] = nil if params[:product][:subcategory_id].blank?
    @product = Product.new(params[:product])
    @product.categorias_tabla = params[:category].to_json unless params[:category].blank?
    if @product.save
      Slug.set @product
      @title = pat(:create_title, :model => "product #{@product.id}")
      flash[:success] = pat(:create_success, :model => 'Product')
      params[:save_and_continue] ? redirect(url(:products, :index)) : redirect(url(:products, :edit, :id => @product.id))
    else
      @title = pat(:create_title, :model => 'product')
      flash.now[:error] = pat(:create_error, :model => 'product')
      render 'products/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "product #{params[:id]}")
    @product = Product.get(params[:id].to_i)
    if @product
      render 'products/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'product', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    logger.info "____--------".bold.blue
    logger.info params.inspect.yellow.blue
    logger.info "____--------".bold.blue
    @title = pat(:update_title, :model => "product #{params[:id]}")
    @product = Product.get(params[:id].to_i)

    if @product
      params[:product][:subcategory_id] = nil if params[:product][:subcategory_id].blank?

      if @product.update(params[:product])
        @product.categorias_tabla = params[:category].to_json unless params[:category].blank?
        @product.save
        Slug.set @product
        flash[:success] = pat(:update_success, :model => 'Product', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:products, :index)) :
          redirect(url(:products, :edit, :id => @product.id))
      else
        logger.info @product.errors.inspect.red
        flash.now[:error] = pat(:update_error, :model => 'product')
        render 'products/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'product', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Products"
    product = Product.get(params[:id].to_i)
    if product
      if product.destroy
        flash[:success] = pat(:delete_success, :model => 'Product', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'product')
      end
      redirect url(:products, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'product', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Products"
    unless params[:product_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'product')
      redirect(url(:products, :index))
    end
    ids = params[:product_ids].split(',').map(&:strip).map(&:to_i)
    products = Product.all(:id => ids)
    
    if products.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Products', :ids => "#{ids.to_sentence}")
    end
    redirect url(:products, :index)
  end
end
