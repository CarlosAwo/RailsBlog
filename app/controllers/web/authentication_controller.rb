class Web::AuthenticationController < Web::BaseController
  before_action :authenticate_user
end
