class AppointmentsController < ApplicationController

  def new
    @appointment = Appointment.new
    @doctors = Doctor.all
  end

  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      redirect_to appointments_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
    @doctors = Doctor.all
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_params)
      redirect_to appointments_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @appointments = Appointment.all
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    redirect_to appointments_path, status: :see_other
  end


  private

  def appointment_params
    params.require(:appointment).permit(:appointment_date, :time, :content, :doctor_id)
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

end
