class UsersController < ApplicationController
  expose_decorated(:users){ User.order(:supports_count) }
end
