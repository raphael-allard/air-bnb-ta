class ServicesController < ApplicationController
  def index
    @services = policy_scope(Service)
  end
end
