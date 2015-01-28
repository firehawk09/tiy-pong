class AddRandomTokenToPongPlayers < ActiveRecord::Migration
  def change
    add_column :pong_player, :random_token, :string
  end
end
