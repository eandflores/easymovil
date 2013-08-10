# encoding: utf-8
# Seed add you the ability to populate your db.
# We provide you a basic shell for interaction with the end user.
# So try some code like below:
#
#   name = shell.ask("What's your name?")
#   shell.say name
#
# email     = shell.ask "Which email do you want use for logging into admin?"
# password  = shell.ask "Tell me the password to use:"

# shell.say ""

# account = Account.create(:email => email, :name => "Foo", :surname => "Bar", :password => password, :password_confirmation => password, :role => "admin")

# if account.valid?
#   shell.say "================================================================="
#   shell.say "Account has been successfully created, now you can login with:"
#   shell.say "================================================================="
#   shell.say "   email: #{email}"
#   shell.say "   password: #{password}"
#   shell.say "================================================================="
# else
#   shell.say "Sorry but some thing went wrong!"
#   shell.say ""
#   account.errors.full_messages.each { |m| shell.say "   - #{m}" }
# end

# shell.say ""


# shell.say "---- INIT SEEDS ----".red

c = Category.create name: 'Cambiar piso', position: 1
Product.create name: 'Piso flotante 8mm 2,40m2 1S', local: 'Loc Haya piemonte. - EUROFLOOR', number: 816627, price: 11858, normal_price: 13176, category: c, image_url: '/img/Producto1.png'
Product.create name: 'Piso flotante 8mm 2,40m2 2S', local: 'Loc Haya piemonte. - EUROFLOOR', number: 816627, price: 11858, normal_price: 13176, category: c, image_url: '/img/Producto2.png'
Product.create name: 'Piso flotante 8mm 2,40m2 3S', local: 'Loc Haya piemonte. - EUROFLOOR', number: 816627, price: 11858, normal_price: 13176, category: c, image_url: '/img/Producto1.png'
Product.create name: 'Piso flotante 8mm 2,40m2 4S', local: 'Loc Haya piemonte. - EUROFLOOR', number: 816627, price: 11858, normal_price: 13176, category: c, image_url: '/img/Producto2.png'
c = Category.create name: 'Remodelar el baño', position: 2
c = Category.create name: 'Remodelar la terraza', position: 3
c = Category.create name: 'Pintar la casa', position: 4
c = Category.create name: 'Remodelar el baño', position: 5
c = Category.create name: 'Cambiar muebles de cocina', position: 6
c = Category.create name: 'Cambiar alfombras de la casa', position: 7
c = Category.create name: 'Cambiar ropa de cama', position: 8
c = Category.create name: 'Remodelar cortinas', position: 9
c = Category.create name: 'Cambiar menaje', position: 10
c = Category.create name: 'Remodelación línea blanca', position: 11
c = Category.create name: 'Cambiar lámparas de la casa', position: 12
c = Category.create name: 'Cambiar muebles de la casa', position: 12
