class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  def index
    @players = Player.all
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new( Player.merge_default_parameters( player_params ) )
    if @player.save
      log_in @player
      redirect_to @player, notice: 'Player was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
    unless logged_in? @player
      redirect_to root_url, notice: "Invalid credentials"
    end
  end

  def update
    if @player.update_attributes_with_encrypted_password( player_params )
      redirect_to @player, notice: "Player was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    unless logged_in @player
      if @player.destroy
        redirect_to players_url, notice: 'You were successfully deleted.'
      else
        redirect_to players_url, notice: "Deleting error."
      end
    end
  end

  def login
    @player = Player.find_by login: params[:login]
    notice = nil
    if @player
      if @player.correct_password?( params[:password] )
        cookies[:random_token] = Player::PasswordDigester.generate_token
        @player.update_attributes( random_token: cookies[:random_token] )
        log_in(@player)
      else
        notice = "Invalid password"
      end
    else
      notice = "Invalid login"
    end
    redirect_to root_path, notice: notice
  end

  def logout
    log_out
    redirect_to root_path
  end

  private

    def player_params
      params[:player][:password] =
        Player::PasswordDigester.encrypt(params[:player][:password])
      params.require(:player).permit(:name, :login, :password)
    end

    def set_player
      @player = Player.find(params[:id])
    end
    #if player's cookie matches db cookie log in
    # if @player.random_token == cookies[:random_token]
    #   log_in(@player)
    # end
end