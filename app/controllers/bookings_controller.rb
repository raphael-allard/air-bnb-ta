class BookingsController < ApplicationController
  before_action :set_booking, only: [:update, :destroy]

  def index
    @my_bookings = policy_scope(Booking).where(user: current_user)
    @clients_booking = policy_scope(Booking).includes(:service).where(services: { user: current_user })
    # @clients_booking = current_user.clients_booking
    @review = Review.new
  end

  def create
    @booking = Booking.new(booking_params)
    @service = Service.find(params[:service_id])
    @booking.service = @service
    @booking.user = current_user
    authorize @booking

    if @booking.save
      redirect_to bookings_path(anchor: "booking-#{@booking.id}"), notice: "Booking was successfully created."
    else
      render "services/show"
    end
  end

  def update
    if params[:status] == "accepted"
      @booking.status_accepted!
    else
      @booking.status_declined!
    end

    redirect_to bookings_path
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path, notice: "Booking was successfully deleted."
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end
end
