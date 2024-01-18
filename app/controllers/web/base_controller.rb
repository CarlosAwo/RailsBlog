class Web::BaseController < ApplicationController
  include Authentication
  before_action :authenticate_user
end
