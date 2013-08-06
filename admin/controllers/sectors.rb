VQ::Admin.controllers :sectors do
  get :index do
    @title = "Sectors"
    @sectors = Sector.all
    render 'sectors/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'sector')
    @sector = Sector.new
    render 'sectors/new'
  end

  post :create do
    @sector = Sector.new(params[:sector])
    if @sector.save
      @title = pat(:create_title, :model => "sector #{@sector.id}")
      flash[:success] = pat(:create_success, :model => 'Sector')
      params[:save_and_continue] ? redirect(url(:sectors, :index)) : redirect(url(:sectors, :edit, :id => @sector.id))
    else
      @title = pat(:create_title, :model => 'sector')
      flash.now[:error] = pat(:create_error, :model => 'sector')
      render 'sectors/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "sector #{params[:id]}")
    @sector = Sector.get(params[:id].to_i)
    if @sector
      render 'sectors/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'sector', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "sector #{params[:id]}")
    @sector = Sector.get(params[:id].to_i)
    if @sector
      if @sector.update(params[:sector])
        flash[:success] = pat(:update_success, :model => 'Sector', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:sectors, :index)) :
          redirect(url(:sectors, :edit, :id => @sector.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'sector')
        render 'sectors/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'sector', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Sectors"
    sector = Sector.get(params[:id].to_i)
    if sector
      if sector.destroy
        flash[:success] = pat(:delete_success, :model => 'Sector', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'sector')
      end
      redirect url(:sectors, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'sector', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Sectors"
    unless params[:sector_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'sector')
      redirect(url(:sectors, :index))
    end
    ids = params[:sector_ids].split(',').map(&:strip).map(&:to_i)
    sectors = Sector.all(:id => ids)
    
    if sectors.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Sectors', :ids => "#{ids.to_sentence}")
    end
    redirect url(:sectors, :index)
  end
end
