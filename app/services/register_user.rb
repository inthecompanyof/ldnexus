#registers users from gapps login
class RegisterUser

  attr_accessor :klass, :data, :user

  def initialize(user_hash, user_klass = User)
    self.klass = user_klass
    self.data = user_hash
  end

  def commence! # nakurwiam węgorza
    Rails.logger.info "na na na na na na"
    self.user = build_new_user
    user.save!
  end

  def build_new_user
    klass.new(data)
  end

end
