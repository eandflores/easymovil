VQ::Admin.controllers :promos do
  get :index do
    @title = "Promos"
    @promos = Promo.all
    render 'promos/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'promo')
    @promo = Promo.new
    render 'promos/new'
  end

  post :create do
    @promo = Promo.new(params[:promo])
    if @promo.save
      @title = pat(:create_title, :model => "promo #{@promo.id}")
      flash[:success] = pat(:create_success, :model => 'Promo')
      params[:save_and_continue] ? redirect(url(:promos, :index)) : redirect(url(:promos, :edit, :id => @promo.id))
    else
      @title = pat(:create_title, :model => 'promo')
      flash.now[:error] = pat(:create_error, :model => 'promo')
      render 'promos/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "promo #{params[:id]}")
    @promo = Promo.get(params[:id].to_i)
    if @promo
      render 'promos/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'promo', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "promo #{params[:id]}")
    @promo = Promo.get(params[:id].to_i)
    if @promo
      if @promo.update(params[:promo])
        flash[:success] = pat(:update_success, :model => 'Promo', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:promos, :index)) :
          redirect(url(:promos, :edit, :id => @promo.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'promo')
        render 'promos/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'promo', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Promos"
    promo = Promo.get(params[:id].to_i)
    if promo
      if promo.destroy
        flash[:success] = pat(:delete_success, :model => 'Promo', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'promo')
      end
      redirect url(:promos, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'promo', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Promos"
    unless params[:promo_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'promo')
      redirect(url(:promos, :index))
    end
    ids = params[:promo_ids].split(',').map(&:strip).map(&:to_i)
    promos = Promo.all(:id => ids)
    
    if promos.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Promos', :ids => "#{ids.to_sentence}")
    end
    redirect url(:promos, :index)
  end
end
