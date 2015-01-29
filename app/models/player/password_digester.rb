require 'bcrypt'

class Player::PasswordDigester
  def self.encrypt(password)
    BCrypt::Password.create(password)
  end

  def self.check?(password, encrypted_password)
    BCrypt::Password.new(encrypted_password) == password
  end

  def self.generate_token
    self.encrypt( (0..100).to_a.sample(10).join )
  end
end