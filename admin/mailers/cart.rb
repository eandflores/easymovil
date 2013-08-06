# encoding: utf-8
VQ::Admin.mailer :cart do

  email :status do |user, email, cart|
    
    from VQ::Cart.email
    to email
    subject "Actualización del pedido Nº #{cart.id}"
    locals user: user, cart: cart
    render 'status'

  end

end
