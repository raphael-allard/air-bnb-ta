class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :destroy]

  def index
    @services = policy_scope(Service)
  end

  def show
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
      redirect_to services_path, notice: "Service was successfully created."
    else
      render :new
    end
  end

  def destroy
    @service.destroy
    redirect_to services_path, notice: "Service was successfully destroyed."
  end

  private

  def set_service
    @service = Service.find(params[:id])
    authorize @service
  end

  def service_params
    params.require(:service).permit(:title, :description, :price, :address, photos: [])
  end
end
