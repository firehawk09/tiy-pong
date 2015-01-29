class Player < ActiveRecord::Base
  self.table_name = "pong_player"

  def self.merge_default_parameters(player_params)
    player_params.merge(
      { wins: 0,
        losses: 0,
        random_token: PasswordDigester.generate_token
      })
  end

  def update_attributes_with_encrypted_password(player_params)
    self.update_attributes(
      name: player_params[:name],
      login: player_params[:login],
      password: PasswordDigester.encrypt( player_params[:password] )
    )
  end

  def correct_password?(entered_password)
    PasswordDigester.check?( entered_password, self.password )
  end

end