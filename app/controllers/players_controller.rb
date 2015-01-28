class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  def index
    @players = Player.all
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params.merge({ wins: 0, losses: 0 }))

    if @player.save
      redirect_to @player, notice: 'Player was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
    if logged_in?
      render :edit
    else
      @show_login_form = true
      redirect_to root_url, notice: "You need to be logged in to edit.", flash: { show_login_form: true }
    end
  end

  def update
    if @player.update_attributes(
                  name: player_params[:name],
                  login: player_params[:login],
                  password: PasswordDigester.encrypt(player_params[:password])
                  )
      redirect_to @player, notice: "Player was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @player.destroy
     redirect_to players_url, notice: 'Post was successfully destroyed.'
  end

  def login
    @player = Player.find_by login: params[:login]
    if @player
      #if player's cookie matches db cookie log in
      if true
      #if no cookie compare password and set new cookie
      elsif PasswordDigester.check?(params[:password], @player.password)

      #no password or cookie match
      else

      end

    end

    redirect_to root_url
  end

  private

    def player_params
      params[:player][:password] = PasswordDigester.encrypt(params[:player][:password])
      params.require(:player).permit(:name, :login, :password)
    end

    def set_player
      @player = Player.find(params[:id])
    end

    def logged_in?
      if session[:logged] == true
        true
      else
        false
      end
    end

end