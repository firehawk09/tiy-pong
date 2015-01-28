class ChangeNicknameAddPassword < ActiveRecord::Migration
  def change
    rename_column :pong_player, :nickname, :login
    add_column :pong_player, :password, :string
  end
end
