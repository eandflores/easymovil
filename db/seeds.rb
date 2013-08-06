# Seed add you the ability to populate your db.
# We provide you a basic shell for interaction with the end user.
# So try some code like below:
#
#   name = shell.ask("What's your name?")
#   shell.say name
#
email     = shell.ask "Which email do you want use for logging into admin?"
password  = shell.ask "Tell me the password to use:"

shell.say ""

account = Account.create(:email => email, :name => "Foo", :surname => "Bar", :password => password, :password_confirmation => password, :role => "admin")

if account.valid?
  shell.say "================================================================="
  shell.say "Account has been successfully created, now you can login with:"
  shell.say "================================================================="
  shell.say "   email: #{email}"
  shell.say "   password: #{password}"
  shell.say "================================================================="
else
  shell.say "Sorry but some thing went wrong!"
  shell.say ""
  account.errors.full_messages.each { |m| shell.say "   - #{m}" }
end

shell.say ""


shell.say "---- INIT SEEDS ----".red


c1 = Category.create name: 'Makimonos', position: 1
c2 = Category.create name: 'Sake Roll\'s', position: 2
c3 = Category.create name: 'Hosomaki', position: 3
c4 = Category.create name: 'Especial Caliente', position: 4
c5 = Category.create name: 'Avocado Roll\'s', position: 5

Category.all.each do |c|
    c.update slug: c.name.to_slug if c.slug.blank?
end