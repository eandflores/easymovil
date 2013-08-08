# encoding: utf-8
VQ::Cart.controllers :home do

  get :index, :map => '/' do
    render 'home/index'
  end

  get :categorias, map: 'categorias' do
    render 'home/categorias'
  end

  get :productos, map: 'productos(/:id)' do
    render 'home/productos'
  end

  get :compras, map: 'compras(/:id)' do
    render 'home/compras'
  end
  
end
