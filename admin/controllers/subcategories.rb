VQ::Admin.controllers :subcategories do
  get :index do
    @title = "Subcategories"
    @subcategories = Subcategory.all
    render 'subcategories/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'subcategory')
    @subcategory = Subcategory.new
    render 'subcategories/new'
  end

  post :create do
    @subcategory = Subcategory.new(params[:subcategory])
    if @subcategory.save
      @title = pat(:create_title, :model => "subcategory #{@subcategory.id}")
      flash[:success] = pat(:create_success, :model => 'Subcategory')
      params[:save_and_continue] ? redirect(url(:subcategories, :index)) : redirect(url(:subcategories, :edit, :id => @subcategory.id))
    else
      @title = pat(:create_title, :model => 'subcategory')
      flash.now[:error] = pat(:create_error, :model => 'subcategory')
      render 'subcategories/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "subcategory #{params[:id]}")
    @subcategory = Subcategory.get(params[:id].to_i)
    if @subcategory
      render 'subcategories/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'subcategory', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "subcategory #{params[:id]}")
    @subcategory = Subcategory.get(params[:id].to_i)
    if @subcategory
      if @subcategory.update(params[:subcategory])
        flash[:success] = pat(:update_success, :model => 'Subcategory', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:subcategories, :index)) :
          redirect(url(:subcategories, :edit, :id => @subcategory.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'subcategory')
        render 'subcategories/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'subcategory', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Subcategories"
    subcategory = Subcategory.get(params[:id].to_i)
    if subcategory
      if subcategory.destroy
        flash[:success] = pat(:delete_success, :model => 'Subcategory', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'subcategory')
      end
      redirect url(:subcategories, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'subcategory', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Subcategories"
    unless params[:subcategory_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'subcategory')
      redirect(url(:subcategories, :index))
    end
    ids = params[:subcategory_ids].split(',').map(&:strip).map(&:to_i)
    subcategories = Subcategory.all(:id => ids)
    
    if subcategories.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Subcategories', :ids => "#{ids.to_sentence}")
    end
    redirect url(:subcategories, :index)
  end
end
