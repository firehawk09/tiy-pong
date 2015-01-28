class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  def index
    @players = Player.all
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params.merge({ wins: 0, losses: 0, random_token: generate_token }))

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
    if @player.destroy
      redirect_to players_url, notice: 'You were successfully deleted.'
    else
      redirect_to players_url, notice: "Deleting error."
    end
  end

  def login
    @player = Player.find_by login: params[:login]
    notice = nil
    if @player
      if PasswordDigester.check?(params[:password], @player.password)
        cookies[:random_token] = generate_token
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
      params[:player][:password] = PasswordDigester.encrypt(params[:player][:password])
      params.require(:player).permit(:name, :login, :password)
    end

    def set_player
      @player = Player.find(params[:id])
    end

      #if player's cookie matches db cookie log in
      # if @player.random_token == cookies[:random_token]
      #   log_in(@player)
      # end

    def generate_token
      PasswordDigester.encrypt( (0..100).to_a.sample(10).join )
    end

end