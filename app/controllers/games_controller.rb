class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all.sort { |game1,game2| game1.week <=> game2.week }
    @games.uniq! { |game| "week=#{game.week}&p1=#{game.player1_id}&p2=#{game.player2_id}"}
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
    #gets all 3 games
    @games = Game.where(week: @game.week,
      player2_id: @game.player2_id,
      player1_id: @game.player1_id)
  end

  # POST /games
  # POST /games.json
  def create
    redirect_to games_path
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to edit_game_path }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    redirect_to games_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:player1_id, :player2_id, :player1_score, :player2_score, :winner_player_id, :date_played)
    end
end
