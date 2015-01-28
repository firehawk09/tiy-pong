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
    @ttt = player_params

    if @player.save
      redirect_to @player, notice: 'Player was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
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

  private

    def player_params
      params[:player][:password] = PasswordDigester.encrypt(params[:player][:password])
      params.require(:player).permit(:name, :login, :password)
    end

    def set_player
      @player = Player.find(params[:id])
    end

end