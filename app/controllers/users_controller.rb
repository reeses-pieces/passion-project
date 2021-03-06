# USERS NEW
get '/users/new' do
  if request.xhr?
    erb :'users/new', layout: false
  else
    erb :'users/new'
  end
end

# USERS CREATE
post '/users' do

  if params[:password_confirmation] == params[:user][:password]
    @user = User.new(params[:user])

    if @user.save
      session[:id] = @user.id
      redirect "/users/#{@user.id}"
    else
      @errors = @user.errors.full_messages
      erb :'users/new'
    end

  else
    @errors = ["Passwords do not match!"]
    erb :'users/new'
  end

end

# USERS SHOW
get '/users/:id' do
  @user = User.find(params[:id])
  # Only show user page for current user
  if current_user.id == @user.id
    erb :'users/show'
  else
    "Access forbidden!"
  end
end

# USERS EDIT
get '/users/:id/edit' do
  @user = User.find(params[:id])
  erb :'users/edit'
end


# USERS UPDATE
put '/users/:id' do
  @user = User.find(params[:id])
  @user.update(params[:user])
  redirect "/users/#{@user.id}"
end


# USERS DESTROY
delete '/users/:id' do
  @user = User.find(params[:id])
  @user.destroy
  redirect "/users"
end
