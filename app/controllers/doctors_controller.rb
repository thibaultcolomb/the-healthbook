class DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all
  end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
    @doctor.user = current_user
    @doctor.save

    if @doctor.save
      redirect_to doctors_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :specialty, :email)
  end
end
