class DoctorsController < ApplicationController
  def index
    @doctors = current_user.doctors.all
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

  def edit

    @doctor = current_user.doctors.find(params[:id])
  end

  def update
    @doctor = current_user.doctors.find(params[:id])
    if @doctor.update(doctor_params)
      redirect_to doctors_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @doctor = current_user.doctors.find(params[:id])
    @doctor.destroy
    redirect_to doctors_path, status: :see_other
  end


  private

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :specialty, :email)
  end

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end
end
