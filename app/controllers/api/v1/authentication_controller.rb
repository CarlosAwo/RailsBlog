class Api::V1::AuthenticationController < Api::BaseController
  include ApiAuthentication

  before_action :authenticate_user!
end
