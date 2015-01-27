class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :pong_player do |t|
      t.string :name
      t.string :title
      t.integer :wins
      t.integer :losses
    end
  end
end
