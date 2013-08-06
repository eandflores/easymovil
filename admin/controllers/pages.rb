VQ::Admin.controllers :pages do
  before :create, :update do
    if params[:page][:position].blank?
      params[:page][:position] = Page.count + 1
    end
  end
  after :create, :update do
    Slug.set @page
  end

  get :index do
    @title = "Pages"
    @pages = Page.all
    render 'pages/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'page')
    @page = Page.new
    render 'pages/new'
  end

  post :create do
    @page = Page.new(params[:page])
    if @page.save
      @title = pat(:create_title, :model => "page #{@page.id}")
      flash[:success] = pat(:create_success, :model => 'Page')
      params[:save_and_continue] ? redirect(url(:pages, :index)) : redirect(url(:pages, :edit, :id => @page.id))
    else
      @title = pat(:create_title, :model => 'page')
      flash.now[:error] = pat(:create_error, :model => 'page')
      render 'pages/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "page #{params[:id]}")
    @page = Page.get(params[:id].to_i)
    if @page
      render 'pages/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'page', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "page #{params[:id]}")
    @page = Page.get(params[:id].to_i)
    if @page
      if @page.update(params[:page])
        flash[:success] = pat(:update_success, :model => 'Page', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:pages, :index)) :
          redirect(url(:pages, :edit, :id => @page.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'page')
        render 'pages/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'page', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Pages"
    page = Page.get(params[:id].to_i)
    if page
      if page.destroy
        flash[:success] = pat(:delete_success, :model => 'Page', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'page')
      end
      redirect url(:pages, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'page', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Pages"
    unless params[:page_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'page')
      redirect(url(:pages, :index))
    end
    ids = params[:page_ids].split(',').map(&:strip).map(&:to_i)
    pages = Page.all(:id => ids)
    
    if pages.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Pages', :ids => "#{ids.to_sentence}")
    end
    redirect url(:pages, :index)
  end
end
