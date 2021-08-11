class BookingsController < ApplicationController
  def create
    @booking = Booking.new(booking_params)
    authorize @booking

    @service = Service.find(params[:service_id])
    @booking.service = @service
    @booking.user = current_user

    if @booking.save
      redirect_to service_path(@booking.service), notice: "Booking was successfully created."
    else
      render "services/show"
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
