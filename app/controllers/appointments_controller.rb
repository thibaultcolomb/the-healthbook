class AppointmentsController < ApplicationController
  def new
    @appointment = Appointment.new
    @doctors = Doctor.all
  end

  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      redirect_to appointment_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @appointment = Appointment.find(params[:id])
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to appointment_path(@appointment)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @appointments = Appointment.all
  end

  private

  def appointment_params
    params.require(:appointment).permit(:appointment_date, :content, :doctor_id)
  end

end



  private

  def appointment_params
    params.require(:appointment).permit(:appointment_date, :content, :doctor_id)
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end
