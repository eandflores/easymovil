# encoding: utf-8
VQ::Cart.mailer :cart do

  email :sell do |user, email, cart|
    
    from VQ::Cart.email
    to email
    subject "Compra realizada Nº #{cart.id}"
    locals user: user, cart: cart
    render 'cart/sell'

  end

end
