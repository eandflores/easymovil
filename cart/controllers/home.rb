# encoding: utf-8
VQ::Cart.controllers :home do

  get :index, :map => '/' do
    render 'home/index'
  end

  get :categorias, map: 'categorias' do
    @categorias = Category.all
    render 'home/categorias'
  end

  get :productos, map: 'productos(/:id)' do
    @categoria = Category.get params[:id]
    opts = {}
    opts = {category_id: params[:id]} unless params[:id].blank?
    @productos = Product.all opts
    render 'home/productos'
  end

  get :compras, map: 'compras(/:id)' do
    productos = Product.all id: session[:cart].map{|x| x[:id]}
    @data = []
    productos.each do |x|
      tmp = session[:cart].select{|y| y[:id].to_i == x.id}

      @data << x.attributes.merge( {quantity: tmp.blank? ? 1 : tmp.first[:quantity]} )
    end

    render 'home/compras'
  end

  get :producto, map: 'producto(/:id)' do
    @producto = Product.get params[:id]
    render 'home/producto'
  end

  get :registrar, map: 'registrar' do
    render 'home/registrar'
  end

  post :registrar, map: 'registrar' do
    debe_registrar = false

    @user = Account.authenticate params[:email], params[:password]
    debe_registrar = true if @user.blank?
    if debe_registrar == false
      @user = Account.new email: params[:email], password: params[:password]
      @user.save
    end
    redirect url(:home, :categorias)
  end

end
