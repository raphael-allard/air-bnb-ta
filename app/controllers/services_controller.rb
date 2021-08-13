class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]

  def index
    @services = policy_scope(Service)

    if params[:stimulus_query].present?
      @services = @services.where("title ILIKE ?", "%#{params[:stimulus_query]}%")
    elsif params[:title_username].present?
      @services = @services.search_by_title_username(params[:title_username])
    elsif params[:address].present?
      @services = @services.where("address ILIKE ?", "%#{params[:address]}%")
    end

    @markers = @services.geocoded.map do |service|
      {
        lat: service.latitude,
        lng: service.longitude,
        info_window: render_to_string(partial: "services/partials/info_window", locals: { service: service })
      }
    end

    respond_to do |format|
      format.html
      format.text { render partial: "services/partials/list", locals: { services: @services } }
    end
  end

  def show
    @booking = Booking.new
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
      redirect_to service_path(@service), notice: "Service was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @service.update(service_params)
      redirect_to service_path(@service), notice: "Service was successfully updated."
    else
      render :edit
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
