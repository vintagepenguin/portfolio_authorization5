class User < ActiveRecord::Base

  include BCrypt
	# error messages for both --> set these up with k-champ
  # password --> via bcrypt. 

  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true 

  # Verifying the User
  def password 
  	@password ||= Password.new(password_hash)
  end

  def password=(new_password)
  	@password = Password.create(new_password)
  	self.password_hash = @password
  end

  # LOGIN


  def self.login(params)
    user = User.find_by_email(params[:email])
    if user.password == params[:password]
      user
    else
      false
    end
  end

end
