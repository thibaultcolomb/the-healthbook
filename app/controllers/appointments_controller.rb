class AppointmentsController < ApplicationController

  def new
    @appointment = Appointment.new
    @appointment.build_doctor
    @doctors = Doctor.all
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @doctor = Doctor.new(appointment_params[:doctor_attributes])
    @doctor.user = current_user
    @doctor.save
    @appointment.doctor = @doctor

   @report_ids = params[:appointment][:report_ids]

   @report_ids.each_with_index do |report_id, index|
    next if index == 0
    @appointment.reports << Report.find(report_id)
    # @appointment_attachements.reports << Report.find(report_id)

   end



   @appointment.save


    if @appointment.save
      redirect_to appointments_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @appointment = current_user.appointments.find(params[:id])
    @doctors = Doctor.all
  end

  def update
    @appointment = current_user.appointments.find(params[:id])
    if @appointment.update(appointment_params)
      redirect_to appointments_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @appointments = current_user.appointments
  end

  def destroy
    @appointment = current_user.appointments.find(params[:id])
    @appointment.destroy
    redirect_to appointments_path, status: :see_other
  end


  private

  def appointment_params
    params.require(:appointment).permit(:appointment_date, :time, :doctor_id, report_ids: [], doctor_attributes: [:email, :first_name, :last_name, :specialty])
  end

  def set_appointment
    @appointment = current_user.appointments.find(params[:id])
  end

end
