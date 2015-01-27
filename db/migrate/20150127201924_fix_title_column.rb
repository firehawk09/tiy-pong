class FixTitleColumn < ActiveRecord::Migration
  def change
    rename_column :pong_player, :title, :nickname
  end
end
