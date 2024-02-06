class AppointmentsController < ApplicationController
  def new
    @appointment = Appointment.new
    @doctors = Doctor.all
  end

  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      redirect_to @appointment, notice: 'Appointment was successfully created.'
    else
      @doctors = Doctor.all
      render :new
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:date, :report_image, :doctor_id)
  end


end
