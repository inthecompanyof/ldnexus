# exsting user logged in with data
# non-existing user created (dispatched to service)
class LogUserIn

  attr_accessor :session, :data, :user

  def initialize session, user_hash
    self.session = session
    self.data = user_hash
  end

  def commence!
    if user.present?
      session[:user_id] = user.id
      user
    else
      create_user
      user
    end
  end

  def create_user
    registration = RegisterUser.new(data)
    registration.commence!
    self.user = registration.user
  end

  def user
    return @user if defined?(@user)
    @user = User.find_by(email: data[:email])
  end

end
