Warden::Manager.after_set_user do |user, auth, opts| 
  # sets cookie for signed in user and makes available for our method in our connection.rb channel
  scope = opts[:scope] 
  auth.cookies.signed["#{scope}.id"] = user.id
end

# clears the cookie after log out
Warden::Manager.before_logout do |user, auth, opts| 
  scope = opts[:scope] 
  auth.cookies.signed["#{scope}.id"] = nil
end