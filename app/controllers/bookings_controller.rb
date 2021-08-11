class BookingsController < ApplicationController
  before_action :set_booking, only: [:update, :destroy]

  def index
    @my_bookings = policy_scope(Booking).where(user: current_user)
    @booking_clients = current_user.booking_clients
  end

  def create
    @booking = Booking.new(booking_params)
    authorize @booking

    @service = Service.find(params[:service_id])
    @booking.service = @service
    @booking.user = current_user

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
