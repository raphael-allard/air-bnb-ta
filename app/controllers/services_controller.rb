class ServicesController < ApplicationController
  def index
    @services = policy_scope(Service)
  end

  def new
    @service = Service.new
    authorize @service
  end

  def create
    @service = Service.new(service_params)
    @service.user = current_user
    authorize @service

    if @service.save
      redirect_to services_path
    else
      render :new
    end
  end

  private

  def service_params
    params.require(:service).permit(:title, :description, :price, :address, photos: [])
  end
end
