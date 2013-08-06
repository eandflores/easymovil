# encoding: utf-8
VQ::Cart.controllers :home do

  get :index, :map => '/' do
    render 'home/index'
  end
  
end
