VQ::Admin.controllers :slides do
  before :create, :update do
    if params[:slide][:position].blank?
      params[:slide][:position] = Slide.count + 1
    end
  end

  get :index do
    @title = "Slides"
    @slides = Slide.all
    render 'slides/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'slide')
    @slide = Slide.new
    render 'slides/new'
  end

  post :create do
    @slide = Slide.new(params[:slide])
    if @slide.save
      @title = pat(:create_title, :model => "slide #{@slide.id}")
      flash[:success] = pat(:create_success, :model => 'Slide')
      params[:save_and_continue] ? redirect(url(:slides, :index)) : redirect(url(:slides, :edit, :id => @slide.id))
    else
      @title = pat(:create_title, :model => 'slide')
      flash.now[:error] = pat(:create_error, :model => 'slide')
      render 'slides/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "slide #{params[:id]}")
    @slide = Slide.get(params[:id].to_i)
    if @slide
      render 'slides/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'slide', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "slide #{params[:id]}")
    @slide = Slide.get(params[:id].to_i)
    if @slide
      if @slide.update(params[:slide])
        flash[:success] = pat(:update_success, :model => 'Slide', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:slides, :index)) :
          redirect(url(:slides, :edit, :id => @slide.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'slide')
        render 'slides/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'slide', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Slides"
    slide = Slide.get(params[:id].to_i)
    if slide
      if slide.destroy
        flash[:success] = pat(:delete_success, :model => 'Slide', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'slide')
      end
      redirect url(:slides, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'slide', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Slides"
    unless params[:slide_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'slide')
      redirect(url(:slides, :index))
    end
    ids = params[:slide_ids].split(',').map(&:strip).map(&:to_i)
    slides = Slide.all(:id => ids)
    
    if slides.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Slides', :ids => "#{ids.to_sentence}")
    end
    redirect url(:slides, :index)
  end
end
