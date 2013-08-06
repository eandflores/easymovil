VQ::Admin.controllers :categories do
  get :index do
    @title = "Categories"
    @categories = Category.all
    render 'categories/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'category')
    @category = Category.new
    render 'categories/new'
  end

  post :create do
    @category = Category.new(params[:category])
    if @category.save
      @title = pat(:create_title, :model => "category #{@category.id}")
      flash[:success] = pat(:create_success, :model => 'Category')
      params[:save_and_continue] ? redirect(url(:categories, :index)) : redirect(url(:categories, :edit, :id => @category.id))
    else
      @title = pat(:create_title, :model => 'category')
      flash.now[:error] = pat(:create_error, :model => 'category')
      render 'categories/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "category #{params[:id]}")
    @category = Category.get(params[:id].to_i)
    if @category
      render 'categories/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'category', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "category #{params[:id]}")
    @category = Category.get(params[:id].to_i)
    if @category
      if @category.update(params[:category])
        flash[:success] = pat(:update_success, :model => 'Category', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:categories, :index)) :
          redirect(url(:categories, :edit, :id => @category.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'category')
        render 'categories/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'category', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Categories"
    category = Category.get(params[:id].to_i)
    if category
      if category.destroy
        flash[:success] = pat(:delete_success, :model => 'Category', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'category')
      end
      redirect url(:categories, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'category', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Categories"
    unless params[:category_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'category')
      redirect(url(:categories, :index))
    end
    ids = params[:category_ids].split(',').map(&:strip).map(&:to_i)
    categories = Category.all(:id => ids)
    
    if categories.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Categories', :ids => "#{ids.to_sentence}")
    end
    redirect url(:categories, :index)
  end
end
