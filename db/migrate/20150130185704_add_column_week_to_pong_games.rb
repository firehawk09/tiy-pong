class AddColumnWeekToPongGames < ActiveRecord::Migration
  def change
    add_column :pong_games, :week, :integer
  end
end
