# If a user is signed in, they can see all users on the home page.
# A user can SignOut using the provided delete route which is invoked via AJAX.


get '/' do
  # render home page
 #TODO: Show all users if user is signed in
  erb :index
end

get '/home_page' do 
  @users = User.all 
  erb :home_page
end 


#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page 
  erb :sign_in
end

post '/sessions' do
  if user = User.login(params[:user])
    session[:user_id] = user.id 
    redirect ('/home_page')
  else 
    @error = "Login the right way, ya chanch."
    erb :sign_in
  end 
  #if verified, set session and redirect user to home
  #if login fails, redirect to login page so they can try again
end

delete '/sessions/:id' do
  session.clear
  redirect to ("/")
end



#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  erb :sign_up
end


post '/users' do
  current_user = User.create(params[:user])
  session[:user_id] = current_user.id 
  redirect to('/home_page')
end