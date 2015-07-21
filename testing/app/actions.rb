# Homepage (Root path)

helpers do
  def current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end
end

before do
  redirect '/login' if !current_user && request.path != '/login' && request.path != '/signup'
end


get '/' do
  @user_bets = Bet.where(user_id: session[:user_id])
  erb :index
end

post '/' do
  outcome = params[:outcome]
end


get '/login' do
    erb :login
end

post '/login' do

  username = params[:username]
  password = params[:password]

  puts username
  puts password

  user = User.where(username: username, password: password).first
  if user
    session[:user_id] = user.id
    redirect '/'
  else
    erb :login
  end
end

get '/profile' do
    erb :profile
end

post '/profile' do
    redirect '/'
end

get '/signup' do
    erb :signup
end

post '/signup' do
  username = params[:username]
  password = params[:password]
  password_confirm = params[:password_confirm]
  
  user = User.find_by(username: username)
  if user
     erb :signup
  else
    if password == password_confirm
      user = User.create(username: username, password: password)
      session[:user_id] = user.id
      redirect '/login'
    else
      erb :signup
    end
  end
end

get '/bets/new' do
  erb :'bets/new'
end

post '/bets/new' do
  date = params[:date]
  home_team = params[:home_team]
  road_team = params[:road_team]
  bet_type = params[:bet_type]
  bet_n = params[:bet_n]
  odds = params[:odds]
  units = params[:units]
  reasoning = params[:reasoning]
  user_id = @current_user.id

  new_bet = Bet.create(
                        date: date, 
                        home_team: home_team, 
                        road_team: road_team,
                        bet_type: bet_type,
                        bet_n: bet_n,
                        odds: odds,
                        units: units,
                        reasoning: reasoning,
                        user_id: user_id
                      )
  redirect '/'
end

get '/bets/all' do
  @user_bets = Bet.where(user_id: session[:user_id]).reverse
  erb :'bets/all'
end


get '/bets/:id' do
  @bet = Bet.find(params[:id])
  erb :'bets/bet'
end

post '/bets/:id' do
  outcome = params[:outcome]

  bet = Bet.find(params[:id])
  bet.update(outcome: outcome)

  redirect '/'
end


get '/logout' do
  session.clear #log the user out by clearing the session
  erb :login
end
